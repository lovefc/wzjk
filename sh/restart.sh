#!/bin/bash

# 执行进程重启任务 
# 各个服务器有所差异,请根据实际情况来调整

# 重启apache
/etc/init.d/httpd restart

# 重启php
/etc/init.d/php-fpm restart

# 重启nginx
/etc/init.d/nginx	restart

# 重启mysql
/etc/init.d/mysqld	restart