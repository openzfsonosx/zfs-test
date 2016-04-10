
WARNING: These tests should only be run in a VM or other similar disposable OSX installation. There are tests that are known to render your machine unbootable, they have been disabled until issue resolved. Having said that, let the buyer beware!

These tests take along time to run probably more than 3 hours.

Approximately 75% of the tests currently pass

This is the ZFS Test Suite, with support for all platforms that ZFS from Sun Solaris have been ported to.


Setup
========================================================================

* The user zfs-test needs to be able to run sudo without issuing a
password. Add the following to sudoers:

    zfs-tests   ALL=(ALL) NOPASSWD: ALL

* The sudo root environment must be configured to pass certain enviroment variables from zfs-test through to the root environment. Add the following to sudoers:

    Defaults env_keep += "__ZFS_MAIN_MOUNTPOINT_DIR"

and assign __ZFS_MAIN_MOUNTPOINT_DIR to / somewhere central (e.g. /etc/bashrc).

* To run the Test Suite, it is also required that you have a built O3X
zfs and spl repository in:

    ../zfs
    ../spl

* You will need quite a lot of free space on /var/tmp (which needs
to be 'rwxrwxrwt') for temporary files etc. At least 100GB seems
to be required.

* To setup the test suite, run

   ./autogen.sh
	./configure CC=clang CXX=clang++ 

* Recommended configuration is to provide your test environment
  with 3 x 25 GB HDD in addition to the boot drive. There are certain tests
  that cannot operate in a file based environemnt, this will allow those
  tests to execute.

  The three drives will be erased, please ensure they contain no valuable data!

  Ensure that the DISKS environment variable the in test_hw target in 
  the makefile contains the /dev/diskX /dev/diskY and /dev/diskZ
  entries for your 25 GB test drives. Then:

    sudo make test_hw

   NOTE: every time you restart OSX the drives can move, the makefile must be aligned with the output of "diskutil list".

To run specific test group(s), make a copy of the

   cp test/zfs-tests/runfiles/osx.run test/zfs-tests/runfiles/osx.run.tmp

file, edit it (uncomment or delete all that shouldn't be run) and set
the RUNFILE variable:

     export RUNFILE="-c test/zfs-tests/runfiles/osx.run.tmp"


