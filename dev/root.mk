.for dir in .base dev root tmp user var usr/local
DIRSCMD+=	mkdir -p ${JAILROOT}/${dir};
.endfor
.for dir in bin lib libexec sbin
DIRSCMD+=	ln -sf /.base/${dir} ${JAILROOT}/${dir};
.endfor
.for dir in bin include lib lib32 libdata libexec obj sbin share
DIRSCMD+=	ln -sf /.base/usr/${dir} ${JAILROOT}/usr/${dir};
.endfor

root:
	${DIRSCMD}
