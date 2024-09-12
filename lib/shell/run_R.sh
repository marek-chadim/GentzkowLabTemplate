#!/bin/bash   

unset run_R
run_R () {
    # get arguments
    program="$1"
    logfile="$2"

    # set R command if unset
    if [ -z "$rCmd" ]; then
        echo "No R command set. Using default: Rscript"
        rCmd="Rscript"
    fi

    # run program, add output to logfile
    echo "Executing: ${rCmd} ${program}"
    (
        ${rCmd} "${program}" 1>> "${logfile}" 2>> "${logfile}"

        # report on errors
        return_code=$?
        if [ $return_code -ne 0 ]; then
            # Log an error message if the command failed
            echo "Error: ${program} failed with exit code $return_code"
        fi
    )
}

