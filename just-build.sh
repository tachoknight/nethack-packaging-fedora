#!/bin/bash

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
dnf builddep -y ./nethack.spec
# Now do the actual build
rpmbuild -ba ./nethack.spec
popd

