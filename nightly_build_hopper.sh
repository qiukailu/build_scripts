#!/bin/bash -ex

source /etc/profile.d/modules.sh;

  module load java;
  module swap PrgEnv-pgi PrgEnv-gnu;
  module swap gcc/4.8.1 gcc/4.7.2;
  module load netcdf/4.3.0;
  module load cray-petsc;

BUILD_DIR=nightly_build

cd;
rm -rf $BUILD_DIR; 
mkdir $BUILD_DIR;
cd $BUILD_DIR;

#build

svn co http://redmine.scorec.rpi.edu/svn/slac/trunk/Scripts Scripts;
ln -s Scripts/env/env.hopper .;
source env.hopper;
ln -s Scripts/checkout/checkout_source_code.sh .;
./checkout_source_code.sh;
ln -s Scripts/build/build-hopper.sh .;
ln -s Scripts/build/build_func.sh .;
ln -s Scripts/build/build-exe.hopper.sh .;
./build-hopper.sh;

# build tests

./build-exe.hopper.sh;
