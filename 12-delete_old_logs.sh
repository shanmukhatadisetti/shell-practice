source_path=/home/ec2-user

delete_file=$(find $source_path -name "*.log" -mtime +14)

while IFS= read -r files
do
    echo $files
    rm -rf $files
done >>>$delete_file