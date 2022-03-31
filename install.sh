#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
WHITE='\033[0;37m'

export BCO_DIST="${BCO_DIST:=$HOME/usr/}"
export OPENBASE_DIST="${OPENBASE_DIST:=$BCO_DIST}"

if [ ! -d ${OPENBASE_DIST} ]; then
    echo "No openbase distribution found at: ${OPENBASE_DIST}"
    echo 'Please define the distribution installation target directory by setting the $OPENBASE_DIST environment variable.'
    exit 255
fi

APP_NAME='developer-tools'
APP_NAME=${BLUE}${APP_NAME}${NC}
echo -e "=== ${APP_NAME} project ${WHITE}installation${NC}" &&
mkdir -p ${OPENBASE_DIST}/bin &&
rsync -a src/* ${OPENBASE_DIST}/bin/ &&
echo -e "=== ${APP_NAME} was ${GREEN}successfully${NC} installed to ${WHITE}${OPENBASE_DIST}${NC}"
