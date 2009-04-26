#!/bin/bash
###muestra el estado de la bateria
### BATTERY
REM=`awk '/remaining capacity/ { print $3 }' /proc/acpi/battery/BAT1/state`
LAST=`awk '/last full/ { print $4}' /proc/acpi/battery/BAT1/info`
STATE=`awk '{print $2}' /proc/acpi/ac_adapter/AC0/state`
#para evitar la division por cero
if [ "$LAST" != ""  ]; then
if [ "$STATE" = "on-line" ]; then
  BAT=$(echo $REM $LAST | awk '{printf "Bat: %.1f%%, AC", ($1/$2)*100'})
else
  PRESENT=`awk '/present rate/ { print $3}' /proc/acpi/battery/BAT1/state`
  BAT=$(echo $REM $LAST $PRESENT | \
    awk '{printf "Bat: %.1f%%", ($1/$2)*100}')
fi
PERCENT=$(echo $REM $LAST | awk '{printf "%d", ($1/$2)*100'})
fi
###solo AC
if [ "$REM" = "" ]; then
 PERCENT="AC "
else
 PERCENT=$(echo $PERCENT%)
fi
echo "$PERCENT"
