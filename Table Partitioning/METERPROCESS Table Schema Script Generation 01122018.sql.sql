/*****METERPROCESS*****/
txn_meter_validated_monthly: 
pg_dump -v -d crss -t meterprocess.txn_meter_validated_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_meter_validated_monthly.sql

txn_meter_raw_mq_monthly:
pg_dump -v -d crss -t meterprocess.txn_meter_raw_mq_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_meter_raw_mq_monthly.sql

txn_meter_ssla_mq_monthly:
pg_dump -v -d crss -t meterprocess.txn_meter_ssla_mq_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_meter_ssla_mq_monthly.sql

txn_meter_validated_daily:
pg_dump -v -d crss -t meterprocess.txn_meter_validated_daily -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_meter_validated_daily.sql

txn_meter_raw_mq_daily:
pg_dump -v -d crss -t meterprocess.txn_meter_raw_mq_daily -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_meter_raw_mq_daily.sql

txn_meter_ssla_mq_daily:
pg_dump -v -d crss -t meterprocess.txn_meter_ssla_mq_daily -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_meter_ssla_mq_daily.sql

txn_stl_adjusted_monthly:
pg_dump -v -d crss -t meterprocess.txn_stl_adjusted_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_adjusted_monthly.sql

txn_stl_daily:
pg_dump -v -d crss -t meterprocess.txn_stl_daily -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_daily.sql

txn_stl_final_monthly:
pg_dump -v -d crss -t meterprocess.txn_stl_final_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_final_monthly.sql

txn_stl_prelim_monthly:
pg_dump -v -d crss -t meterprocess.txn_stl_prelim_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_prelim_monthly.sql

txn_stl_gesq_adjusted_monthly:
pg_dump -v -d crss -t meterprocess.txn_stl_gesq_adjusted_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_gesq_adjusted_monthly.sql

txn_stl_gesq_daily:
pg_dump -v -d crss -t meterprocess.txn_stl_gesq_daily -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_gesq_daily.sql

txn_stl_gesq_final_monthly:
pg_dump -v -d crss -t meterprocess.txn_stl_gesq_final_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_gesq_final_monthly.sql

txn_stl_gesq_prelim_monthly:
pg_dump -v -d crss -t meterprocess.txn_stl_gesq_prelim_monthly -s -Fp -f /pg_backup/table_partitioning_dumps/meterprocess/txn_stl_gesq_prelim_monthly.sql


