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
	/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_meter_validated_daily_historical13mos SELECT * FROM meterprocess.txn_meter_validated_daily_current3mos WHERE reading_datetime < '$FINAL_DATE_CURRENT3MOS';" -c "INSERT INTO meterprocess.txn_meter_raw_mq_daily_historical13mos SELECT B.* FROM meterprocess.txn_meter_validated_daily_current3mos A JOIN meterprocess.txn_meter_raw_mq_daily_current3mos B ON A.id = B.validated_id WHERE A.reading_datetime < '$FINAL_DATE_CURRENT3MOS';" -c "INSERT INTO meterprocess.txn_meter_ssla_mq_daily_historical13mos SELECT C.* FROM meterprocess.txn_meter_validated_daily_current3mos A JOIN meterprocess.txn_meter_raw_mq_daily_current3mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_daily_current3mos C ON B.id = C.daily_mq_id WHERE A.reading_datetime < '$FINAL_DATE_CURRENT3MOS';"

if [ "$?" = "0" ]; then
#delete from current 3 mos
/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_meter_ssla_mq_daily_current3mos A USING (SELECT B.id FROM meterprocess.txn_meter_raw_mq_daily_current3mos B JOIN meterprocess.txn_meter_validated_daily_current3mos C ON B.validated_id = C.id WHERE C.reading_datetime < '$FINAL_DATE_CURRENT3MOS') D WHERE A.daily_mq_id = D.id;" -c "DELETE FROM meterprocess.txn_meter_raw_mq_daily_current3mos A USING meterprocess.txn_meter_validated_daily_current3mos B WHERE A.validated_id = B.id AND B.reading_datetime < '$FINAL_DATE_CURRENT3MOS';" -c "DELETE FROM meterprocess.txn_meter_validated_daily_current3mos A WHERE A.reading_datetime < '$FINAL_DATE_CURRENT3MOS';"	
	
	if [ "$?" = "0" ]; then 
	#vacuum analyze
/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "VACUUM ANALYZE meterprocess.txn_meter_ssla_mq_daily_current3mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_raw_mq_daily_current3mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_validated_daily_current3mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_validated_daily_historical13mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_raw_mq_daily_historical13mos;" -c "VACUUM ANALYZE meterprocess.txn_meter_ssla_mq_daily_historical13mos;"		

		if [ "$?" = "0" ]; then
		#dump older than historical13mos data to archive file
/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "COPY(
SELECT * FROM ONLY meterprocess.txn_meter_validated_daily_historical13mos WHERE reading_datetime < '$FINAL_DATE_HISTORICAL13MOS') TO '/tmp/crss_meterprocess.txn_meter_validated_daily_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat';"
gzip /tmp/crss_meterprocess.txn_meter_validated_daily_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat					

			if [ "$?" = "0" ]; then
			#dump older than historical13mos data to archive file	
/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "COPY(
SELECT B.* FROM meterprocess.txn_meter_validated_daily_historical13mos A JOIN meterprocess.txn_meter_raw_mq_daily_historical13mos B ON A.id = B.validated_id WHERE A.reading_datetime < '$FINAL_DATE_HISTORICAL13MOS') TO '/tmp/crss_meterprocess.txn_meter_raw_mq_daily_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat';"
gzip /tmp/crss_meterprocess.txn_meter_raw_mq_daily_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat				

				if [ "$?" = "0" ]; then
				#dump older than historical13mos data to archive file
/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "COPY(
SELECT C.* FROM meterprocess.txn_meter_validated_daily_historical13mos A JOIN meterprocess.txn_meter_raw_mq_daily_historical13mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_daily_historical13mos C ON B.id = C.daily_mq_id WHERE A.reading_datetime < '$FINAL_DATE_HISTORICAL13MOS') TO '/tmp/crss_meterprocess.txn_meter_ssla_mq_daily_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat';"
gzip /tmp/crss_meterprocess.txn_meter_ssla_mq_daily_historical13mos_$FINAL_DATE_HISTORICAL13MOS.dat					

					if [ "$?" = "0" ]; then
					#delete from historical 13 mos
/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_meter_ssla_mq_daily_historical13mos A USING (SELECT B.id FROM meterprocess.txn_meter_raw_mq_daily_historical13mos B JOIN meterprocess.txn_meter_validated_daily_historical13mos C ON B.validated_id = C.id WHERE C.reading_datetime < '$FINAL_DATE_HISTORICAL13MOS') D WHERE A.daily_mq_id = D.id;" -c "DELETE FROM meterprocess.txn_meter_raw_mq_daily_historical13mos A USING meterprocess.txn_meter_validated_daily_historical13mos B WHERE A.validated_id = B.id AND B.reading_datetime < '$FINAL_DATE_HISTORICAL13MOS';" -c "DELETE FROM meterprocess.txn_meter_validated_daily_historical13mos A WHERE A.reading_datetime < '$FINAL_DATE_HISTORICAL13MOS';"						

						if [ "$?" = "0" ]; then
						#create check constraint
/opt/edb/as9.6/bin/psql -p 5433 -U postgres -d crss -c "ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_current3mos DROP CONSTRAINT IF EXISTS txn_meter_validated_daily_current3mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_current3mos ADD CONSTRAINT txn_meter_validated_daily_current3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_CURRENT3MOS'); ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_historical13mos DROP CONSTRAINT IF EXISTS txn_meter_validated_daily_historical13mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_historical13mos ADD CONSTRAINT txn_meter_validated_daily_historical13mos_ck CHECK (reading_datetime < '$FINAL_DATE_CURRENT3MOS');"
							
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

