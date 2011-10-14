#! /bin/bash

# This script dumps the database defined in backup-head.sh

tim=$(date +%D-%T | sed 's/\//\\/g');

echo "mysql dump started for .:"$sqluser":. with .:"$sqlpass":. on .:"$sqlbckt;
servquery=$(mysqldump --user=$sqluser --password=$sqlpass $sqlbckt >> $bseloc$tmploc"."$tim)

if [ "$(echo $msqldmp | awk /sage/)" != "" ] ;then
  echo "SET UP SQL CREDENTIALS IN backup-head.sh !";
  exit 1;
fi

bzip2 -czs  > $bseloc/$tim.sql.bz2 >> $backupdb;

# Clear the sql stuff from memory

sqluser='';
sqlpass='';

export sqluser=$sqluser ;
export sqlpass=$sqlpass ;

