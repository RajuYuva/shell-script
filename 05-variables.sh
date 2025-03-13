# #!/bin/bash

# echo "Please enter username::"

# read -s USERNAME #here USERNAME is variable

# echo "Please enter password::"

# read -s PASSWORD

# echo "Username is: $USERNAME, Password is: $PASSWORD"

#!/bin/bash

read -p "Please enter username: " USERNAME

read -sp "Please enter password: " PASSWORD
echo  # add a newline after the hidden password input

echo "Username is: $USERNAME, Password is: $PASSWORD"
