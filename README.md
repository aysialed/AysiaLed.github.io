# AysiaLed.github.io
```

midterm question response and explanation of code by Aysia and Hyunjun


Script1.sh

csv="$1"
recipe="$2"

sed '1d;

s/\([^,]*\),\([^,]*\),1,\([^,]*\)s/sed -i "s\/\\*\L\1\E\/1 \3 \2\/gI" '"$recipe"'/;
t;
s/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/sed -i "s\/\\*\L\1\E\/\3 \4 \2\/gI" '"$recipe"'/' "$csv" | bash

cat "$recipe"

grep -o '\*[A-Za-z]\+' "$recipe" | sort -u | sed '1s/^/Missing\n/' >&2


csv = “$1”
recipe = “$2”
these make the csv the first argument variable and recipe the second argument variable

sed ‘1d; deletes the first line of the csv file so we don’t get the header
then we use the pattern \([^,]*\) to match anything until the comma, the capture group is \( until \)

s/\([^,]*\),\([^,]*\),1,\([^,]*\)s 
will capture \1 which aligns to the ingredient name, \2 which is the units and \3 is the amount of the units to put in
the 1 checks for if there is only 1 in the quantity column
sed -i "s\/\\*\L\1\E\/1 \3 \2\/gI" '"$recipe"'/;
this part we use sed -I which edits the file in place
\* matches the ingredients in the recipe file marked with *
\L converts it to lowercase
\1 gets the ingredient name
1 \3 \2 is the new format of the recipe file
So *sugar would become 1 cup sugar
t; tests if the last substitution worked
s/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/
sed -i "s\/\\*\L\1\E\/\3 \4 \2\/gI" '"$recipe"'/
this part is for the ingredients that are more than 1
\1 is the ingredient
\1 is the units 
\3 is the amount
\4 is the units if its more than 1
| bash
This pipes to bash to execute the commands
Cat “$recipe” prints the file to stdout
grep -o '\*[A-Za-z]\+' "$recipe"
this searching for the ingredients that start with * again after everything has already been changed, if they exist still that means they were not replaced
| sort -u removes these
| sed ‘1s\^\Missing\/’ creates the header that says Missing
>&2 sends the output to stderr 



Script2.sh

cat "$1" | sed 's/,//g' | sed 's/\.//g' | tr ' ' '\n' | grep -E '^.(..)*$' | sort | uniq > words_list.txt

cat words_list.txt | grep -no '.' | cut -d: -f1 | uniq -c | sed 's/^ *//' | cut -d' ' -f1 > counts.tmp

grep -n '' "$1" | grep -E '^[0-9]*[02468]:' | cut -d: -f2- | sed 's/,//g' | sed 's/\.//g' | tr ' ' '\n' > even_lines.txt

cat words_list.txt | xargs -I {} grep -c "^{}$" even_lines.txt > p2.tmp
s
echo "word,characters,counts"
paste -d ',' words_list.txt counts.tmp p2.tmp | sort -t',' -k1,1f -k1,1r
rm words_list.txt even_lines.txt p2.tmp


cat "$1" | sed 's/,//g' | sed 's/\.//g' | tr ' ' '\n' | grep -E '^.(..)*$' | sort | uniq > words_list.txt

//Open the file, and delete commas and periods
Exchange a space with a new line
Get words with odd characters
sort them
and get unique words
//Save it in a file
cat words_list.txt | grep -no '.' | cut -d: -f1 | uniq -c | sed 's/^ *//' | cut -d' ' -f1 > counts.tmp
//Open the file which is just saved in the first command line
Get a word and creates a list of line numbers of each character in one word
cut the file and leave just a list of line numbers
uniq -c shows how many times each line number appears
delete space(s)
//get word counts and save it in counts.temp file
grep -n '' "$1" | grep -E '^[0-9]*[02468]:' | cut -d: -f2- | sed 's/,//g' | sed 's/\.//g' | tr ' ' '\n' > even_lines.txt
//adds line numbers to every line, using a grep
keeps only lines whose number ends in even numbers
Get the contents of the lines, using cut
delete commas and periods
exchange the space with a new line
//save it in
cat words_list.txt | xargs -I {} grep -c "^{}$" even_lines.txt > p2.tmp
//Open the file that is just saved
With xargs, take one word in the file and holds it in a placeholder
if the word matches with the pattern, it counts how many times it appears in the file
//then save it in a file
echo "word,characters,counts"
//Make an output look identical to the example output
paste -d ',' words_list.txt counts.tmp p2.tmp | sort -t',' -k1,1f -k1,1r
//Make an output look identical to the example output
it sorts the final table by the first column in a case-insensitive way
rm words_list.txt even_lines.txt p2.tmp
//Remove all the files that are created in the process
```

