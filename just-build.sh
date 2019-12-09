#!/bin/bash


rm -rf /home/rolson/rpmbuild
mkdir -p /home/rolson/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp $PWD/*.patch /home/rolson/rpmbuild/SOURCES
cp $PWD/nethack.desktop /home/rolson/rpmbuild/SOURCES
cp $PWD/nethack.spec /home/rolson/rpmbuild/SPECS

pushd /home/rolson/rpmbuild/SPECS
spectool -g -R ./nethack.spec
# Get the dependencies
dnf builddep -y ./nethack.spec
# Now do the actual build
rpmbuild -ba ./nethack.spec
popd

