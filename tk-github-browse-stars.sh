#!/bin/bash
[ ! $# -eq 1 ] && echo "usage: ${0} <feed-file-to-open>" && exit
file="$1"
[ ! -e ${file} ] && echo "bad file" && exit

cat ${file} | grep -oP '[^ ]*/[^ ]*' > links
cat links | grep -oP '(?<=/).*' > names
cat names | sort | uniq -c | sort -r -k1 > cnt-uniq-names
cat names | sort -u > only-uniq-names

function open_and_delay {
	chromium "https://github.com/${1}" &
	sleep 1
}

i=0
total=$(wc -l only-uniq-names)
total=`echo $total | grep -o '^[0-9]*'`
while read name 
do
	cnt_uniq_name=$(grep "\b${name}\b" cnt-uniq-names)
	echo -n "${cnt_uniq_name} -> "
	link=`grep -m1 ${name} links`
	let 'i=i+1'
	echo "${link}  #${i} / ${total}"
	open_and_delay ${link}
done << EOF
$(cat only-uniq-names)
EOF

# rm -f links names only-uniq-names cnt-uniq-names
