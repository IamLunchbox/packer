# packer-vm

This is my repository for packer privisioned virtual machiness. Virtualbox is the only supported    
hypervisor. If you look at the configuration files you'll notice, that each VM will be exported to     
`/tmp/packer_builds` as a default directory. You can change this with the flag `-var='build_directory=/your/prefered/dir'`     

## How do I run this?
First off, you'll need the packer binary in your $PATH (obiously). I always run packer as:      
`packer build -only=virtualbox-iso path/to/linux.json`
You could actually use an alias to run packer
`alias packer='packer build -only=virtualbox-iso'`
     
Any variable assigned in the `"variables":{ ... }` section can be changed using the `-var` flag.     
You *should always* set another password using either `-var='password=foo'` or `-var-file="password.json"`. Nevertheless, a default password is still supplied. For now.
The follwing variables work and don't break the build process:     

Variable | Use | Default | Values
:---:|:---:|:---:|:---:
`password` | Set the user password for the VM | ubuntu | Any string
`guest_additions_mode` | Decide if you want to deploy and install the Virtualbox-Guest-Additions-ISO | `upload` | `disable`,`upload`,`attach`
`vramsize` | Virtual RAM for your VM | 8 |1-128 or 1-256
`desktop_env` | Select a specific desktop environment, changing this will change the i3-Desktop of Ubuntu to Gnome | `i3` | `i3`, `gnome`
`cpus` | Number of assigned cpus | `2` | Depends on your setup

For other flags you may consult the packer [documentation](https://www.packer.io/docs), keep in mind that changing some vaules may crash the build process.

## To-do

The most recent changes have been done to the ubuntu build - the kali-build needs additional tweaking, including upgrading to the current version of the kali installer.


