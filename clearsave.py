# importing required packages
import pathlib
import shutil
import os
 
dir = pathlib.Path(__file__).parent.resolve()

print(dir)


checkPath = os.path.join(dir, "saves")
if not os.path.exists(checkPath):
    os.makedirs(checkPath)



givenSrc = "levels"
givenDst = "saves"

# defining source and destination
# paths
src = os.path.join(dir, givenSrc)
dst = os.path.join(dir, givenDst)

print(src)
print(dst)
 
files=os.listdir(src)
 
# iterating over all the files in
# the source directory
for fname in files:

    if fname.endswith('tscn'):
     
        # copying the files to the
        # destination directory
        shutil.copy2(os.path.join(src,fname), dst)