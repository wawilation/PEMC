#get cut-off date for current 3 mos
TEMP_DATE=$(date --date='4 months ago' +%Y-%m-%d)
DAY=$(date -d "$TEMP_DATE" '+%d')
FINAL_DATE_c3mos=$(date -d "$TEMP_DATE + 26 days - $DAY days" +%Y-%m-%d)


##########---SETTLEMENT---##########
#####txn_output_ready_bilateral_energy_qty_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_bilateral_energy_qty_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_bilateral_energy_qty_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_bilateral_energy_qty_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_bilateral_energy_qty_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_bilateral_energy_qty_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_bilateral_energy_qty_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_bilateral_energy_qty_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_bilateral_energy_qty_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_bilateral_energy_qty_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_bilateral_energy_qty_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_bilateral_energy_qty_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_bilateral_energy_qty_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_bilateral_energy_qty_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_bilateral_energy_qty_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_bilateral_energy_qty_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_bilateral_energy_qty_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_bilateral_energy_qty_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_bilateral_energy_qty_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_bilateral_energy_qty_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"	

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_bilateral_energy_qty_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_bilateral_energy_qty_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_bilateral_energy_qty_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_bilateral_energy_qty_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_bilateral_energy_qty_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_energy_qty_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_energy_qty_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_energy_qty_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_energy_qty_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_energy_qty_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_energy_qty_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_energy_qty_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_energy_qty_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"	
	

#####txn_output_ready_energy_qty_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_energy_qty_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_energy_qty_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_energy_qty_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_energy_qty_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_energy_qty_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_energy_qty_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_energy_qty_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_energy_qty_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_energy_qty_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_energy_qty_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_energy_qty_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_energy_qty_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_energy_qty_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_energy_qty_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_energy_qty_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_energy_qty_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_eta_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_eta_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_eta_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_eta_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_eta_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_eta_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_eta_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_eta_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_eta_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_eta_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_eta_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_eta_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_eta_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_eta_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_eta_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_eta_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_eta_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_eta_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_eta_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_eta_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_eta_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_eta_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_eta_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_eta_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_eta_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"



#####txn_output_ready_gmrvat_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_gmrvat_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_gmrvat_monthly_adjusted_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_gmrvat_monthly_adjusted_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_gmrvat_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_gmrvat_monthly_adjusted_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_gmrvat_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_gmrvat_monthly_adjusted_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_gmrvat_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_gmrvat_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_gmrvat_monthly_final_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_gmrvat_monthly_final_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_gmrvat_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_gmrvat_monthly_final_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_gmrvat_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_gmrvat_monthly_final_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_gmrvat_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_gmrvat_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_gmrvat_monthly_prelim_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_gmrvat_monthly_prelim_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_gmrvat_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_gmrvat_monthly_prelim_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_gmrvat_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_gmrvat_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_gmrvat_monthly_prelim_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_lr_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_lr_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_lr_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_lr_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_lr_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_lr_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_lr_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_lr_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_lr_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_lr_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_lr_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_lr_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_lr_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_lr_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_lr_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_lr_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"



#####txn_output_ready_lr_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_lr_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_lr_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_lr_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_lr_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_lr_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_lr_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_lr_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_lr_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_market_fee_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_market_fee_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_market_fee_monthly_adjusted_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_market_fee_monthly_adjusted_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_market_fee_monthly_adjusted_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_market_fee_monthly_adjusted_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_market_fee_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_market_fee_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_market_fee_monthly_final_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_market_fee_monthly_final_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_market_fee_monthly_final_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_market_fee_monthly_final_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_market_fee_monthly_prelim######
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_market_fee_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_market_fee_monthly_prelim_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_market_fee_monthly_prelim_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_market_fee_monthly_prelim_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_market_fee_monthly_prelim_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_market_fee_reserve_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_market_fee_reserve_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_market_fee_reserve_monthly_adjusted_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_market_fee_reserve_monthly_adjusted_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_reserve_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_market_fee_reserve_monthly_adjusted_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_reserve_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_market_fee_reserve_monthly_adjusted_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_market_fee_reserve_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_market_fee_reserve_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_market_fee_reserve_monthly_final_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_market_fee_reserve_monthly_final_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_reserve_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_market_fee_reserve_monthly_final_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_reserve_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_market_fee_reserve_monthly_final_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_market_fee_reserve_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_market_fee_reserve_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_market_fee_reserve_monthly_prelim_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_market_fee_reserve_monthly_prelim_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_reserve_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_market_fee_reserve_monthly_prelim_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_market_fee_reserve_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_market_fee_reserve_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_market_fee_reserve_monthly_prelim_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_energy_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_energy_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_mf_energy_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_energy_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_energy_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_mf_energy_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_energy_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_mf_energy_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_energy_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_energy_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_mf_energy_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_energy_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_energy_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_mf_energy_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_energy_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_mf_energy_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_energy_monthly_prelim#####
#insert into historical 13 mos
	/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_energy_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_mf_energy_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_energy_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_energy_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_mf_energy_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_energy_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_energy_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_mf_energy_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_reserve_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_reserve_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_mf_reserve_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_reserve_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_mf_reserve_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_mf_reserve_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_reserve_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_reserve_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_mf_reserve_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_reserve_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_mf_reserve_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_mf_reserve_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_reserve_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_reserve_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_mf_reserve_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_reserve_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_mf_reserve_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_mf_reserve_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_reserve_qty_monthly_adjusted#####
