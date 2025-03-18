Fish functions get sourced into every shell instance.

These functions usually need to set ENV variables with `set -gx`  in which case
doing it from a sub-shell doesn't work (e.g. when loading secrets).

These usually live at: `~/.config/fish/functions`
