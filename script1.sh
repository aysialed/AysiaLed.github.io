csv="$1"
recipe="$2"

sed '1d;

s/\([^,]*\),\([^,]*\),1,\([^,]*\)s/sed -i "s\/\\*\L\1\E\/1 \3 \2\/gI" '"$recipe"'/;
t;
s/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/sed -i "s\/\\*\L\1\E\/\3 \4 \2\/gI" '"$recipe"'/' "$csv" | bash

cat "$recipe"

grep -o '\*[A-Za-z]\+' "$recipe" | sort -u | sed '1s/^/Missing\n/' >&2