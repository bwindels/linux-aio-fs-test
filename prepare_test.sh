#!/bin/bash
source config_test.sh
TESTFILE_SIZE=100M
echo "### prepare test file ..."
set -x
rm $TESTFILE
head -c $TESTFILE_SIZE </dev/urandom > $TESTFILE
set +x
echo "### prepare xfs partition ..."
set -x
sudo umount $XFS_PARTITION > /dev/null
sudo mkfs.xfs -f $XFS_PARTITION > /dev/null
mkdir -p $XFS_MOUNTPOINT
sudo mount $XFS_PARTITION $XFS_MOUNTPOINT > /dev/null
sudo cp $TESTFILE $XFS_MOUNTPOINT > /dev/null
set +x
echo "### prepare btrfs partition ..."
set -x
sudo umount $BTRFS_PARTITION > /dev/null
sudo mkfs.btrfs -f $BTRFS_PARTITION > /dev/null
mkdir -p $BTRFS_MOUNTPOINT
sudo mount $BTRFS_PARTITION $BTRFS_MOUNTPOINT > /dev/null
sudo cp $TESTFILE $BTRFS_MOUNTPOINT > /dev/null
set +x
echo "### prepare ext4 partition ..."
set -x
sudo umount $EXT4_PARTITION > /dev/null
sudo mkfs.ext4 -F $EXT4_PARTITION > /dev/null
mkdir -p $EXT4_MOUNTPOINT
sudo mount $EXT4_PARTITION $EXT4_MOUNTPOINT > /dev/null
sudo cp $TESTFILE $EXT4_MOUNTPOINT > /dev/null
set +x
echo "### compile sha512sum_aio ..."
set -x
cc sha512sum_aio.c -o sha512sum_aio -lcrypto
set +x