#!/usr/bin/bash
#default options
BAT='BAT0'
LIMIT='95'

while getopts 'hb:l:' opt
do
  case $opt in
    h) helptext ;;
    b) BAT=$OPTARG ;;
    l) LIMIT=$OPTARG ;;
  esac
done

helptext() {
  echo -e "
USAGE: battery-limit.sh [OPTIONS]

OPTIONS:
  -h - OPTIONAL - show this help text.
  -b - OPTIONAL - battery to use from /sys/class/power_supply/. Default is BAT0.
  -l - OPTIONAL - limit percentage. Default is 95.
  "
}

check() {
  if [[ -d /sys/class/power_supply/ && -d /sys/class/power_supply/BAT0 ]];then
    echo "Platform has battery power supply, continue"
  else
    echo "Platform does not have a battery."
    exit 1
  fi
}

show(){
  echo "chosen battery: ${BAT}"
  echo "chosen limit: ${LIMIT}"
}

show
