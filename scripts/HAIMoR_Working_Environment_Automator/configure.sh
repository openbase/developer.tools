#!/bin/bash

#################################################################		
#			BCO Installer				#
#								#
#								#
#			[ Vignesh Natarajan (a) Viki  ]		#
#			[ vnatarajan@uni-bielefeld.de ]		#
#								#
#								#
# Reference: https://openbase.github.io/bco/
#								#
#################################################################

prefix="/usr/local/bco"


function env_setup {
	echo
	echo "Setting Up Environment"
	echo 'export prefix="/usr/local/bco"' >> ~/.bashrc
	echo 'export PATH="$PATH:$prefix/bin"' >> ~/.bashrc
	sudo mkdir -p $prefix
	sudo chown -R $USER $prefix
	sudo chmod -R 750 $prefix
}


function init {
	echo
	sudo ls
	if [ $? -eq 0 ]; then
		echo ""
	else
		echo "sudo password unsuccessful"
		exit 1
	fi
}

init
env_setup
. ~/.bashrc

echo "configuration is successful"
echo "exit the shell and run bco_batch_installer.sh in a new shell to complete the installation"

