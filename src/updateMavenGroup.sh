#!/bin/bash

# configure exit on error
    set -e
    set -o pipefail

ORIGIN_FOLDER=$(pwd)

echo rename source folder

SOURCE_FOLDER=$(find ./ -type d -name 'dc' | grep .git -v | grep target -v)

for DIR in ${SOURCE_FOLDER}
do
   echo [$DIR]
   cd ${DIR}/..
   git mv dc openbase
   cd ${ORIGIN_FOLDER}
done

#echo rename packages
#sed -i 's/.dc./.openbase./g' *.java

#echo rename artifacts
#sed -i 's/dc/openbase/g' *.pom

#echo rename cooperation namw
#sed -i 's/DivineCooperation/openbase.org/g' *.pom

