import sys
import os

if __name__ == "__main__":
   
   original_branch = sys.argv[1]
   destination_branch = sys.argv[2]
   
   os.system("git diff --name-only " + original_branch + " " + destination_branch)
