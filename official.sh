#！/bin/bash

### check script update
script_latest_version=$(curl -Ls "https://api.github.com/repos/UbiquityTony/Cloudreve-Script/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

### check the latest version from github
cloudreve_version=$(curl -Ls "https://api.github.com/repos/cloudreve/cloudreve/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

### update needed
script_current_version=1.0.1
update_time=2022.06.19

### update official edition
#beta_verison=false
beta_word=
beta_connect=

### update beta
beta_verison=84574
#beta_word=beta
#beta_connect=

### init
cloudreve_type=community
cloudreve_pro=false
cloudreve_name=cloudreve
cloudreve_mixed_name=cloudreve_$cloudreve_type
cloudreve_install_path=/data/$cloudreve_mixed_name
cloudreve_download_domain=cloudrevedownload.cf
cloudreve_tools_1=cloudreve.db
cloudreve_tools_2=conf.ini
cloudreve_ip=$(curl ip.sb)

print_cloudreve_logo(){
clear
echo "|======================================================================|"
echo "|                                                                      |"
echo "|              ___ _                 _                                 |"
echo "|             / __\ | ___  _   _  __| |_ __ _____   _____              |"
echo "|            / /  | |/ _ \| | | |/ _  | '__/ _ \ \ / / _ \	       |"
echo "|           / /___| | (_) | |_| | (_| | | |  __/\ V /  __/             |"
echo "|           \____/|_|\___/ \__,_|\__,_|_|  \___| \_/ \___|             |"
echo "|                                                                      |"
echo "|                                                                      |"
echo "|                cloudreve latest version : ${cloudreve_version}                      |"
echo "|                           cloudreve pro : ${cloudreve_pro}                      |"
echo "|                          script version : v${script_current_version}                     |"
echo "|                            beta verison : ${beta_verison}                      |"
echo "|                            update time  : ${update_time}                 |"
echo "|                                                                      |"
echo "|                         Powered By UbiquityTony                      |"
echo "|                                                                      |"
echo "|======================================================================|"
}

print_start(){
    echo ""
    echo "=============================== Start ================================="
    echo ""
}

print_warning(){
    echo ""
    echo "============================== Warning ================================"
    echo ""
}

print_start_install(){
    echo ""
    echo "========= Start to install $cloudreve_mixed_name, mode : $install_cloudreve_mode ========="
    echo ""
}

print_install_success(){
    echo ""
    echo "=========================== Install success! ==========================="
    echo ""
}

check_script_update(){
if [[ $script_latest_version == $script_current_version ]]; then
    sleep 0.1
else
    print_warning
	echo "You are still using the old version v$script_current_version, "
    echo "while v$script_latest_version is availble."
    echo "If you really want to use this old version, "
    echo "enter “I really want to use this old version, maybe contain bugs.”"
    read -p "Otherwise,this script will autoly run the latest version : " script_old_version_confirm
    if [[ $script_old_version_confirm == "I really want to use this old version, which may contain bugs." ]]; then    
        install_cloudreve_beginning_input
    else 
        wget -N --no-check-certificate https://raw.githubusercontent.com/UbiquityTony/Cloudreve-Script/main/official.sh && bash official.sh
    fi
fi
}

install_cloudreve_beginning_input(){
    echo "About to start installation, press any key to start!"
    read -p "You can also press CTRL+C to exit." 
    echo "Select your install mode. Support master or Slave."
    read -p "Enter M for Master, enter S for Slave : " cloudreve_install_mode
}

create_cloudreve_dir(){
echo "$(date +"%Y-%m-%d %T") Creating the path ......"
mkdir -p $cloudreve_install_path
}

generate_download_link(){
    if [ `uname -m` = "x86_64" ] ; then
	aarch=amd64
elif [ `uname -m` = "aarch32" ] ; then
	aarch=arm
elif [ `uname -m` = "aarch64" ] ; then
	aarch=arm64
else
	echo "This system is not supported for the time being."
    exit 1
fi
cloudreve_download_link="https://$cloudreve_type.$cloudreve_download_domain/$cloudreve_version/$aarch/cloudreve"
}

generate_tools_link(){
cloudreve_tools_1_link="https://$cloudreve_type.$cloudreve_download_domain/tools/$cloudreve_tools_1"
cloudreve_tools_2_link="https://$cloudreve_type.$cloudreve_download_domain/tools/$cloudreve_tools_2"
}

download_cloudreve(){
echo "$(date +"%Y-%m-%d %T") Downloading cloudreve ......"
wget -nv -o /dev/stdout -O $cloudreve_install_path/$cloudreve_name --no-check-certificate $cloudreve_download_link
echo "$(date +"%Y-%m-%d %T") Download cloudreve success!"
}

download_tools(){
echo "$(date +"%Y-%m-%d %T") Downloading things needed ......"
wget -nv -o /dev/stdout -O $cloudreve_install_path/$cloudreve_tools_1 --no-check-certificate $cloudreve_tools_1_link
wget -nv -o /dev/stdout -O $cloudreve_install_path/$cloudreve_tools_2 --no-check-certificate $cloudreve_tools_2_link
echo "$(date +"%Y-%m-%d %T") Download things success!"
}

process_daemon(){
### Grant authority
chmod +x $cloudreve_install_path/$cloudreve_name
echo "$(date +"%Y-%m-%d %T") Grant cloudreve success!"

### Register as a service
cat >/etc/systemd/system/$cloudreve_name.service <<EOF
[Unit]
Description=$cloudreve_name
Documentation=https://docs.cloudreve.org
After=network.target
After=mysqld.service
Wants=network.target

[Service]
WorkingDirectory=$cloudreve_install_path
ExecStart=$cloudreve_install_path/$cloudreve_name
Restart=on-abnormal
RestartSec=5s
KillMode=mixed

StandardOutput=null
StandardError=syslog

[Install]
WantedBy=multi-user.target
EOF

systemctl enable $cloudreve_name
systemctl restart $cloudreve_name
}

print_info(){
echo "$(date +"%Y-%m-%d %T") Your site: http://$cloudreve_ip:5212"
echo "$(date +"%Y-%m-%d %T") Your account: admin@cloudreve.org"
echo "$(date +"%Y-%m-%d %T") Your password: admin@cloudreve.org"
echo "$(date +"%Y-%m-%d %T") Please login and edit your password!"
echo "$(date +"%Y-%m-%d %T") Thankyou for using this program ${script_current_version}${beta_connect}${beta_word}! Goodbye!"
### Delete script
rm -rf $0
}

############################################# Main Code #############################################

### Step 0: Print logo
print_cloudreve_logo

### Step 1: Script update
check_script_update

### Step 2: Print start
print_start

### Step 3: Tips before install
install_cloudreve_beginning_input

### Step 4: Install mode
if [[ $cloudreve_install_mode == "M" ]]; then
    install_cloudreve_mode=Master
elif [[ $cloudreve_install_mode == "S" ]]; then
    install_cloudreve_mode=Slave
    ###### echo "$(date +"%Y-%m-%d %T") Still developing."        
	exit 1
else
    echo "Wrong mode!"
	exit 1
fi

### Step 5: Print start install
print_start_install

### Step 6: Create Dir
create_cloudreve_dir

### Step 7: Generate cloudreve download link
generate_download_link

### Step 8: Download cloudreve
download_cloudreve

### Step 9: Master or Slave branch

    ## Step 9.1: Master
    if [[ $cloudreve_install_mode == "M" ]]; then
        generate_tools_link
        download_tools
        process_daemon

    ## Step 9.2: Slave
    elif [[ $cloudreve_install_mode == "S" ]]; then
        echo "$(date +"%Y-%m-%d %T") Still developing."        
	    exit 1

    ## Step 9.3: Other
    else
        echo "Wrong mode!"
	exit 1
    fi

### Step 10: Print success
print_install_success

### Step 11: print_info
print_info
