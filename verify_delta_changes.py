import os
import sys
import subprocess

def verifyDeltaChages(origin_branch, destination_branch):

   # Fetch the latest changes
   subprocess.run("git fetch --all", shell=True)

   # Get the list of files that have changed
   result = subprocess.run(
      ["git", "diff", "--name-only", origin_branch, destination_branch, "force-app/main/default"],
      stdout=subprocess.PIPE,
      text=True
   )

   # Concatenate the files into a single string
   files       = result.stdout.split('\n')
   concatFiles = ''

   for file in files:
     if os.path.exists(file):
        concatFiles += ' ' + file

   print(concatFiles)

if __name__ == "__main__":
   
   verifyDeltaChages(sys.argv[1], sys.argv[2])

   
