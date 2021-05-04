import os
arr = os.listdir("notmyluas")
for file in arr:
    with open("notmyluas/" + file, "a", encoding="utf8") as f:
        f.write("\n\n")
