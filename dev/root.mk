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

jail: install pkgs ip

root: ; ${DIRSCMD}

hosts: ; cp /etc/hosts .

resolv.conf: ; cp /etc/resolv.conf .

browse:
	xdg-open http://${IP}

ip:
	@echo Jail\'s IP is ${IP}
