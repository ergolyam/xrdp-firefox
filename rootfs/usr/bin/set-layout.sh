#!/usr/bin/env ash

DEFAULT_OPTION="grp:win_space_toggle"

if [ "${XKBMAP_OPTION:-}" ]; then
  DEFAULT_OPTION=$XKBMAP_OPTION
fi

if grep -q "^\[rdp_keyboard_ru\]" "/etc/xrdp/xrdp_keyboard.ini"; then
    echo "The rdp_keyboard_ru section is already present - I skip it."
else

tee -a /etc/xrdp/xrdp_keyboard.ini >/dev/null <<EOF

[rdp_keyboard_ru]
keyboard_type=4
keyboard_subtype=1
model=pc105
options=$DEFAULT_OPTION
rdp_layouts=default_rdp_layouts
layouts_map=layouts_map_ru

[layouts_map_ru]
rdp_layout_us=us,ru
rdp_layout_ru=us,ru
EOF
fi

