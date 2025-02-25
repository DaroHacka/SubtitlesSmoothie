#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 youtube_url output_file.txt"
  exit 1
fi

# Define output file path
youtube_url="$1"
output_file="/home/.../SRT/ready/$2" # Paste your own directory here for example output_file="/home/user/tools/SubtitlesSmoothie/SRT/ready/$2".. The two provided files must be placed here. Leave /SRT/ready/$2 as is

# Download the VTT file using yt-dlp
echo "Downloading subtitles..."
yt_dlp_output=$(yt-dlp --skip-download --write-auto-sub --output "/home/.../SRT/%(title)s.%(ext)s" "$youtube_url" 2>&1) # add --sublang en (or any other language) if needed - place your own directory here as well 
# echo "$yt_dlp_output"  # Debug: Print the yt-dlp command output (delete the initial # if you need debugging)

# Extract the input file path
# input_file=$(echo "$yt_dlp_output" | grep -oP '(?<=Writing video subtitles to: ).*\.en-en\.vtt' | tr -d '\r')
input_file=$(echo "$yt_dlp_output" | grep -oP '/home/.../SRT/.*\.vtt' | head -n 1) # place your own directory here as well  

# Debug: Print the input file path
# echo "Downloaded VTT file: \"$input_file\"" (delete the initial # if you need debugging)

# Ensure the input file exists
if [ ! -f "$input_file" ]; then
  echo "Input file not found: \"$input_file\""
  exit 1
fi

# Convert .vtt to .srt using ffmpeg
srt_file="${input_file%.vtt}.srt"
ffmpeg -i "$input_file" "$srt_file"
input_file="$srt_file"

# Ensure the converted .srt file exists
if [ ! -f "$input_file" ]; then
  echo "Converted SRT file not found: \"$input_file\""
  exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p /home/.../SRT/ready # place your own directory here but leave /SRT/ready at the end where the file will be saved 

# Run the Python script to remove duplicate lines
python3 srt_fix.py "$input_file" "$input_file"

# Run the conversion command to remove line numbers and timestamps
# Replace newlines with spaces before removing them
sed -e '/^[0-9]/d' -e '/-->/d' "$input_file" | tr '\n' ' ' | tr -d '\r' > "$output_file"

echo "Conversion complete: \"$output_file\""
