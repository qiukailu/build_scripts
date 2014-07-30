#!/bin/bash -ex

LOCAL_DIR=/space/qlu/weekly_build;

rm -rf weekly_build.tar.gz;
rm -rf $LOCAL_DIR; 
mkdir $LOCAL_DIR;
cd $LOCAL_DIR;

svn co http://redmine.scorec.rpi.edu/svn/slac/trunk/Scripts Scripts;
ln -s Scripts/checkout/checkout_source_code.sh .;
./checkout_source_code.sh;

# pack up things
cd ..
tar zcf weekly_build.tar.gz weekly_build;

# send to CCNI
ssh $CCNI ' ssh q ' rm -rf weekly_build ' ';
scp weekly_build.tar.gz $CCNI:~/

# go to CCNI BG/Q

ssh $CCNI ' ssh q ' ./WeeklyBuild.sh ' ';
