# JAIL BUILD SYSTEM FOR FREEBSD

## Main directories

```
/usr/local/jails - contains images
 |- $jail_name
    |- root
    |- fstab
 |- ...

/usr/local/share/jail
 |- releases
    |- 12.1-RELEASE - extracted base.txz system
```

## General usage

cd into jailport directory, run 

```
make install
```

it will produce working jail.
You can change NAME and IP of jail, defining like this:

```
make NAME=jailname IP="lo1|10.0.0.1" install
```

Please inspect sourcecode before use.
