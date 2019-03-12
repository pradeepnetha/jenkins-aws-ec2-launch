#!/bin/bash

#echo "enter ami_id"
#read ami_id;
#echo "enter keypair_name"
#read keypair_name;
#echo "enter Instance_type"
#read instance_type;
#echo "enter region"
#read region
#echo "subnet id - public/private"
#read subnet_id
ami_id=$1
keypair_name=$2
Instance_type=$3
subnetid=$4

launch_ec2()
{
aws ec2 run-instances --image-id $ami_id --count 1 --instance-type $Instance_type --key-name $keypair_name --security-group-ids sg-088974251af4f8415 --subnet-id $subnetid --region ap-south-1 > ec2.txt
}

instancespec()
{
sleep 3
grep InstanceId ec2.txt | tr -d '", "' > InstanceId
sed -i 's/:/=/g' InstanceId
echo "aws ec2 create-tags --resources ""$"InstanceId"  --tags Key=Name,Value=Web1 --region ap-south-1" >> InstanceId
chmod +x InstanceId
./InstanceId
echo " Instance is launched"
echo "$ami_id" > ami.txt
}
launch_ec2
sleep 5
instancespec