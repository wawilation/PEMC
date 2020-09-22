/*****AUDIT*****/
audit_log:
pg_dump -v -d crss -t audit.audit_log -s -Fp -f /pg_backup/table_partitioning_dumps/audit/audit_log.sql


