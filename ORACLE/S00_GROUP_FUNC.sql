--COUNT :입력데이터의 총 건수 출력
--복수행 함수에 *를 사용하면 NULL을 포함
--복수행 함수에 이름을 쓰면 NULL을 포함하지 않음
SELECT COUNT(*), COUNT(comm)
FROM emp;
--  COUNT(*) COUNT(COMM)
------------ -----------
--        12           4