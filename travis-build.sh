#! /bin/sh

apt-get --yes update
apt-get --yes install wget equivs curl git

cd package/

deps=$(sed -r '/^(#.*|\s)*$/d; $! s/$/,/' package/dependencies | tr -d \\n)
git_commit=$(git rev-parse --short HEAD)

> configuration printf "%s\n" \
	"Section: misc" \
	"Priority: optional" \
	"Homepage: https://nxos.org" \
	"Package: nitrux-standard" \
	"Version: 0.1.14-$git_commit" \
	"Maintainer: Uri Herrera <uri_herrera@nxos.org>" \
	"Depends: $deps" \
	"Architecture: amd64" \
	"Description: The Nitrux standard system."

equivs-build configuration
