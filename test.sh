ami_id=ami-09c813fb71547fc4f
security_group=sg-061a70ce669d05c8c
instance_name=("mongodb" "catalogue" "frontend")

for instance in ${instance_name[@]}
do
    INSTANCES4=$(run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-061a70ce669d05c8c --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=shan}]" --query "Instances[0].InstanceId" --output text)
    echo $INSTANCES4
done