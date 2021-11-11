#!/bin/sh
fname=$(git grep -l 'func globalPluginDirs(') && git log -L :globalPluginDirs:$fname | grep 'commit' -A 4
#git log -S'func providerSource(' --oneline
