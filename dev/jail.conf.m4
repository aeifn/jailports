allow.raw_sockets=1;
host.hostname=$name;
interface="vtnet0";
exec.start="/bin/sh /etc/rc";
exec.stop="/bin/sh /etc/rc.shutdown";
path="/usr/local/jails/$name/root";
mount.fstab=/usr/local/jails/$name/fstab;
mount.devfs;

_NAME_ {
	ip4.addr="_IP_";
}
