#!/bin/bash
# make a list of every commit on a branch
# $1 = branch to search
# outputs to log.txt
git log $1 --not $(git for-each-ref --format '^%(refname:short)' refs/heads/)