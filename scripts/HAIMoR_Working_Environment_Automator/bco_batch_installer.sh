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

function repo_download {
	echo
	echo "Downloading Repositories"
	mkdir -p ~/workspace/openbase/bco
	cd ~/workspace/openbase/bco
	git clone https://github.com/openbase/bco.registry.git registry
	git clone https://github.com/openbase/bco.dal.git dal
	git clone https://github.com/openbase/bco.manager.git manager
	git clone https://github.com/csra/bco.registry.csra-db
}


function install_spread {

	echo
	echo "Installing 	[ Spread ]"

	release=`lsb_release -a 2> /dev/null | grep Codenam`
	ubuntu_version=""
	
	if [[ $release == *"precise"* ]]; then
        	echo "Ubuntu Release [ precise ] "
		ubuntu_version="precise"
	elif [[ $release == *"trusty"* ]]; then
        	echo "Ubuntu Release [ trusty ] "
		ubuntu_version="trusty"
	elif [[ $release == *"xenial"* ]]; then
        	echo "Ubuntu Release [ xenial ] "
		ubuntu_version="xenial"
	else
        	echo "Unknown Ubuntu Version"
		echo "Terminating installation process"
		exit 1
	fi
	

	echo 'deb http://packages.cor-lab.de/ubuntu/ '$ubuntu_version' main' | sudo tee -a /etc/apt/sources.list
  	echo 'deb http://packages.cor-lab.de/ubuntu/ '$ubuntu_version' testing' | sudo tee -a /etc/apt/sources.list
  	
	wget -q http://packages.cor-lab.de/keys/cor-lab.asc -O- | sudo apt-key add -
  	sudo apt-get update	
	sudo apt-get install spread rsb-tools-cl0.15

	if [ $? -eq 0 ]; then
		echo "Installation Successful [ Spread ]"
	else
		echo "Installation Unsuccessful [ Spread ]"
		exit 1
	fi

}

function install_git {
	echo

	git &> /dev/null
	
	if [ $? -eq 0 ]; then
		echo "Dependency Met	[ Git ]"
	else
		echo "Installing [ Git ]"
		sudo apt-get install -y git 
	fi
}


function install_maven {
	echo

	mvn &> /dev/null

	if [ $? -eq 0 ]; then
		echo "Dependency Met	[ Maven ]"
	else
		echo "Installing 	[ Maven ]"
		sudo apt-get -y install maven
	fi
}

function install_java {
	echo
	echo "Installing 	[ Java 8 ]"
	sudo apt-add-repository -y ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get -y install oracle-java8-installer
}


function install_wget {
	echo
	echo "Installing 	[ wget ]"
	sudo apt-get update
	sudo apt-get install -y wget
}

function essential_file_copy {
	echo
	echo "Copying Essential Files"
	mkdir -p ~/.m2/
	cp ./settings.xml ~/.m2/
	cp ./rsb.conf ~/.config/rsb.conf
}

function install_bco {
	echo
	echo "Installing 	[ cmake ]"	
	sudo apt-get install -y cmake

	echo "Installing 	[ bco registry ]"
	cd ~/workspace/openbase/bco/registry
	./install.sh

	if [ $? -eq 0 ]; then
		echo "Installation Successful [ bco registry ]"
	else
		echo "Installation Unsuccessful [ bco registry ]"
		exit 1
	fi

	echo "Installing 	[ bco dal ]"
	cd ~/workspace/openbase/bco/dal
	./install.sh

	if [ $? -eq 0 ]; then
		echo "Installation Successful [ bco dal ]"
	else
		echo "Installation Unsuccessful [ bco dal ]"
		exit 1
	fi


	echo "Installing 	[ bco manager ]"
	cd ~/workspace/openbase/bco/manager
	./install.sh

	if [ $? -eq 0 ]; then
		echo "Installation Successful [ bco manager ]"
	else
		echo "Installation Unsuccessful [ bco manager ]"
		exit 1
	fi


	echo "Installing 	[ bco db ]"
	cd ~/workspace/openbase/bco/bco.registry.csra-db
	./install.sh

	if [ $? -eq 0 ]; then
		echo "Installation Successful [ bco db ]"
	else
		echo "Installation Unsuccessful [ bco db ]"
		exit 1
	fi

	cp -R $prefix/share/bco $prefix/var/
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
essential_file_copy
install_wget
install_java
install_git
install_maven
repo_download
install_spread
install_bco

echo "............."
echo "............."
echo "............."
echo "Installation Is Successful"
echo "You can start using bco in a new terminal using [spread] and [bco] commands"
echo "............."
echo "............."
echo "............."
exit 0
