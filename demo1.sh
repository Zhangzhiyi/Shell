#!/bin/sh
cd ~
mkdir shellDemo
cd shellDemo

for ((i=0; i<10; i++)); do    
	touch test_$i.txt
done