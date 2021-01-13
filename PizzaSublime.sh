#project adjustment
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
# Print the contents of an array on one line echo "${myArray[*]}"
# Print contents of an array on different lines $ printf '%s\n' "${my_array[@]}"
# $ printf '%s\n' "${array[@]}"
#
###################################################


# Clark's extra code - messing around with select functionality
#prompt the user to select a pizza size

: <<'END'
pizza_list=()
function order_pizza
{
echo "What size pizza would you like to order?:"
select SIZE in Small Medium Large Extra-Large
do
	echo "What pizza topping would you like?:"
	select TOPPING in Meat-Lovers Veggie Cheese Pineapple Sausage Pepperoni
	do
		this_order = "$SIZE $TOPPING"
		read -p "You have chosen a $this_order pizza. Is that correct?`echo $'\n'`" accept
		if accept == "Yes";then
			pizza_list+=($this_order)
		else
			order_pizza	
		fi
		break
	done
		read -p "Would you like to place another order?" add_order
		if add_order == "Yes";then
			order_pizza
		else
			:
		fi
done
echo $pizza_list
}
END

##########################################################################
# Start of assignment below                                              #
##########################################################################

declare -A pizza_sizes=([Small]=7 [Medium]=9 [Large]=11 [X-Large]=13)
pizza_list=()
declare -A pizza_toppings=([Cheese]=7 [Veggie]=5 [Sausage]=5 [Pepperoni]=7)

function order_pizza
{

#Exclamation is to get the key of the array, @symbol prints on different lines, * prints out different lines
	echo "What size pizza would you like to order?:"
	for size in "${!pizza_sizes[@]}";
	do
		echo "Size:$size           Price: \$${pizza_sizes[$size]}";
	done

	read -p "" users_input

	for i in "${!pizza_sizes[@]}":
	do
#Run through the pizza sizes array and see if there is a key that matches users_input(i)
		if [[ "$i" == $users_input ]]; then
			size_of_pizza=$i			price_for_pizza="${pizza_sizes[$i]}"
			echo "Your pizza size is $size_of_pizza and the price is $price_for_pizza"
		fi
	done


}
order_pizza

	echo "What type of pizza topping would you like?:"
	for toppings in "${!pizza_toppings[@]}";
	do
		echo "Toppings:$toppings           Price: \$${pizza_toppings[$toppings]}";
	done

	read -p "" users_input_2

	for b in "${!pizza_toppings[@]}":
	do

	if [[ "$b" == "$users_input_2" ]]; then

		pizza_toppings=$b			price_for_pizza_2="${pizza_toppings[$b]}"
		echo "Your pizza topping is $pizza_toppings and the price is $price_for_pizza_2"
	

		echo "This is your current order. Would you like to add another pizza?"
		echo "${pizza_list[@]}"
		read -p "`echo $'\n>'`" add_pizza
	
	fi


		order_pizza
END
