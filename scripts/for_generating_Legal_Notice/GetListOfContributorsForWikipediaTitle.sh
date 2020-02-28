#!/bin/bash
# BASH script that gets list of contributors for a Wikipedia title, using HTTP GET method requests from the MediaWiki action API.
# This script has been developed to create the appropriate credits required by the CC BY-SA 3.0 licensing, in respect of various Wikipedia CC BY-SA 3.0 material that has been used in this project.
# Example invocation: GetListOfContributorsForWikipediaTitle.sh "Scotland"
# The script for the above invocation, will create a folder called Scotland in the current path, and create one JSON file for the contributor list if the number of contributors is 500 or less.
# If the number of contributors is instead more than 500, more than one JSON file will be created, with each file containing at most the names of 500 contributors, and where the JSON files
# taken as a whole will constitute the list of contributors (with hopefully no duplicate entries) for the Scotland Wikipedia page. Each JSON file generated is given a page name where each page name
# is set apart from other generated page names by the page's number.

Set_pccontinue (){
# Old code that used to operate HTML response.
#	pccontinue=$(more  "Page_$pagenumber.html" | grep -E -i "[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;pccontinue&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*:[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;" | sed -E "s/[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;pccontinue&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*:[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*&quot;//i" | sed -E "s/[[:space:]]*&quot;[[:space:]]*<\/span>[[:space:]]*<span class=\"[0-9a-zA-Z]+\">[[:space:]]*,[[:space:]]*<\/span>[[:space:]]*//i")	

# New code operates on JSON.
pccontinue=$(more  "Page_$pagenumber.json" | grep -E -i "^[[:space:]]*{[[:space:]]*\"continue\"[[:space:]]*:[[:space:]]*{[[:space:]]*\"pccontinue\"[[:space:]]*:[[:space:]]*\".*")
pccontinue=$(echo $pccontinue | sed -E "s/^[[:space:]]*\{[[:space:]]*\"continue\"[[:space:]]*:[[:space:]]*\{[[:space:]]*\"pccontinue\"[[:space:]]*:[[:space:]]*\"([^\"]+).*/\\1/i")

# echo $pccontinue


}

mkdir "$1"
cd "$1"
pagenumber=1
wget -O "Page_$pagenumber.json" "https://en.wikipedia.org/w/api.php?action=query&prop=contributors&titles=$1&pclimit=500&format=json"

Set_pccontinue;

while [[ "$pccontinue" != "" ]]
do
	pagenumber=$((pagenumber+1))
	wget -O "Page_$pagenumber.json"  "https://en.wikipedia.org/w/api.php?action=query&prop=contributors&titles=$1&pclimit=500&pccontinue=$pccontinue&format=json"
	Set_pccontinue 

done


cd ..
