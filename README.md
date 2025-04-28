# MHNnet Emerge Scripts

This is a small assembly of helper scripts to manage Gentoo installations.
The scripts support three different "setup types":

 1. _Standalone:_ This setup is a traditional Gentoo installation.
    Machines with this setup download the sources of a package from a
    Gentoo mirror and build the package locally.
 2. _Build server:_ This setup is a Gentoo installation in a chroot
    environment which maintains a "prototype" installation for a
    build client and prepares binary packages for the build client.
 3. _Build client:_ This setup is a Gentoo installation which pulls its
    Portage configuration from a corresponding build server and also
    fetches pre-compiled binary packages from the build server for
    installation.

Most scripts are simple wrappers around corresponding `emerge` commands with
some additional default flags.
A notable exception is `emerge-sync` whose behavior depends on the setup
type:

 1. _Standalone:_ For standalone installations `emerge-sync` is a wrapper
    around `emerge --sync` with some extra flags similar to the other
    `emerge-*` scripts.
 2. _Build server:_ For build servers the script is a no-op.
    A build server is running in a chroot environment, uses the same
    repositories as the host and assumes that the host syncs the
    repositories.
 3. _Build client:_ For build clients the script does not only
    synchronizes the package repositories, but also pulls the Portage
    configuration from the build server.

The script `emerge-do-all` allows non-privileged users to trigger a full
system upgrade of the system incl. maintenance tasks.
