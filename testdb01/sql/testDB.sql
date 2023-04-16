-- testDB.sql

set heading off
spool \testdb01\log\testdb.log
select instance_name from v$instance;
spool off
exit;
