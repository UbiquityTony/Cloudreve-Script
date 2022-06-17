#！/bin/bash
### check script update
script_latest_version=$(curl -Ls "https://api.github.com/repos/UbiquityTony/Cloudreve-Script/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

### check the latest version from github
cloudreve_version=$(curl -Ls "https://api.github.com/repos/cloudreve/cloudreve/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

### update needed
script_current_version=v1.1.0
update_time=2022.06.17

### update official edition
#beta_verison=false
#beta_word=
#beta_connect=

### update beta
beta_verison=uh34tety
beta_word=beta
beta_connect=

### init
cloudreve_type=community
cloudreve_pro=false
cloudreve_mixed_name=cloudreve_$cloudreve_type
cloudreve_install_path=/data/$cloudreve_mixed_name
cloudreve_download_domain=cloudrevedownload.cf
cloudreve_tools_1=cloudreve.db
cloudreve_tools_2=conf.ini
cloudreve_ip=$(curl ip.sb)
cloudreve_install_mode_init_time=0

echo "|=================================================================|"
echo "|                                                                 |"
echo "|            ___ _                 _                              |"
echo "|           / __\ | ___  _   _  __| |_ __ _____   _____           |"
echo "|          / /  | |/ _ \| | | |/ _  | '__/ _ \ \ / / _ \	  |"
echo "|         / /___| | (_) | |_| | (_| | | |  __/\ V /  __/          |"
echo "|         \____/|_|\___/ \__,_|\__,_|_|  \___| \_/ \___|          |"
echo "|                                                                 |"
echo "|                                                                 |"
echo "|              cloudreve latest version : ${cloudreve_version}                 |"
echo "|                         cloudreve pro : ${cloudreve_pro}                 |"
echo "|                script current version : ${script_current_version}        |"
echo "|                          beta verison : ${beta_verison}                 |"
echo "|                          update time  : ${update_time}            |"
echo "|                                                                 |"
echo "|                      Powered By UbiquityTony                    |"
echo "|                                                                 |"
echo "|=================================================================|"
echo ""
echo "============================= Start ==============================="
echo ""
echo "About to start installation, press any key to start!"
read -p "You can also press CTRL+C to exit." 
echo "Select your install mode. Support master or Slave."

install_cloudreve_master(){
if [[ $cloudreve_install_mode_init_time == "0" ]]; then
    text=
else
    text=shibai
    exit 1
fi
}

read -p "$text Enter M for Master, enter S for Slave:" cloudreve_install_mode
	##read -p "Error, please try again:" cloudreve_install_mode

### Check Script Update
#if [[ $cloudreve_install_mode == "M" ]]; then



### Prepare to install
if [[ $cloudreve_install_mode == "M" ]]; then
    echo "1e!"
    install_cloudreve_master
elif [[ $cloudreve_install_mode == "S" ]]; then
    echo "$(date +"%Y-%m-%d %T") Still developing."        
	exit 1
else
    echo "Wrong mode!"
	exit 1
fi

    ### Install Cloudreve Master
    install_cloudreve_master(){
    ## Determine processor architecture
    if [ `uname -m` = "x86_64" ] ; then
	    aarch=amd64
    elif [ `uname -m` = "aarch32" ] ; then
	    aarch=arm
    elif [ `uname -m` = "aarch64" ] ; then
	    aarch=arm64
    else
	    echo "This system is not supported for the time being."
	exit
    fi

    ### make cloudreve dir
    echo "$(date +"%Y-%m-%d %T") ========== Start to install $cloudreve_mixed_name =========="
    echo "$(date +"%Y-%m-%d %T") Creating the path ......"
    mkdir -p $cloudreve_install_path

    ### Generate download and tools link
    cloudreve_download_link="https://$cloudreve_type.$cloudreve_download_domain/$cloudreve_version/$aarch/cloudreve"
    cloudreve_tools_1_link="https://$cloudreve_type.$cloudreve_download_domain/tools/$cloudreve_tools_1"
    cloudreve_tools_2_link="https://$cloudreve_type.$cloudreve_download_domain/tools/$cloudreve_tools_2"

    ### Download cloudreve
    echo "$(date +"%Y-%m-%d %T") Downloading cloudreve ......"
    wget -nv -o /dev/stdout -O $cloudreve_install_path/$cloudreve_mixed_name --no-check-certificate $cloudreve_download_link
    echo "$(date +"%Y-%m-%d %T") Download success!"

    ### Download tools needed
    echo "$(date +"%Y-%m-%d %T") Downloading things needed ......"
    wget -nv -o /dev/stdout -O $cloudreve_install_path/$cloudreve_mixed_name --no-check-certificate $cloudreve_tools_1_link
    wget -nv -o /dev/stdout -O $cloudreve_install_path/$cloudreve_mixed_name --no-check-certificate $cloudreve_tools_2_link

    ### Grant authority
    chmod +x $cloudreve_install_path/$cloudreve_mixed_name
    echo "$(date +"%Y-%m-%d %T") Grant cloudreve success!"

    ### Register as a service
    cat >/etc/systemd/system/$cloudreve_mixed_name.service <<EOF
[Unit]
Description=$cloudreve_mixed_name
Documentation=https://docs.cloudreve.org
After=network.target
After=mysqld.service
Wants=network.target

[Service]
WorkingDirectory=$cloudreve_install_path
ExecStart=$cloudreve_install_path/$cloudreve_mixed_name
Restart=on-abnormal
RestartSec=5s
KillMode=mixed

StandardOutput=null
StandardError=syslog

[Install]
WantedBy=multi-user.target
EOF

    systemctl enable $cloudreve_mixed_name
    systemctl restart $cloudreve_mixed_name
    echo "$(date +"%Y-%m-%d %T") ================== Install success! =================="
    echo "$(date +"%Y-%m-%d %T") Your site: http://$cloudreve_ip:5212"
    echo "$(date +"%Y-%m-%d %T") Your account: admin@cloudreve.org"
    echo "$(date +"%Y-%m-%d %T") Your password: admin@cloudreve.org"
    echo "$(date +"%Y-%m-%d %T") Please login and edit your password!"
    echo "$(date +"%Y-%m-%d %T") Thankyou for using this program ${script_current_version}${beta_connect}${beta_word}! Goodbye!"
    ### Delete script
    rm -rf $0
}

