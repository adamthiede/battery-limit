#!/usr/bin/env bash
ifndef PREFIX
  PREFIX = /usr/
endif
DESTDIR=${PREFIX}

default:
	install-systemd

install-systemd:
	install -Dm 0755 battery-limit.sh ${DESTDIR}/bin/battery-limit.sh
	install -Dm 0644 battery-limit.service ${DESTDIR}/lib/systemd/system/battery-limit.service

install-openrc:
	install -Dm 0755 battery-limit.sh ${DESTDIR}/bin/battery-limit.sh
	install -Dm 0755 battery-limit /etc/init.d/battery-limit

