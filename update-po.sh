#!/bin/bash

set -x

GETTEXT_DOMAIN=$(cat configure.ac | grep -E "^GETTEXT_PACKAGE=" | sed -e 's/GETTEXT_PACKAGE=//')

cd po/
cat LINGUAS | while read lingua; do
	if [ ! -e ${lingua}.po ]; then
		msginit --input=${GETTEXT_DOMAIN}.pot --locale=${lingua} --no-translator --output-file=$lingua.po
	else
		intltool-update --gettext-package ${GETTEXT_DOMAIN} $(basename ${lingua})
	fi
done
cd - 1>/dev/null
