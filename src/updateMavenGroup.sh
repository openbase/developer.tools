#!/bin/bash

# configure exit on error
    set -e
    set -o pipefail

ORIGIN_FOLDER=$(pwd)

echo clean
mvn clean

echo rename source folder

SOURCE_FOLDER=$(find ./ -type d -name 'dc' | grep .git -v | grep target -v)

for DIR in ${SOURCE_FOLDER}
do
   echo [$DIR]

   INTERNAL_FILE_COUNTER=$(find $DIR -type f | wc -l)
   cd ${DIR}/..
   if [ $INTERNAL_FILE_COUNTER == 0 ]; then
       mv dc openbase 
   else
       git mv dc openbase
   fi

   cd ${ORIGIN_FOLDER}
done


echo rename groups and imports
find . -type f | grep -v .git | xargs sed -i 's/org\.dc/org\.openbase/g'

echo rename domain
find . -type f | grep -v .git | xargs sed -i 's/DivineCooperation/openbase.org/g'

echo rename github url
find . -type f | grep -v .git | xargs sed -i 's/github\.com\/divinecooperation/github\.com\/openbase/g'

echo rename git remote repository
sed -i 's/github\.com\/divinecooperation/github\.com\/openbase/g' ./.git/config

echo finished
    


