-- testDB.sql

set heading off
spool \testdb01\log\sql4.txt
select instance_name from v$instance;
spool off
exit;
