#!/bin/bash

# 说明信息和当前时间
echo "星穹铁道2.3版本，构建于2024.7"
echo "当前时间: $(date '+%Y-%m-%d %H:%M:%S')"

# 询问是否安装
read -p "是否继续 (yes/no): " user_input

if [ "$user_input" = "yes" ]; then
    chmod +x start.sh
    echo "正在下载必须文件..."
    pkg install curl -y
    pkg install openjdk-17 -y
    echo "正在下载主体文件"
    curl -# -LO https://cloud.wujiyan.cc/f/8w4Tb/HSR_2.3.zip
    echo "请稍候..."
    if [ -s "./HSR_2.3.zip" ]; then
        echo "下载完成"
        echo "正在解压"
        unzip HSR_2.3.zip
        echo "解压完成"
        rm -rf HSR_2.3.zip
        read -p "是否安装Mongodb数据库 ，推荐安装(yes/no): " user2_input
        if [ "$user2_input" = "yes" ]; then
            echo "正在下载"
            curl -# -LO https://cloud.wujiyan.cc/f/4Mkix/deb.sh
            bash deb.sh
            pkg update -y
            pkg install mongodb -y
            # 设置红色文本
            echo -e "\033[31m完成，如有报错请截图，不是100%成功\033[0m"
            # 设置蓝色文本
            echo -e "\033[34m开始运行\033[0m"
            ./start.sh
            exit 1
        else
            # 设置蓝色文本
            echo -e "\033[34m开始运行\033[0m"
            java -jar LunarCore.jar
            exit 1
        fi
    else
        echo "下载失败"
        exit 1
    fi
else
    exit 1
fi
