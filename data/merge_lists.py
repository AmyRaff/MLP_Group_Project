competent = ['able', 'effective', 'bright', 'practical', 'capable', 'critical', 'brilliant', 'creative', 'wise', 'logical', 'efficient', 'competitive', 'skilled', 'intelligent', 'rational', 'competent','determined', 'active', 'independent', 'dominant', 'secure', 'dedicated', 'aggressive', 'confident', 'persistent', 'ambitious', 'daring', 'energetic', 'conscientious', 'motivated', 'resolute', 'industrious']

incompetent = ['unable', 'stupid', 'naive', 'foolish', 'dumb', 'ignorant', 'incapable', 'irrational', 'inefficient', 'clumsy', 'impractical', 'unwise', 'incompetent', 'inept', 'uneducated', 'unimaginative','dependent', 'anxious', 'doubtful', 'helpless', 'dominated', 'vulnerable', 'cautious', 'meek', 'lazy', 'careless', 'inactive', 'sporadic', 'submissive', 'docile', 'insecure', 'negligent']

def countList(lst1, lst2):
    return [sub[item] for item in range(len(lst2))
                      for sub in [lst1, lst2]]
      

output = open("comp_stereotypes.txt","w")

com_list = countList(competent,incompetent)
for word in com_list:
    output.write(word)
    output.write("\n")
output.close()
