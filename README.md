# Git-Commit-Search
Find the commit that is most like a local copy of a git repo. Used to resync the work of another developer's orphaned fork

## Motivation

At one point, I was tasked with replicating the modifications another dev made to a large open-source project before leaving the company. Instead of cloning the repo this dev downloaded the zip file of the project and I had no idea what he had changed. He could have used any version of the project over months of the previous year. I had to make a way to search every version of the project.

These scripts allow you to diff every file in every commit on a branch of a project against an orphaned directory and get a total of the number of differences for a given hash in a CSV file diffsPerCommit.csv

## Scripts

Copy these scripts into the directory above the git project in question and its orphaned copy. The result of ls should be

git_project orphaned_project difffile.sh looplog.sh makeLog.sh partFile.sh


**DO NOT PUT ANOTHER PROJECT INSIDE OF THIS ONE. IT WILL CAUSE UNPREDICTABLE BEHAVIOR**

### makeLog.sh

makeLog.sh makes a text file log.txt for a git branch

./makeLog.sh branch_name git_project

**TIP** modify log.txt to exclude commits from date ranges for very long-lived projects

### looplog.sh

Uses log.txt to make a list of every commit to check. Splits that list into n+1 equal parts for a processor with n cores. Makes a copy of the target project for each of those split parts. Runs partFile.sh for each of those copies and parts. Collects the CSV output of partFile.sh into the output file diffsPerCommit.csv. Cleans up host directory.

./looplog.sh git_project orphaned_project

Leaves log.txt and commits.txt in case they are useful.

### partFile.csv

Preps each copy of the git project for use. Switches to each commit for that copy and runs ./difffile.sh.

### difffile.sh

diffs every file in 2 directories and counts the total. Adds that to the end of a CSV file 





