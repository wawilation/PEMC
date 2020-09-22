#!/bin/bash

#get cut-off date for current 3 mos
TEMP_DATE=$(date --date='4 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_c3mos=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)

#get cut-off date for historical 13 mos
TEMP_DATE=$(date --date='17 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_h13mos=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)

#insert into historical 13 mos
	/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_daily_h13mos SELECT * FROM meterprocess.txn_stl_daily_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

if [ "$?" = "0" ]; then
#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_daily_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"	
	
	if [ "$?" = "0" ]; then 
	#vacuum analyze
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "VACUUM ANALYZE meterprocess.txn_stl_daily_c3mos;" -c "VACUUM ANALYZE meterprocess.txn_stl_daily_h13mos;"		

		if [ "$?" = "0" ]; then
		#dump older than historical13mos data to archive file
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "COPY(
SELECT * FROM ONLY meterprocess.txn_stl_daily_h13mos WHERE created_datetime < '$FINAL_DATE_h13mos') TO '/tmp/crss_meterprocess.txn_stl_daily_h13mos_$FINAL_DATE_h13mos.dat';"
gzip /tmp/crss_meterprocess.txn_stl_daily_h13mos_$FINAL_DATE_h13mos.dat					

					if [ "$?" = "0" ]; then
					#delete from historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_daily_h13mos A WHERE A.created_datetime < '$FINAL_DATE_h13mos';"

						if [ "$?" = "0" ]; then 
						#vacuum analyze
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "VACUUM ANALYZE meterprocess.txn_stl_daily_h13mos;"
						

						if [ "$?" = "0" ]; then
						#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_daily_c3mos DROP CONSTRAINT IF EXISTS txn_stl_daily_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_daily_c3mos ADD CONSTRAINT txn_stl_daily_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_daily_h13mos DROP CONSTRAINT IF EXISTS txn_stl_daily_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_daily_h13mos ADD CONSTRAINT txn_stl_daily_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"
							
						else
							exit
						fi						
						
						else
							exit
						fi

					else
						exit
					fi
		else
			exit
		fi	
	else
		exit
	fi
else
	exit
fi

