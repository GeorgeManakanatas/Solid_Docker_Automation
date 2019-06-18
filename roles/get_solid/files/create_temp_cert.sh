#!/bin/sh
# set -e
#
# NAME=$1
# FILEPATH=$2
#
# if [ -z $NAME ]; then
# 	echo "Usage: ./create-temporary-cert.sh some-name some-path"
# 	exit 1
# fi

openssl req -nodes -x509 -days 3 -newkey rsa:2048 \
	-keyout ./selfSignedKey.pem \
	-out ./selfSignedCert.pem \
	-subj "/O=selfSigned/OU=selfSigned/CN=selfSigned"
