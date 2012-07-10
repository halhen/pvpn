include config.mk

export APPLICATION=pvpn
export VERSION=0.1

MANPAGES = ${APPLICATION}.8

.PHONY: all clean install uninstall

all: $(MANPAGES)

clean:
	rm -vf $(MANPAGES) PKGBUILD

install: all
	install -d ${DESTDIR}${PREFIX}/bin
	install -m 0755	${APPLICATION} ${DESTDIR}${PREFIX}/bin
	@sed -i 's|^VERSION=.*|VERSION="${VERSION}"|' ${DESTDIR}${PREFIX}/bin/${APPLICATION}
	install -d $(DESTDIR)${MANPREFIX}/man8
	install -m 0664 ${APPLICATION}.8 $(DESTDIR)${MANPREFIX}/man8

uninstall:
	@rm ${DESTDIR}${PREFIX}/bin/${APPLICATION}
	@rm ${DESTDIR}${MANPREFIX}/man8/${APPLICATION}.8

%.8: %.8.txt
	a2x -d manpage -f manpage $<

PKGBUILD: contrib/PKGBUILD.in
	@sed 's|^pkgver=.*|pkgver=${VERSION}|' contrib/PKGBUILD.in > PKGBUILD
