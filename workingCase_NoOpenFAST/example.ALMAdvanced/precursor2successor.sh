#!/bin/bash
#SBATCH --job-name=refin_A8_pre2succ

# PARTITIONS: dbg: 2 nodes, 30 min max ; prod: 1-195 nodes, 24 hours
##SBATCH --partition=knl_usr_prod
#SBATCH --partition=knl_usr_dbg
#SBATCH --time=00:29:59
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


#SBATCH --account=Pra16_4200
#SBATCH --hint=memory_bound
#SBATCH --constraint=cache
##SBATCH --export=NONE
#SBATCH --threads-per-core=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=86000
#SBATCH --out=log.%x_%j.out
#SBATCH --err=log.%x_%j.err

#############################################################
# Setup environment
module purge
module load profile/global
module load mkl/2017--binary
module load intel/pe-xe-2017--binary
module load szip/2.1--gnu--6.1.0
module load zlib/1.2.8--gnu--6.1.0
module load hdf5/1.8.17--intel--pe-xe-2017--binary
module load gnu/6.1.0
module load openmpi/1-10.3--gnu--6.1.0
module load boost/1.61.0--gnu--6.1.0

# LOAD OpenFOAM
export WORK=/marconi_work/Pra16_4200
source ${WORK}/SowfaRoot/OpenFOAM/OpenFOAM-2.4.x/etc/bashrc

# LOAD OpenFAST: 0 load SC version, 1 regular version
SC=1

if [ $SC == 0 ]
then
  echo "Loading Supercontroller version"
  export OPENFAST_LIB=${WORK}/SowfaRoot/OpenFAST_SC/lib
  export FOAM_USER_APPBIN=${WORK}/SowfaRoot/SOWFA_SC/bin
  export FOAM_USER_LIBBIN=${WORK}/SowfaRoot/SOWFA_SC/lib
else
  echo "Loading NO Supercontroller version"
  export OPENFAST_LIB=${WORK}/SowfaRoot/OpenFAST_20181212/lib
  export FOAM_USER_APPBIN=${WORK}/SowfaRoot/SOWFA_20181212/bin
  export FOAM_USER_LIBBIN=${WORK}/SowfaRoot/SOWFA_20181212/lib
fi

export PATH=${FOAM_USER_APPBIN}:${PATH}
export LD_LIBRARY_PATH=${OPENFAST_LIB}:${FOAM_USER_LIBBIN}:${LD_LIBRARY_PATH}

##############################################################

echo
echo "Job ${SLURM_JOB_NAME}, (${SLURM_JOB_ID}),"
echo "Nº nodes: ${SLURM_JOB_NUM_NODES}, Cores per node: ${SLURM_NTASKS_PER_NODE}. Total number of cores: ${SLURM_NTASKS}"
echo "Running on ${SLURM_JOB_PARTITION} partition."
echo

##############################################################

#mapFields -consistent -sourceTime 91000 ../003_PRECURSOR_WRITING_A4_NoFF_Original &> log.mapFields

changeDictionary -dict system/changeDictionaryDict.updateBCs.southwest -enableFunctionEntries &> log.changeDictionary.updateBCs.southwest 

#############################################################

echo "      *selecting cells to refinement 1 ..."
topoSet -dict system/topoSetDict.local.1 &> log.topoSet.local.1 
echo "      *refining cells..."
refineHexMesh local -overwrite &> log.refineHexMesh.local.1 
echo "      *selecting cells to refinement 2 ..."
topoSet -dict system/topoSetDict.local.2 &> log.topoSet.local.2 
echo "      *refining cells..."
refineHexMesh local -overwrite &> log.refineHexMesh.local.2 
#echo "      *selecting cells to refinement 3 ..."
#topoSet -dict system/topoSetDict.local.3 > log.topoSet.local.3 2>&1
#echo "      *refining cells..."
#refineHexMesh local -overwrite > log.refineHexMesh.local.3 2>&1

#############################################################

#decomposePar -fields -time '200' &> log.decomposePar
#decomposePar -fields -time '91000' > log.decomposePar 2>&1


