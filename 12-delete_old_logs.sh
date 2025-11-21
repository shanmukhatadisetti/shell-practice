source_dir=/home/ec2-user

Delete_files=$(find $source_dir -name "*log" -mtime +14)

while IFS= read -r filepath
do
    echo $filepath
    rm -rf $filepath
done