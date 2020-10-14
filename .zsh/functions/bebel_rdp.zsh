# Create an SSH tunnel for RDP to a computer at bebelhof.de. First argument is the local IP of the PC.
bebel_rdp () {
    if (( ARGC < 1 )); then
        printf 'usage: bebel_rdp <local_ip>\n'
        return 1;
    fi

    ssh root@bebelhof.de -N -L 4000:$1:3389
}
