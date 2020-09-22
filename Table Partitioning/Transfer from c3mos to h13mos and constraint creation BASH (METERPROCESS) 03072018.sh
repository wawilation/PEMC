#get cut-off date for current 3 mos
TEMP_DATE=$(date --date='4 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_c3mos=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)

##########---METERPROCESS---##########
#####txn_meter_validated_monthly, txn_meter_raw_mq_monthly, & txn_meter_ssla_mq_montly#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_meter_validated_monthly_h13mos SELECT * FROM meterprocess.txn_meter_validated_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.txn_meter_raw_mq_monthly_h13mos SELECT B.* FROM meterprocess.txn_meter_validated_monthly_c3mos A JOIN meterprocess.txn_meter_raw_mq_monthly_c3mos B ON A.id = B.validated_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.txn_meter_ssla_mq_monthly_h13mos SELECT C.* FROM meterprocess.txn_meter_validated_monthly_c3mos A JOIN meterprocess.txn_meter_raw_mq_monthly_c3mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_monthly_c3mos C ON B.id = C.monthly_mq_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_meter_ssla_mq_monthly_c3mos A USING (SELECT B.id FROM meterprocess.txn_meter_raw_mq_monthly_c3mos B JOIN meterprocess.txn_meter_validated_monthly_c3mos C ON B.validated_id = C.id WHERE C.reading_datetime < '$FINAL_DATE_c3mos') D WHERE A.monthly_mq_id = D.id;" -c "DELETE FROM meterprocess.txn_meter_raw_mq_monthly_c3mos A USING meterprocess.txn_meter_validated_monthly_c3mos B WHERE A.validated_id = B.id AND B.reading_datetime < '$FINAL_DATE_c3mos';" -c "DELETE FROM meterprocess.txn_meter_validated_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_meter_validated_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_meter_validated_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_monthly_c3mos ADD CONSTRAINT txn_meter_validated_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_meter_validated_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_meter_validated_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_monthly_h13mos ADD CONSTRAINT txn_meter_validated_monthly_h13mos_ck CHECK(reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_meter_validated_daily, txn_meter_raw_mq_daily, & txn_meter_ssla_mq_daily#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_meter_validated_daily_h13mos SELECT * FROM meterprocess.txn_meter_validated_daily_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.txn_meter_raw_mq_daily_h13mos SELECT B.* FROM meterprocess.txn_meter_validated_daily_c3mos A JOIN meterprocess.txn_meter_raw_mq_daily_c3mos B ON A.id = B.validated_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';" -c "INSERT INTO meterprocess.txn_meter_ssla_mq_daily_h13mos SELECT C.* FROM meterprocess.txn_meter_validated_daily_c3mos A JOIN meterprocess.txn_meter_raw_mq_daily_c3mos B ON A.id = B.validated_id JOIN meterprocess.txn_meter_ssla_mq_daily_c3mos C ON B.id = C.daily_mq_id WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_meter_ssla_mq_daily_c3mos A USING (SELECT B.id FROM meterprocess.txn_meter_raw_mq_daily_c3mos B JOIN meterprocess.txn_meter_validated_daily_c3mos C ON B.validated_id = C.id WHERE C.reading_datetime < '$FINAL_DATE_c3mos') D WHERE A.daily_mq_id = D.id;" -c "DELETE FROM meterprocess.txn_meter_raw_mq_daily_c3mos A USING meterprocess.txn_meter_validated_daily_c3mos B WHERE A.validated_id = B.id AND B.reading_datetime < '$FINAL_DATE_c3mos';" -c "DELETE FROM meterprocess.txn_meter_validated_daily_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_c3mos DROP CONSTRAINT IF EXISTS txn_meter_validated_daily_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_c3mos ADD CONSTRAINT txn_meter_validated_daily_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_h13mos DROP CONSTRAINT IF EXISTS txn_meter_validated_daily_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_meter_validated_daily_h13mos ADD CONSTRAINT txn_meter_validated_daily_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"



#####txn_stl_prelim_monthly#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_prelim_monthly_h13mos SELECT * FROM meterprocess.txn_stl_prelim_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_prelim_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_prelim_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_prelim_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_prelim_monthly_c3mos ADD CONSTRAINT txn_stl_prelim_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_prelim_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_prelim_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_prelim_monthly_h13mos ADD CONSTRAINT txn_stl_prelim_monthly_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_stl_gesq_prelim_monthly#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_gesq_prelim_monthly_h13mos SELECT * FROM meterprocess.txn_stl_gesq_prelim_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_gesq_prelim_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_gesq_prelim_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_prelim_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_prelim_monthly_c3mos ADD CONSTRAINT txn_stl_gesq_prelim_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_gesq_prelim_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_prelim_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_prelim_monthly_h13mos ADD CONSTRAINT txn_stl_gesq_prelim_monthly_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_stl_gesq_final_monthly#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_gesq_final_monthly_h13mos SELECT * FROM meterprocess.txn_stl_gesq_final_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_gesq_final_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_gesq_final_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_final_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_final_monthly_c3mos ADD CONSTRAINT txn_stl_gesq_final_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_gesq_final_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_final_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_final_monthly_h13mos ADD CONSTRAINT txn_stl_gesq_final_monthly_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_stl_gesq_adjusted_monthly#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_gesq_adjusted_monthly_h13mos SELECT * FROM meterprocess.txn_stl_gesq_adjusted_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_gesq_adjusted_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_gesq_adjusted_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_adjusted_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_adjusted_monthly_c3mos ADD CONSTRAINT txn_stl_gesq_adjusted_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_gesq_adjusted_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_adjusted_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_adjusted_monthly_h13mos ADD CONSTRAINT txn_stl_gesq_adjusted_monthly_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_stl_adjusted_monthly#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_adjusted_monthly_h13mos SELECT * FROM meterprocess.txn_stl_adjusted_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_adjusted_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_adjusted_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_adjusted_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_adjusted_monthly_c3mos ADD CONSTRAINT txn_stl_adjusted_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_adjusted_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_adjusted_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_adjusted_monthly_h13mos ADD CONSTRAINT txn_stl_adjusted_monthly_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_stl_final_monthly#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_final_monthly_h13mos SELECT * FROM meterprocess.txn_stl_final_monthly_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_final_monthly_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_c3mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_c3mos ADD CONSTRAINT txn_stl_final_monthly_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_h13mos DROP CONSTRAINT IF EXISTS txn_stl_final_monthly_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_final_monthly_h13mos ADD CONSTRAINT txn_stl_final_monthly_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_stl_gesq_daily#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_gesq_daily_h13mos SELECT * FROM meterprocess.txn_stl_gesq_daily_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_gesq_daily_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_gesq_daily_c3mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_daily_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_daily_c3mos ADD CONSTRAINT txn_stl_gesq_daily_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_gesq_daily_h13mos DROP CONSTRAINT IF EXISTS txn_stl_gesq_daily_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_gesq_daily_h13mos ADD CONSTRAINT txn_stl_gesq_daily_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"


#####txn_stl_daily#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO meterprocess.txn_stl_daily_h13mos SELECT * FROM meterprocess.txn_stl_daily_c3mos WHERE reading_datetime < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM meterprocess.txn_stl_daily_c3mos A WHERE A.reading_datetime < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY meterprocess.txn_stl_daily_c3mos DROP CONSTRAINT IF EXISTS txn_stl_daily_c3mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_daily_c3mos ADD CONSTRAINT txn_stl_daily_c3mos_ck CHECK (reading_datetime >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY meterprocess.txn_stl_daily_h13mos DROP CONSTRAINT IF EXISTS txn_stl_daily_h13mos_ck; ALTER TABLE ONLY meterprocess.txn_stl_daily_h13mos ADD CONSTRAINT txn_stl_daily_h13mos_ck CHECK (reading_datetime < '$FINAL_DATE_c3mos');"











