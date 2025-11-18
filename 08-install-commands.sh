#!/bin/bash

userid=$(id -u)

if [ $userid -eq 0 ]
then
    echo "your running with root user"
else
    echo "ERROR:: your not running with root user"
    exit 1
fi

dnf install nginx -y
if [ $? -eg 0 ]
then
    echo "installation succesful"
else
    echo "ERROR:: installation has been failed"
    exit 1
fi
