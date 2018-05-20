#!/usr/bin/env bash

## One liner:
## bash <(curl -s https://raw.githubusercontent.com/neil-tan/cloud9-installer/master/install.sh)

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'


##### Path and files
logfile="install.log"

installDir=`realpath ~/environment`
installDir=`echo "$installDir/tools"`

gccURL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2?revision=375265d4-e9b5-41c8-bf23-56cbe927e156?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2017-q4-major"

#cmd msg
chkStatus() {
    if [ $# -eq 2 ]; then
        msg=$2
    else
        msg=$1
    fi
    
    outputmsg=`$1 `
    if [ $? -eq 0 ]; then
        printf "$msg        [${grn} OK ${end}]\n"
    else
        printf "$msg        [${red} Failed ${end}]\n"
        exit 1
    fi 
}

####### Instatllation Start

chkStatus "mkdir $installDir"

####### Instatlling GCC
chkStatus "wget $gccURL -t 3 -O $installDir/gcc-arm-none-eabi.tar.bz2" "downloading GCC"

#  decompress
printf "Extracting GCC..."
chkStatus "tar xvjf $installDir/gcc-arm-none-eabi.tar.bz2 -C $installDir"

# book keeping
chkStatus "rm $installDir/*.tar.bz2"
chkStatus "mv $installDir/gcc-arm-none-eabi* $installDir/gcc-arm-none-eabi"
gccPath="$installDir/gcc-arm-none-eabi"

###### Installing Other Requirements
chkStatus "sudo pip install scipy"
chkStatus "sudo pip install matplotlib"

###### Installing TensorFlow
printf "\nInstalling TensorFlow"
chkStatus "sudo pip --no-cache-dir install tensorflow==1.7.0"

###### Installing Other Requirements
chkStatus "sudo pip install scipy"

###### Installating uTensor CLI
chkStatus "sudo pip install utensor_cgen" "uTensor-cli installation"

######## Installing Mbed

chkStatus "sudo yum -y install hg"
chkStatus "sudo pip install intelhex prettytable junit_xml beautifulsoup4 fuzzywuzzy"
chkStatus "sudo pip install mbed-cli"

chkStatus "mbed config -G GCC_ARM_PATH "$gccPath/bin""

echo "\n\n uTensor Mbed installation successful!"
