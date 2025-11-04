must use sudo
must specify the tty you are on

sudo kmscon \
--vt tty4 \
--switchvt \
--drm \
--hwaccel \
--font-engine pango

That has been enough for me

Ctrl++ - increase font size
Ctrl-- - decrease font size


zellij is perfect
Tabs are the way to go
Ctrl+t is the easiest way, instead of Alt + arrows, although that is easy too


You must add this block to ~/.config/zellij/config.kdl
```
normal {
  unbind "Ctrl h" { SwitchToMode "Move"; }
}
```