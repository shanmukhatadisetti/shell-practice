#!/bin/bash

ami_id="ami-09c813fb71547fc4f"
security_group="sg-09051fba61d292f5a"
# instance_name=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
# instace_name=$@
zone_id="Z04587632P94S10NUVKK9"
domain_name="autonagar.in"

# for instances in "${instance_name[@]}"
for instances in "$@"
do 
    INSTANCE_ID=$(aws ec2 run-instances --image-id $ami_id --instance-type t3.micro --security-group-ids $security_group --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instances}]" --query "Instances[0].InstanceId" --output text)
    if [ $instances != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
        RECORD_NAME="$instances.$domain_name"
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
        RECORD_NAME="$instances.$domain_name"
    fi
    echo "$instances ip-address is:: $IP"

    aws route53 change-resource-record-sets \
  --hosted-zone-id $zone_id \
  --change-batch '
  {
    "Comment": "creating or updating a record set"
    ,"Changes": [{
      "Action"              : "UPSERT" 
      ,"ResourceRecordSet"  : {
        "Name"              : "'$RECORD_NAME'"
        ,"Type"             : "A"
        ,"TTL"              : 1
        ,"ResourceRecords"  : [{
            "Value"         : "' $IP '"
        }]
      }
    }]
  }
  '
done