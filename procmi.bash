#!/bin/bash

for pid in "$@";
do
  if [ -d "/proc/$pid" ];
  then
    vmsize=$(grep VmSize "/proc/$pid/status" | awk '{print $2}')
    vmdata=$(grep VmData "/proc/$pid/status" | awk '{print $2}')
    vmstk=$(grep VmStk "/proc/$pid/status" | awk '{print $2}')
    vmexe=$(grep VmExe "/proc/$pid/status" | awk '{print $2}')
    vmlib=$(grep VmLib "/proc/$pid/status" | awk '{print $2}')
    vmrss=$(grep VmRSS "/proc/$pid/status" | awk '{print $2}')
    vmpte=$(grep VmPTE "/proc/$pid/status" | awk '{print $2}')
    vmdse=$((vmdata+vmstk+vmexe))

    date=$(date +%Y%m%d-%H:%M:%S)
	file="$pid-$date.meminfo"
  {
	echo "******** Minneinfo om prosess med PID $pid ********"
	echo "Total bruk av virtuelt minne (VmSize): $vmsize"
	echo "Mengde privat virtuelt minne (VmData+VmStk+VmExe): $vmdse"
	echo "Mengde shared virtuelt minne (VmLib): $vmlib"
	echo "Total bruk av fysisk minne (VmRSS): $vmrss"
	echo "Mengde fysisk minne som benyttes til page tables (VmPTE): $vmpte"
  } >> "$file"
  else
    echo "Prosess med pid $pid finnes ikke"
  fi
done