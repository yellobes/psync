#!/bin/sh

# Get the content directory
echo "copying .: "$wrdpcnt":. to $sqlbckt";

# Mount the s3 bucket
echo "attempting to mount s3 .: " $sqlbckt " :. at .: " ~/sync/$sqlbckt;
done=$(time s3fs $sqlbckt ~/sync/$sqlbckt/);
echo $done;

# Limit the bandwidth s3fs has access to
# trickle s3fs $up $down;

# Preform the backup
rsync ~/sync/tmp/ ~/sync/$bucket/;


