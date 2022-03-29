-- sqlplus / as sysdba @/tmp/CommonDB/PreparatorySQL/1_create_tbs.sql

-- set db_create_file_dest according your database
alter system set db_create_file_dest = '/u01/oradata/OWNTST';

-- create common tbs
CREATE BIGFILE TABLESPACE MAIN_TBS DATAFILE
  SIZE 100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
