#!/bin/bash

USERHOME=/home/naokihori
INSTALL=/usr/local

# git
yum remove -y git
yum install -y make
yum install -y gcc
yum install -y autoconf
yum install -y wget
yum install -y curl-devel expat-devel gettext-devel  openssl-devel zlib-devel perl-ExtUtils-MakeMaker
cd $INSTALL/src
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.18.0.tar.gz
tar zxvf git-2.18.0.tar.gz
cd git-2.18.0
make configure
./configure --prefix=$INSTALL
make all
make install
echo 'export PATH=$PATH:/usr/local/bin' >> $USERHOME/.bash_profile
source $USERHOME/.bash_profile
yum remove -y git

# python3
git clone https://github.com/pyenv/pyenv.git $USERHOME/.pyenv
echo 'export PYENV_ROOT="/home/naokihori/.pyenv"' >> $USERHOME/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $USERHOME/.bash_profile
echo 'eval "$(pyenv init -)"' >> $USERHOME/.bash_profile
source $USERHOME/.bash_profile
yum install -y bzip2 bzip2-devel readline-devel sqlite sqlite-devel libffi-devel
pyenv install 3.7.0
pyenv global 3.7.0
echo 'export PATH="$PYENV_ROOT/versions/3.7.0:$PATH"' >> $USERHOME/.bash_profile
source $USERHOME/.bash_profile

# vim
#yum remove -y vi
#yum install -y lua-devel
#cd /usr/local/src
#git clone https://github.com/vim/vim
#cd vim
#./configure  --enable-fail-if-missing  --with-features=huge  --enable-python3interp=dynamic  --with-python3-config-dir=/home/naokihori/.pyenv/versions/3.7.0/lib/python3.7/config-3.7m-x86_64-linux-gnu/  --enable-cscope  --enable-fontset  --enable-multibyte  vi_cv_path_python3=/home/naokihori/.pyenv/versions/3.7.0/bin/python3.7  --enable-luainterp=dynamic  --enable-gpm  --enable-luainterp
#echo 'export vi="vim"' >> ~/.bashrc
#vi --version
