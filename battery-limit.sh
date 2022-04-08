#!/bin/bash
#default options
BAT='BAT0'
LIMIT='95'
BC=0
LC=0
AVAIL_BATS=$(cd /sys/class/power_supply/ && ls -d BAT*)

helptext() {
  echo -e "
USAGE: battery-limit.sh [OPTIONS]

OPTIONS:
  -h - OPTIONAL - show this help text.
  -b - OPTIONAL - battery to use from /sys/class/power_supply/. Default is BAT0.
       Choose from the following: ${AVAIL_BATS}
  -l - OPTIONAL - limit percentage between 1-99. Default is 95.
  "
}

while getopts 'hb:l:' opt
do
  case $opt in
    h) helptext ;;
    b) BAT=$OPTARG BC='1' ;;
    l) LIMIT=$OPTARG LC='1' ;;
  esac
done

validate() {
  if [[ -d /sys/class/power_supply/ ]];then
    echo "Platform has battery power supply, continue"
  else
    echo "Platform does not have a battery."
    exit 1
  fi
  if [[ -d /sys/class/power_supply/${BAT} ]];then
    echo "Battery ${BAT} exists."
  else
    echo "
    Battery ${BAT} does not exist.
    Choose from the available batteries:
    ${AVAIL_BATS}
    "
  fi
  if [[ ${LIMIT} -gt "99" ]];then
    echo "Limit should be 
}

show(){
  echo "battery: ${BAT} ${BC}"
  echo "limit: ${LIMIT} ${LC}"
}

# Run!
validate
show
