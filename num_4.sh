#!/bin/sh
cmd=$(git log v0.12.23..v0.12.24^ --oneline --pretty=format:'HASH: '%H', Subject: '%s) && echo "$cmd" && echo "$cmd" |  wc -l | awk '{print "Total commits: " $1}'

