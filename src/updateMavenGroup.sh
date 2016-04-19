#!/bin/bash

# configure exit on error
    set -e
    set -o pipefail

echo rename source folder
find ./ -type d -name 'dc' | grep .git -v | grep target -v

echo rename packages
sed -i 's/.dc./.openbase./g' *.java

echo rename artifacts
sed -i 's/dc/openbase/g' *.pom

echo rename cooperation namw
sed -i 's/DivineCooperation/openbase.org/g' *.pom

