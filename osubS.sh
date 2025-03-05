#!/bin/bash
#

pwd
if ls *.inp 1> /dev/null 2>&1; then
    for file in *.inp
    do
			echo submitting $file
			echo
			qsub -N ${file%%.*} -l h_data=2G,h_rt=24:00:00,arch=intel-[Eg][5o][l-]* -pe shared 8 /u/home/[initial]/[username]/.local/bin/orca_sub.sh
		done
else
    echo "No .inp file found"
fi
