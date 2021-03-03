#!/usr/bin/env bash

# Get the package list from a file.
# Removes comment lines and trailing comments.
function get_pkglist() {
    local filename
    filename="$1"; shift

    cat "${filename}" \
        | tr -s '\n' \
        | while read -r line; do if [[ "${line}" =~ ^# ]]; then continue; else printf "%s\n" "${line}"; fi; done \
        | while read -r line; do printf "%s" "${line}" | cut -d '#' -f 1 | tr -d ' ' | printf "%s\n" "$(cat /dev/stdin)"; done
}

function main() {
    for pkglist in $(ls src/*); do
        printf "%s\n" "$(get_pkglist ${pkglist})" >> expected.txt
    done
    sort expected.txt -o expected.txt

    yay -Qe \
        | tr -s ' ' \
        | while read -r line; do printf "%s\n" "$(printf "%s" "${line}" | cut -d ' ' -f 1)"; done \
        | tee actual.txt 1>/dev/null

    grep -F -x -v -f <(grep -o '[^/]*$' expected.txt) <(grep -o '[^/]*$' actual.txt) > untracked.txt
    grep -F -x -v -f <(grep -o '[^/]*$' actual.txt) <(grep -o '[^/]*$' expected.txt) > missing.txt

    rm expected.txt
    rm actual.txt
}

main $@
