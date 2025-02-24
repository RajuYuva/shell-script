#!/bin/bash

i=("mysql"  "rabittmq" "mongodb" "redis" "catlogue" "cart" "shipping" "payment" "user" "web")

for i in ${i[@]}; do

    if [ $i = "mysql" ] || [ $i = "shipping" ] 
    then 
        instance_type="t3.medium"
    else
        instance_type="t3.micro"
    fi        
    echo "installing $i with instance type is $instance_type"
done   