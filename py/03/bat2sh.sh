#!/usr/bin/env bash 
#
# Converts Windows batch script to Linux shell script
#
# Invocation:
#     ./bat2sh script.bat
#

OUTFILE=${2:-${1%%.bat}.sh}

cat "$1" | \
    sed \
        -e 's/\bset\b/export/g'     \
        -e 's/%\([^/]\+\)%/${\1}/g' \
        -e 's/^call.*$//g'          \
        -e 's/\r//'                 \
    > "$OUTFILE"

chmod a+x "$OUTFILE"