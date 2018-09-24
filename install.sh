#!/bin/bash

USERHOME=/home/naokihori
INSTALL=/usr/local
GITVER=2.19.0
PYTHONVER=3.7.0

# git
yum remove -y git
yum install -y make
yum install -y gcc
yum install -y autoconf
yum install -y wget
yum install -y curl-devel expat-devel gettext-devel  openssl-devel zlib-devel perl-ExtUtils-MakeMaker
cd $INSTALL/src
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-$GITVER.tar.gz
tar zxvf git-$GITVER.tar.gz
cd git-$GITVER
make configure
./configure --prefix=$INSTALL
make all
make install
echo 'export PATH=$PATH:/usr/local/bin' >> $USERHOME/.bash_profile
source $USERHOME/.bash_profile
yum remove -y git
rm -rf $INSTALL/src/git-$GITVER $INSTALL/src/git-$GITVER.tar.gz

# python3
git clone https://github.com/pyenv/pyenv.git $USERHOME/.pyenv
echo 'export PYENV_ROOT="/home/naokihori/.pyenv"' >> $USERHOME/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $USERHOME/.bash_profile
echo 'eval "$(pyenv init -)"' >> $USERHOME/.bash_profile
source $USERHOME/.bash_profile
yum install -y bzip2 bzip2-devel readline-devel sqlite sqlite-devel libffi-devel
pyenv install $PYTHONVER
pyenv global $PYTHONVER
echo 'export PATH="$PYENV_ROOT/versions/3.7.0:$PATH"' >> $USERHOME/.bash_profile
source $USERHOME/.bash_profile

# vim
yum remove -y vi
yum install -y lua-devel
cd /usr/local/src
git clone https://github.com/vim/vim
cd vim
./configure --enable-fail-if-missing --with-features=huge --enable-cscope --enable-fontset  --enable-multibyte --enable-luainterp=dynamic --enable-gpm --enable-luainterp
make
make install
echo 'alias vi="vim"' >> /home/naokihori/.bashrc
source /home/naokihori/.bashrc
