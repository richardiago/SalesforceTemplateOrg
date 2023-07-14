import sys
import subprocess

if __name__ == "__main__":
   
   origin_branch = sys.argv[1]
   destination_branch = sys.argv[2]

   result = subprocess.run(
        ["git", "diff", "--name-only", origin_branch, destination_branch],
        stdout=subprocess.PIPE,
        text=True
   )
   
   print(result.stdout)
