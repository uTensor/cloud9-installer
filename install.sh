#!/usr/bin/env bash

##bash <(curl -s https://raw.githubusercontent.com/neil-tan/cloud9-installer/master/install.sh)
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

logfile="install.log"

installDir=`realpath ~/environment`
installDir=`echo "$installDir/tools"`

gccURL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2?revision=375265d4-e9b5-41c8-bf23-56cbe927e156?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2017-q4-major"


#msg cmd pattern invert
chkInstall() {
    
    printf "\nPerforming $2:\n"
    msg=`$1 2>&1 | tail -f -n 5 | tee $stdout`
    
    if [[ $msg =~ $3 ]]; then
        printf "$2...    [${grn} OK ${end}]\n"
    else
        printf "$2...    [${red} Failed ${end}]\n"
        printf "Please share the install.log with the developers\n"
        #echo $msg > ./$logfile
        exit 1
    fi

}

#cmd
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


chkStatus "mkdir $installDir"

# downloading gcc
chkStatus "wget $gccURL -t 3 -O $installDir/gcc-arm-none-eabi.tar.bz2" "downloading GCC"

## decompress

chkInstall "tar xvjf $installDir/gcc-arm-none-eabi.tar.bz2 -C $installDir" "extracting GCC" "gcc-arm-none-eabi-7-2017-q4-major/bin/arm-none-eabi-gcc"

## book keeping
chkStatus "rm $installDir/*.tar.bz2"
chkStatus "mv $installDir/gcc-arm-none-eabi* $installDir/gcc-arm-none-eabi"

#chkStatus "sudo yum upgrade python-pip"

chkStatus "pip install tensorflow"
