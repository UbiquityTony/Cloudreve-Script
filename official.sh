#！/bin/bash

### release and update needed
script_current_version=2.1.0
update_time=2022.07.08
beta_verison=false
developer_beta=false
beta_commit=210RC1

### check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo "Run failed with status code 101" 
    exit 1
fi

if [[ x"${release}" == x"centos" ]]; then
    yum install curl tar -y
    yum -y install jq -y
else
    apt install curl tar -y
    apt-get install jq -y
fi

### init
script_api_base="https://cloudreve-script.cf/api/v1/"
script_api_count_developer=$(curl -sm8 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fcloudreve-script.cf%2Fapi%2Fv1%2Fcount%2Fdeveloper&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%20%23E7E7E7&title=hits&edge_flat=false" 2>&1) &&
script_api_count_developer_today=$(expr "$script_api_count_developer" : '.*\s\([0-9]\{1,\}\)\s/.*')
script_api_count_developer_total=$(expr "$script_api_count_developer" : '.*/\s\([0-9]\{1,\}\)\s.*')

script_api_count_beta=$(curl -sm8 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fcloudreve-script.cf%2Fapi%2Fv1%2Fcount%2Fbeta&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%20%23E7E7E7&title=hits&edge_flat=false" 2>&1) &&
script_api_count_beta_today=$(expr "$script_api_count_beta" : '.*\s\([0-9]\{1,\}\)\s/.*')
script_api_count_beta_total=$(expr "$script_api_count_beta" : '.*/\s\([0-9]\{1,\}\)\s.*')

script_api_count_official=$(curl -sm8 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fcloudreve-script.cf%2Fapi%2Fv1%2Fcount%2Fofficial&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%20%23E7E7E7&title=hits&edge_flat=false" 2>&1) &&
script_api_count_official_today=$(expr "$script_api_count_official" : '.*\s\([0-9]\{1,\}\)\s/.*')
script_api_count_official_total=$(expr "$script_api_count_official" : '.*/\s\([0-9]\{1,\}\)\s.*')

if [[ $developer_beta == "true" ]]; then
    script_api_count_today=$script_api_count_developer_today
    script_api_count_total=$script_api_count_developer_total
else
    if [[ $beta_verison == "true" ]]; then
        script_api_count_today=$script_api_count_beta_today
        script_api_count_total=$script_api_count_beta_total
    else
        script_api_count_today=$script_api_count_official_today
        script_api_count_total=$script_api_count_official_total
    fi
fi

cloudreve_type=community
cloudreve_pro=false
cloudreve_name=cloudreve
cloudreve_download_domain=cloudrevedownload.cf
cloudreve_tools_1=cloudreve.db
cloudreve_tools_2=conf.ini
cloudreve_ip_1=$(curl ip.sb)
cloudreve_ip_2=":"
cloudreve_default_port=5212
cloudreve_slave_config_default_secret=cloudrevescriptcloudrevescriptcloudrevescriptcloudrevescriptcloudrevescript

if [[ $cloudreve_ip_1 =~ $cloudreve_ip_2 ]]; then
    cloudreve_ip="[${cloudreve_ip_1}]"
else
    cloudreve_ip=$cloudreve_ip_1
fi

### check script update
script_latest_version=$(curl -Ls "${script_api_base}script/version" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

### check the latest version from github
cloudreve_version=$(curl -Ls "${script_api_base}cloudreve/version" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

### curl progess bar
if curl --help | grep progress-bar >/dev/null 2>&1; then # $curl_bar
    curl_bar="--progress-bar";
fi

### check download nodes status
#node 1
if [[ $(curl -Ls "${script_api_base}node1/status" | jq '.status' | sed 's/\"//g') == "online" ]]; then
    wget -N -O /node1status.json --no-check-certificate ${script_api_base}node1/node1status
    if [[ $(cat /node1status.json | jq '.ping' | sed 's/\"//g') == "success" ]]; then
        node1_status_mixed="Available; Cloudreve v${cloudreve_version} : Supported"
        node1_status_code=0
    else
        node1_status_mixed=Unavailable
        node1_status_code=1
    fi
else
    node1_status_mixed=Unavailable
    node1_status_code=1
fi

#node 2
if [[ $(curl -Ls "${script_api_base}node2/status" | jq '.status' | sed 's/\"//g') == "online" ]]; then
    wget -N -O /node2status.json --no-check-certificate ${script_api_base}node2/node2status
        if [[ $(cat /node2status.json | jq '.ping' | sed 's/\"//g') == "success" ]]; then
            node2_status_mixed="Available; Cloudreve v${cloudreve_version} : Supported"
            node2_status_code=0
        else
            node2_status_mixed=Unavailable
            node2_status_code=1
        fi
else
    node2_status_mixed=Unavailable
    node2_status_code=1
fi

#node 3
if [[ $(curl -Ls "${script_api_base}node3/status" | jq '.status' | sed 's/\"//g') == "online" ]]; then
    ping -c 2 $(curl -Ls "${script_api_base}node3/status" | jq '.base' | sed 's/\"//g')
    if [ $? == '0' ]; then
        wget -N -O /node3status.json --no-check-certificate https://community.cloudrevedownload.cf/node2status.json
            if [[ $(cat /node3status.json | jq '.ping' | sed 's/\"//g') == "success" ]]; then
                node3_status_1=Available
                if [[ $(curl -Ls "${script_api_base}node3/status" | jq '.version' | sed 's/\"//g') == $cloudreve_version ]]; then
                    node3_status_2=Supported
                    node3_status_code=0
                else
                    node3_status_2=Unsupported
                    node3_status_code=1
                fi
                node3_status_mixed="${node3_status_1}; Cloudreve v${cloudreve_version} : ${node3_status_2}"
            else
                node3_status_mixed=Unavailable
                node3_status_code=1
            fi
    else
        node3_status_mixed=Unavailable
        node3_status_code=1
    fi
else
    node3_status_mixed=Unavailable
    node3_status_code=1
fi

#node 4
if [[ $(curl -Ls "${script_api_base}node4/status" | jq '.status' | sed 's/\"//g') == "online" ]]; then
    ping -c 2 $(curl -Ls "${script_api_base}node4/status" | jq '.base' | sed 's/\"//g')
    if [ $? == '0' ]; then
        wget -N -O /node4status.json --no-check-certificate https://us-cloudreve-script.oss-us-east-1.aliyuncs.com/node3status.json
            if [[ $(cat /node4status.json | jq '.ping' | sed 's/\"//g') == "success" ]]; then
                node4_status_1=Available
                if [[ $(curl -Ls "${script_api_base}node4/status" | jq '.version' | sed 's/\"//g') == $cloudreve_version ]]; then
                    node4_status_2=Supported
                    node4_status_code=0
                else
                    node4_status_2=Unsupported
                    node4_status_code=1
                fi
                node4_status_mixed="${node4_status_1}; Cloudreve v${cloudreve_version} : ${node3_status_2}"
            else
                node4_status_mixed=Unavailable
                node4_status_code=1
            fi
    else
        node4_status_mixed=Unavailable
        node4_status_code=1
    fi
else
    node4_status_mixed=Unavailable
    node4_status_code=1
fi

#node 5
if [[ $(curl -Ls "${script_api_base}node5/status" | jq '.status' | sed 's/\"//g') == "online" ]]; then
    ping -c 2 $(curl -Ls "${script_api_base}node5/status" | jq '.base' | sed 's/\"//g') 
    if [ $? == '0' ]; then
        wget -N -O /node5status.json --no-check-certificate https://speedcloud.cf/api/v3/file/source/1257/status.txt?sign=D855mkxRX6ZAfUz3WEEPWAlccabPk1yud440il68FLU%3D%3A0
            if [[ $(cat /node5status.json | jq '.ping' | sed 's/\"//g') == "success" ]]; then
                node5_status_1=Available
                if [[ $(curl -Ls "${script_api_base}node5/status" | jq '.version' | sed 's/\"//g') == $cloudreve_version ]]; then
                    node5_status_2=Supported
                    node5_status_code=0
                else
                    node5_status_2=Unsupported
                    node5_status_code=1
                fi
                node5_status_mixed="${node5_status_1}; Cloudreve v${cloudreve_version} : ${node5_status_2}"
            else
                node5_status_mixed=Unavailable
                node5_status_code=1
            fi
    else
        node5_status_mixed=Unavailable
        node5_status_code=1
    fi
else
    node5_status_mixed=Unavailable
    node5_status_code=1
fi

rm -rf /node1status.json
rm -rf /node2status.json
rm -rf /node3status.json
rm -rf /node4status.json
rm -rf /node5status.json

if [[ $beta_verison == "true" ]]; then
    beta_word=beta
    beta_connect=-
elif [[ $beta_verison == "false" ]]; then
    beta_word=
    beta_connect=
else
    exit 1
fi

print_cloudreve_logo_animated(){
sleep 0.5
clear
echo ""
echo "      |======================================================================|"
sleep 0.07
echo "      |                                                                      |"
sleep 0.07
echo "      |              ___ _                 _                                 |"
sleep 0.07
echo "      |             / __\ | ___  _   _  __| |_ __ _____   _____              |"
sleep 0.07
echo "      |            / /  | |/ _ \| | | |/ _  | '__/ _ \ \ / / _ \             |"
sleep 0.07
echo "      |           / /___| | (_) | |_| | (_| | | |  __/\ V /  __/             |"
sleep 0.07
echo "      |           \____/|_|\___/ \__,_|\__,_|_|  \___| \_/ \___|             |"
sleep 0.07
echo "      |                                                                      |"
sleep 0.07
echo "      |                                                                      |"
sleep 0.07
echo "      |               cloudreve latest version : ${cloudreve_version}                       |"
sleep 0.07
echo "      |                          cloudreve pro : ${cloudreve_pro}                       |"
sleep 0.07
echo "      |                         script version : v${script_current_version}                      |"
sleep 0.07
if [[ $beta_verison == "true" ]]; then
    echo "      |                           beta verison : ${beta_verison}                        |"
    if [[ $developer_beta == "true" ]]; then
        sleep 0.07
        echo "      |                         developer beta : ${developer_beta}                        |"
    fi
else
    echo "      |                           beta verison : ${beta_verison}                       |"
    sleep 0.07
fi

if [[ $beta_verison == "true" ]]; then
    echo "      |                            beta commit : ${beta_commit}                      |"
    sleep 0.07
fi
echo "      |                            update time : ${update_time}                  |"
sleep 0.07
echo "      |                                                                      |"
sleep 0.07
echo "      |             Run times today : ${script_api_count_today}     Run times total : ${script_api_count_total}            |"
sleep 0.07
echo "      |                                                                      |"
sleep 0.07
echo "      |                        Powered By UbiquityTony                       |"
sleep 0.07
echo "      |                                                                      |"
sleep 0.07
echo "      |======================================================================|"
sleep 0.07
echo ""
}

print_cloudreve_logo_no_animation(){
clear
echo ""
echo "      |======================================================================|"
echo "      |                                                                      |"
echo "      |              ___ _                 _                                 |"
echo "      |             / __\ | ___  _   _  __| |_ __ _____   _____              |"
echo "      |            / /  | |/ _ \| | | |/ _  | '__/ _ \ \ / / _ \             |"
echo "      |           / /___| | (_) | |_| | (_| | | |  __/\ V /  __/             |"
echo "      |           \____/|_|\___/ \__,_|\__,_|_|  \___| \_/ \___|             |"
echo "      |                                                                      |"
echo "      |                                                                      |"
echo "      |               cloudreve latest version : ${cloudreve_version}                       |"
echo "      |                          cloudreve pro : ${cloudreve_pro}                       |"
echo "      |                         script version : v${script_current_version}                      |"
if [[ $beta_verison == "true" ]]; then
    echo "      |                           beta verison : ${beta_verison}                        |"
    if [[ $developer_beta == "true" ]]; then
        echo "      |                         developer beta : ${developer_beta}                        |"
    fi
else
    echo "      |                           beta verison : ${beta_verison}                       |"
fi
if [[ $beta_verison == "true" ]]; then
    echo "      |                            beta commit : ${beta_commit}                      |"
fi
echo "      |                            update time : ${update_time}                  |"
echo "      |                                                                      |"
echo "      |             Run times today : ${script_api_count_today}     Run times total : ${script_api_count_total}            |"
echo "      |                                                                      |"
echo "      |                        Powered By UbiquityTony                       |"
echo "      |                                                                      |"
echo "      |======================================================================|"
echo ""
}

print_clear(){
    sleep 2
    clear
    sleep 0.01
    clear
    sleep 0.01
    clear
    print_cloudreve_logo_animated
}

print_clear_2(){
    sleep 2
    clear
    sleep 0.01
    clear
    sleep 0.01
    clear
    print_cloudreve_logo_no_animation
}

print_clear_3(){
    clear
    sleep 0.001
    clear
    sleep 0.001
    clear
    print_cloudreve_logo_no_animation
}

print_warning(){
    sleep 0.1
    echo ""
    echo "   ================================== Warning =================================="
    echo ""
    echo ""
}

print_congratulations(){
    sleep 0.1
    echo ""
    echo "   ============================== Congratulations =============================="
    echo ""
    echo ""
}

print_start(){
    sleep 0.1
    echo ""
    echo "   =================================== Start ==================================="
    echo ""
    echo ""
}

print_start_2(){
    echo ""
    echo "   =================================== Start ==================================="
    echo ""
    echo ""
}

print_start_install(){
    sleep 0.1
    echo ""
    echo "   ============= Start to install ${cloudreve_name}_${cloudreve_type}. Mode: $install_cloudreve_mode ============="
    echo ""
    echo ""
}

print_confirm(){
    sleep 0.1
    echo ""
    echo "   =================================== Confirm =================================="
    echo ""
    echo ""
}

print_install_success(){
    sleep 0.1
    echo ""
    echo "   =============================== Install success =============================="
    echo ""
    echo ""
}

print_thanks(){
    sleep 0.1
    echo ""
    echo "   ==================================== Thanks =================================="
    echo ""
    echo ""
}

check_script_update(){
    if [[ $beta_verison == "true" ]]; then
        print_warning
        sleep 0.1
        echo "       You are using the beta version!"
        sleep 0.1
        read -p "       Press any key to confirm!"
        print_clear_3
    else
        if [[ $script_latest_version == $script_current_version ]]; then
            print_congratulations
            sleep 0.1
            echo "       Congratulations! You are using the latest version!"
            sleep 2
            print_clear_3
        else
            print_warning
            sleep 0.1
            echo "       You are still using the old version v$script_current_version, "
            sleep 0.1
            echo "       while v$script_latest_version is availble."
            sleep 0.1
            echo "       If you really want to use this old version, "
            sleep 0.1
            echo "       type “I really want to use this old version, maybe contain bugs.”"
            sleep 0.1
            read -p "       Otherwise,this script will automaticly run the latest version : " script_old_version_confirm

            if [[ $script_old_version_confirm == "I really want to use this old version, maybe contain bugs." ]]; then    
                sleep 0.1
                print_clear_3
            else
                wget -N --no-check-certificate https://raw.githubusercontent.com/UbiquityTony/Cloudreve-Script/main/official.sh && bash official.sh
            fi
        fi
    fi
}

install_cloudreve_beginning_input(){
    sleep 0.1
    echo "       About to start installation, press any key to start!"
    sleep 0.1
    read -p "       You can also press CTRL+C to exit."
    echo ""
}

install_cloudreve_mode_confirm(){
    sleep 1
    echo "       Select Mode"
    sleep 0.1
    echo ""
    sleep 0.1
    echo "       Select your install mode. Supported Master or Slave."
    sleep 0.1
    echo "       Enter 'M' or 'm' for Master, enter 'S' or 's' for Slave."
    sleep 0.1
    echo "       Also, press enter key will enable the default mode : Master"
    sleep 0.1
    read -p "       Now enter : " cloudreve_install_mode
    echo ""
}

install_cloudreve_path_jump(){
    install_cloudreve_path_confirm
}

install_cloudreve_path_confirm(){
    sleep 1
    echo "       Select Path"
    sleep 0.1
    echo ""
    sleep 0.1
    echo "       Enter the path you like. The path should be absolute, starting with /"
    sleep 0.1
    echo "       Also, press enter key will enable the default path : "
    sleep 0.1
    echo "       $cloudreve_default_install_path"
    sleep 0.1
    read -p "       Now, enter : " cloudreve_actural_install_path_unconfirmed
        if [[ $cloudreve_actural_install_path_unconfirmed == /* ]]; then
            sleep 0.1
            echo "       Your path $cloudreve_actural_install_path_unconfirmed set successfully."
            echo ""
            cloudreve_actural_install_path=$cloudreve_actural_install_path_unconfirmed
        elif [[ $cloudreve_actural_install_path_unconfirmed == "" ]]; then
            sleep 0.1
            echo "       OK. The path will be the default path : $cloudreve_default_install_path"
            echo ""
            cloudreve_actural_install_path=$cloudreve_default_install_path
        else
            sleep 0.1
            echo "       Wrong Path! Please try again!"
            sleep 1
            print_clear_3
            print_start_2
            install_cloudreve_path_jump
            echo ""
        fi
}

install_cloudreve_port_error_jump(){
    install_cloudreve_port_confirm
}

install_cloudreve_port_confirm(){
    sleep 1
    echo "       Select Port"
    sleep 0.1
    echo ""
    sleep 0.1
    echo "       Enter the port you want. The port should be between 1 and 65535."
    sleep 0.1
    echo "       Also, press enter key will enable the default port : $cloudreve_default_port"
    sleep 0.1
    read -p "       Now, enter : " cloudreve_install_port_input
    if [[ "$cloudreve_install_port_input" = "" ]]; then
        cloudreve_install_port_type=0
    else
        cloudreve_install_port_type=1
    fi
    
    if [[ "$cloudreve_install_port_type" = "1" ]]; then
        if [[ "$cloudreve_install_port" =~ ^[0-9]*$ ]]; then
            if [[ ${cloudreve_install_port_input} -ge 1 ]] && [[ ${cloudreve_install_port_input} -le 65535 ]]; then
                if [[ -n $(ss -ntlp | awk '{print $4}' | grep -w  "$cloudreve_install_port_input") ]]; then
                    echo "       The port has been used! Please try again!"
                    sleep 1
                    print_clear_3
                    print_start_2
                    install_cloudreve_port_error_jump
                else
                    echo "       Your port $cloudreve_install_port_input set successfully"
                    echo ""
                    cloudreve_install_port=$cloudreve_install_port_input
                fi
            else
                echo "       Error! Please try again!"
                sleep 1
                print_clear_3
                print_start_2
                install_cloudreve_port_error_jump
            fi
        fi
    elif [[ "$cloudreve_install_port_type" = "0" ]]; then
        cloudreve_install_port=$cloudreve_default_port
        if [[ -n $(ss -ntlp | awk '{print $4}' | grep -w  "$cloudreve_install_port") ]]; then
            echo "       The default port has been used! Please try again!"
            sleep 1
            print_clear_3
            print_start_2
            install_cloudreve_port_error_jump
        else
            echo "       OK. The port will be the default port : $cloudreve_default_port"
            echo ""
        fi
    fi
}

install_cloudreve_download_node_jump(){
    sleep 1
    print_clear_3
    print_start_2
    install_cloudreve_download_node
}

install_cloudreve_download_node(){
    sleep 1
    echo "       Select Download Node"
    sleep 0.1
    echo ""
    sleep 0.1
    echo "       Download Nodes"
    sleep 0.1
    echo "       Node 1 : Github origin ($node1_status_mixed)"
    sleep 0.1
    echo "       Node 2 : Github mirror ($node2_status_mixed)"
    sleep 0.1
    echo "       Node 3 : Server        ($node3_status_mixed)"
    sleep 0.1
    echo "       Node 4 : Aliyun OSS    ($node4_status_mixed)"
    sleep 0.1
    echo "       Node 5 : Speedcloud    ($node5_status_mixed)"
    sleep 0.1
    echo ""
    if [[ $node1_status_code == "1" ]]&&[[ $node2_status_code == "1" ]]&&[[ $node3_status_code == "1" ]]&&[[ $node4_status_code == "1" ]]&&[[ $node5_status_code == "1" ]]; then
        echo "       Warning : There is no available nodes!"
        sleep 2
        exit 1
    else
        echo "       You can enter 1/2/3/4/5 for Node 1, 2, 3, 4, 5"
        sleep 0.1
        echo "       Also, Press enter key will choose one in random order."
        sleep 0.1
        echo ""
        read -p "       Now, enter : " cloudreve_download_node_unconfirmed
        if [[ $cloudreve_download_node_unconfirmed == "1" ]]; then
            if [[ $node1_status_code == "0" ]]; then
                echo "       Your node $cloudreve_download_node_unconfirmed set successfully."
                cloudreve_download_node=$cloudreve_download_node_unconfirmed
            elif [[ $node1_status_code == "1" ]]; then
                echo "       This node is not available! Please try again!"
                install_cloudreve_download_node_jump
            fi
        elif [[ $cloudreve_download_node_unconfirmed == "2" ]]; then
            if [[ $node2_status_code == "0" ]]; then
                echo "       Your node $cloudreve_download_node_unconfirmed set successfully."
                cloudreve_download_node=$cloudreve_download_node_unconfirmed
            elif [[ $node2_status_code == "1" ]]; then
                echo "       This node is not available! Please try again!"
                install_cloudreve_download_node_jump
            fi
        elif [[ $cloudreve_download_node_unconfirmed == "3" ]]; then
            if [[ $node3_status_code == "0" ]]; then
                echo "       Your node $cloudreve_download_node_unconfirmed set successfully."
                cloudreve_download_node=$cloudreve_download_node_unconfirmed
            elif [[ $node3_status_code == "1" ]]; then
                echo "       This node is not available! Please try again!"
                install_cloudreve_download_node_jump
            fi
        elif [[ $cloudreve_download_node_unconfirmed == "4" ]]; then
            if [[ $node4_status_code == "0" ]]; then
                echo "       Your node $cloudreve_download_node_unconfirmed set successfully."
                cloudreve_download_node=$cloudreve_download_node_unconfirmed
            elif [[ $node4_status_code == "1" ]]; then
                echo "       This node is not available! Please try again!"
                install_cloudreve_download_node_jump
            fi
        elif [[ $cloudreve_download_node_unconfirmed == "5" ]]; then
            if [[ $node5_status_code == "0" ]]; then
                echo "       Your node $cloudreve_download_node_unconfirmed set successfully."
                cloudreve_download_node=$cloudreve_download_node_unconfirmed
            elif [[ $node5_status_code == "1" ]]; then
                echo "       This node is not available! Please try again!"
                install_cloudreve_download_node_jump
            fi
        elif [[ $cloudreve_download_node_unconfirmed == "" ]]; then
            if [[ $node5_status_code == "0" ]]; then
                echo "       The default node 5 set successfully."
                cloudreve_download_node=5
            elif [[ $node5_status_code == "1" ]]; then
                if [[ $node4_status_code == "0" ]]; then
                    echo "       The default node 4 set successfully."
                    cloudreve_download_node=4
                elif [[ $node4_status_code == "1" ]]; then
                    if [[ $node3_status_code == "0" ]]; then
                        echo "       The default node 3 set successfully."
                        cloudreve_download_node=3
                    elif [[ $node3_status_code == "1" ]]; then
                        if [[ $node2_status_code == "0" ]]; then
                            echo "       The default node 2 set successfully."
                            cloudreve_download_node=2
                        elif [[ $node1_status_code == "1" ]]; then
                            if [[ $node1_status_code == "0" ]]; then
                                echo "       The default node 1 set successfully."
                                cloudreve_download_node=1
                            elif [[ $node5_status_code == "1" ]]; then
                                echo "       Something happened."
                                exit 1
                            else
                                echo "       Something Wrong! "
                                exit 1
                            fi
                        else
                            echo "       Something Wrong! "
                            exit 1
                        fi
                    else
                        echo "       Something Wrong! "
                        exit 1
                    fi
                else
                    echo "       Something Wrong! "
                    exit 1
                fi
            else
                echo "       Something Wrong! "
                exit 1
            fi
        else
            echo "       Error! Please try again!"
            install_cloudreve_download_node_jump
        fi
    fi
}

print_confirm_info(){
    sleep 0.1
    echo "       Your selected node : Node $cloudreve_download_node"
    sleep 0.1
    echo "       Your selected mode : $install_cloudreve_mode"
    sleep 0.1
    echo "       Your selected port : $cloudreve_install_port"
    sleep 0.1
    echo "       Your selected path : $cloudreve_actural_install_path"
    echo ""
    sleep 0.1
    read -p "       Press any key to start install!"
}

create_cloudreve_dir(){
    echo "       $(date +"%Y-%m-%d %T") Creating the path ......"
    mkdir -p $cloudreve_actural_install_path
    sleep 1
    echo "       $(date +"%Y-%m-%d %T") Path created successfully!"
}

generate_download_link(){
    if [ `uname -m` = "x86_64" ] ; then
	    aarch=amd64
    elif [ `uname -m` = "aarch32" ] ; then
	    aarch=arm
    elif [ `uname -m` = "aarch64" ] ; then
	    aarch=arm64
    else
	    echo "       This aarch is not supported for the time being."
        exit 1
    fi

    if [[ $cloudreve_download_node == "1" ]]; then
        cloudreve_download_link="https://github.com/cloudreve/Cloudreve/releases/download/${cloudreve_version}/cloudreve_${cloudreve_version}_linux_${aarch}.tar.gz"
    elif [[ $cloudreve_download_node == "2" ]]; then
        cloudreve_download_link="https://hub.fastgit.org/cloudreve/Cloudreve/releases/download/${cloudreve_version}/cloudreve_${cloudreve_version}_linux_${aarch}.tar.gz"
    elif [[ $cloudreve_download_node == "3" ]] || [[ $cloudreve_download_node == "4" ]] || [[ $cloudreve_download_node == "5" ]]; then
        cloudreve_download_link=$(curl -Ls "${script_api_base}node${cloudreve_download_node}/$aarch" | jq '.url' | sed 's/\"//g')
    fi
}

generate_master_tools_link(){
    cloudreve_tools_1_link="https://$cloudreve_type.$cloudreve_download_domain/tools/$cloudreve_tools_1"
    cloudreve_tools_2_link="https://$cloudreve_type.$cloudreve_download_domain/tools/$cloudreve_tools_2"
}

download_cloudreve(){
    echo "       $(date +"%Y-%m-%d %T") Downloading cloudreve ......"
    if [[ $cloudreve_download_node == "1" ]] || [[ $cloudreve_download_node == "2" ]]; then
        curl -L $cloudreve_download_link -o /tmp/cloudreve.tar.gz $curl_bar
        tar zxf /tmp/cloudreve.tar.gz -C $cloudreve_actural_install_path
    elif [[ $cloudreve_download_node == "3" ]] || [[ $cloudreve_download_node == "4" ]] || [[ $cloudreve_download_node == "5" ]]; then
        curl -L $cloudreve_download_link -o $cloudreve_actural_install_path/$cloudreve_name $curl_bar
    fi
    echo "       $(date +"%Y-%m-%d %T") Download cloudreve success!"
}

download_master_tools(){
    echo "       $(date +"%Y-%m-%d %T") Downloading things needed ......"
    wget -nv -o /dev/stdout -O $cloudreve_actural_install_path/$cloudreve_tools_1 --no-check-certificate $cloudreve_tools_1_link
    wget -nv -o /dev/stdout -O $cloudreve_actural_install_path/$cloudreve_tools_2 --no-check-certificate $cloudreve_tools_2_link
    echo "       $(date +"%Y-%m-%d %T") Download things success!"
}

create_slave_config(){
    echo "       $(date +"%Y-%m-%d %T") Creating the slave config ......"
    cat >$cloudreve_actural_install_path/conf.ini <<EOF
[System]
Mode = slave
Listen = :$cloudreve_install_port

[Slave]
Secret = $cloudreve_slave_config_default_secret

[CORS]
AllowOrigins = *
AllowMethods = OPTIONS,GET,POST
AllowHeaders = *
EOF

    sleep 1
    echo "       $(date +"%Y-%m-%d %T") The slave config is created successfully!"
}

process_daemon(){
    echo "       $(date +"%Y-%m-%d %T") Granting cloudreve ......"
    chmod +x $cloudreve_actural_install_path/$cloudreve_name
    sleep 1
    echo "       $(date +"%Y-%m-%d %T") Grant cloudreve success!"
    sleep 1
    echo "       $(date +"%Y-%m-%d %T") Creating daemon config ......"
cat >/etc/systemd/system/$cloudreve_mixed_name.service <<EOF
[Unit]
Description=$cloudreve_mixed_name
Documentation=https://docs.cloudreve.org
After=network.target
After=mysqld.service
Wants=network.target

[Service]
WorkingDirectory=$cloudreve_actural_install_path
ExecStart=$cloudreve_actural_install_path/$cloudreve_name
Restart=on-abnormal
RestartSec=5s
KillMode=mixed

StandardOutput=null
StandardError=syslog

[Install]
WantedBy=multi-user.target
EOF
    echo "       $(date +"%Y-%m-%d %T") Daemon config created successfully!"
    systemctl enable $cloudreve_mixed_name
    systemctl restart $cloudreve_mixed_name
}

master_change_ports(){
    systemctl stop $cloudreve_mixed_name
    sed -i -e 's/5212/'"$cloudreve_install_port"'/g' $cloudreve_actural_install_path/conf.ini
    systemctl start $cloudreve_mixed_name
}

print_daemon_info(){
    sleep 0.1
    echo "       Your can manage daemon by using the following commands:"
    sleep 0.1
    echo "       Status  : systemctl status $cloudreve_mixed_name"
    sleep 0.1
    echo "       Start   : systemctl start $cloudreve_mixed_name"
    sleep 0.1
    echo "       Stop    : systemctl stop $cloudreve_mixed_name"
    sleep 0.1
    echo "       Restart : systemctl restart $cloudreve_mixed_name"
    echo ""
}

print_master_info(){
    sleep 0.1
    echo "       Your site     : http://${cloudreve_ip}:${cloudreve_install_port}"
    sleep 0.1
    echo "       Your account  : admin@cloudreve.org"
    sleep 0.1
    echo "       Your password : admin@cloudreve.org"
    sleep 0.1
    echo "       Please login and edit your password!"
    sleep 0.1
}

print_slave_info(){
    sleep 0.1
    echo "       Your site         : http://${cloudreve_ip}:${cloudreve_install_port}"
    sleep 0.1
    echo "       Your slave secret : $cloudreve_slave_config_default_secret"
}

print_thanks_note(){
    sleep 0.1
    echo "       This script ${script_current_version}${beta_connect}${beta_word} is powered by UbiquityTony."
    echo "       Github : https://github.com/UbiquityTony/Cloudreve-Script"
    echo "       Thank you for using it! Don't froget to give a star if you like it!"
    echo ""
}

############################################# Main Code #############################################

### Step 0: Print logo
clear
sleep 0.01
clear
sleep 1
clear
print_cloudreve_logo_animated

### Step 1: Script update
check_script_update

### Step 2: Print start
print_start

### Step 3: before install
install_cloudreve_beginning_input
sleep 1
print_clear_3
print_start_2
install_cloudreve_mode_confirm


### Step 4: Install mode
if [[ $cloudreve_install_mode == "M" ]] || [[ $cloudreve_install_mode == "m" ]] || [[ $cloudreve_install_mode == "" ]]; then
    install_cloudreve_mode=master
    cloudreve_mixed_name=cloudreve_${cloudreve_type}_master
    sleep 0.1
    echo "       Your mode $install_cloudreve_mode set successfully."
elif [[ $cloudreve_install_mode == "S" ]] || [[ $cloudreve_install_mode == "s" ]] ; then
    install_cloudreve_mode=slave
    cloudreve_mixed_name=cloudreve_${cloudreve_type}_slave
    sleep 0.1
    echo "       Your mode $install_cloudreve_mode set successfully."
else
    echo "       Wrong mode! Please try again!"
        sleep 2
        print_clear_3
        print_start_2
        install_cloudreve_mode_confirm
fi

cloudreve_default_install_path=/data/$cloudreve_mixed_name
sleep 1
print_clear_3
print_start_2
install_cloudreve_path_confirm
sleep 1
print_clear_3
print_start_2
install_cloudreve_port_confirm
sleep 1
print_clear_3
print_start_2
install_cloudreve_download_node

print_clear_2

print_confirm
print_confirm_info

### Step 5: Print start install

print_clear_2

print_start_install

### Step 6: Create Dir
create_cloudreve_dir

### Step 7: Generate cloudreve download link
generate_download_link

### Step 8: Download cloudreve
download_cloudreve

### Step 9: Master or Slave branch

    ## Step 9.1: Master
    if [[ $cloudreve_install_mode == "M" ]] || [[ $cloudreve_install_mode == "m" ]] || [[ $cloudreve_install_mode == "" ]]; then
        generate_master_tools_link
        download_master_tools
        process_daemon
        master_change_ports

    ## Step 9.2: Slave
    elif [[ $cloudreve_install_mode == "S" ]] || [[ $cloudreve_install_mode == "s" ]]; then
        create_slave_config
        process_daemon

    ## Step 9.3: Other
    else
        echo "      Wrong mode! "
	exit 1
    fi

### Step 10: Print success

print_clear_2

print_install_success

### Step 11: Print info
print_daemon_info
print_${install_cloudreve_mode}_info

### Step 12: Print thanks
sleep 2
print_thanks
print_thanks_note
sleep 2

### Step 13: Delete script
rm -rf $0
