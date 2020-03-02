#!/bin/sh

list="$(find . -type f -name "*.c")"

for i in $list ;do
    cpp -MM $i
    echo "\n"
done



