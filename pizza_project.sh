#!/bin/bash


##############################################################################
# NOTES:
#loop through the size menu, the ! looks through the keys. Print the sizes and prices
#declare -A size_menu=([Small]=7 [Medium]=9 [Large]=11 [X-Large]=13)
#! is to get the key (size). No exclamation mark gives the value (price)
#
##############################################################################

: <<'END'



##########################################################################

END

#Need to do float addition and subtraction
#*******************************************************************************

#declare -A size_menu=([Small]=7.00 [Medium]=9.00 [Large]=11.00 [X-Large]=13.00)
#declare -A topping_menu=([Sausage]=8.00 [Pepperoni]=8.00 [Cheese]=6.00 [Pineapple]=7.00 [Meat-Lovers]=10.00)

#this array contains the sizes and prices for each size. Key=Size, Value=Price
declare -A size_menu=(["Small"]=7 ["Medium"]=9 ["Large"]=11 ["X-Large"]=13)

#size array normal
size_array=( "Small" "Medium" "Large" "X-Large" )

#append key to this array
declare -A cart_count_array

#this array contains the toppings and prices for those toppings. Key=Topping, Value=Price
declare -A topping_menu=([Sausage]=8 [Pepperoni]=8 [Cheese]=6 [Pineapple]=7 [Meat-Lovers]=10)

#not being used yet, but it will allow manipulation of the final order
declare -A final_order_size
declare -A final_order_topping_selection
declare -A piza_size_and_topping

#the cart
declare -A cart

#number of pizzas in the cart
number_of_pizzas=""


#function for what size pizza would you like

function what_size_pizza

{

#stores the price for the size selected from the array
price_for_size=""

#stores the size that the customer selected
size_of_pizza=""

#flag to see if size is found
found_size=false

echo "What size pizza would you like?"

for size in "${!size_menu[@]}";
do
	echo "Size: $size 		Price: \$${size_menu[$size]}";
done

#users input for what size they want
read -p "`echo $'\n>'`" size_selection

#loop through the sizes
for i in "${!size_menu[@]}"; do
	#echo "Loop ${#size_menu[@]}"
        #if there is a match in the size menu with the size the customer entered (size_selection)
        if [[ "$i" == "$size_selection" ]]; then
        		#set found = true
        		found_size=true
        		#size_of_pizza = the size from the menu that matches what the customer wants
                size_of_pizza="$i"
                #price for that size is from the menu
                price_for_size="${size_menu[$i]}"
                #call the next function to find out what type of piza toppings they want
                what_type_pizza
                break
        fi
done

if [ "$found_size" == "false" ]; then

	echo "You entered $size_selection"
    echo "Please enter a valid size"
    what_size_pizza

fi



}

######################################################################

#function for what type of pizza topping you want

function what_type_pizza

{

#price for topping and what topping they want
price_for_topping=""
topping_of_pizza=""

echo -e "\nWhat type of topping would you like for your pizza?"

#loop through the toppings and print the topping and price
for topping in "${!topping_menu[@]}";
do
	echo "Topping: $topping 		Price: \$${topping_menu[$topping]}";
done

#user enters what topping they want
read -p "`echo $'\n>'`" topping_selection

#loop through the keys of the topping menu (the topping name)
for i in "${!topping_menu[@]}"; do
        
        #if a topping in the topping menu matches the topping the user entered (topping_selection)
        if [[ "$i" == "$topping_selection" ]]; then
        		#topping of the pizza=the iteration in the loop that matches the users input
        		#price for the topping is the value of that key
                topping_of_pizza="$i"
                price_for_topping="${topping_menu[$i]}"
      
        fi
done

#calculate the price for the pizza from the size price and topping price
price_for_this_pizza_int=$(( "$price_for_size" + "$price_for_topping" )) 


#read their order back to them
echo -e "You have chosen a $size_of_pizza $topping_of_pizza Pizza for \$$price_for_this_pizza_int"


#did they order the correct thing?
read -p "Is this correct?:`echo $'\n>'`" correct_selection

#if what the user selected is correct
if [[ "$correct_selection" == "Yes" ]]; then 
	echo "Good Job"

	#add 1 pizza to the cart (number_of_pizzas) and echo how many pizzas are in the cart
	number_of_pizzas=$((number_of_pizzas+1))
	echo "Amount of pizzas in cart: $number_of_pizzas"

	
	#Make the name of the pizza the size and topping (ex: Large Pepperoni) and add it as a key
	#Save the price as a value in an array

	name_of_pizza="${size_of_pizza} ${topping_of_pizza} Pizza"
	#echo "$name_of_pizza"


	#if the cart contains the pizza already
	if [ ${cart["$name_of_pizza"]+true} ];then
			#from the cart count array, for the element at name of pizza, increment by one
			(( cart_count_array["$name_of_pizza"]++ ))


	else
			#add to the cart at index $name_of_pizza, the price for the pizza
			cart["$name_of_pizza"]="$price_for_this_pizza_int"
			#initialize the number of that kind of pizza in the cart
			cart_count_array["$name_of_pizza"]=1
	fi

 
	#show them what is in their cart
	echo "This is the cart now"
	echo "************************************************************************************"

	#loop through cart, for each key, print the key, value, and count (from cart count array at that element)
	for pizza_order in "${!cart[@]}";do
		echo "Pizza: $pizza_order 		Price: \$${cart[$pizza_order]}		Count: ${cart_count_array[$pizza_order]}";
	done

	#************************************************************************************

	#does the user want another pizza
	read -p "Would you like to add another pizza?:`echo $'\n>'`" thank_you_sir_may_i_have_another

	#if yes find out what size
	if [[ "$thank_you_sir_may_i_have_another" == "Yes" ]]; then
		what_size_pizza
	else
		echo "That's all for now"


	fi

#if what the user selected was wrong
else

	echo "Sorry, let's try that again"

	what_size_pizza

fi

}



function get_customer_information
{
	# Prompt user for delivery or pickup

#read -p "Is this order for [1] Pickup or [2] Delivery?:`echo $'\n>'`" order_type
read -p "Type [1] for Pickup or [2] for Delivery:`echo $'\n>'`" order_type

# Delivery and carryout instructions below (if, elif, else)

# if the order type is pickup or 1, ask for name and phone number

#if (( "$order_type" == "1" || "$order_type" == "Pickup" ));then
if (( order_type == "1" ));then	
	echo "You have chosen Pickup"
	# 1) ask for the customers name 
	read -p "What is the name for the order?:`echo $'\n>'`" customer_name

	# 2) ask for the customers phone number
	read -p "What is the phone number for the order?:`echo $'\n>'`" phone_number

# else if the order type is Delivery, ask for delivery information
# ******************************************************************
# ERROR = If you type delivery, it reads it as Pickup - Need to fix
#*******************************************************************
#elif (( "$order_type" == "2" || "$order_type" == "Delivery" ));then
elif (( order_type == "2" ));then

	echo "You have chosen Delivery"

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

	# ask for the city, save in variable city 
	read -p "What is the city:?:`echo $'\n>'`" city

	# ask for the state, save in variable state
	read -p "What is the state?:`echo $'\n>'`" state

	# ask for the zip
	read -p "What is the zip code?:`echo $'\n>'`" zip
  

#else - if the user enters an invalid option - will do later

else
	echo "Please enter a valid option"
	get_customer_information

fi

what_size_pizza
}

########################################################################
#call functions in the end
get_customer_information
#what_size_pizza
#what_type_pizza

