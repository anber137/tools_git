#!/bin/sh
fname=$(git grep -l 'func globalPluginDirs(') && git log -L :globalPluginDirs:$fname | grep 'commit' -A 4
