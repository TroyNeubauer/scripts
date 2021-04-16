import os
from pathlib import Path
import shutil

script_dir = os.path.dirname(os.path.realpath(__file__))

dest_dir = os.path.join(script_dir, "dotfiles")
src_dir = str(Path.home())

print("Src dir for dot files is: " + src_dir)
print("Dest dir is: " + dest_dir)

to_copy = [
    ".config/nvim/init.vim",
    ".config/nvim/coc-settings.json",

#   ... Add each file or dir that needs to be copied
]

if os.path.exists(dest_dir):
    shutil.rmtree(dest_dir)


for path in to_copy:
    src = os.path.join(src_dir, path)
    dest = os.path.join(dest_dir, path)
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




