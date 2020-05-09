# MAKEFILE FOR BUILDING JAIL

NAME = 	moin
PKGS =	moinmoin ap24-py27-mod_wsgi apache24
IP?=	192.168.64.80
MAINTAINER=	egor@math.ru
MOINSCRIPT=	moin.wsgi
MOINDIR=	/usr/local/share/moin
MOINDEST=	/usr/local/www/wiki
CGIUSER=	www
CGIGROUP=	www
CHROOT=		chroot ${JAILROOT}

.include "../root.mk"

post-install: run
	#If you're installing from ports, just run 'make instance'
	#with appriopriate arguments.
	#eg. make MOINTYPE=FCGI MOINDEST=/usr/local/www/wiki instance
	
	#If you're installing from package, run these commands.
	
	# Choose here one script depending on the type of wiki you
	# want : moin.py (standalone), moin.fcg (FCGI), moin.wsgi (WSGI) or moin.cgi.
	# Set this to your apache user and group.
	
	${CHROOT} mkdir -p ${MOINDEST}/data 
	${CHROOT} mkdir -p ${MOINDEST}/underlay 
	${CHROOT} cp -R ${MOINDIR}/data ${MOINDEST} 
	${CHROOT} cp -R ${MOINDIR}/underlay ${MOINDEST} 
	${CHROOT} chmod -R u+rw,go-ws ${MOINDEST}/data 
	${CHROOT} install -m 0555 ${MOINDIR}/config/wikiconfig.py ${MOINDEST}
	${CHROOT} ln -sf ${MOINDEST}/wikiconfig.py /usr/local/lib/python2.7/
	${CHROOT} install -m 0555 ${MOINDIR}/server/${MOINSCRIPT} ${MOINDEST}
	${CHROOT} chown -R ${CGIUSER}:${CGIGROUP} ${MOINDEST}


	cp site.conf ${JAILROOT}/usr/local/etc/apache24/Includes/site.conf
	
	#Note: export might not work with your shell, use
	# setenv VAR 'value' instead
	service -j${NAME} apache24 enable
	service -j${NAME} apache24 restart

superuser: run
	patch -i wikiconfig.py.diff ${JAILROOT}/${MOINDEST}/wikiconfig.py
	jexec ${NAME} moin account create --name=Admin --password=Admin --email="admin@moin"
