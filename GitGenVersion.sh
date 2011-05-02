git=/usr/bin/git
version=`$git describe`
echo "#define GIT_VERSION $version" > InfoPlist.h