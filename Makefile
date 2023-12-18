PREFIX = ${HOME}/.config/roxterm.sourceforge.net/Colours

mkdirp:
	@mkdir -p ${PREFIX}

install: mkdirp
	@install solarized-dark ${PREFIX}
	@install solarized-light ${PREFIX}

uninstall:
	@rm -f ${PREFIX}/solarized-dark
	@rm -f ${PREFIX}/solarized-light

