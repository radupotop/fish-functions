Fish functions get sourced into every shell instance.

These functions usually need to export ENV variables with `set -gx`  in which case
doing it from a sub-shell doesn't work (e.g. when loading secrets).

They usually live at: `~/.config/fish/functions`
