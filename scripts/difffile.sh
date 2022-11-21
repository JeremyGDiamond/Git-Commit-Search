#!/bin/bash
# $1 is the commit hash
# $2 = textSplit element that is to be used as a name and list of commits to check
# $3 = $2 + git project name
# $4 = detached project name

# fname = commit hash removing the new line charater .txt
fname=${1%"\n"}.txt
echo $fname
rm -f $fname


LC_ALL=C diff -rq $4 $3 | grep -v '^Only in' >> $fname
diff=$(wc -l $fname)
echo $diff
diffnum=${diff%" $fname"}
echo $1,$diffnum >> $2".csv"
rm $fname

