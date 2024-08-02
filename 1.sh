#!/bin/bash
# 说明信息和当前时间
function print_info {
    dialog --msgbox "LunarCore_2.4\n当前时间: $(date '+%Y-%m-%d %H:%M:%S')" 10 50
}

# 下载环境
function install_packages {
    echo "正在下必要环境Jdk17..."
    pkg install curl -y
    pkg install openjdk-17 -y
}

# 颜色变量移除了
# 下载文件
function download_file {
    local url=$1
    local output=$2
    local retries=3
    local count=0

    echo -e "${BLUE}正在下载 ${output}...${NC}"

    until [ $count -ge $retries ]
    do
        curl -L -o "$output" "$url" && break
        count=$((count+1))
        echo -e "${RED}下载失败，重试 $count/${retries}...${NC}"
        sleep 2
    done

    if [ $count -ge $retries ]; then
        echo -e "${RED}下载失败，已尝试 $retries 次。${NC}"
        return 1
    fi

    echo -e "${GREEN}下载完成${NC}"
}

# 解压文件
function extract_file {
    local file=$1
    echo "正在解压 $file"
    unzip "$file"
    echo "解压完成"
    rm -rf "$file"
}

# 安装Mongodb
function install_mongodb {
    download_file "https://cloud.wujiyan.cc/f/zdRSn/mongodb_4.2.9_aarch64.deb" "mongodb_4.2.9_aarch64.deb"
    dpkg -i mongodb_4.2.9_aarch64.deb
    pkg update -y
    dialog --msgbox "完成，如有报错请截图，不是100%成功" 10 50
}

# 开始运行程序
function start_program {
    if [ "$1" = "yes" ]; then
        ./start.sh
    else
        java -jar "$package_name"
    fi
}

# 原始主函数（变）
function LunarCore {
    package_name="LunarCore.jar"
    print_info

    while true; do
        dialog --yesno "是否继续?" 10 50
        if [ $? -ne 0 ]; then
            return
        fi

        chmod +x start.sh
        install_packages

        download_file "https://cloud.wujiyan.cc/f/Wyehy/HSR_2.4.zip" "HSR_2.4.zip"

        if [ ! -s "./HSR_2.4.zip" ]; then
            dialog --msgbox "下载失败" 10 50
            return
        fi

        extract_file "HSR_2.4.zip"

        dialog --yesno "是否安装Mongodb数据库，推荐安装?有极大的概率失败(等待修复)" 10 50
        if [ $? -eq 0 ]; then
            install_mongodb
        fi

        dialog --msgbox "开始运行" 10 50
        start_program "$user2_input"
        return
    done
}

# 其他下载项目的函数
function Grasscutter {
    while true; do
        dialog --yesno "是否继续下载Grasscutter?" 10 50
        if [ $? -ne 0 ]; then
            return
        fi

        dialog --msgbox "下载Grasscutter的逻辑" 10 50
        echo "下载Grasscutter..."
        return
    done
}

function zzz {
    while true; do
        dialog --yesno "是否继续下载zzz?" 10 50
        if [ $? -ne 0 ]; then
            return
        fi

        dialog --msgbox "下载zzz的逻辑" 10 50
        echo "下载zzz..."
        return
    done
}

# 新的主函数
function main {
    while true; do
        exec 3>&1
        selection=$(dialog --menu "选择菜单(Cancel/Esc退出)：" 15 50 3 \
            1 "⭐️·穹铁道 修复中" \
            2 "⭕️神      不可用" \
            3 "绝蛆0️⃣    不可用"\
            2>&1 1>&3)
        exit_status=$?
        exec 3>&-

        if [ $exit_status -ne 0 ]; then
            clear
            exit 1
        fi

        case $selection in
            1) LunarCore ;;
            2) Grasscutter ;;
            3) zzz ;;
            *) clear; exit 1 ;;
        esac
    done
}

# 调用主函数
main

