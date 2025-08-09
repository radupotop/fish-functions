function sortsums --description "Sort file in place by the second column (e.g. for checksums files)"
    set -l file $argv[1]
    set -l opts $argv[2..-1]
    sort -k2 $opts $file -o $file
end
