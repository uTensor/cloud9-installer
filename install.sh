#!/usr/bin/env bash

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
    stdout=`tty`
    #arg1 arg2 arg3 >stdout.txt 2>stderr.txt
    #msg=`$1 > tee -a $stdout ./$logfile 2>&1 | tail -n 25 ./$logfile | tee $stdout | tail -n 5`
    msg=`$1 2>&1 | tail -f -n 5 | tee $stdout`
    #msg=`$1 2>&1 | less -F | tee $stdout`
    
    if [[ $msg =~ $3 ]]; then
        printf "$2...    [${grn} OK ${end}]\n"
    else
        printf "$2...    [${red} Failed ${end}]\n"
        printf "Please share the install.log with the developers\n"
        #echo $msg > ./$logfile
        exit 1
    fi

}

chkQuiet() {
    msg="$($1 2>&1)"
    if [ -n "$msg" ] && ! [[ "$msg" =~ "^\n$" ]]; then
        echo $msg > ./$logfile
        echo "Error :"
        echo "$msg"
        printf "Please share the install.log with the developers\n"
        exit 1
    fi
}

chkQuiet "mkdir $installDir"

# downloading gcc
chkInstall "wget $gccURL -t 3 -O $installDir/gcc-arm-none-eabi.tar.bz2" "downloading GCC" "saved"

## decompress

chkInstall "tar xvjf $installDir/gcc-arm-none-eabi.tar.bz2 -C $installDir" "extracting GCC" "gcc-arm-none-eabi-7-2017-q4-major/bin/arm-none-eabi-gcc"

## book keeping
chkQuiet "rm $installDir/*.tar.bz2"
chkQuiet "mv $installDir/gcc-arm-none-eabi* $installDir/gcc-arm-none-eabi"

# sudo pip install --upgrade pip
# printf("pip upgrade    ")
# if [ $? -eq 0 ]; then
#     printf "[${grn} OK ${end}]\n"
# else
#     printf "[${red} Failed ${end}]\n"
#     EXIT 1
# fi

sudo pip install tensorflow
printf("installing tensorflow     ")
if [ $? -eq 0 ]; then
    printf "[${grn} OK ${end}]\n"
else
    printf "[${red} Failed ${end}]\n"
    EXIT 1
fi