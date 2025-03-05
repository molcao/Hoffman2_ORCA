#!/bin/bash
#

# traverse directories and submit jobs in the deepest directories containing .inp files
submit_all() {
    local dir="$1"
    local subdirs=()

    # Collect subdirectories
    for sub in "$dir"/*/; do
        [ -d "$sub" ] && subdirs+=("$sub")
    done

    # If there are subdirectories, traverse them first
    if [ ${#subdirs[@]} -gt 0 ]; then
        for sub in "${subdirs[@]}"; do
            traverse_and_submit "$sub"
        done
    fi

    # Once all subdirectories have been checked, process the current directory
    if ls "$dir"/*.inp 1> /dev/null 2>&1; then
        cd "$dir" || exit
        for file in *.inp; do
            echo "Submitting $file in $dir"
            qsub -N "${file%%.*}" -l h_vmem=120G,h_data=5G,h_rt=24:00:00,arch=intel-[Eg][5o][l-]* -pe shared 24 /u/home/[initial]/[username]/.local/bin/orca_sub.sh
        done
        cd - > /dev/null || exit  
    fi
}

# Start from the current directory
submit_all "$(pwd)"
