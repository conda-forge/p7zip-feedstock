#!/bin/bash

#mkdir -p ${PREFIX}/bin
#mkdir -p ${PREFIX}/lib

if [[ "$target_platform" == osx* ]]; then
    mv "makefile.macosx_llvm_64bits" "makefile.machine"
fi

make all3 Client7z LzmaCon CC=$CC CXX=$CXX ALLFLAGS_C="$CFLAGS" ALLFLAGS_CPP="$CXXFLAGS" LDFLAGS="$LDFLAGS"

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make all_test CC=$CC CXX=$CXX ALLFLAGS_C="$CFLAGS" ALLFLAGS_CPP="$CXXFLAGS" LDFLAGS="$LDFLAGS"
fi

#sed -i "s|#! /bin/sh|#!/bin/bash|" install.sh
sed -i.bak "s|DEST_HOME=.*|DEST_HOME=$PREFIX|" install.sh
bash ./install.sh

rm -r ${PREFIX}/man
rm -r ${PREFIX}/share

