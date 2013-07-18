f = open("activities.txt")
out = open("json.txt", "w")
out.write("[")

content = f.readlines()

count = 1
for line in content:
	line = line.strip()
	temp = line.split(" ")
	temp[0] = "<b>" + temp[0] + "</b>"
	line = " ".join(temp)
	#print(line)
	out.write('{')
	out.write('"id": ' + str(count) + ',')
	out.write('"description": "' + line + '"') 	
	if count == 1:
		out.write(',"isCurrent": true')
	if count == len(content):
		out.write(',"isLast": true')
		out.write('}\n')
	else:
		out.write('},\n')
	count = count + 1
	
out.write("]")

f.close()
out.close()
