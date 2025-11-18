#!/bin/bash
ami_id="ami-09c813fb71547fc4f"
security_group="sg-061a70ce669d05c8c"
instance_name=("mongodb" "catalogue" "frontend")

for instances in ${instance_name[@]}
do 
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-061a70ce669d05c8c --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instances}]" --query "Instances[0].InstanceId" --output text)
    if [ $instance_name != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instances ip-address is:: $IP"
done