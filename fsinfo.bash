#!/bin/bash

dir=$1

usedSpace=$(df "$dir" | awk 'FNR == 2 {print $5}')
echo "Partisjonen $dir befinner seg på er $usedSpace full."

echo "Det finnes $(find "$dir" -type f -print | wc -l) filer."

largestFileName=$(find "$dir" -type f -printf "%s\t%p\n" | sort -n | tail -1 | awk '{print $2}')
largestFileSize=$(find "$dir" -type f -printf "%s\t%p\n" | sort -n | tail -1 | awk '{print $1}')
largestFileSizeMegaBytes=$(echo "$largestFileSize" | numfmt --to=iec)

echo "Den største er $largestFileName som er $largestFileSize ($largestFileSizeMegaBytes) stor."

averageFileSize=$(find "$dir" -ls | awk '{sum += $7; n++;} END {print sum/n;}')

echo "Gjennomsnittlig filstørrelse er ca $averageFileSize bytes"

mostHardlinks=0
mostHardlinksFile=""

for file in $(find "$dir" -type f)
do
	hardlinks=$(stat -c "%h" "$file")
  	if [ "$hardlinks" -gt "$mostHardlinks" ]
  	then
    mostHardlinks=$hardlinks
    mostHardlinksFile="$file"
  	fi
done

echo "Filen $mostHardlinksFile har flest hardlinks, den har $mostHardlinks."