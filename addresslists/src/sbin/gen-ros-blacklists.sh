#!/bin/sh

#### FUNCTIONS

source ./gen-ros-include.sh

##### SCRIPT BODY

if [ -d ${DEST_DIR} ] ; then

    scriptStart
    scriptLog "Updating address lists"

##### BLACKLIST: dshield

  export LISTNAME="dshield"
  LIST_WGET="$(wget ${WGET_ARGS_EXTRA} -q -O - http://feeds.dshield.org/block.txt)"
  if [ -n "${LIST_WGET}" ]
    then
      test -f ${DEST_DIR}/${LISTNAME}.rsc && rm ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertAuthorDetails
      echo "# Address details courtesy of https://www.dshield.org/" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# (c) DShield.org - SANS Internet Storm Center" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# This list summarizes the top 20 attacking class C (/24)" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# subnets over the last THREE DAYS. The number of 'attacks'" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# indicates the number of targets reporting scans from this" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# subnet" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertListDetails
      echo "/ip firewall address-list" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "${LIST_WGET}" | awk --posix '/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0\t/ { print "add list=blacklist address=" $1 "/24 comment=DShield";}' >> ${DEST_DIR}/${LISTNAME}.rsc;
    else
      errNotify
  fi;

##### BLACKLIST: spamhaus
  
  export LISTNAME="spamhaus"
  LIST_WGET="$(wget ${WGET_ARGS_EXTRA} -q -O - http://www.spamhaus.org/drop/drop.lasso)"
  if [ -n "${LIST_WGET}" ]
    then
      test -f ${DEST_DIR}/${LISTNAME}.rsc && rm ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertAuthorDetails
      echo "# Address details courtesy of https://www.spamhaus.org/drop/" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# (c) Spamhaus Project - Non-Profit Anti-spam DNS/IP blacklisting" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# DROP (Don't Route Or Peer) is an advisory \"drop all traffic\"" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# list. DROP is a tiny subset of the SBL designed for use by" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# firewalls and routing equipment. The DROP list will not" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# includes any IP space allocated to a legitimate network" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# and reassigned - even if reassigned to the proverbial" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# \"spammers from hell\"" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertListDetails
      echo "/ip firewall address-list" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "${LIST_WGET}" | awk --posix '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\// { print "add list=blacklist address=" $1 " comment=SpamHaus";}' >> ${DEST_DIR}/${LISTNAME}.rsc
    else
      errNotify
  fi;

##### BLACKLIST: openbl
  
  export LISTNAME="openbl"
  LIST_WGET="$(wget ${WGET_ARGS_EXTRA} -q -O - http://www.openbl.org/lists/base_30days.txt.gz | gunzip -c)"
  if [ -n "${LIST_WGET}" ]
    then
      test -f ${DEST_DIR}/${LISTNAME}.rsc && rm ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertAuthorDetails
      echo "# Address details courtesy of https://www.openbl.org/" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# (c) OpenBL - Abuse Reporting and Blacklisting" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# The OpenBL.org project (formerly known as the SSH blacklist)" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# is about detecting, logging and reporting various types of" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# internet abuse. Currently our hosts monitor ports 21 (FTP)," >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# 22 (SSH), 23 (TELNET), 25 (SMTP), 110 (POP3), 143 (IMAP)," >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# 587 (Submission), 993 (IMAPS) and 995 (POP3S) for" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# bruteforce login attacks as well as scans on ports 80 (HTTP)" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# and 443 (HTTPS) for vulnerable installations of phpMyAdmin" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# and other web applications." >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertListDetails
      echo "/ip firewall address-list" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "${LIST_WGET}" | awk --posix '/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ { print "add list=blacklist address=" $1 " comment=OpenBL";}' >> ${DEST_DIR}/${LISTNAME}.rsc
    else
      errNotify
  fi;

##### BLACKLIST: tornodes
  
  export LISTNAME="tornodes"
  LIST_WGET="$(wget ${WGET_ARGS_EXTRA} -q -O - https://www.dan.me.uk/torlist/)"
  if [ -n "${LIST_WGET}" ]
    then
      test -f ${DEST_DIR}/${LISTNAME}.rsc && rm ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertAuthorDetails
      echo "# Courtesy of (c) Daniel Austin MBCS" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# https://www.dan.me.uk/tornodes" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# Contains a list of all nodes in the TOR network" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "# -------------------------------------------------------" >> ${DEST_DIR}/${LISTNAME}.rsc;
      insertListDetails
      echo "/ip firewall address-list" >> ${DEST_DIR}/${LISTNAME}.rsc;
      echo "${LIST_WGET}" | awk '{ print "add list=tornodes address=" $1 " comment=tornodes";}' >> ${DEST_DIR}/${LISTNAME}.rsc
    else
      errNotify
  fi;

fi;

exit 0;
