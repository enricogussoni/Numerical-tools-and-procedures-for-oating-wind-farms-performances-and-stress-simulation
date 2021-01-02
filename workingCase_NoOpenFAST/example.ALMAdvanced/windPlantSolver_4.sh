#!/bin/bash
#SBATCH --job-name=004A41TY030R

# PARTITIONS: dbg: 2 nodes, 30 min max ; prod: 1-195 nodes, 24 hours 
#SBATCH --partition=knl_usr_prod
##SBATCH --partition=knl_usr_dbg
#SBATCH --time=23:59:59
#SBATCH --nodes=40
#SBATCH --ntasks-per-node=64


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
#SETUP ENVIRONMENT
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
  export OPENFAST_LIB=${WORK}/SowfaRoot/OpenFAST/lib
  export FOAM_USER_APPBIN=${WORK}/SowfaRoot/SOWFA/bin
  export FOAM_USER_LIBBIN=${WORK}/SowfaRoot/SOWFA/lib
fi

export PATH=${FOAM_USER_APPBIN}:${PATH}
export LD_LIBRARY_PATH=${OPENFAST_LIB}:${FOAM_USER_LIBBIN}:${LD_LIBRARY_PATH}

##############################################################

#module purge
#module load profile/global
#module load mkl/2017--binary
#module load intel/pe-xe-2017--binary
#module load szip/2.1--gnu--6.1.0
#module load zlib/1.2.8--gnu--6.1.0
#module load hdf5/1.8.17--intel--pe-xe-2017--binary
#module load gnu/6.1.0
#module load openmpi/1-10.3--gnu--6.1.0
#module load boost/1.61.0--gnu--6.1.0
#export SOWFA_ROOT=/marconi_work/Pra16_4200/SowfaRoot
#source ${SOWFA_ROOT}/OpenFOAM/OpenFOAM-2.4.x/etc/bashrc
#export OPENFAST_LIB=${SOWFA_ROOT}/OpenFAST/lib
#export LD_LIBRARY_PATH=${OPENFAST_LIB}:${SOWFA_ROOT}/SOWFA_SC/lib:${LD_LIBRARY_PATH}
#PATH=${SOWFA_ROOT}/SOWFA_SC/bin:${PATH}


##############################################################

# export CASE_DIR=/marconi_scratch/userexternal/sgomez00/FINAL_precursors/002_PRECURSOR_WRITING__A4_NoFF/
# cd ${CASE_DIR}

echo
echo "Job ${SLURM_JOB_NAME}, (${SLURM_JOB_ID}),"
echo "Nº nodes: ${SLURM_JOB_NUM_NODES}, Cores per node: ${SLURM_NTASKS_PER_NODE}. Total number of cores: ${SLURM_NTASKS}"
echo "Running on ${SLURM_JOB_PARTITION} partition."
#echo "CASE_DIR = ${CASE_DIR}"
echo 

#which setFieldsABL
#ls $(which setFieldsABL) 
# mpirun --map-by core --bind-to core  setFieldsABL -parallel > log.setFieldsABL
# cp -r /marconi_work/Pra16_4200/sugoi/000_PREPROCESS_20180522_newest_inputs .
#mpirun --map-by core --bind-to core  ABLSolver -parallel > log.ABLSolver

#reconstructPar -time '91000' > log.reconstructPar

###############################################################

controlDictTemplateFile=controlDictTemplate   #name of the controlDict template file
simulationStartTime=91000                     #simulation Initial Start Time (seg)
simulationTotalTime=92000                     #simulation total time (seg)
deltaPeriod=5                                 #lenght of the simulation periods
solver=windPlantSolver.ALMAdvancedOpenFAST    #name of the solver

startTime=${simulationStartTime}

for i in $(ls -rtd processor0/*/ | cut -f2 -d'/'); do time=${i%%/}; done
latestStartTime=$time
if [ ${latestStartTime} -gt ${simulationStartTime} ]; then
   echo "starting @ second "${latestStartTime}
   startTime=${latestStartTime}
fi

mkdir h5.backup.${startTime}

while [ ${startTime} -lt $((${simulationTotalTime}-${deltaPeriod})) ]; do

   endTime=$((${startTime}+${deltaPeriod}))

   echo "********************************"
   echo "Simulation for "${startTime}" to "${endTime}

   #changing the endtime in control dict file
   sed "s|endTimexxx|endTime         ${endTime};|g" ./system/${controlDictTemplateFile} > ./system/controlDict

   #running the mpi application
   mpirun --map-by core --bind-to core ${solver} -parallel &> log.${solver}_${endTime}s
   simOK=$?

   solutionFolder=processor0/${endTime}
   # now it checks both conditions: simulation finished ok (error output==0) and it created the output folder
   if [ -d ./${solutionFolder} ] && [ ${simOK} -eq 0 ]; then
      # in order to save some storage, it deletes the processor/"previousTime" files
      #rm -rf processor*/${startTime}

      mv h5.backup.${startTime} h5.backup.${endTime}
      # create a copy of the windDatafile.h5
      cp *.h5 ./h5.backup.${endTime}/
      # advance in time
      startTime=${endTime}
      
   else
      echo "   missing folder. Repeating simulation for startTime="${startTime}
      # replace the h5 file for the one backed up
      cp ./h5.backup.${startTime}/*.h5 ./
      
      # remove the core* files that are only dumpling memory useless stuff produced when mpirun fails
      rm -rf core*
      
      mv log.${solver}_${endTime}s log.${solver}_${endTime}s.old
   fi

done
