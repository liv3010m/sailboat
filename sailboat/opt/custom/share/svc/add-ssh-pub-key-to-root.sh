#!/bin/bash
# Add SSH Public Key to Root Script


# Version="1.0.0";
# Revision="0b";
# Script="add-ssh-pub-key-to-root.sh";

SSH="/root/.ssh";
AuthorizedKeys="/root/.ssh/authorized_keys";
KeyImport="/opt/custom/ssh-keys";




set -o xtrace

. /lib/svc/share/smf_include.sh

cd /
PATH=/usr/sbin:/usr/bin:/opt/custom/bin:/opt/custom/sbin; export PATH;

case "$1" in
    'start')
	#### Insert code to execute on startup here.

	#[*] $Script : Adding SSH key to root

	if [ ! -d "$SSH" ];
	then # [*] $Script : Creating directory
	     mkdir $SSH && echo "[OK]" || exit $SMF_EXIT_ERR_FATAL; fi;

	# [*] $Script : Adding public keys
	for key in `ls $KeyImport/*.pub`; do cat "$key" >> $AuthorizedKeys && echo "" >> $AuthorizedKeys && sed -i '' '/^$/d' $AuthorizedKeys; done;
	;;
    
    'stop')
	### Insert code to execute on shutdown here.	
	;;
    
    *)
	echo "Usage: $0 { start | stop }"
	exit $SMF_EXIT_ERR_FATAL
	;;
esac
exit $SMF_EXIT_OK
