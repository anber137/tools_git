#!/bin/sh
#echo "Use only for merge."
#echo "Parents of hash($(git rev-parse $1)) commit:"
#git rev-parse $(git show $1 | grep Merge: |  awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}')
git show -s --pretty=format:%P b8d720
