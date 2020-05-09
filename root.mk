JAILDIR=	/usr/local/jails/${NAME}
JAILROOT=	${JAILDIR}/root
RELEASE =	12.1-RELEASE
RELEASEDIR=/usr/local/share/jail/releases/${RELEASE}

.for dir in .base dev root tmp user var usr/local
DIRSCMD+=	mkdir -p ${JAILROOT}/${dir};
.endfor
.for dir in bin lib libexec sbin
DIRSCMD+=	ln -sf /.base/${dir} ${JAILROOT}/${dir};
.endfor
.for dir in bin include lib lib32 libdata libexec obj sbin share
DIRSCMD+=	ln -sf /.base/usr/${dir} ${JAILROOT}/usr/${dir};
.endfor

all: root install-config pkgs post-install ip

root: ;	${DIRSCMD}

fstab: fstab.m4
	m4 -DPWD=${PWD} -DRELEASEDIR=${RELEASEDIR} -DJAILROOT=${JAILROOT} < fstab.m4 > fstab
jail.conf: jail.conf.m4
	m4 -D_IP_=${IP} -D_NAME_=${NAME} < jail.conf.m4 > jail.conf
hosts: ; cp /etc/hosts .
resolv.conf: ; cp /etc/resolv.conf .
install-config: jail.conf fstab hosts resolv.conf
	cp -r ${RELEASEDIR}/etc ${JAILROOT}
	install hosts ${JAILROOT}/etc/
	install resolv.conf ${JAILROOT}/etc/
	install jail.conf /etc/jail.${NAME}.conf
	install fstab ${JAILDIR}

run: 
	-service jail start ${NAME}
restart: ; service jail restart ${NAME}
ip: ; @echo Jail\'s IP is ${IP}

pkgs: run
	pkg -j $(NAME) install -y ${PKGS}

.PHONY: destroy
destroy:
	service jail stop ${NAME}
	-chflags -f -R 0 ${JAILDIR}
	rm -rf ${JAILDIR}
	rm -f /etc/jail.${NAME}.conf

.PHONY: clean
clean:
	rm -f fstab jail.conf hosts resolv.conf
