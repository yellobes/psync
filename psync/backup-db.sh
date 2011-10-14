#! /bin/bash

# This script dumps the database defined in backup-head.sh

tim=$(date +%D-%T | sed 's/\//\\/g');
mesg="";
file=$bseloc$tmploc$tim;

touch $file;

echo "mysql dump started for .:"$sqluser":. with .:"$sqlpass":. on .:"$sqlbckt;
echo "dumping .:"$sqlbckt":. to .:"$bseloc$tmploc"."$tim;

mysqldump --user=$sqluser --password=$sqlpass $sqlbckt >> $bseloc$tmploc"."$tim;

echo "mysqldump returns .:"$?;

if [ "$(echo $msqldmp | awk /sage/)" != "" ] ;then
  echo "SET UP SQL CREDENTIALS IN backup-head.sh !";
  exit 1;
fi

bzip2 -czs  > $bseloc$tmploc$tim.sql.bz2 >> $backupdb;

# Clear the sql stuff from memory

sqluser='';
sqlpass='';

export sqluser=$sqluser ;
export sqlpass=$sqlpass ;

