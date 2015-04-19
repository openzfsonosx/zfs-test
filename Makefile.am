SUBDIRS  = test/zfs-tests/tests/functional/ctime
SUBDIRS += test/zfs-tests/tests/functional/exec
SUBDIRS += test/zfs-tests/cmd/chg_usr_exec
SUBDIRS += test/zfs-tests/cmd/mktree
SUBDIRS += test/zfs-tests/cmd/file_write
SUBDIRS += test/zfs-tests/cmd/mkbusy
SUBDIRS += test/zfs-tests/cmd/randfree_file
SUBDIRS += test/zfs-tests/cmd/largest_file
SUBDIRS += test/zfs-tests/cmd/rm_lnkcnt_zero_file
SUBDIRS += test/zfs-tests/cmd/readmmap
SUBDIRS += test/zfs-tests/cmd/mmapwrite
SUBDIRS += test/zfs-tests/cmd/file_trunc
SUBDIRS += test/zfs-tests/cmd/file_check

abs_top_srcdir = /usr/src/zfs-test
SHELL = /bin/bash

AUTOMAKE_OPTIONS = foreign

ctags:
	$(RM) $(top_srcdir)/tags
	find $(top_srcdir) -name .git -prune -o -name '*.[hc]' | xargs ctags

etags:
	$(RM) $(top_srcdir)/TAGS
	find $(top_srcdir) -name .pc -prune -o -name '*.[hc]' | xargs etags -a

test: test_verify test/zfs-tests/cmd
	@KEEP="`zpool list -H -oname`" \
	 STF_TOOLS=$(abs_top_srcdir)/test/test-runner/stf \
	 STF_SUITE=$(abs_top_srcdir)/test/zfs-tests \
	 DISKS="$(shell for i in {1..3}; do \
	    rm -f /var/tmp/zfs_test-$$i; \
	    $(abs_top_srcdir)/scripts/mkfile -s 25000m /var/tmp/zfs_test-$$i; \
	    echo "/var/tmp/zfs_test-$$i "; \
	   done)" \
	 su zfs-tests -c "ksh $(abs_top_srcdir)/test/zfs-tests/cmd/scripts/zfstest.ksh $$RUNFILE"

test_verify:
	@# -------------------------------------------------------------------
	@# adduser --home /var/tmp/test_results --shell /usr/bin/ksh --gecos "ZFS Test Suite" --disabled-password zfs-tests
	@# echo 'zfs-tests	ALL = (ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
	@# -------------------------------------------------------------------
	@( if ! id zfs-tests > /dev/null 2>&1; then \
		echo "ERROR: You must create a 'zfs-tests' user to run the test as."; \
		exit 1; \
	   fi; \
	   if ! su - zfs-tests -c "sudo ls" > /dev/null 2>&1; then \
		echo "ERROR: User zfs-tests is not allowed to run sudo without password."; \
		exit 1; \
	   fi)

test/zfs-tests/cmd:
	@(for subdir in $(SUBDIRS); do \
		make -C $$subdir all; \
	done)

clean:
	@(for subdir in $(SUBDIRS); do \
		make -C $$subdir clean; \
	done)

tags: ctags etags

.PHONY: test test/zfs-tests/cmd

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
