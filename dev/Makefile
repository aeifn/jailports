# MAKEFILE FOR BUILDING JAIL

NAME = tl
JAILDIR=/usr/local/jails/${NAME}
JAILROOT=${JAILDIR}/root
RELEASE =	12.1-RELEASE
RELEASEDIR=/usr/local/share/jail/releases/${RELEASE}
PKGS =	nginx
IP=	192.168.64.3
MAINTAINER=	egor@math.ru


all: jail start

jail: install pkgs

install: fstab jail.conf hosts resolv.conf root
	cp -r ${RELEASEDIR}/etc ${JAILROOT}
	install hosts ${JAILROOT}/etc/
	install resolv.conf ${JAILROOT}/etc/
	install jail.conf /etc/jail.${NAME}.conf
	install fstab ${JAILDIR}
	mkdir -p ${JAILROOT}/code

hosts: ; cp /etc/hosts .

resolv.conf: ; cp /etc/resolv.conf .

fstab: fstab.m4
	m4 -DPWD=${PWD} -DRELEASEDIR=${RELEASEDIR} -DJAILROOT=${JAILROOT} < fstab.m4 > fstab

jail.conf: jail.conf.m4
	m4 -D_IP_=${IP} < jail.conf.m4 > jail.conf

pkgs: start
	pkg -j $(NAME) install -y ${PKGS}
	service -j ${NAME} nginx enable
	service -j ${NAME} nginx restart

start:
	service jail start ${NAME}

restart:
	service jail restart ${NAME}

destroy:
	service jail stop ${NAME}
	-chflags -f -R 0 ${JAILDIR}
	rm -rf ${JAILDIR}
	rm -f /etc/jail.${NAME}.conf

.PHONY: clean
clean:
	rm -f fstab jail.conf hosts resolv.conf

.include "root.mk"
