#!/bin/bash

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
W="\e[0m"

if [ $userid -eq 0 ]
then
    echo -e "$G your running with root user $W"
else
    echo -e "$R ERROR:: your not running with root user $W"
    exit 1
fi

VALIDATION(){
        if [ $1 -eq 0 ]
    then
        echo -e "$G $2 installation succesful $W"
    else
        echo -e "$R ERROR:: $2 installation has been failed $W"
        exit 1
    fi
}

dnf list installed nginx
if [ $? -ne 0 ]
then 
    echo "The package is installing"
    dnf install nginx -y
    VALIDATION $? "nginx"

else
    echo -e "$Y nginx package is already installed $W"
fi

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "The package is installing"
    dnf install python3 -y
    VALIDATION $? "python3"

else
    echo -e "$Y python3 package is already installed $W"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then 
    echo "The package is installing"
    dnf install mysql -y
    VALIDATION $? "mysql"

else
    echo -e "$Y mysql package is already installed $W"
fi