#!/bin/bash

if [ -f /etc/redhat-release ] ;  then
    sudo yum install -y vim-enhanced mc tree git > /dev/null
    vagrant_user="vagrant"
fi

if [ -f /etc/lsb-release ] ; then
    echo "ubuntu"
    grep -q "archive.ubuntu.com" /etc/apt/sources.list && sed -i.bak -e 's/archive.ubuntu.com/ftp.daum.net/g' -e 's/security.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list && sudo apt update
    sudo apt install -y mc tree git
    vagrant_user="ubuntu"

    date | grep -q UTC && sudo timedatectl set-timezone Asia/Seoul
fi

cat > /home/$vagrant_user/.vimrc <<EOF
set expandtab
" set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
EOF

chown $vagrant_user.$vagrant_user /home/$vagrant_user/.vimrc

if ! [ -f /etc/profile.d/change_ps1.sh ] ; then
    cat > /etc/profile.d/change_ps1.sh <<'EOF'
if [ -f ~/.bashrc ]  ; then
    grep ^PS1 ~/.bashrc | grep vagrant  > /dev/null || echo 'PS1="[vagrant] $PS1"' >> ~/.bashrc
fi
EOF
fi
