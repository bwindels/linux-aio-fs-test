source config_test.sh
TEST_CMD="strace -w -c -e io_submit,epoll_wait,io_getevents ./sha512sum_aio $((50*1024))"

echo "### run xfs test..."
sudo time $TEST_CMD ${XFS_MOUNTPOINT}$TESTFILE
echo "### run btrfs test..."
sudo time $TEST_CMD ${BTRFS_MOUNTPOINT}$TESTFILE
echo "### run ext4 test..."
sudo time $TEST_CMD ${EXT4_MOUNTPOINT}$TESTFILE
