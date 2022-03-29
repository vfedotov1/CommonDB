-- recreate tmp table TIGER.DBA_TMP_INDEX_STATS to gather stats
--DROP TABLE TIGER.DBA_INDEX_STATS_1;
CREATE TABLE TIGER.DBA_INDEX_STATS_1
(
  NAME           		VARCHAR2(100 BYTE),
  HEIGHT         		NUMBER,
  DISTINCT_KEYS_RATIO  	NUMBER NULL,
  PCT_USED		 		NUMBER,
  "PCT_DELETED %"       NUMBER,
  NUM_ROWS				NUMBER,
  DISTINCT_KEYS		  	NUMBER,
  LF_ROWS        		NUMBER,
  LF_BLKS				NUMBER,
  DEL_LF_ROWS    		NUMBER,
  INSERT_DATE timestamp default systimestamp
)
PCTUSED    0
PCTFREE    0
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING
COMPRESS BASIC
NOCACHE
MONITORING;

-- Создание таблицы для индексов по которым не прошел ANALYZE
CREATE TABLE TIGER.DBA_INDEX_ANALYZE_ERROR_1
(
  NAME VARCHAR2(50 CHAR),
  ANALYZE_DATE  TIMESTAMP(6)                    DEFAULT systimestamp,
  ERROR   VARCHAR2(4000 BYTE)
)
PCTUSED    0
PCTFREE    0
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING
COMPRESS BASIC
NOCACHE
MONITORING;

-- 1.1 Создание временной таблицы с именами индексов, которые необходимо ребилдить + показателями из-за которого необходим ребилд
CREATE TABLE TIGER.DBA_INDEX_INDEXES_TO_REBUILD_1
(
NAME VARCHAR2(50 CHAR),
FREE_SPACE_MORE_50 NUMBER,
HEIGHT_GREATER_3 NUMBER,
PCT_DELETED_MORE_20 NUMBER,
DISTINCT_KEYS_RATIO_LESS_0_30 NUMBER,
LF_ROWS_LESS_LF_BLKS NUMBER
)
PCTUSED    0
PCTFREE    0
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING
COMPRESS BASIC
NOCACHE
MONITORING;

-- 2.3.1 recreate tmp table TIGER.DBA_INDEX_REBUILD_STATUS_1 to gather index rebuild date by JOB
--DROP TABLE TIGER.DBA_INDEX_REBUILD_STATUS_1 CASCADE CONSTRAINTS;
CREATE TABLE TIGER.DBA_INDEX_REBUILD_STATUS_1
(
  STATUS        VARCHAR2(100 BYTE),
  REBUILD_DATE  TIMESTAMP(6)                    DEFAULT systimestamp,
  S_COMMAND     VARCHAR2(30 CHAR)
)
PCTUSED    0
PCTFREE    0
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING
COMPRESS BASIC
NOCACHE
MONITORING;
--На случай если необходима выборка индексов без статуса из данной таблицы
--select regexp_substr(STATUS, '[^ ]+$') as STATUS from TIGER.DBA_INDEX_REBUILD_STATUS_1;
