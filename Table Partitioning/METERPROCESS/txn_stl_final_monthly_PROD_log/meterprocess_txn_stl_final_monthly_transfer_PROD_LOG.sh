#!/bin/bash

#get cut-off date for current 3 mos
TEMP_DATE=$(date --date='4 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_c3mos=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)

#get cut-off date for historical 13 mos
TEMP_DATE=$(date --date='17 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_h13mos=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)

ID=$RANDOM$(date +"%m%d%Y")

#####LOG HERE (status = 'P')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_stl_final_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0, NULL, 'P';" 

#####LOG HERE TEMP STATUS (status = 'XX'), get count of rows to be inserted
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log 
SELECT '$ID','meterprocess.txn_stl_final_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(1), NULL, 'XX'
FROM meterprocess.txn_stl_final_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#drop check constraint
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_h13mos_ck;"

if [ "$?" = "0" ]; then
#insert into historical 13 mos
	/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_final_monthly_h13mos SELECT * FROM meterprocess.txn_stl_final_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

if [ "$?" = "0" ]; then
#####LOG HERE (status = 'H', count of recs inserted taken from status = 'XX')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "UPDATE meterprocess.partition_log SET status = 'H', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_stl_final_monthly_h13mos' AND status = 'XX';"

#delete from current 3 mos
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_final_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"	
	
	if [ "$?" = "0" ]; then 
	#####LOG HERE (status = 'DC', count of recs deleted based on status = 'H')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_stl_final_monthly_c3mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, NULL, 'DC'
FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_stl_final_monthly_h13mos' AND A.status = 'H';"	
	
	#vacuum analyze
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "VACUUM ANALYZE meterprocess.txn_stl_final_monthly_c3mos;" -c "VACUUM ANALYZE meterprocess.txn_stl_final_monthly_h13mos;"		

		if [ "$?" = "0" ]; then
		#####LOG HERE (status = 'V')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log SELECT '$ID','(meterprocess) txn_stl_final_monthly_c3mos,txn_stl_final_monthly_h13mos','$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0,NULL,'V';"

		#####LOG HERE TEMP STATUS (status = 'XX', count of recs archived)
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log
SELECT '$ID','meterprocess.txn_stl_final_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(1), '/pg_backup/data_archive/crss_meterprocess.txn_stl_final_monthly_h13mos_$FINAL_DATE_h13mos.dat', 'XX' FROM meterprocess.txn_stl_final_monthly_h13mos WHERE created_datetime < '$FINAL_DATE_h13mos';"		

		#dump older than historical13mos data to archive file
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "SET temp_file_limit = '40960MB';" -c "COPY(
SELECT * FROM ONLY meterprocess.txn_stl_final_monthly_h13mos WHERE created_datetime < '$FINAL_DATE_h13mos') TO '/pg_backup/data_archive/crss_meterprocess.txn_stl_final_monthly_h13mos_$FINAL_DATE_h13mos.dat';"
gzip -f /pg_backup/data_archive/crss_meterprocess.txn_stl_final_monthly_h13mos_$FINAL_DATE_h13mos.dat					

					if [ "$?" = "0" ]; then
					#####LOG HERE (status = 'A', count of recs archived based on status = 'XX')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "UPDATE meterprocess.partition_log SET status = 'A', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_stl_final_monthly_h13mos' AND status = 'XX' AND archivepath IS NOT NULL;"					

					#delete from historical 13 mos
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_final_monthly_h13mos A WHERE A.created_datetime < '$FINAL_DATE_h13mos';"						

						if [ "$?" = "0" ]; then 
						#####LOG HERE (status = 'DH', count of recs deleted based on status = 'A')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_stl_final_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, A.archivepath, 'DH'
FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_stl_final_monthly_h13mos' AND A.status = 'A';"					

						#vacuum analyze
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "VACUUM ANALYZE meterprocess.txn_stl_final_monthly_h13mos;"

						if [ "$?" = "0" ]; then
						#####LOG HERE (status = 'V')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log SELECT '$ID','(meterprocess) txn_stl_final_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0,NULL,'V';"						

						#create check constraint
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_c3mos ADD CONSTRAINT txn_stl_final_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_h13mos ADD CONSTRAINT txn_stl_final_monthly_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"
							
							if [ "$?" = "0" ]; then							
							#####LOG HERE (status = 'C')
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "INSERT INTO meterprocess.partition_log SELECT '$ID','(meterprocess) txn_stl_final_monthly_c3mos_ck CHECK (reading_datetime >= ''$FINAL_DATE_c3mos''),txn_stl_final_monthly_h13mos_ck CHECK (reading_datetime < ''$FINAL_DATE_c3mos'')', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0,NULL,'C';"
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
	else
		exit
	fi
else
	exit
fi

