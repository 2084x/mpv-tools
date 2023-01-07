# mpv-tools

Various small scripts for mpv. 

Options (if available) can be configured at the beginning of each script. 

Keybinds can be changed at the end of each script.

## bo.lua

An alternative to [blackout](https://github.com/sibwaf/mpv-scripts/blob/master/blackout.lua) / [boss-key](https://github.com/detuur/mpv-scripts/blob/master/boss-key.lua) for `vo=gpu-next`.

<kbd>b</kbd> toggles blackout.

Does **not** minimise window or alter pause state.

Based on [quality-menu's](https://github.com/christoph-heinrich/mpv-quality-menu) curtain opacity feature.

## dl.lua

Downloads current video with yt-dlp.

<kbd>d</kbd> starts download.

Based on [ytdl-preload](https://gist.github.com/bitingsock/17d90e3deeb35b5f75e55adb19098f58).

## rs.lua

Toggles redshift when using mpv.

<kbd>r</kbd> activates / deactivates toggling on a window-by-window basis.

Based on [toggle-redshift-on-play](https://gist.github.com/CreamyCookie/d036b66af4e17ea527d08e303eb96145). 

## set.lua

Automatically sets `loop-file=inf` if duration <= given length or `pause` if path has no duration (image file).

Based on [autoloop](https://github.com/zc62/mpv-scripts/blob/master/autoloop.lua).

## skip.lua

Automatically skips chapters based on their title.

<kbd>F1</kbd> toggles skipping off / on.

Based on [skipchapters](https://github.com/haasn/gentoo-conf/blob/xor/home/nand/.mpv/scripts/avail/skipchapters.lua).

## yap.lua

Yanks, appends and puts paths / links.

<kbd>y</kbd> yanks (copies) path of current file to clipboard.

<kbd>a</kbd> appends clipboard contents to playlist.

<kbd>P</kbd> puts (pastes) and loads clipboard contents.

Based on [copy-permalink](https://gist.github.com/olejorgenb/a5194d9bc183dbe0bfb02aac18fe37f9) and [copy-paste-url](https://github.com/yassin-l/copy-paste-url/blob/master/copy-paste-url.lua).