#insert into historical 13 mos
	/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_reserve_qty_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_mf_reserve_qty_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_reserve_qty_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_qty_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_mf_reserve_qty_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_qty_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_mf_reserve_qty_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_reserve_qty_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_reserve_qty_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_mf_reserve_qty_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_reserve_qty_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_qty_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_mf_reserve_qty_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_qty_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_mf_reserve_qty_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_mf_reserve_qty_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_mf_reserve_qty_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_mf_reserve_qty_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_mf_reserve_qty_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_qty_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_mf_reserve_qty_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_mf_reserve_qty_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_mf_reserve_qty_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_mf_reserve_qty_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"



#####txn_output_ready_nss_flowback_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_nss_flowback_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_nss_flowback_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_nss_flowback_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_nss_flowback_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_nss_flowback_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_nss_flowback_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_nss_flowback_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_nss_flowback_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_nss_flowback_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_nss_flowback_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_nss_flowback_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_nss_flowback_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_nss_flowback_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_nss_flowback_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_nss_flowback_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_nss_flowback_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_nss_flowback_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_nss_flowback_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_nss_flowback_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_nss_flowback_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_nss_flowback_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_nss_flowback_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_nss_flowback_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_nss_flowback_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_disagg_bcq_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_disagg_bcq_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_process_disagg_bcq_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_disagg_bcq_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_disagg_bcq_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_process_disagg_bcq_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_disagg_bcq_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_process_disagg_bcq_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_disagg_bcq_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_disagg_bcq_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_process_disagg_bcq_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_disagg_bcq_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_disagg_bcq_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_process_disagg_bcq_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_disagg_bcq_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_process_disagg_bcq_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_disagg_bcq_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_disagg_bcq_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_process_disagg_bcq_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_disagg_bcq_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_disagg_bcq_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_process_disagg_bcq_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_disagg_bcq_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_disagg_bcq_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_process_disagg_bcq_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_gmr_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_gmr_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_process_gmr_monthly_adjusted_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_gmr_monthly_adjusted_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_gmr_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_process_gmr_monthly_adjusted_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_gmr_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_process_gmr_monthly_adjusted_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_gmr_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_gmr_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_process_gmr_monthly_final_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_gmr_monthly_final_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_gmr_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_process_gmr_monthly_final_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_gmr_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_process_gmr_monthly_final_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_gmr_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_gmr_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_process_gmr_monthly_prelim_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_gmr_monthly_prelim_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_gmr_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_process_gmr_monthly_prelim_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_gmr_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_gmr_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_process_gmr_monthly_prelim_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_nss_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_nss_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_process_nss_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_nss_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_nss_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_process_nss_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_nss_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_process_nss_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_nss_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_nss_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_process_nss_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_nss_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_nss_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_process_nss_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_nss_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_process_nss_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_nss_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_nss_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_process_nss_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_nss_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_nss_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_process_nss_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_nss_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_nss_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_process_nss_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_rgmr_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_rgmr_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_process_rgmr_monthly_adjusted_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_rgmr_monthly_adjusted_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rgmr_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_process_rgmr_monthly_adjusted_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rgmr_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_process_rgmr_monthly_adjusted_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_rgmr_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_rgmr_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_process_rgmr_monthly_final_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_rgmr_monthly_final_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rgmr_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_process_rgmr_monthly_final_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rgmr_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_process_rgmr_monthly_final_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_rgmr_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_rgmr_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_process_rgmr_monthly_prelim_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_rgmr_monthly_prelim_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rgmr_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_process_rgmr_monthly_prelim_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rgmr_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rgmr_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_process_rgmr_monthly_prelim_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_rp_rta_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_rp_rta_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_process_rp_rta_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"


