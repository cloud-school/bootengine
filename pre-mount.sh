#!/bin/sh
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

find_root() {
    blkdev=${root#*GPTPRIO=}
    for dev in ${blkdev}; do
        blkid -L $dev
        root="block:/dev/sda4"
        cgpt show -i 4 -P /dev/sda
}

if [ -n "$root" -a -z "${root%%gptprio:*}" ]; then
    find_root
fi
