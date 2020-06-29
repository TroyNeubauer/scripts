#!/usr/bin/env python3

import argparse
import subprocess
import os
import sys
import shutil


def getSize(string):
	try:
		return float(string)
	except Exception as e:
		if 'k' in string:
			return int(''.join(list(filter(str.isdigit, string)))) * 1000
		if 'm' in string:
			return int(''.join(list(filter(str.isdigit, string)))) * 1000 * 1000


parser = argparse.ArgumentParser(description='Converts video files to sizes sutiable for discord')
parser.add_argument('file', metavar='FILE', help='The source file to compress')
parser.add_argument('--output', '-o', default='encoded.mp4', help='Specifies where the output file is (overwrites any old files)')
parser.add_argument('--size', '-s', default='8mb', help='Specifies the max size allowed for the output file in bytes (or use values like 8mb to represent megabytes)')
parser.add_argument('--resolution', '-r', default='1280x720', help='Specifies how large the output frame size is')


results = parser.parse_args()

args = "ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1".split()
args.append(results.file)

length = float(subprocess.check_output(args).decode().strip())
print("Video length is: " + str(length) + " seconds")
maxSize = getSize(results.size)
print("Output size is no larger than: " + str(maxSize) + " bytes")
print("Output frame size is: " + results.resolution)


bitrate = (maxSize) / length
print("Bitrate is: " + str(bitrate) + " bits/second")

args = []
args.append("ffmpeg")

args.append("-y")
args.append("-i")
args.append(results.file)

args.append("-b:v")
args.append(str(int(bitrate)) + "B")


args.append(results.output)



ffmpegPath = shutil.which("ffmpeg")

print("Running ffmpeg at path: " + ffmpegPath + " with args " + str(args))
sys.stdout.flush()

os.execve(ffmpegPath, args, os.environ.copy())

