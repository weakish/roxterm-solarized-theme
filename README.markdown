Roxterm solarized theme
==========================

Description
-------------

[Solarized] themes (dark and light) for roxterm.

[Solarized]: http://ethanschoonover.com/solarized

Install
---------

```sh
make install
```

The Makefile is compatible with both GNU and BSD make.

Alternatively, you can manually copy `solarized-dark` and/or `solarized-light` into
`~/.config/roxterm.sourceforge.net/Colours/`.

Uninstall
---------

```sh
make uninstall
```

Alternatively, you can manually delete `solarized-dark` and/or `solarized-light` under
`~/.config/roxterm.sourceforge.net/Colours/`.


Development
-----------

For ease of updating and to avoid manual typos,
I wrote a script (gen-theme.rc) to generate the dark theme file from 
upstream (main solarized repo) README.md automatically.
Then I copied the dark theme file and edited it manually to
produce the light theme file.
(Since there are only few differences, I don't bother to alter
my script to generate both themes.
Improvements are always welcome, though.)

Links
-------

- Solarized main repository: <https://github.com/altercation/solarized/>
- repo of this theme itself: <https://github.com/weakish/roxterm-solarized-theme>

Screenshots
------------

Screenshots of `htop` under roxterm with solarized dark and light theme.

![htop under roxterm with solarized dark theme](dark.png)

![htop under roxterm with solarized light theme](light.png)
