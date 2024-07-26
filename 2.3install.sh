#!/bin/bash

# 说明信息和当前时间
echo "星穹铁道2.3版本，构建于2024.7"
echo "当前时间: $(date '+%Y-%m-%d %H:%M:%S')"

# 询问是否安装
read -p "是否继续 (yes/no): " user_input

if [ "$user_input" = "yes" ]; then
    echo "正在下载必须文件..."
    pkg install wget
    wget https://cloud.wujiyan.cc/f/LRqSE/HSR_2.3tar.gz
    echo "请稍候..."
    if [ -s "./HSR_2.3.tar.gz" ];then
        echo "下载完成"
        echo"正在解压"
        cd ~
        cd ~
        tar -v -xzvf ./Anime-game-Server/HSR_2.3.tar.gz  -C ../../files2
        mv ../../files2/data/data/com.termux/files/home ../../files
        mv ../../files2/data/data/com.termux/files/usr ../../files
        rm -rf ../../files2/data
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
