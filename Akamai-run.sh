#!/bin/bash

# Congratulations! You found the easter egg! ❤️
# おめでとうございます！イースターエッグを見つけました！❤️

# Define the text to animate
text="♥PEACE♥FOR♥ALL♥PEACE♥FOR♥ALL♥PEACE♥FOR♥ALL♥PEACE♥FOR♥ALL♥"

# Get terminal dimensions
cols=$(tput cols)
lines=$(tput lines)

# Calculate the length of the text
text_length=${#text}

# Hide the cursor
tput civis

# Trap CTRL+C to show the cursor before exiting
trap "tput cnorm; exit" SIGINT

# Set frequency scaling factor
freq=0.2

# Infinite loop for continuous animation
for (( t=0; ; t+=1 )); do
    # Extract one character at a time
    char=${text:t % text_length:1}

    # Calculate angle
    angle=$(echo "$t * $freq" | bc -l)

    # Calculate sine of the angle (vertical displacement)
    sine_value=$(echo "s($angle)" | bc -l)

    # Map sine (-1..1) to row position within terminal height
    mid=$((lines / 2))
    offset=$(echo "$sine_value * $mid" | bc -l)
    row=$(printf "%.0f" "$(echo "$mid + $offset" | bc -l)")

    # Map time step to column position
    col=$((t % cols))

    # Pick a color (cycling through 256-color palette)
    color=$((t % 256))

    # Print the character at calculated position with color
    tput cup $row $col
    echo -ne "\033[38;5;${color}m${char}\033[0m"

    # Small sleep for smoother animation
    sleep 0.02
done
