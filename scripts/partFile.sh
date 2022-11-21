#!/bin/bash
#partFile.sh
# $1 is textSplit element that is to be used as a name and list of commits to check
# $2 is $1 + git project name
# $3 is the detached project name

cd $2

#refreshes all the indexes
git status

cd ..
# for every commit in the $1 file run a git stash, checkout to that commit and run difffile.sh
cat $1 | while read line 
do
	cd $2
	git stash
	sleep 1
	git checkout $line
	sleep 1
	cd ..
	#echo $PWD
	./difffile.sh $line $1 $2 $3
done
