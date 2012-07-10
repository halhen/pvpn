include config.mk

export APPLICATION=pvpn
export VERSION=0.1

MANPAGES = ${APPLICATION}.1

.PHONY: all clean install uninstall

all: $(MANPAGES)

clean:
	rm -vf $(MANPAGES) PKGBUILD

install: all
	install -d ${DESTDIR}${PREFIX}/bin
	install -m 0755	${APPLICATION} ${DESTDIR}${PREFIX}/bin
	@sed -i 's|^VERSION=.*|VERSION="${VERSION}"|' ${DESTDIR}${PREFIX}/bin/${APPLICATION}
	install -d $(DESTDIR)${MANPREFIX}/man1
	install -m 0664 ${APPLICATION}.1 $(DESTDIR)${MANPREFIX}/man1

uninstall:
	@rm ${DESTDIR}${PREFIX}/bin/${APPLICATION}
	@rm ${DESTDIR}${MANPREFIX}/man1/${APPLICATION}.1

%.1: %.1.txt
	a2x -d manpage -f manpage $<

PKGBUILD: contrib/PKGBUILD.in
	@sed 's|^pkgver=.*|pkgver=${VERSION}|' contrib/PKGBUILD.in > PKGBUILD
