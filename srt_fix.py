import re
import argparse

def remove_duplicates(lines):
    """Removes duplicate lines from the list of subtitle lines."""
    seen = set()
    result = []
    for line in lines:
        if line not in seen:
            seen.add(line)
            result.append(line)
    return result

def fix_subtitle_file(input_file, output_file):
    with open(input_file, 'r', encoding='utf-8') as infile:
        lines = infile.readlines()

    # Removing duplicate lines
    fixed_lines = remove_duplicates(lines)

    # Writing the fixed subtitles to a new file
    with open(output_file, 'w', encoding='utf-8') as outfile:
        outfile.writelines(fixed_lines)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Fix subtitle files by removing duplicate lines.')
    parser.add_argument('input_file', type=str, help='The input subtitle file (.srt)')
    parser.add_argument('output_file', type=str, help='The output subtitle file (.srt)')

    args = parser.parse_args()
    fix_subtitle_file(args.input_file, args.output_file)
