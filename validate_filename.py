import re
import sys
import subprocess

def validateFilename():

   output = subprocess.check_output(["git", "diff", "--name-only", "HEAD^", "HEAD"])
   files_changed = output.decode("utf-8").splitlines()

   # Check if any of the changed files match the pattern
   pattern = r"^[^_]*\.field-meta\.xml$"

   for file_name in files_changed:
    if not re.match(pattern, file_name):
        print(f"File name '{file_name}' does not match the required pattern")
        sys.exit(1)


if __name__ == "__main__":
   
   validateFilename()