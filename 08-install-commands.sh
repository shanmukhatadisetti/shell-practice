#!/bin/bash

userid=$(id -u)

if [ $userid -eq 0 ]
then
    echo "your running with root user"
else
    echo "ERROR:: your not running with root user"
    exit 1
fi

VALIDATION(){
        if [ $1 -eq 0 ]
    then
        echo "$2 installation succesful"
    else
        echo "ERROR:: $2 installation has been failed"
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
    echo "$2 The package is already installed"
fi

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "The package is installing"
    dnf install python3 -y
    VALIDATION $? "python3"

else
    echo "$2 The package is already installed"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then 
    echo "The package is installing"
    dnf install mysql -y
    VALIDATION $? "mysql"

else
    echo "$2 The package is already installed"
fi