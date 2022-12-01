#!/bin/bash
# Script used to auto add a user to the server by: Tait Hoglund

# This if statement first checks that I am Root User, then proceeds to ask the user for a username & pasword. 
# It then searches existing database to ensure there is no username already in existance.

if [ $(id -u) -eq 0 ]; then
        read -p "Select a Username : " username
        read -s -p "Set your Password : " password
        egrep "^$username" /etc/passwd > /dev/null

# If a user name is found, it prompts the user to pick another name. If the name is available, it then asks the user
# to pick a password and assigns it to that user and uses the perl command below to encrypt the password into
# etc/shadow, then adds the user and pass word to the system

                if [ $? -eq 0 ]; then
                                echo "$username already exists. Please choose a different username."
                                exit 1
                        else
                                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                                useradd -m -p $pass $username
                                [ $? -eq 0 ] && echo "You have been successfully added to the system" || echo "Authentication Error. Failed to Create New User"                       
			 fi
    else

	echo "Only a user with administrative privledges may add a user to the system."
                        exit 2
    fi
