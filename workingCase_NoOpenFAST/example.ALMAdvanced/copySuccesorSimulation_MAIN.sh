#!/bin/bash

## ******************INPUTS **************************
# Full path of the case "origin"
caseFrom=/marconi_scratch/userexternal/afriger1/enrico/example.cases2018/example.ABL.flatTerrain.neutral

# Full path of the case "destination" (directory is created if the path doesn't exit) 
caseTo=/marconi_scratch/userexternal/afriger1/enrico/example.cases2018/example.ALMAdvanced

#Full path of the boundaryData information for the corresponding case:
boundaryDataPath=/marconi_scratch/userexternal/afriger1/enrico/example.cases2018/example.ABL.flatTerrain.neutral/constant/

# Time directory to copy when the processor* is copied
time2copy=200

## **************************************************************************************

echo " cloning case: "${caseFrom} " to "
echo ${caseTo}

# create destination folder if it does not exist
if [ ! -d ${caseTo} ]; then mkdir -p ${caseTo}; fi

# copy general structure (note that rsync doesn't contain -a to make the new files appear with current date to avoid deletion from scratch soon and avoid ownership problems)
echo "**************************"
echo "copying general structure"
rsync -r --exclude=boundaryData --exclude=setUp --exclude=system --exclude=processor* --exclude=Innwind10MWRef.0* --exclude=log.* --exclude=h5.backup* --exclude=postProcessing --exclude=velDatafile*  ${caseFrom}/*  ${caseTo}/ 

#rsync -r ${caseFrom}/Innwind10MWRef.fst ${caseTo}/Innwind10MWRef.fst
rsync -r ${caseFrom}/Innwind10MWRef.0.fst ${caseTo}/Innwind10MWRef.0.fst

# copy boundary data
#rsync -ra ${caseFrom}/constant/boundaryData  ${caseTo}/constant/

# copy boundary data
echo "**************************"
echo "creating symbolic linkt to boundary data"
finishOK=1
COUNTER=0
while [ ${finishOK} -ne 0 ]; do
   echo "trying to create symbolic links for boundary data for the "${COUNTER}"th time"

   timeFolders=$(ls ${boundaryDataPath}/boundaryData/south/)

   for iTime in ${timeFolders}; do
      
      for inflowPatch in south west; do
         
         if [ ${iTime} != "points" ]; then
            destPath=${caseTo}/constant/boundaryData/${inflowPatch}/${iTime}/
            if [ ! -d ${destPath} ]; then mkdir -p ${destPath}; fi
            
            for var in k T U; do
               if [ ! -f ${destPath}/${var} ]; then 
                  ln -sf ${boundaryDataPath}/boundaryData/${inflowPatch}/${iTime}/${var} ${destPath}/${var}
               fi
            done

         else
            ln -sf ${boundaryDataPath}/boundaryData/${inflowPatch}/points ${caseTo}/constant/boundaryData/${inflowPatch}/points
         fi
         
      done   
   done            
   finishOK=$?
   let COUNTER=COUNTER+1 
done

	
# copying the information from the processorx data
echo "**************************"
echo "copying data for processorsx of timeFolder: "${time2copy}
finishOK=1
COUNTER=0
while [ ${finishOK} -ne 0 ]; do
   echo "trying for the  "${COUNTER}"th time"

   nFiles=$(find ${caseFrom}/processor*/${time2copy}/ -type f -follow -print|xargs ls)
   nFiles2=$(find ${caseFrom}/processor*/constant/ -type f -follow -print|xargs ls)

   for i in ${nFiles} ${nFiles2}; do
      iPath=${i%/*}
      relativePath=${iPath#$caseFrom}
      relativeFile=${i#$caseFrom}

      destPath=${caseTo}/${relativePath}
      destFile=${caseTo}/${relativeFile}

      if [ ! -d ${destPath} ]; then
         mkdir -p ${destPath}
      fi

      if [ ! -f ${destFile} ]; then
         #ln -sf ${i} ${destFile}
         rsync -ra ${i} ${destFile}
      fi
   done
   finishOK=$?

   let COUNTER=COUNTER+1 
done

if [ ${finishOK} -eq 0 ]; then
   echo " OUUHHH YEAH BABY. the crap finished correctly"
fi


