#!/bin/sh

cache_file="$HOME/.cache/wallpaper_cache"
images_dir="$HOME/dotfiles/wallpapers/"

# Function to set wallpaper and update cache
set_wallpaper() {
  feh --bg-fill "$1"
  wal -i "$1"
  echo "$1" > "$cache_file"
  qtile cmd-obj -o cmd -f restart
  pywalfox update
  rm ~/.fehbg

}

# Read the cache to get the last displayed wallpaper
if [ -f "$cache_file" ]; then
  current_wallpaper=$(cat "$cache_file")
else
  current_wallpaper=$(find "$images_dir" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)
  echo "$current_wallpaper" > "$cache_file"
fi

# Get a list of images in the directory
all_images=($(find "$images_dir" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \)))

# Determine the index of the current wallpaper in the list of images
current_index=0
for ((i = 0; i < ${#all_images[@]}; i++)); do
  if [ "${all_images[i]}" = "$current_wallpaper" ]; then
    current_index=$i
    break
  fi
done

# Determine the next or previous wallpaper index based on the argument provided
if [ "$1" == "next" ]; then
  next_index=$(( (current_index + 1) % ${#all_images[@]} ))
  next_wallpaper="${all_images[next_index]}"
elif [ "$1" == "prev" ]; then
  prev_index=$(( (current_index - 1 + ${#all_images[@]}) % ${#all_images[@]} ))
  next_wallpaper="${all_images[prev_index]}"
else
  next_wallpaper="$current_wallpaper" # Load from cache if no argument provided
fi

# Set the next wallpaper or select the first image if the current one is not found
if [ -n "$next_wallpaper" ]; then
  set_wallpaper "$next_wallpaper"
else
  set_wallpaper "${all_images[0]}"
fi

