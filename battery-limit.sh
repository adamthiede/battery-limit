#!/usr/bin/bash

setup(){
  if [[ ! -d /sys/class/power_supply/ ]];then echo "Platform does not have a battery."; exit 1; fi
  AVAIL_BATS=($(cd /sys/class/power_supply/ && ls -d BAT*))
  BAT=${AVAIL_BATS[0]}
  if [[ -z ${AVAIL_BATS[*]} ]];then echo "No batteries."; exit 1; fi
  # default options
  LIMIT='95'
  BC=false
  LC=false
  SVCFILE="/usr/lib/systemd/system/battery-limit.service"
  ELEVATE_CMD=$(command -v doas || command -v sudo)
}

helptext() {
  echo -e "
USAGE: battery-limit.sh [OPTIONS]

OPTIONS:
  -h - OPTIONAL - show this help text.
  -b - OPTIONAL - battery to use from /sys/class/power_supply/. Default is the first in the following list.
       Batteries detected: ${AVAIL_BATS[*]}
  -l - OPTIONAL - limit percentage between 1-99. Default is 95.

ENABLE: 
  battery-limit.sh
  ${ELEVATE_CMD} systemctl daemon-reload
  ${ELEVATE_CMD} systemctl enable battery-limit.service --now
DISABLE:
  ${ELEVATE_CMD} systemctl disable battery-limit.service --now
"
}

validate() {
  if [[ ${LIMIT} -gt "99" || ${LIMIT} -lt "1" ]];then
    echo "Limit should be between 1 and 99"
    exit 1
  fi
  if [[ ! ${AVAIL_BATS[*]} =~ ${BAT} ]];then
    echo "
    Battery ${BAT} does not exist.
    Choose from the available batteries:
    ${AVAIL_BATS}
    "
    exit 1
  fi
}

show(){
  echo "battery: ${BAT} chosen: ${BC}"
  echo "limit: ${LIMIT} chosen: ${LC}"
}

makeService(){
  svcText="[Unit]
Description=Set battery charge thresholds
After=multi-user.target
StartLimitBurst=0

[Service]
Type=oneshot
Restart=on-failure
RemainAfterExit=yes
ExecStart=/bin/bash -c 'echo ${LIMIT} > /sys/class/power_supply/${BAT}/charge_control_end_threshold'
ExecStop=/bin/bash -c 'echo 100 > /sys/class/power_supply/${BAT}/charge_control_end_threshold'

[Install]
WantedBy=multi-user.target
"
  echo -e "#####\n${svcText}\n#####"
  echo -e "Need root to install the service to:\n${SVCFILE}\n"
  echo "${svcText}" | ${ELEVATE_CMD} tee "${SVCFILE}"

}

###############################
########### Run! ##############
###############################

setup

while getopts 'hb:l:' opt
do
  case $opt in
    h) helptext; exit 0 ;;
    b) BAT=$OPTARG BC=true ;;
    l) LIMIT=$OPTARG LC=true ;;
    *) exit 1 ;;
  esac
done

validate
makeService

