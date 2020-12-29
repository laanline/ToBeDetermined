#!/bin/bash

#Put graphics here
#Delivery or carryout

read -p "Is this order for [1] Pickup or [2] Delivery?:" order_type

if (($order_type == "1" || $order_type == "Pickup"));then
echo "What is the name for the Pickup order?"

elif (($order_type == "2" || $order_type == "Delivery"));then
echo "What is the name for the Delivery order?"

else
echo "Please enter a valid option"

fi
