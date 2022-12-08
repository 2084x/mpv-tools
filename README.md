# mpv-tools
Various scripts for mpv.

## auto-set.lua

Automatically sets `loop-file=inf` if duration <= given length or `pause` if path has no duration (image file).

Can optionally ignore file types / directories.

Based on [autoloop](https://github.com/zc62/mpv-scripts/blob/master/autoloop.lua).

## blackout-next.lua

An alternative to [blackout](https://github.com/sibwaf/mpv-scripts/blob/master/blackout.lua) / [boss-key](https://github.com/detuur/mpv-scripts/blob/master/boss-key.lua) for `vo=gpu-next`.

`b` toggles blackout.

Does not minimise window or pause file.

## copy-paste.lua

A simple script to copy paths from and paste links into mpv.

`y` copies (yanks) path of current file to clipboard.

`alt+v` appends clipboard contents to playlist.

`ctrl+v` loads clipboard contents.

Based on [copy-permalink](https://gist.github.com/olejorgenb/a5194d9bc183dbe0bfb02aac18fe37f9) (copying) and [copy-paste-url](https://github.com/yassin-l/copy-paste-url/blob/master/copy-paste-url.lua) (pasting).

## redshift-toggle.lua

Toggle redshift when using mpv.

`F1` activates / deactivates toggling of redshift on a window-by-window basis.

Based on [toggle-redshift-on-play](https://gist.github.com/CreamyCookie/d036b66af4e17ea527d08e303eb96145). 
