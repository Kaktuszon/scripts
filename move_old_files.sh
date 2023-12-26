#!/bin/bash
# Get todays date, convert to seconds, divide to days. Might be an easier way to do this
today=`date +%Y%m%d`
today=`date +%s -d $today`
today=$(($today/86400))

folder="FOLDER TO CHECK IN" # Folder to check in
files=`ls $folder` # List all files in folder and save as array
for i in ${files}; do # Loop all files
        # Get files date, convert to seconds, divide to days
        f=`date -r ${folder}/$i +%Y%m%d`
        f=`date +%s -d $f`
        f=$(($f/86400))

        # Get date differense between today and file age
        datediff=$(($today-$f))

        # If files is older than 14 days, remove it
        if [ $datediff -gt 3 ]
        then
                echo "Moving "$folder/$i >> delete_old_files_src.log
                mv $folder/$i "FOLDER TO SAVE OLD FILES IN"$i
        fi
done
