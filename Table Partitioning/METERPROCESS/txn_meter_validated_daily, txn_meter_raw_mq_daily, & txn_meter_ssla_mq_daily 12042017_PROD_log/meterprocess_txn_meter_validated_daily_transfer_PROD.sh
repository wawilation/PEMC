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
	/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_meter_validated_daily_h13mos SELECT * FROM meterprocess.txn_meter_validated_daily_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.txn_meter_raw_mq_daily_h13mos SELECT B.* FROM meterprocess.txn_meter_validated_daily_c3mos A JOIN meterprocess.txn_meter_raw_mq_daily_c3mos B ON A.id = B.validated_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.txn_meter_ssla_mq_daily_h13mos SELECT C.* FROM meterprocess.txn_meter_validated_daily_c3mos A JOIN meterprocess.txn_meter_raw_mq_daily_c3mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_daily_c3mos C ON B.id = C.daily_mq_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

if [ "$?" = "0" ]; then
#delete from current 3 mos
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_meter_ssla_mq_daily_c3mos A USING (SELECT B.id FROM meterprocess.txn_meter_raw_mq_daily_c3mos B JOIN meterprocess.txn_meter_validated_daily_c3mos C ON B.validated_id = C.id WHERE C.reading_datetime < '$FINAL_DATE_c3mos') D WHERE A.daily_mq_id = D.id;" -c "DELETE FROM meterprocess.txn_meter_raw_mq_daily_c3mos A USING meterprocess.txn_meter_validated_daily_c3mos B WHERE A.validated_id = B.id AND B.reading_datetime < '$FINAL_DATE_c3mos';" -c "DELETE FROM meterprocess.txn_meter_validated_daily_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"	
	
	if [ "$?" = "0" ]; then 
	#vacuum analyze
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "VACUUM ANALYZE meterprocess.txn_meter_ssla_mq_daily_c3mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_raw_mq_daily_c3mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_validated_daily_c3mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_validated_daily_h13mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_raw_mq_daily_h13mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_ssla_mq_daily_h13mos;"		

		if [ "$?" = "0" ]; then
		#dump older than historical13mos data to archive file
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "COPY(
SELECT * FROM ONLY meterprocess.txn_meter_validated_daily_h13mos WHERE created_date_time < '$FINAL_DATE_h13mos') TO '/pg_backup/data_archive/crss_meterprocess.txn_meter_validated_daily_h13mos_$FINAL_DATE_h13mos.dat';"
gzip /pg_backup/data_archive/crss_meterprocess.txn_meter_validated_daily_h13mos_$FINAL_DATE_h13mos.dat					

			if [ "$?" = "0" ]; then
			#dump older than historical13mos data to archive file	
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "COPY(
SELECT B.* FROM meterprocess.txn_meter_validated_daily_h13mos A JOIN meterprocess.txn_meter_raw_mq_daily_h13mos B ON A.id = B.validated_id WHERE A.created_date_time < '$FINAL_DATE_h13mos') TO '/pg_backup/data_archive/crss_meterprocess.txn_meter_raw_mq_daily_h13mos_$FINAL_DATE_h13mos.dat';"
gzip /pg_backup/data_archive/crss_meterprocess.txn_meter_raw_mq_daily_h13mos_$FINAL_DATE_h13mos.dat				

				if [ "$?" = "0" ]; then
				#dump older than historical13mos data to archive file
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "COPY(
SELECT C.* FROM meterprocess.txn_meter_validated_daily_h13mos A JOIN meterprocess.txn_meter_raw_mq_daily_h13mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_daily_h13mos C ON B.id = C.daily_mq_id WHERE A.created_date_time < '$FINAL_DATE_h13mos') TO '/pg_backup/data_archive/crss_meterprocess.txn_meter_ssla_mq_daily_h13mos_$FINAL_DATE_h13mos.dat';"
gzip /pg_backup/data_archive/crss_meterprocess.txn_meter_ssla_mq_daily_h13mos_$FINAL_DATE_h13mos.dat					

					if [ "$?" = "0" ]; then
					#delete from historical 13 mos
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_meter_ssla_mq_daily_h13mos A USING (SELECT B.id FROM meterprocess.txn_meter_raw_mq_daily_h13mos B JOIN meterprocess.txn_meter_validated_daily_h13mos C ON B.validated_id = C.id WHERE C.created_date_time < '$FINAL_DATE_h13mos') D WHERE A.daily_mq_id = D.id;" -c "DELETE FROM meterprocess.txn_meter_raw_mq_daily_h13mos A USING meterprocess.txn_meter_validated_daily_h13mos B WHERE A.validated_id = B.id AND B.created_date_time < '$FINAL_DATE_h13mos';" -c "DELETE FROM meterprocess.txn_meter_validated_daily_h13mos A WHERE A.created_date_time < '$FINAL_DATE_h13mos';"						

						if [ "$?" = "0" ]; then 
						#vacuum analyze
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "VACUUM ANALYZE meterprocess.txn_meter_validated_daily_h13mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_raw_mq_daily_h13mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_ssla_mq_daily_h13mos;"

						if [ "$?" = "0" ]; then
						#create check constraint
/Postgres/edb/as9.6/bin/psql -p 5432 -U postgres -d crss -c "ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_c3mos DROP CONSTRAINT IF EXISTS txn_meter_validated_daily_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_c3mos ADD CONSTRAINT txn_meter_validated_daily_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_h13mos DROP CONSTRAINT IF EXISTS txn_meter_validated_daily_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_h13mos ADD CONSTRAINT txn_meter_validated_daily_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"
							
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

