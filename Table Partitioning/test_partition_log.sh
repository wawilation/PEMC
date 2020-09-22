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
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_validated_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0, NULL, 'P';" -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_raw_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0, NULL, 'P';" -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_ssla_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0, NULL, 'P';" 


#####LOG HERE TEMP STATUS (status = 'XX'), get count of rows to be inserted
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log 
SELECT '$ID','meterprocess.txn_meter_validated_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(1), NULL, 'XX'
FROM meterprocess.txn_meter_validated_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.partition_log 
SELECT '$ID','meterprocess.txn_meter_raw_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(B.*), NULL, 'XX'
FROM meterprocess.txn_meter_validated_monthly_c3mos A JOIN meterprocess.txn_meter_raw_mq_monthly_c3mos B ON A.id = B.validated_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.partition_log 
SELECT '$ID','meterprocess.txn_meter_ssla_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(C.*), NULL, 'XX' 
FROM meterprocess.txn_meter_validated_monthly_c3mos A JOIN meterprocess.txn_meter_raw_mq_monthly_c3mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_monthly_c3mos C ON B.id = C.monthly_mq_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';" 

#####LOG HERE (status = 'H', count of recs inserted taken from status = 'XX')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "UPDATE meterprocess.partition_log SET status = 'H', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_meter_validated_monthly_h13mos' AND status = 'XX';" -c "UPDATE meterprocess.partition_log SET status = 'H', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_meter_raw_mq_monthly_h13mos' AND status = 'XX';" -c "UPDATE meterprocess.partition_log SET status = 'H', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_meter_ssla_mq_monthly_h13mos' AND status = 'XX';"


#####LOG HERE (status = 'DC', count of recs deleted based on status = 'H')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_validated_monthly_c3mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, NULL, 'DC'
FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_meter_validated_monthly_h13mos' AND A.status = 'H';" -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_raw_mq_monthly_c3mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, NULL, 'DC'
FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_meter_raw_mq_monthly_h13mos' AND A.status = 'H';" -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_ssla_mq_monthly_c3mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, NULL, 'DC'
FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_meter_ssla_mq_monthly_h13mos' AND A.status = 'H';"

#####LOG HERE (status = 'V')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log SELECT '$ID','(meterprocess) txn_meter_validated_monthly_c3mos,txn_meter_validated_monthly_h13mos,txn_meter_raw_mq_monthly_c3mos,txn_meter_raw_mq_monthly_h13mos,txn_meter_ssla_mq_monthly_c3mos,txn_meter_ssla_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0,NULL,'V';"


#####LOG HERE TEMP STATUS (status = 'XX', count of recs archived)
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log
SELECT '$ID','meterprocess.txn_meter_validated_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(1), '/pg_backup/data_archive/crss_meterprocess.txn_meter_validated_monthly_h13mos_$FINAL_DATE_h13mos.dat', 'XX' FROM meterprocess.txn_meter_validated_monthly_h13mos WHERE created_date_time < '$FINAL_DATE_h13mos';"

#####LOG HERE (status = 'A', count of recs archived based on status = 'XX')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "UPDATE meterprocess.partition_log SET status = 'A', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_meter_validated_monthly_h13mos' AND status = 'XX' AND archivepath IS NOT NULL;"


#####LOG HERE TEMP STATUS (status = 'XX', count of recs archived)
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log
SELECT '$ID','meterprocess.txn_meter_raw_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(B.*), '/pg_backup/data_archive/crss_meterprocess.txn_meter_raw_mq_monthly_h13mos_$FINAL_DATE_h13mos.dat', 'XX' FROM meterprocess.txn_meter_validated_monthly_h13mos A JOIN meterprocess.txn_meter_raw_mq_monthly_h13mos B ON A.id = B.validated_id WHERE A.created_date_time < '$FINAL_DATE_h13mos';"

#####LOG HERE (status = 'A', count of recs archived based on status = 'XX')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "UPDATE meterprocess.partition_log SET status = 'A', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_meter_raw_mq_monthly_h13mos' AND status = 'XX' AND archivepath IS NOT NULL;"


#####LOG HERE TEMP STATUS (status = 'XX', count of recs archived)
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log
SELECT '$ID','meterprocess.txn_meter_ssla_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, COUNT(C.*), '/pg_backup/data_archive/crss_meterprocess.txn_meter_ssla_mq_monthly_h13mos_$FINAL_DATE_h13mos.dat', 'XX' FROM meterprocess.txn_meter_validated_monthly_h13mos A JOIN meterprocess.txn_meter_raw_mq_monthly_h13mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_monthly_h13mos C ON B.id = C.monthly_mq_id WHERE A.created_date_time < '$FINAL_DATE_h13mos';"

#####LOG HERE (status = 'A', count of recs archived based on status = 'XX')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "UPDATE meterprocess.partition_log SET status = 'A', controldate = current_timestamp WHERE id = '$ID' AND object = 'meterprocess.txn_meter_ssla_mq_monthly_h13mos' AND status = 'XX' AND archivepath IS NOT NULL;"

#####LOG HERE (status = 'DH', count of recs deleted based on status = 'A')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_validated_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, A.archivepath, 'DH'
FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_meter_validated_monthly_h13mos' AND A.status = 'A';" -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_raw_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, A.archivepath, 'DH' FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_meter_raw_mq_monthly_h13mos' AND A.status = 'A';" -c "INSERT INTO meterprocess.partition_log SELECT '$ID','meterprocess.txn_meter_ssla_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, A.count, A.archivepath, 'DH' FROM meterprocess.partition_log A WHERE A.id = '$ID' AND A.object = 'meterprocess.txn_meter_ssla_mq_monthly_h13mos' AND A.status = 'A';"


#####LOG HERE (status = 'V')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log SELECT '$ID','(meterprocess) txn_meter_validated_monthly_h13mos,txn_meter_raw_mq_monthly_h13mos,txn_meter_ssla_mq_monthly_h13mos', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0,NULL,'V';"


#####LOG HERE (status = 'C')
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "INSERT INTO meterprocess.partition_log SELECT '$ID','(meterprocess) txn_meter_validated_monthly_c3mos_ck CHECK (reading_datetime >= ''$FINAL_DATE_c3mos''),txn_meter_validated_monthly_h13mos_ck CHECK (reading_datetime < ''$FINAL_DATE_c3mos'')', '$FINAL_DATE_c3mos', '$FINAL_DATE_h13mos', current_timestamp, 0,NULL,'C';"





