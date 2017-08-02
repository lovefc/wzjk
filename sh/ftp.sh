#!/bin/bash

# 创建一个目录,存放压缩包
mkdir webfile
btime=$(date +%y%m%d%H%M)
agobtime=$(date -d -7day +%y%m%d%H%M)
# 压缩目录成压缩包
tar -cvf webfile/vps_web_$btime.tar /home/admin/domains
bzip2 -z -9 -f webfile/vps_web_$btime.tar
# 进入目录
cd webfile

#执行ftp上传命令
ftp -v -n 127.0.0.1 <<end
user ftpuser password
type binary
cd webbackup
put vps_web_$btime.tar.bz2
delete vps_web_$agobtime.tar.bz2
bye
end

# cd ..
# rm -r webfile
