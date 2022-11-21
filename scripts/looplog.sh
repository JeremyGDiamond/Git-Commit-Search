#!/bin/bash
#$1 = directory with the git project
#$2 = directory to compare it to

# removes old files from another run
rm commits.txt
rm diffsPerCommit.csv

# makes a list of every commit in file commits.txt
cat log.txt | while read line 
do
	if [[ "$line" == commit* ]] 
	then
  		echo ${line#"commit "} >> commits.txt
	fi
done

# splits the commits.txt list into n lists of length such that n=number of cores+1 for parallel processing
commitLen=$(sed -n '$=' commits.txt)
#echo $commitLen
cores=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
#echo $((cores))
div=$((commitLen / cores))
echo $div lines, $cores cores

split -l $div commits.txt 

#makes a list of all the split files
textSplit=(xa*)
echo ${textSplit[@]}

#makes a copy of the target git project for each split files 
for name in "${textSplit[@]}"
do
	echo "running copy for: "$name 
	cp -r $1 "$name$1" &
done

wait

for name in  "${textSplit[@]}"
do
	echo "running partfile for: "$name 
	./partFile.sh $name "$name$1" $2 &
done

wait

for name in  "${textSplit[@]}"
do
	echo "collecting diffs from: "$name 
	cat $name".csv" >> diffsPerCommit.csv
done

for name in "${textSplit[@]}"
do
	echo "running cleanup for: "$name 
	rm -r "$name$1" &
	rm -r $name &
 	rm -r $name".csv" &
done

wait



