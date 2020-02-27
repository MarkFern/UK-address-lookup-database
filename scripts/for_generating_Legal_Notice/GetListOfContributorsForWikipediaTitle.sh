#!/bin/bash

mkdir "$1"
cd "$1"
pagenumber=1
wget -O "Page_$pagenumber.html" "https://en.wikipedia.org/w/api.php?action=query&prop=contributors&titles=$1&pclimit=500"

pccontinue=$(more  "Page_$pagenumber.html" | grep -E -i "[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;pccontinue&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*:[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;" | sed -E "s/[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;pccontinue&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*:[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;//i" | sed -E "s/[[:space:]]*&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*,[[:space:]]*<\/span>[[:space:]]*//i")

while [[ "$pccontinue" != "" ]]
do
	pagenumber=$((pagenumber+1))
	wget -O "Page_$pagenumber.html"  "https://en.wikipedia.org/w/api.php?action=query&prop=contributors&titles=$1&pclimit=500&pccontinue=$pccontinue"
	
	pccontinue=$(more  "Page_$pagenumber.html" | grep -E -i "[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;pccontinue&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*:[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;" | sed -E "s/[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;pccontinue&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*:[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;//i" | sed -E "s/[[:space:]]*&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*,[[:space:]]*<\/span>[[:space:]]*//i")	
done


cd ..
