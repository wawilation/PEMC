#!/bin/bash

#get cut-off date for current 3 mos
TEMP_DATE=$(date --date='4 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_CURRENT3MOS=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)

#get cut-off date for historical 13 mos
TEMP_DATE=$(date --date='14 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_HISTORICAL13MOS=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)

#insert into historical 13 mos
	/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_final_monthly_historical13mos SELECT * FROM meterprocess.txn_stl_final_monthly_current3mos WHERE reading_datetime < '$FINAL_DATE_CURRENT3MOS';"

if [ "$?" = "0" ]; then
#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_final_monthly_current3mos A WHERE A.reading_datetime < '$FINAL_DATE_CURRENT3MOS';"	
	
	if [ "$?" = "0" ]; then 
	#vacuum analyze
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "VACUUM ANALYZE meterprocess.txn_stl_final_monthly_current3mos;" -c "VACUUM ANALYZE meterprocess.txn_stl_final_monthly_historical13mos;"		

		if [ "$?" = "0" ]; then
		#dump older than historical13mos data to archive file
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "COPY(
SELECT * FROM ONLY meterprocess.txn_stl_final_monthly_historical13mos WHERE reading_datetime < '$FINAL_DATE_HISTORICAL13MOS') TO '/tmp/crss_meterprocess.txn_stl_final_monthly_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat';"
gzip /tmp/crss_meterprocess.txn_stl_final_monthly_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat					

					if [ "$?" = "0" ]; then
					#delete from historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_final_monthly_historical13mos A WHERE A.reading_datetime < '$FINAL_DATE_HISTORICAL13MOS';"						

						if [ "$?" = "0" ]; then
						#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_current3mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_current3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_current3mos ADD CONSTRAINT txn_stl_final_monthly_current3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_CURRENT3MOS'); ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_historical13mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_historical13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_historical13mos ADD CONSTRAINT txn_stl_final_monthly_historical13mos_ck CHECK (reading_datetime < '$FINAL_DATE_CURRENT3MOS');"
							
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

