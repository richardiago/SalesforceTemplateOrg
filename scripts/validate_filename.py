import os
import re
import sys
import subprocess

def validateFilename(origin_branch, destination_branch):

   output = subprocess.check_output(["git", "diff", "--name-only", origin_branch, destination_branch])
   files_changed = output.decode("utf-8").splitlines()

   # Check if any of the changed files match the pattern
   pattern = r"^[^_]*\.field-meta\.xml$"

   for file_name in files_changed:
    if os.path.exists(file_name):
        if not re.match(pattern, os.path.basename(file_name)):
            print(f"File name '{file_name}' does not match the required pattern")
            sys.exit(1)


if __name__ == "__main__":
   
   validateFilename(sys.argv[1], sys.argv[2])