#!/bin/bash



Echo_Yellow()
{
  echo $(Color_Text "$1" "33")
}


Self_Download(){
        v2_ver=`curl --silent "https://api.github.com/repos/JMVoid/ssrpanel-v2ray/releases/latest" |  grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'`
        wget https://github.com/JMVoid/ssrpanel-v2ray/releases/download/$va_ver/ssrpanel-v2ray.tar.gz

        if [[ $? -eq 0 ]]; then
 		tar zxvf ssrpanel-v2ray.tar.gz
        else
                echo "fail to get ssrpanel-v2ray, exit"
                exit 1
        fi
}


V2ray_Download(){
if [[ $? -eq 0 ]]; then
        v2_ver=`curl --silent "https://api.github.com/repos/v2ray/v2ray-core/releases/latest" |  grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'`
        wget https://github.com/v2ray/v2ray-core/releases/download/$v2_ver/v2ray-linux-$linxu_bits.zip

        if [[ $? -eq 0 ]]; then
 		unzip v2ray-linux-$linxu_bits.zip -d ./v2ray-core
        else
                echo "fail to get vadaptor, exit"
                exit 1
        fi
else
        echo "fail t get v2ray-core, exit"
        exit 1
fi
}


Get_Dist_Name()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Amazon Linux" /etc/issue || grep -Eq "Amazon Linux" /etc/*-release; then
        DISTRO='Amazon'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    elif grep -Eqi "Deepin" /etc/issue || grep -Eq "Deepin" /etc/*-release; then
        DISTRO='Deepin'
        PM='apt'
    elif grep -Eqi "Mint" /etc/issue || grep -Eq "Mint" /etc/*-release; then
        DISTRO='Mint'
        PM='apt'
    elif grep -Eqi "Kali" /etc/issue || grep -Eq "Kali" /etc/*-release; then
        DISTRO='Kali'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    Get_OS_Bit
}

Get_OS_Bit()
{
    if [[ `getconf WORD_BIT` = '32' && `getconf LONG_BIT` = '64' ]] ; then
        Is_64bit='y'
        linux_bits="64"
    else
        Is_64bit='n'
        linux_bits="32"
    fi
}


Install_OpenJDK(){
  $PM install openjdk-8-jdk
  if [ $? -ne 0 ]; then
      echo 'fail to install openjdk, exit...'
      exit 1
  if
	
}

Install_Wget(){
  $PM install wget
  if [ $? -ne 0 ]; then
      echo 'fail to install wget, exit...'
      exit 1
  if
}

Check_Root(){
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install"
    exit 1
fi
}

GetTar_panel(){
   wget https://github.com/JMVoid.....
   if [ $? -ne 0 ]; then
      echo 'fail to download ssrpane v2ray tar file'
      exit 1
   fi 
   tar zxvf xxxx.tar.gz 
}

Config_Input(){
	db_username="root"

	echo "You need to setup up node in ssrpanel first before input node id"
	read -p "Node ID: " $node_id
        echo "ssrpanel mysql url like as 123.456.789.888:3306"
	read -p "ssrpanel mysql url:", $db_url
	mysql_url=jdbc:mysql://${db_url}/ssrpanel?serverTimezone=GMT%2B8
        read -p "mysql username:(defalut root)", $db_username
	read -p "mysql database password:", $db_password


	sed -i "s/\(node\.id=\).*\$/\1${node_id}/" config.properties
	sed -i "s/\(datasource\.url=\).*\$/\1${mysql_url}/" config.properties
	sed -i "s/\(datasource\.username=\).*\$/\1${db_username}/" config.properties
	sed -i "s/\(datasource\.password=\).*\$/\1${db_password}/" config.properties
	
}

v2ray_cfg_type = ('vmess-kcp-utp','vmess-kcp-wechat')

V2rayConfig_Selection(){
	cfg_type = "1"
	Echo_Yellow "You have two options for base v2ray config file"
	echo "1. Use ${v2ray_cfg_type[0]}"
	echo "2. Use ${v2ray_cfg_type[1]}"
	read -p "Enter you choice:" cfg_type
	cp $cfg_type.json ./v2ray-core/config.json
        
}


Get_Dist_Name
Self_Download
V2ray_Download
Config_Input
V2rayConfig_Selection



# check os and bits to define what version v2ray donwload
# wget ssrpanel-v2ray.tar.gz file
# untar ssrpanel-v2ray.tar.gz file
# wget updatest v2ray-core from github 
# ask node_id
# ask database url xxxx:port
# ask database password
# ask vmess_kcp_utp, vemss_kcp_webchat, vmess_tls_ws
# copy right config to config.json 


