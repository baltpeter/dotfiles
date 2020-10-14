# Taken from: https://github.com/wimpysworld/quickemu/blob/master/quickemu
function get_port() {
        local PORT_START=$1
        local PORT_RANGE=$2
        while true; do
            local CANDIDATE=$[${PORT_START} + (${RANDOM} % ${PORT_RANGE})]
            (echo "" >/dev/tcp/127.0.0.1/${CANDIDATE}) >/dev/null 2>&1
            if [ $? -ne 0 ]; then
                echo "${CANDIDATE}"
                break
            fi
        done
    }

function qemu-iso () {
    if (( ARGC != 1 )); then
        printf 'usage: qemu-iso <isofile>\n'
        return 1;
    fi
    if [[ ! -f "$1" ]]; then
        echo "Error: Path doesn't exist: '$1'"
        return 1;
    fi

    if [ -x "$(command -v qemu-virgil)" ]; then
        QEMU=$(which qemu-virgil)
    else
        QEMU=$(which qemu-system-x86_64)
    fi

    ISO_NAME="${1##*/}"

    # Adapted after: https://github.com/wimpysworld/quickemu/blob/master/quickemu
    readonly LAUNCHER=$(basename "${0}")
    local SPICE_PORT=$(get_port 5930 9)
    if [ ! -n "${SPICE_PORT}" ]; then
        echo " - spice:      All spice ports have been exhausted."
    fi

    ${QEMU} \
      -enable-kvm -machine q35 \
      -cpu host,kvm=on -smp 4,sockets=1,cores=4,threads=1 \
      -m 4G -device virtio-balloon \
      -device virtio-vga,virgl=on,xres=1152,yres=648 -display sdl,gl=on \
      -device qemu-xhci,id=usb,p2=8,p3=8 -device usb-kbd,bus=usb.0 -device usb-tablet,bus=usb.0 \
      -device virtio-net,netdev=nic -netdev user,hostname=qemu-iso-${ISO_NAME}-tmp,id=nic \
      -audiodev pa,id=pa,server=unix:${XDG_RUNTIME_DIR}/pulse/native,out.stream-name=${LAUNCHER}-${ISO_NAME},in.stream-name=${LAUNCHER}-${ISO_NAME} \
      -device intel-hda -device hda-duplex,audiodev=pa,mixer=off \
      -rtc base=localtime,clock=host \
      -object rng-random,id=rng0,filename=/dev/urandom \
      -device virtio-rng-pci,rng=rng0 \
      -spice port=${SPICE_PORT},disable-ticketing \
      -device virtio-serial-pci \
      -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
      -chardev spicevmc,id=spicechannel0,name=vdagent \
      -serial mon:stdio \
      "${@}"
}

# MIT License
#
# Copyright (c) 2020 Wimpy's World
# Copyright (c) 2020 Benjamin Altpeter
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
