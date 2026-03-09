cat "$1" | sed 's/,//g' | sed 's/\.//g' | tr ' ' '\n' | grep -E '^.(..)*$' | sort | uniq > words_list.txt

cat words_list.txt | grep -no '.' | cut -d: -f1 | uniq -c | sed 's/^ *//' | cut -d' ' -f1 > counts.tmp

grep -n '' "$1" | grep -E '^[0-9]*[02468]:' | cut -d: -f2- | sed 's/,//g' | sed 's/\.//g' | tr ' ' '\n' > even_lines.txt

cat words_list.txt | xargs -I {} grep -c "^{}$" even_lines.txt > p2.tmp
s
echo "word,characters,counts"
paste -d ',' words_list.txt counts.tmp p2.tmp | sort -t',' -k1,1f -k1,1r
rm words_list.txt even_lines.txt p2.tmp