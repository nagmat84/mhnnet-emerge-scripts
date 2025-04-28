# MHNnet Client Scripts

This is a small assembly of helper scripts to manage Gentoo installations.
For each Gentoo installation, the build server maintains a "prototype"
installation.
A client pulls its corresponding installation from the build server.

Most scripts are simple wrappers around corresponding `emerge` commands with
some additional default flags.
A notable exception is `emerge-sync` which does not only synchronizes the
package repositories,
but also pulls the Portage configuration from the build server.
The script `emerge-do-all` allows non-privileged users to trigger a full
system upgrade of the system incl. maintenance tasks.
