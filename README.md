
BGH: Some progress has been made, all test programs now compile. The tests attempt to run
but generally fail. The test scripts need to be augmented for conditional behavior
where the is a $LINUX logical branch in the script, and equivalent $OSX branch needs
to be added.

WARNING: You should never run these tests on a production system. They are 
probably dangerous for existing data.

This is (supposed to be) the ZFS Test Suite, with support for all platforms
that ZFS from Sun Solaris have been ported to.


To setup the test suite, run

   ./autogen.sh

This will create the configure file. Run this to setup the makefiles etc.

   ./configure CC=clang CXX=clang++ 

Then, to run the test suite, just issue the command:

   sudo make test

It will require that your environment is setup in a certain way, but
the Makefile will make sure to check this. Most of it any way...

To run specific gest group(s), make a copy of the

   cp test/zfs-tests/runfiles/osx.run test/zfs-tests/runfiles/osx.run.tmp

file, edit it (uncomment or delete all that shouldn't be run) and set
the RUNFILE variable:

     export RUNFILE="-c test/zfs-tests/runfiles/osx.run.tmp"


                             CAVEATS
========================================================================
* The user zfs-test needs to be able to run sudo without issuing a
  password.

* To run the Test Suite, it is also required that you have a built O3X
  zfs repository in:

	../zfs

* You will need quite a lot of free space on /var/tmp (which needs
  to be 'rwxrwxrwt') for temporary files etc. At least 100GB seems
  to be required.
