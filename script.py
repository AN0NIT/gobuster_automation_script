#!/bin/usr/env python3

fhandle = open("gobuster/direct.txt")
fh = open("gobuster/put.txt",'w')

str = list()
for lines in fhandle:
	str=lines.split()
	fh.write(str[0])
	fh.write("\n")
	print(str[0])

fh.close()
fhandle.close()

