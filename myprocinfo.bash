#!/bin/bash
# no arguments, display a menu with option for info
# about processes

clear
while [ "$svar" != "9" ]
do
 echo ""
 echo "	1 - Hvem er jeg og hva er navnet på dette scriptet?"
 echo "	2 - Hvor lenge er det siden siste boot?"
 echo "	3 - Hva var gjennomsnittlig load siste minutt?"
 echo "	4 - Hvor mange prosesser og tråder finnes?"
 echo "	5 - Hvor mange context switch'er fant sted siste sekund?"
 echo "	6 - Hvor mange interrupts fant sted siste sekund?"
 echo "	9 - Avslutt dette scriptet"
 echo ""
 echo -n "Velg en funksjon: "
 read -r svar
 echo ""
 case $svar in
  1)clear
    echo "Jeg er $(whoami), navnet på dette scriptet er $(basename -- "$0")"
    ;;
  2)clear
    echo "Tid siden siste boot er: $(uptime -p)"
    ;;
  3)clear
    echo "Gjennomsnittlig load siste minutt: $(awk '{print $1}' /proc/loadavg)"
    ;;
  4)clear
    echo "Det finnes $(ps -AL --no-headers | wc -l) prosesser og $(ps axms | wc -l ) tråder"
    ;;
  5)clear
	before=$(grep "^ctxt" /proc/stat | awk '!($1="")')
    sleep 1
    after=$(grep "^ctxt" /proc/stat | awk '!($1="")')
    difference=$((after-before))
    echo "Antall context switch'er siste sekund var $difference"
    ;;
  6)clear
	before=$(grep "^intr" /proc/stat | awk '{print $2}')
    sleep 1
    after=$(grep "^intr" /proc/stat | awk '{print $2}')
    difference=$((after-before))
    echo "Antall interrupts siste sekund: $difference"
    ;;
  9)echo Scriptet avsluttet
    exit
    ;;
  *)echo Ugyldig valg
    read -r
    clear
    ;;
 esac
done

