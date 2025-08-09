function sortsums -a file opts --description "Sort file in place by the second column (e.g. for checksums files)"
    sort -k2 $opts $file -o $file
end
