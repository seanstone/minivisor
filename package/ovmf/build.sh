#!/bin/bash

_toolchain_opt=GCC5
nproc=4

cd $1

# edk2 uses python everywhere, but expects python2
mkdir bin
ln -s /usr/bin/python2 bin/python
export PATH="$1/bin:$PATH"

make -C BaseTools
export EDK_TOOLS_PATH="$1/BaseTools"
. edksetup.sh BaseTools

# Set RELEASE target, toolchain and number of build threads
sed "s|^TARGET[ ]*=.*|TARGET = RELEASE|; \
   s|TOOL_CHAIN_TAG[ ]*=.*|TOOL_CHAIN_TAG = ${_toolchain_opt}|; \
   s|MAX_CONCURRENT_THREAD_NUMBER[ ]*=.*|MAX_CONCURRENT_THREAD_NUMBER = ${nproc}|;" -i Conf/target.txt
# Build OVMF for ia32
#sed "s|^TARGET_ARCH[ ]*=.*|TARGET_ARCH = IA32|; \
#     s|^ACTIVE_PLATFORM[ ]*=.*|ACTIVE_PLATFORM = OvmfPkg/OvmfPkgIa32.dsc|;" -i Conf/target.txt
#./BaseTools/BinWrappers/PosixLike/build
# Build OVMF for x64
sed "s|^TARGET_ARCH[ ]*=.*|TARGET_ARCH = X64|; \
   s|^ACTIVE_PLATFORM[ ]*=.*|ACTIVE_PLATFORM = OvmfPkg/OvmfPkgX64.dsc|;" -i Conf/target.txt
./BaseTools/BinWrappers/PosixLike/build
