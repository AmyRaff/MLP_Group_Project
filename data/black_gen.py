names = ['Melanie', 'Josh', 'Heather', 'Stephen', 'Justin', 'Ellen', 'Alan', 'Jack', 'Courtney', 'Frank', 'Paul', 'Amanda', 'Andrew', 'Rachel', 'Ryan', 'Harry', 'Lauren', 'Colleen', 'Megan', 'Kristin', 'Roger', 'Jonathan', 'Betsy', 'Stephanie', 'Adam', 'Peter', 'Katie', 'Nancy']

file = open("white.txt","w")

for i in range(0,25):
    file.write(names[i])
    file.write("\n")
