# TODO
 - Reconfigure .ssh
 - Reconfig .gitconfig.
 - Reconfigure  completion.tcsh.
 - Fix failed installation on VirtualBox. 

```
 Error: Execution of '/usr/sbin/installer -pkg /private/tmp/dmg.g5qTYM/VirtualBox.pkg -target /' returned 1: installer: Package name is Oracle VM VirtualBox
 installer: Installing at base path /
 installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance.)
 Error: /Stage[main]/Virtualbox/Package[VirtualBox-4.3.2-90405]/ensure: change from absent to present failed: Execution of '/usr/sbin/installer -pkg /private/tmp/dmg.g5qTYM/VirtualBox.pkg -target /' returned 1: installer: Package name is Oracle VM VirtualBox
 installer: Installing at base path /
 installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance.)
```

 - Fix git-flow
 - Make macPass boxen.
 - Reconfigure packer, it was installed manually
 - Create PR for the GPGtool