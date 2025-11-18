#!/bin/bash

userid=$(id -u)

if [ $userid -eg 0 ]
then
    echo "your running with root user"
else
    echo "ERROR:: your not running with root user"
    exit 1
fi

dnf install nginx -y
