# SubtitlesSmoothie <img src="https://github.com/user-attachments/assets/ece5a7ef-4e3c-4540-a879-7ec602b0e9b2" alt="SubtitlesSmoothie logo" width="300" align="right"/>

download youtube captions in a readable format


I created SubtitlesSmoothie to easily download subtitles from YouTube videos using Linux Terminal. The tool converts them into a readable format without time codes, numbers, or segmentation. The process is simple and works in a few steps: 

prerequisites: To use SubtitlesSmoothie, you need to have both yt-dlp and ffmpeg installed on your system. 
run sudo apt-get install yt-dlp and sudo apt-get install ffmpeg


1. Place the two files into a directory of your choice and insert the path into the provided code as indicated by the # comments
2. Make the script executable by running the following command: chmod +x SubtitlesSmoothie.sh
3. Launch the program by typing `./SubtitlesSmoothie.sh youtube_link name_of_the_file_as_you_want_to_save_it`.

These are the steps taken by SubtitlesSmoothie
1. yt-dlp downloads the subtitles in the `.vtt` format.
2. The script uses `ffmpeg` to convert `.vtt` to `.srt`.
3. A Python script (`srt_fix.py`) removes duplicate lines, numbers, and timestamps.
4. Finally, `sed` and `tr` commands format the subtitles into a continuous block of text.

This streamlined process ensures you get clean, readable subtitles quickly and efficiently that you can use in your articles, research, thesis, notes, emails, and more.
