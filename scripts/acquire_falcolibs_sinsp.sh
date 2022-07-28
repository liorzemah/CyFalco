#!/bin/bash
cd /home

# yum -y install kernel-devel-$(uname -r)

if [ -d "/home/LuaJIT" ] 
then
    echo "LuaJIT already installed." 
else
    echo "Cloning LuaJIT" 
    git clone https://github.com/LuaJIT/LuaJIT.git
	cd LuaJIT
	make
	make install
fi 

cd /home

if [ -d "/home/falcolibs" ] 
then
    echo "/home/falcolibs directory already exists." 
else
    echo "Cloning Falcolibs directory" 
	git clone https://github.com/liorzemah/Makefile-for-scap_open-test.git falcolibs
fi

cd falcolibs || exit 1
if [ ! -d "/home/falcolibs/build" ] 
then
    mkdir build
fi

cd build

cmake -DUSE_BUNDLED_DEPS=true -DMINIMAL_BUILD=true -DCREATE_TEST_TARGETS=OFF -DWITH_CHISEL=true ../
make sinsp
