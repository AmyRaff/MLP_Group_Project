import string
import json 

clean_output = open("../data/clean_RC",'w',encoding='utf-8')
translator = str.maketrans(string.punctuation, ' '*len(string.punctuation))
data = []
with open(file='/disk/scratch/s2112744/RC_2017',encoding='utf-8') as f:
    line_count = 0
    while line_count <= 50000:
        for idx,line in enumerate(f):
            comment_line = json.loads(line)
            comment = comment_line["body"]
            if comment != '[deleted]' and comment != '[removed]':
                comment = comment.replace("&gt;"," ")
                comment = comment.replace("&amp;"," ")
                comment = comment.replace("&lt;"," ")
                comment = comment.replace("&quot;"," ")
                comment = comment.replace("&apos;"," ")
                comment = comment.translate(translator)
                data.append(comment)
                line_count += 1
                clean_output.write(comment)
                clean_output.write("\n")
    print(line_count)
    print("data extracted")  

clean_output.close()
