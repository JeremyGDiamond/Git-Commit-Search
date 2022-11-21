#!/bin/bash
# make a list of every commit on a branch
# $1 = branch to search
# $2 = project to search
# outputs to log.txt
rm log.txt

cd $2

git log $1 --not $(git for-each-ref --format '^%(refname:short)' refs/heads/) >> log.txt

mv log.txt ..
cd ..
