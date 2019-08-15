#!/bin/bash

# https://docs.aws.amazon.com/ko_kr/efs/latest/ug/wt1-test.html
${nfs_installer_command}

# prepare mount
mkdir -p ${mount_local_path}

# execute mount
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport \
    ${mount_dns}:${mount_remote_path} ${mount_local_path}

# add permission for the mounted dir
chown ${user}:${user} ${mount_local_path}

