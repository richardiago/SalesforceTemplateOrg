import sys
import os
import subprocess


if __name__ == "__main__":
   
   original_branch = sys.argv[1]
   destination_branch = sys.argv[2]

   subprocess.run(["git", "diff --name-only " + original_branch + " " + destination_branch])
