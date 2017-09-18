#!/bin/bash

__trim_steam () {
cat | sed 's/ Steam Key$//'
}

__sort () {
cat | sort -k2
}

__rempty () {
cat | grep -vx '^$'
}

__de_tab () {
cat | sed 's/\t/   /'
}

if [ "${1}" == '-c' ]; then

    shift

    cat "${1}" | __rempty | while read -r __line; do

        sed 's/^\(.*\): \(.*\)$/\2   \1/' <<< "${__line}" | __trim_steam

    done | __sort

elif [ "${1}" == '-t' ]; then

    shift

    cat "${1}" | __rempty | while read -r __line; do

        __de_tab <<< "${__line}" | __trim_steam

    done | __sort

elif [ "${1}" == '-bs' ]; then

    shift

    while mapfile -t -n 4 ary && ((${#ary[@]})); do
        printf '%s\n' "${ary[@]}" | sed -e '4d' -e '2d' -e '1s/\t.*//' | tac | tr '\n' '\t' | sed 's/$/\n/' | __de_tab
    done < "${1}" | __rempty | __sort

elif [ "${1}" == '-h' ]; then

    shift

    while mapfile -t -n 4 ary && ((${#ary[@]})); do
        printf '%s\n' "${ary[@]}" | sed -e '2,3d' | tac | tr '\n' '\t' | sed 's/$/\n/' | __de_tab
    done < "${1}" | __rempty | __sort

elif [ "${1}" == '-bk' ]; then

    shift

    while mapfile -t -n 2 ary && ((${#ary[@]})); do
        printf '%s\n' "${ary[@]}" | sed -e '2d' | sed 's/\(.*\) : \([^ ]*\)$/\2   \1/'
    done < "${1}" | __rempty | __sort
elif [ "${1}" == '-i' ]; then

    shift

    while mapfile -t -n 3 ary && ((${#ary[@]})); do
        printf '%s\n' "${ary[@]}" | tac | __rempty | tr '\n' '\t' | sed -e 's/$/\n/' | sed -e 's/\t$//' | __de_tab
    done < "${1}" | __rempty | __sort

else
    echo './key_formatter.sh <METHOD> file'
    echo 'See README for more info'
    echo
    echo '-t for KEY<TAB>Name'
    echo '-c for Name: KEY'
    echo '-bs for Bundle Stars weirdness...'
    echo '-h for Humble Bundle weirdness...'
    echo '-bk for Bunch Keys (Name : KEY)'
    echo '-i for IndieGala'
fi

exit
