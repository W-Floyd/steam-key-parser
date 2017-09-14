#!/bin/bash

num_length="$(cat "${1}" | grep -vx '^$' | sed 's/^[^ ]*   //' | uniq -c | sed -e 's/ *//' -e 's/ .*//' | awk '{print length}' | sort -nr | head -n 1)"

cat "${1}" | grep -vx '^$' | sed 's/^[^ ]*   //' | uniq -c | while read -r __line; do

    printf "%0*d x " "${num_length}" "$(sed 's/ .*//' <<< "${__line}")"

    sed 's/^[0-9]* //' <<<  "${__line}"

done | {

if [ "${2}" == '-q' ]; then
    cat | sort -r
else
    cat | sort -k3
fi

}

exit
