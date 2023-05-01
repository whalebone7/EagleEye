usage() {
echo -e "\xF0\x9F\xA6\x85\033[37m@whalebone71\033[0m"              

echo " " 
    echo "Usage: $0 -f <index_file> -k <keyword>"
echo " "
    echo "  -f <index_file>: path to index file"
    echo "  -k <keyword>: keyword to search for"
echo " " 

echo "Example:"
echo " " 
echo './ee.sh -p "path/to/index_screenshot.txt" -k "hacked".'
echo " " 
echo "The script will then filter the URLs that contain the provided XSS payload in their screenshots." 
echo " " 

    exit 1
}

red=$(tput setaf 1)
skyblue=$(tput setaf 153)
electricgreen=$(tput setaf 118)
reset=$(tput sgr0)

while getopts ":f:k:" opt; do
    case $opt in
        f)
            index_file=$OPTARG
            ;;
        k)
            keyword=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done



if [ -z "$index_file" ] || [ -z "$keyword" ]; then
    usage
fi
cut -d " " -f1 "$index_file" > paths.txt



echo ',---.          |             ,---.          
|--- ,---.,---.|    ,---.    |--- ,   .,---.
|    ,---||   ||    |---'\''    |    |   ||---'\'' 
`---'\''`---^`---|`---'\''`---'\''    `---'\''`---|`---'\'' 
          `---'\''                   `---'\'' '

sleep 0.6
while read -r P; do
    # Check if file exists
    if [ ! -f "$P" ]; then
        echo "${red}File not found:${reset} $P"
        continue
    fi


    tesseract "$P" whalebone7 --psm 6 && sleep 1


    if grep -q "$keyword" whalebone7.txt; then
        echo "${electricgreen}$keyword found${reset} in ${skyblue}$P${reset}"
    else
        echo -e "\033[33m$keyword\033[0m${red} not found${reset} in ${skyblue}$P${reset}"
    fi

done < paths.txt


rm -f paths.txt whalebone7*
