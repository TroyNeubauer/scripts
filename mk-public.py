#!/usr/bin/env python3

import argparse
import os
import sys

def shellquote(s):
	return "'" + s.replace("'", "'\\''") + "'"

def fix_fs_name(s):
	return s.replace("\\ ", " ")


def is_valid_file(parser, arg):
	if arg == "default":
		return arg
	file = os.path.abspath(fix_fs_name(arg))
	if not os.path.exists(file):
		parser.error("The file %s does not exist!" % file)
	else:
		return arg


parser = argparse.ArgumentParser(description=
	'''Moves the specified file into the public space of my website,
	setting the relevent permissions. If this file resizes in Downloads/** then its parent folder in Downloads/XXX will be deleted unless --no-delete is specified''')

parser.add_argument('file', metavar='FILE', type=lambda x: is_valid_file(parser, x), help='Specifies which file to use')
parser.add_argument('name', nargs='?', default='default', help='Renames the file to this name once on the server')
parser.add_argument('--no-delete', '-nd', action='store_true', help='Disables deleting')


results = parser.parse_args()

file = results.file
if results.name != 'default':
	fileName = results.name
else:
	fileName = os.path.basename(file)
	if ' ' in fileName:
		print("The file: " + fileName + " contains spaces in its name")
		line = input("Do you want to exit?")
		if "y" in line:
			sys.exit(0)

if results.no_delete:
	cmdName = "cp"
else:
	cmdName = "mv"

print("File " + file)
print("Dest name " + fileName)


destPath = shellquote('/home/host/web/tneubauer.xyz/files/public/' + fileName)
print("Dest path is " + destPath)
os.system('sudo ' + cmdName + ' ' + shellquote(file) + ' ' + destPath)
os.system('sudo chown html ' + destPath)

absPath = os.path.abspath(file)
if not results.no_delete and "/home/troy/Downloads" in absPath:
	print("Deleting Download/XXX dir")
	delFolder = absPath.replace("/home/troy/Downloads/", "").split(os.sep)[0]
	print("Deleting " + delFolder)
	os.system('rm -r ' + shellquote('/home/troy/Downloads/' + delFolder))
