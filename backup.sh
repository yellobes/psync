#!/bin/sh

#	Peter Novotnak | peter@binarysprocket.com


# Sql auth
sql_username=
sql_password=

# If a global $sql_database is set, continue without setting sql_database
if [ $sql_database == null ] ;then
  sql_database=
fi

wp_content_dir=

# Buckets
bucket_container=./s3_mounts
cdn_bucket_name=
sql_bucket_name=

# Rsync include-from
rsync_manifesto=



# Create a folder to contain mount folders
mkdir $bucket_container

# Create folders to mount the sql bucket and content delivery network bucket
mkdir $bucket_container/$sql_bucket_name/
mkdir $bucket_container/$cdn_bucket_name/

# Mount the S3 shares
s3fs  $sql_bucket_name $bucket_container/$sql_bucket_name/
s3fs  $cdn_bucket_name $bucket_container/$cdn_bucket_name/

# Dump the database
sqldump -c -u $sql_username -p $sql_password $sql_database | gzip > "$bucket_container/$sql_bucket_name/$(date +%D%T | sed 's/\//\\/g').sql.bzip2"

# Rsync wp-content
rsync --include-from=$rsync_manifesto $bucket_container/$cdn_bucket_name


echo "Bye! \n Remember to clean up!"
