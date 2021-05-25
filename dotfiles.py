import os
from pathlib import Path
import shutil
import sys

script_dir = os.path.dirname(os.path.realpath(__file__))

git_dir = os.path.join(script_dir, "storage")
home_dir = str(Path.home())

print("home_dir is: " + home_dir)
print("Dest dir is: " + git_dir)

to_copy = [
    ".config/nvim/init.vim",
    ".config/nvim/coc-settings.json",
    ".config/leftwm/config.toml",
    ".config/fish/functions/",
    ".config/fish/completions/",
    ".config/fish/fish_plugins",
    ".gitconfig",
    ".null.gitconfig",
    ".xinitrc",
#   ... Add each file or dir that needs to be copied
]

if "save" in sys.argv:
    if os.path.exists(git_dir):
        shutil.rmtree(git_dir)

    for path in to_copy:
        src = os.path.join(home_dir, path)
        dest = os.path.join(git_dir, path)
        if not os.path.exists(src):
            print("  WARNING: File {} doesn't exist!".format(src))
        else:
            if os.path.isfile(src):
                print(" Copying file... {} to {}".format(src, dest))
                parent = Path(dest).parent.absolute()
                if not os.path.exists(parent):
                    print("  Creating parent dirs: {}".format(parent))
                    os.makedirs(parent, exist_ok=True)
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
            parent = Path(dest).parent.absolute()
            if not os.path.exists(parent):
                print("  Creating parent dirs: {}".format(parent))
                os.makedirs(parent, exist_ok=True)
            shutil.copy(src, dest)

        else:
            print(" Copying directory... {} to {}".format(src, dest))
            if os.path.exists(dest):
                print("Trying to load from: " + src + " to " + dest)
                i = input(dest + " already exists. Delete? y/N")
                if i != "y":
                    continue
            shutil.copytree(src, dest, dirs_exist_ok=True)
else:
    print("Error: Unknown options: " + str(sys.argv) + " use " + sys.argv[0] + " <save|load>")




