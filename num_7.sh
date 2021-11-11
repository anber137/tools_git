#!/bin/bash
#created
#5ac311e2a91e381e2f52234668b49ba670aa0fe5
#removed
#bdfea50cc85161dea41be0fe3381fd98731ff786

hashs=$(git log -S'func synchronizedWriters(' | grep 'commit' | awk '{print($2)}')
for hash in $hashs
do
  ffunc=$(git show $hash | grep '+func synchronizedWriters(')
  if [ -n "$ffunc" ]; then 
	git show -s --pretty=format:'Author: '%an $hash
  fi
done
