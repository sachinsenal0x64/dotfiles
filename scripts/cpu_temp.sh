# Store the temperature in a variable
temperature=$(sensors | grep -Po '(?<=Package id 0:  \+)([0-9]{1,3})' | tr -d '\n')°C

# Display the temperature using echo
echo "$temperature"

