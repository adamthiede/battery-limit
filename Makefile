#!/usr/bin/env bash
ifndef PREFIX
  PREFIX = /usr/
endif
DESTDIR=${PREFIX}

default:
	install

install:
	install -Dm 0755 battery-limit.sh ${DESTDIR}/bin/battery-limit.sh
	install -Dm 0755 battery-limit.service ${DESTDIR}/lib/systemd/system/battery-limit.service

