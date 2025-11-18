#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
W="\e[0m"

SCRIPT_PATH=/var/log/scripting_logs
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$SCRIPT_PATH/$SCRIPT_NAME.log"

mkdir -p $SCRIPT_PATH
echo "script started excuting at:: $(date)"

PACKAGES=("mysql" "nginx" "python3")

if [ $userid -eq 0 ]
then
    echo -e "$G your running with root user $W" | tee -a $LOG_FILE
else
    echo -e "$R ERROR:: your not running with root user $W" | tee -a $LOG_FILE
    exit 1
fi

VALIDATION(){
        if [ $1 -eq 0 ]
    then
        echo -e "$G $2 installation succesful $W" | tee -a $LOG_FILE
    else
        echo -e "$R ERROR:: $2 installation has been failed $W" | tee -a $LOG_FILE
        exit 1
    fi
}

for packages in $PACKAGES
do 
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then 
        echo "The package is installing" &>>$LOG_FILE
         install $packages -y &>>$LOG_FILE
        VALIDATION $? "$packages"

    else
    echo -e "$Y $packages package is already installed $W" | tee -a $LOG_FILE
    fi
done


