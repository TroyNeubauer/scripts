import os
from pathlib import Path
import shutil
import sys

script_dir = os.path.dirname(os.path.realpath(__file__))

git_dir = os.path.join(script_dir, "dotfiles")
home_dir = str(Path.home())

print("home_dir is: " + home_dir)
print("Dest dir is: " + git_dir)

to_copy = [
    ".config/nvim/init.vim",
    ".config/nvim/coc-settings.json",

#   ... Add each file or dir that needs to be copied
]

if "save" in sys.argv:
	if os.path.exists(git_dir):
		shutil.rmtree(git_dir)


	for path in to_copy:
		src = os.path.join(save_dir, path)
		dest = os.path.join(git_dir, path)
		if os.path.isfile(src):
			print(" Copying file... {} to {}".format(src, dest))
			if not os.path.exists(dest):
				dirs = os.path.join(dest, os.pardir)
				print("  Creating parent dirs: " + dirs)
				os.makedirs(dirs, exist_ok=True)
			shutil.copy(src, dest)

		else:
			print(" Copying directory... {} to {}".format(src, dest))
			shutil.copytree(src, dest)

elif "load" in sys.argv:
	for path in to_copy:
		src = os.path.join(git_dir, path)
		dest = os.path.join(home_dir, path)
		if os.path.isfile(src):
			print(" Copying file... {} to {}".format(src, dest))
			if not os.path.exists(dest):
				dirs = os.path.join(dest, os.pardir)
				print("  Creating parent dirs: " + dirs)
				os.makedirs(dirs, exist_ok=True)
			shutil.copy(src, dest)

		else:
			print(" Copying directory... {} to {}".format(src, dest))
			if os.path.exists(dest):
				print("Trying to load from: " + src + " to " + dest)
				print("")
				i = input(dest + " already exists. Delete? y/N")
				if i != "y":
					continue
			shutil.copytree(src, dest, dirs_exist_ok=True)
else:
	print("Error: Unknown options: " + str(sys.argv) + " use " + sys.argv[0] + " <save|load>")




