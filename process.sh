# #!/bin/bash

# process=$1

# process_check=$(pgrep -x $process)

# if [ -n "$process_check" ]
# then
#     echo " $process is running "
# else
#     echo " $process is not running "
# fi       


# #### another way
# #!/bin/bash

# process=$1

# if pgrep -x "$process" > /dev/null; then
#     echo "$process is running"
# else
#     echo "$process is not running"
# fi

#### multiple process to check

# for i in "$@"
# do
#     process_check=$(pgrep -x "$i")
#     if [ -n "$process_check" ]
#     then
#         echo " $i is running "
#     else
#         echo $i " is not running "
#     fi
# done

## another way of multiple process to check
for i in "$@"; do
    if pgrep -x "$i" > /dev/null; then
        echo "$i is running"
    else
        echo "$i is not running"
    fi
done        

### output will be like below

# bash process.sh nginx sshd git sshd terraform nginx nginxx
# nginx is running
# sshd is running
# git is not running
# sshd is running
# terraform is not running
# nginx is running
# nginxx is not running