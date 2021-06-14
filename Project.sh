#!/bin/sh
zenity --info --title "Hello" --text "Welcome to ABC Airlines"
name=$(zenity --entry --text "Enter your name")
type=$(zenity --list --text  "Journey type" --column "Type" One-Way Return)
mysql -u root -pApnapassword <<EOF
USE project
INSERT INTO first values('$name','$type');
EOF
if [ $type = "One-Way" ]; then
	chmod 755 Oneway.sh
	./Oneway.sh
else
	chmod 755 Return.sh
	./Return.sh
fi



