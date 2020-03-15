#!/bin/bash
for pid in $(pgrep chrome); do
  major_page_faults=$(ps --no-headers -o maj_flt "$pid")
  message="Chrome $pid har forårsaket \t $major_page_faults major page faults"
  if [ "$major_page_faults" -gt 1000 ]
  then
    message="$message (mer enn 1000!)"
  fi
  echo -e "$message"
done
