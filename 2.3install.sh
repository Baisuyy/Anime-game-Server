#!/bin/bash

# 说明信息和当前时间
echo "星穹铁道2.3版本，构建于2024.7"
echo "当前时间: $(date '+%Y-%m-%d %H:%M:%S')"

# 询问用户是否安装
read -p "是否继续 (yes/no): " user_input

if [ "$user_input" = "yes" ]; then
    echo "正在下载必须文件..."
    pkg install wget
    wget https://github.com/Baisuyy/Anime-game-Server/releases/download/dev/HSR2.3_LC_andriod.tar.gz
    echo "请稍候..."
    if [ -s "./HSR2.3_LC_andriod.tar.gz" ];then
        echo "下载完成"
        echo"正在解压"
        tar -zxvf HSR2.3_LC_andriod.tar.gz
        echo "解压完成"
        #后台启动MongoDB
        nohup mongod 2>&1 &
        #第一次运行
        cd 
else
    echo "失败"
    exit 1
fi
else
    exit 1
fi
