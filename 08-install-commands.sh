#!/bin/bash

userid=$(id -u)

if [ $userid -eq 0 ]
then
    echo "your running with root user"
else
    echo "ERROR:: your not running with root user"
    exit 1
fi
dnf list installed nginx
if [ $? -eq 0 ]
then 
    echo "The package is installing"
    dnf install nginx -y
    if [ $? -eq 0 ]
    then
        echo "installation succesful"
    else
        echo "ERROR:: installation has been failed"
        exit 1
    fi
else
    echo "The package is already installed"
fi