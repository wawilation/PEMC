/*****NMMS*****/
txn_energy_price_sched:
pg_dump -v -d crss -t nmms.txn_energy_price_sched -s -Fp -f /pg_backup/table_partitioning_dumps/nmms/txn_energy_price_sched.sql

txn_reserve_bcq:
pg_dump -v -d crss -t nmms.txn_reserve_bcq -s -Fp -f /pg_backup/table_partitioning_dumps/nmms/txn_reserve_bcq.sql

txn_reserve_price_sched:
pg_dump -v -d crss -t nmms.txn_reserve_price_sched -s -Fp -f /pg_backup/table_partitioning_dumps/nmms/txn_reserve_price_sched.sql

txn_rtu:
pg_dump -v -d crss -t nmms.txn_rtu -s -Fp -f /pg_backup/table_partitioning_dumps/nmms/txn_rtu.sql


