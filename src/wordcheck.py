name_file = open("../data/black.txt","r")
name_file2 = open("../data/white.txt","r")
names = set(name_file.read().split("\n"))
names |= set(name_file2.read().split("\n"))
names.remove("")

print(names)

data = open("../data/news-commentary-v15.en","r")
lines = data.readlines()

for name in names:
    line_count = 0
    for i,line in enumerate(lines):
        if name in line:
            line_count += 1
    if line_count == 0:
        print(name)
