ifndef PREFIX
  PREFIX = /usr/
endif

DESTDIR=${PREFIX}

default:
	systemd

systemd: battery-limit.sh ${DESTDIR}/lib/systemd/system/battery-limit.service

openrc: battery-limit.sh /etc/init.d/battery-limit

battery-limit.sh:
	install -Dm 0755 battery-limit.sh ${DESTDIR}/bin/battery-limit.sh

${DESTDIR}/lib/systemd/system/battery-limit.service:
	install -Dm 0644 battery-limit.service ${DESTDIR}/lib/systemd/system/battery-limit.service

/etc/init.d/battery-limit:
	install -Dm 0755 battery-limit /etc/init.d/battery-limit
