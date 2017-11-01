export TEST_DEVICE=/dev/sdd3
export TEST_MOUNTPOINT=test_drive/
export TEST_FILENAME=${TEST_MOUNTPOINT}randomfile
export TEST_FILESIZE=2G

set -x
sudo umount $TEST_DEVICE
mkdir -p $TEST_MOUNTPOINT
sudo mkfs.xfs -f $TEST_DEVICE
sudo mount $TEST_DEVICE $TEST_MOUNTPOINT
sudo -E sh -c 'head -c $TEST_FILESIZE </dev/urandom > "${TEST_FILENAME}"'
sudo /usr/bin/time strace -w -c ./sha512sum_aio $((512*1024)) $TEST_FILENAME
