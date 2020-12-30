#!/bin/bash


###################################################
# 
# NOTES:
# Need to add graphics to the top
# Inserting letters or numbers other than 1 and 2 is not working
# To get the '>' on a new line after the read statement, use `echo $'\n>'`
# To add a new line in read, use `echo $'\n'`
# ` is a backtick, and ' is apostrophe
# You can't have an if else or elif statement if you don't add logic to it. To "pass", type :, and you can add logic later
#
###################################################


# Prompt user for delivery or pickup

read -p "Is this order for [1] Pickup or [2] Delivery?:`echo $'\n>'`" order_type

# Delivery and carryout instructions below (if, elif, else)

# if the order type is pickup or 1, ask for name and phone number

if (( $order_type == "1" || $order_type == "Pickup"));then
	# 1) ask for the customers name (Christelle) - replace your code with the colon below
	:

	# 2) ask for the customers phone number (Christelle)

# else if the order type is Delivery, ask for delivery information

elif (($order_type == "2" || $order_type == "Delivery"));then

	# ask for name for order
	read -p "What is the name for the order?:`echo $'\n>'`" customer_name

	# ask for the phone number for the order
	read -p "What is the phone number for the order?:`echo $'\n>'`" phone_number
	
	#address information goes below

	# ask for the location type
	read -p "Choose a location type (House, Apartment, Business, Campus Dorm, School Building, Hotel):`echo $'\n>'`" location_type

	# ask for street address
	read -p "Street Address:`echo $'\n>'`" street_address

	#ask for apartment number
	read -p "Apartment Number (optional):`echo $'\n>'`" apartment_number

	# ask for the city, save in variable city (Christelle)

	# ask for the state, save in variable state (Christelle)

	# ask for the zip, save in variable zip (Christelle)
  

#else - if the user enters an invalid option - will do later

else
	echo "Please enter a valid option"

fi



#extra code - messing around with select functionality
#prompt the user to select a pizza size

: <<'END'

echo "What size pizza would you like to order?:"
select SIZE in Small Medium Large Extra-Large
do
	echo "What pizza topping would you like?:"
	select TOPPING in Meat-Lovers Veggie Cheese Pineapple Sausage Pepperoni
	do
		echo "You have chosen a $SIZE $TOPPING pizza. Is that correct?"
	done
esac
done


END



