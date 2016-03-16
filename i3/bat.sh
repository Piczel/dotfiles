#!/bin/bash

bat_n="$(cat /sys/class/power_supply/BAT0/energy_now)"
bat_f="$(cat /sys/class/power_supply/BAT0/energy_full)"

percent=$(echo "$bat_n/$bat_f*100" | bc -l | cut -d"." -f1)

actual="$(cat /sys/class/power_supply/BAT0/capacity)"

if [ $actual -eq "100" ] #  &&  cat /sys/class/power_supply/BAT0/status -eq "Charging" ]
then
	notify-send --urgency=critical 'Batterie pleine' 'Retirez le chargeur'
fi

if [ $actual -le "15" ] # &&  cat /sys/class/power_supply/BAT0/status -eq "Discharging" ]
then
	notify-send --urgency=critical 'Batterie faible !' 'Branchez le chargeur'
fi

