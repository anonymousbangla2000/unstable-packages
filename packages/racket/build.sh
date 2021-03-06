TERMUX_PKG_HOMEPAGE=https://racket-lang.org
TERMUX_PKG_DESCRIPTION="Full-spectrum programming language going beyond Lisp and Scheme"
TERMUX_PKG_LICENSE="GPL-3.0, LGPL-3.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
TERMUX_PKG_VERSION=7.2
TERMUX_PKG_SRCURL=https://mirror.racket-lang.org/installers/${TERMUX_PKG_VERSION}/racket-minimal-${TERMUX_PKG_VERSION}-src-builtpkgs.tgz
TERMUX_PKG_SHA256=dd75401824b877964b70d8b475b05f424721f72015f41d5ae6c508b60dab3ad5
TERMUX_PKG_DEPENDS="libffi, libandroid-support"
TERMUX_PKG_NO_DEVELSPLIT=true
TERMUX_PKG_HOSTBUILD=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-racket=$TERMUX_PKG_HOSTBUILD_DIR/racket/racketcgc
--enable-libs
--disable-shared
--disable-gracket
--enable-libffi
"

termux_step_host_build() {
	$TERMUX_PKG_SRCDIR/src/configure ${TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j $TERMUX_MAKE_PROCESSES
}

termux_step_pre_configure() {
	CPPFLAGS+=" -I$TERMUX_PKG_SRCDIR/src/racket/include -I$TERMUX_PKG_BUILDDIR/racket"
	# Due to use of syslog.
	LDFLAGS+=" -llog"
	export TERMUX_PKG_SRCDIR=$TERMUX_PKG_SRCDIR/src
}
