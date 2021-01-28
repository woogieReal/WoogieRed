--1.HR생성
--2.ORACLE이 제공하는 SCRIPT수행
--3.SYS계정으로 작업
--4.실행스크립트 @C:\oraclexe\app\oracle\product\11.2.0\server\demo\schema\human_resources\hr_main.sql

SCOTT>conn / as sysdba
SCOTT>ALTER SESSION SET "_ORACLE_SCRIPT"=true