#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_rp_rta_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rp_rta_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_process_rp_rta_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rp_rta_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_process_rp_rta_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_rp_rta_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_rp_rta_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_process_rp_rta_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_rp_rta_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rp_rta_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_process_rp_rta_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rp_rta_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_process_rp_rta_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_rp_rta_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_rp_rta_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_process_rp_rta_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_rp_rta_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rp_rta_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_process_rp_rta_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_rp_rta_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_rp_rta_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_process_rp_rta_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_spotqty_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_spotqty_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_process_spotqty_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_spotqty_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_spotqty_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_process_spotqty_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_spotqty_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_process_spotqty_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_spotqty_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_spotqty_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_process_spotqty_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_spotqty_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_spotqty_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_process_spotqty_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_spotqty_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_process_spotqty_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_process_spotqty_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_process_spotqty_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_process_spotqty_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_process_spotqty_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_spotqty_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_process_spotqty_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_process_spotqty_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_process_spotqty_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_process_spotqty_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rcra_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rcra_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_rcra_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rcra_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rcra_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_rcra_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rcra_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_rcra_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rcra_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rcra_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_rcra_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rcra_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rcra_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_rcra_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rcra_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_rcra_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rcra_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rcra_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_rcra_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rcra_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rcra_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_rcra_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rcra_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rcra_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_rcra_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_reserve_qty_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_reserve_qty_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_reserve_qty_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_reserve_qty_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_reserve_qty_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_reserve_qty_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_reserve_qty_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_reserve_qty_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_reserve_qty_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_reserve_qty_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_reserve_qty_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_reserve_qty_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_reserve_qty_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_reserve_qty_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_reserve_qty_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_reserve_qty_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_reserve_qty_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_reserve_qty_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_reserve_qty_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_reserve_qty_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_reserve_qty_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_reserve_qty_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_reserve_qty_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_reserve_qty_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_reserve_qty_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rgmrvat_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rgmrvat_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_rgmrvat_monthly_adjusted_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rgmrvat_monthly_adjusted_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rgmrvat_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_rgmrvat_monthly_adjusted_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rgmrvat_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_rgmrvat_monthly_adjusted_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rgmrvat_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rgmrvat_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_rgmrvat_monthly_final_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rgmrvat_monthly_final_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rgmrvat_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_rgmrvat_monthly_final_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rgmrvat_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_rgmrvat_monthly_final_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rgmrvat_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rgmrvat_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_rgmrvat_monthly_prelim_c3mos WHERE billing_period_end < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rgmrvat_monthly_prelim_c3mos A WHERE A.billing_period_end < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rgmrvat_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_rgmrvat_monthly_prelim_c3mos_ck CHECK (billing_period_end >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rgmrvat_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rgmrvat_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_rgmrvat_monthly_prelim_h13mos_ck CHECK (billing_period_end < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rta_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rta_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_rta_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rta_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rta_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_rta_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rta_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_rta_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rta_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rta_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_rta_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rta_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rta_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_rta_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rta_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_rta_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_rta_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_rta_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_rta_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_rta_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_rta_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_rta_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_rta_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_rta_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_rta_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_runway_monthly_adjusted#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_runway_monthly_adjusted_h13mos SELECT * FROM settlement.txn_output_ready_runway_monthly_adjusted_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_runway_monthly_adjusted_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_adjusted_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_runway_monthly_adjusted_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_adjusted_c3mos ADD CONSTRAINT txn_output_ready_runway_monthly_adjusted_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_adjusted_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_runway_monthly_adjusted_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_adjusted_h13mos ADD CONSTRAINT txn_output_ready_runway_monthly_adjusted_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_runway_monthly_final#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_runway_monthly_final_h13mos SELECT * FROM settlement.txn_output_ready_runway_monthly_final_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_runway_monthly_final_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_final_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_runway_monthly_final_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_final_c3mos ADD CONSTRAINT txn_output_ready_runway_monthly_final_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_final_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_runway_monthly_final_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_final_h13mos ADD CONSTRAINT txn_output_ready_runway_monthly_final_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


#####txn_output_ready_runway_monthly_prelim#####
#insert into historical 13 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "INSERT INTO settlement.txn_output_ready_runway_monthly_prelim_h13mos SELECT * FROM settlement.txn_output_ready_runway_monthly_prelim_c3mos WHERE dispatch_interval < '$FINAL_DATE_c3mos';"

#delete from current 3 mos
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "set session_replication_role = replica;" -c "DELETE FROM settlement.txn_output_ready_runway_monthly_prelim_c3mos A WHERE A.dispatch_interval < '$FINAL_DATE_c3mos';"

#create check constraint
/usr/pgsql-9.6/bin/psql -p 5432 -U postgres -d crss_table_partitioning -c "ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_prelim_c3mos DROP CONSTRAINT IF EXISTS txn_output_ready_runway_monthly_prelim_c3mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_prelim_c3mos ADD CONSTRAINT txn_output_ready_runway_monthly_prelim_c3mos_ck CHECK (dispatch_interval >= '$FINAL_DATE_c3mos'); ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_prelim_h13mos DROP CONSTRAINT IF EXISTS txn_output_ready_runway_monthly_prelim_h13mos_ck; ALTER TABLE ONLY settlement.txn_output_ready_runway_monthly_prelim_h13mos ADD CONSTRAINT txn_output_ready_runway_monthly_prelim_h13mos_ck CHECK (dispatch_interval < '$FINAL_DATE_c3mos');"


