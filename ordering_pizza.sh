#!/bin/bash

: <<'END'



##########################################################################

END

#Need to do float addition and subtraction
#*******************************************************************************

#declare -A size_menu=([Small]=7.00 [Medium]=9.00 [Large]=11.00 [X-Large]=13.00)
#declare -A topping_menu=([Sausage]=8.00 [Pepperoni]=8.00 [Cheese]=6.00 [Pineapple]=7.00 [Meat-Lovers]=10.00)

#this array contains the sizes and prices for each size. Key=Size, Value=Price
declare -A size_menu=([Small]=7 [Medium]=9 [Large]=11 [X-Large]=13)

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

echo "What size pizza would you like?"

#loop through the size menu, the ! looks through the keys. Print the sizes and prices
#declare -A size_menu=([Small]=7 [Medium]=9 [Large]=11 [X-Large]=13)
#! is to get the key (size). No exclamation mark gives the value (price)

for size in "${!size_menu[@]}";
do
	echo "Size: $size 		Price: \$${size_menu[$size]}";
done

#users input for what size they want
read -p "`echo $'\n>'`" size_selection

#loop through the sizes
for i in "${!size_menu[@]}"; do
        #if there is a match in the size menu with the size the customer entered (size_selection)
        if [[ "$i" == "$size_selection" ]]; then
        		#size_of_pizza = the size from the menu that matches what the customer wants
                size_of_pizza="$i"
                #price for that size is from the menu
                price_for_size="${size_menu[$i]}"
                #call the next function to find out what type of piza toppings they want
                what_type_pizza

         else
         	echo "Please enter a valid size"
         	what_size_pizza


 
        fi
done


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

#price_for_this_pizza_string=$(printf $price_for_this_pizza_int)
#echo "$price_for_this_pizza_int"

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
	echo "$name_of_pizza"


	#************************************************************************************
	#Add the key and value (name_of_pizza and price_for_this_pizza) to an array named cart here
	#************************************************************************************
	# Need to loop through the Keys and make sure that each key is unique as well
	#************************************************************************************
	cart["$name_of_pizza"]="$price_for_this_pizza_int"
 

	echo "This is the cart now"


	for pizza_order in "${!cart[@]}";do
		echo "Pizza: $pizza_order 		Price: \$${cart[$pizza_order]}";
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



########################################################################
#call functions in the end
what_size_pizza
#what_type_pizza