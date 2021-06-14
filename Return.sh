date1=$(zenity --calendar --title "Booking" --text "Select your journey date")
date2=$(zenity --calendar --title "Booking" --text "Select your return date")
from=$(zenity  --list  --text "From" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)
to=$(zenity  --list  --text "To" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)
while [ $from = $to ]
do
zenity --error --text "Same source and destination. Please select again"
from=$(zenity  --list  --text "From" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)
to=$(zenity  --list  --text "To" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE)
done
if [ $from = "Mumbai" ]; then
	case $to in
		"Delhi") cost=6000;;
		"Chennai") cost=13000;;
		"Kolkata") cost=18000;;
		"Bangalore") cost=3000;;
	esac
fi

if [ $from = "Delhi" ]; then
	case $to in
		"Mumbai") cost=6000
		;;
		"Chennai") cost=20000
		;;
		"Kolkata") cost=4000
		;;
		"Bangalore") cost=16000
		;;
	esac
fi

if [ $from = "Chennai" ]; then
	case $to in
		"Mumbai") cost=13000
		;;
		"Delhi") cost=20000
		;;
		"Kolkata") cost=25000
		;;
		"Bangalore") cost=2000
		;;
	esac
fi

if [ $from = "Kolkata" ]; then
	case $to in
		"Mumbai") cost=18000
		;;
		"Delhi") cost=4000
		;;
		"Chennai") cost=25000
		;;
		"Bangalore") cost=26000
		;;
	esac
fi

if [ $from = "Bangalore" ]; then
	case $to in
		"Mumbai") cost=3000
		;;
		"Delhi") cost=16000
		;;
		"Chennai") cost=2000
		;;
		"Kolkata") cost=26000
		;;
	esac
fi
ticket=$(zenity --entry --text "Enter number of tickets")
ticket1=$(($(($ticket)) * 2))
tick=$ticket
zenity --info --text "Passenger Details"
while [ $tick != "0" ]
do
fname=$(zenity --entry --text "First name")
lname=$(zenity --entry --text "Last name")
email=$(zenity --entry --text "Email address")
contact=$(zenity --entry --text "Contact number")
mysql -u root -pApnapassword <<EOF
USE project
INSERT INTO third values('$date1','$date2','$from','$to','$fname','$lname','$email','$contact');
EOF
tick=$(($tick-1))
done
zenity --info --text "Journey fare is $cost"
amount=$(($(($cost)) * $(($ticket1))))
zenity --info --text "Total amount to be paid is $amount"


