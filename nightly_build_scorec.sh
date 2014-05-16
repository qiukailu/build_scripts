#!/bin/bash -ex

date;

# root dir of the sources
SRC_DIR=/space/qlu/nightly_build
ENV_FILE=env.scorec-debug
CHECKOUT_SCRIPT=checkout_source_code.sh
BUILD_FUNC=build_func.sh
BUILD_SCRIPT=build.twister.sh
BUILD_EXE_SCRIPT=build-exe.twister.sh
RUN_EXE_SCRIPT=run-exe.twister.sh

# remove nightly build src dir should it exists
rm -rf $SRC_DIR;

# create a new dir
mkdir -p $SRC_DIR;

# go to root source dir
cd $SRC_DIR;

# check out the root scripts
svn co http://redmine.scorec.rpi.edu/svn/slac/trunk/Scripts Scripts;

# create symbolic links of various scripts
ln -s Scripts/env/$ENV_FILE $ENV_FILE;
ln -s Scripts/env/env.scorec env.scorec;
ln -s Scripts/checkout/$CHECKOUT_SCRIPT $CHECKOUT_SCRIPT;
ln -s Scripts/build/$BUILD_FUNC $BUILD_FUNC;
ln -s Scripts/build/$BUILD_SCRIPT $BUILD_SCRIPT;
ln -s Scripts/build/$BUILD_EXE_SCRIPT $BUILD_EXE_SCRIPT;
ln -s Scripts/run/$RUN_EXE_SCRIPT $RUN_EXE_SCRIPT;

# set environment viarables
source $ENV_FILE;

# update source
./$CHECKOUT_SCRIPT;

# build libraries
./$BUILD_SCRIPT; 

# build executables
./$BUILD_EXE_SCRIPT;

# run tests on executables
./$RUN_EXE_SCRIPT;

date;
