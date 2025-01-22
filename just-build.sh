#!/bin/bash

SECONDS=0

echo Building Everything for Fedora `rpm -E %fedora` | figlet -c -f mini | lolcat

MYDIR=$PWD

START_TS=`date`

# If necessary:
dnf install -y fedora-packager fedora-review

rm -rf $HOME/rpmbuild
mkdir -p $HOME/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp $PWD/*.patch $HOME/rpmbuild/SOURCES
cp $PWD/nethack.desktop $HOME/rpmbuild/SOURCES
cp $PWD/nethack.spec $HOME/rpmbuild/SPECS

pushd $HOME/rpmbuild/SPECS
spectool -g -R ./nethack.spec
# Get the dependencies
dnf builddep -y ./nethack.spec 2>&1 | tee $MYDIR/build-output.txt
# Now do the actual build
rpmbuild -ba ./nethack.spec
popd

echo Started:_____$START_TS
echo Ended:_______`date`

# Now tell us how long it took
hours=$((SECONDS / 3600))
minutes=$(( (SECONDS % 3600) / 60 ))
seconds=$((SECONDS % 60))

# Print the elapsed time
echo "Elapsed Time: $hours hour(s) $minutes minute(s) $seconds second(s)"