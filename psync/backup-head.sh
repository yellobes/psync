#!/bin/sh

echo $(date);

	# Base location
	bseloc=~/sync;
	# Temp location
	tmploc=$baseloc/tmp;
	# wp-content location
        content="/opt/lampp/htdocs/dev/wp-content";
	# wp-bucket
	wpbckt="dev-arrow-backup";
	# Logging to...
        logloc=$bseloc/logs ;
# To x chars...
length=100 ;

	# MySQL info
	sqluser="b";
	sqlpass="a";
	sqldata="foo";
	sqlbckt="dev-arrow-backup";

	# Trickle values
	up= # up speed;
	down= # down speed;


# What to name the log?
time=$( date +%T ) ;

# :.
# AND SO IT BEGINS, MAY THE FORCE BE WITH YOU...
# :'

export backupcon=$logloc/wp-content_backup.log ;
export backupdb=$logloc/database_backup.log ;
export wpbckt=$wpbckt ;
export bseloc=$bseloc ;
export tmploc=$tmploc ;
export sqluser=$sqluser ;
export sqlpass=$sqlpass ;
export sqlbckt=$sqlbckt ;
export sqldata=$sqldata ;
export wpcbckt="";
export trcklup=$up ;
export trckldn=$down ;
export wrdpcnt=$content ;
export strttme=$time ;
export logleng=$length ;

mkdir $bseloc;
mkdir $tmploc;
mkdir $logloc;
mkdir $bseloc/$sqlbckt;

echo "checking if request is sane.." ;

# Loop through $sqldata, and run ./backup-db.sh for every line.
for i in $(echo $sqldata) ;do
  if [ $i = "-e" ] ;then

    echo "YOU NEED TO ASSIGN A DATABASE IN backup-head.sh"
    exit 1;

  else

    echo "starting backup-db for .: " $i  " :. at .: "$( date +%T );
    ./psync/backup-db.sh ;
    if [ "$?" = 1 ] ;then
      exit 1;
    fi
  fi
done

echo "starting backup of .:"$backupcon;
./backup-content.sh &> $backupcon ;

# Cull the logs
 
tail -n $length > $backupcon ;
tail -n $length > $backupdb ;
