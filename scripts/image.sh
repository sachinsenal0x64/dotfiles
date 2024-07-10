#!/bin/sh


path_or_url="$1"

# Function to check if the image format is WebP by inspecting the MIME type
is_webp() {
    local mimetype=$(curl -sI "$1" | grep -i "content-type" | awk '{print $2}' | tr -d '\r')
    [[ "$mimetype" == "image/webp" ]]
}


# Check if the input is a local file
if [[ -f $path_or_url ]]; then
    # Check if the file is a WebP image
    mimetype=$(file --mime-type -b "$path_or_url")
    if [[ "$mimetype" == "image/webp" ]]; then
        # Convert the local WebP image to JPEG using ffmpeg, then pipe to wezterm imgcat, hiding all output
        ffmpeg -loglevel quiet -i "$path_or_url" -f image2pipe -vcodec mjpeg - | wezterm imgcat 
    else
        # Directly display the local image if it's not WebP
        wezterm imgcat "$path_or_url"
    fi
else

    if [[ $path_or_url == http://* || $path_or_url == https://* ]]; then
        # Check if the URL points to a WebP image
        if is_webp "$path_or_url"; then
            # Download the WebP image and convert it to JPEG using ffmpeg, then pipe to wezterm imgcat, hiding all output
            curl -s "$path_or_url" | ffmpeg -loglevel quiet -i pipe:0 -f image2pipe -vcodec mjpeg - | wezterm imgcat
        else
            # Directly download and display the image if it's not WebP
            curl -s "$path_or_url" | wezterm imgcat 
        fi
    else
        echo "Invalid input. Please provide a valid file path or URL."
    fi
fi
