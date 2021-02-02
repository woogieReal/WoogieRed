-- REGEXP_LIKE: LIKE연산과 유사한 정규식
-- REGEXP_REPLACE: 정규식을 검색하여 대체 문자열로 변경
-- REGEXP_INSTR: 정규식을 검색하여 위치반환
-- REGEXP_SUBSTR: 정규식을 검색하여 문자추출
-- REGEXP_COUNT(11g): 정규식을 검색하여 발견한 횟수
--^	    문자열 시작
--$	    문자열 종료
--.	    임의의 문자 [단 ‘'는 넣을 수 없습니다.]
--*	    앞 문자가 0개 이상의 개수가 존재할 수 있습니다.
--+	    앞 문자가 1개 이상의 개수가 존재할 수 있습니다.
--?	    앞 문자가 없거나 하나 있을 수 있습니다.
--[]	문자의 집합이나 범위를 표현합니다. -기호를 통해 범위를 나타낼 수 있습니다. ^가 존재하면 not을 나타냅니다.
--{}	횟수 또는 범위를 나타냅니다.
--()	괄호안의 문자를 하나의 문자로 인식합니다.
--|	    패턴을 OR 연산을 수행할 때 사용합니다.
--\s	공백 문자
--\S	공백 문자가 아닌 나머지 문자
--\w	알파벳이나 문자
--\W	알파벳이나 숫자를 제외한 문자
--\d	[0-9] 숫자
--\D	숫자를 제외한 모든 문자
--(?i)	대소문자를 구분하지 않습니다.

--TEXT
----------------------
--ABC123
--ABC 123
--ABC  123
--abc 123
--abc  123
--a1b2c3
--aabbcc123
--?/!@#$*&
--\~*().,
--123123
--123abc
--abc

-- REGEXP_LIKE: LIKE연산과 유사한 정규식

--영문자
--소문자가 들어있는 텍스트 추출('[a-z]')
--대문자가 들어있는 텍스트 추출('[A-Z]')
--영문자가 들어있는 텍스트 추출('[a-zA-Z]')
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[a-zA-Z]');
--TEXT
----------------------
--ABC123
--ABC 123
--ABC  123
--abc 123
--abc  123
--a1b2c3
--aabbcc123
--123abc
--abc

--영문자로시작, 공백이 하나이상 있는 행 출력
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[a-zA-Z] ');
--TEXT
----------------------
--ABC 123
--ABC  123
--abc 123
--abc  123

--영문자로시작, 공백이 하나, 숫자가 있는 행 출력
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[a-zA-Z] [0-9]');
--TEXT
----------------------
--ABC 123
--abc 123

-- {} 횟수 또는 범위를 나타냅니다.
--영문대문자 3번반복하는 행 출력
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[A-Z]{3}');
--TEXT
----------------------
--ABC123
--ABC 123
--ABC  123

--POSIX문자 클래스 내용
--[:alnum:] 알파벳과 숫자 [A-Za-z0-9]
--[:alpha:] 알파벳 [A-Za-z]
--[:cntrl:] 제어 문자
--[:blank:] 탭과 공백 문자
--[:digit:] 숫자 [0-9]
--[:graph:] 제어문자와 공백 무자를 제외한 문자
--[:lower:] 소문자 [a-z]
--[:upper:] 대문자 [A-Z]
--[:print:] 제어문자를 제외한 문자, 즉 프린터 할 수 있는 문자
--[:punct:] [:graph:]문자 중 [:alnum:]을 제외한 문자. ex)!,@,#,$,%,^....
--[:space:] 화이트스페이스 ex)공백, 탭, 케리지 리턴, 새행, 수직탭, 폼필드
--[:xdigit:] 16진수
--[]:해당 문자에 해당하는 한 문자
--[:space:] 화이트스페이스 ex)공백, 탭, 케리지 리턴, 새행, 수직탭, 폼필드
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[[:space:]]');
--TEXT
----------------------
--ABC 123
--ABC  123
--abc 123
--abc  123

-- ^ 문자열 시작
--특정위치를 지정하여 출력하기
--영문자로 시작하는 데이터 출력('^[a-zA-Z]')
--숫자와 대문자로 시작하는 데이터 출력('^[0-9A-Z]')
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'^[a-zA-Z]');
--TEXT
----------------------
--ABC123
--ABC 123
--ABC  123
--abc 123
--abc  123
--a1b2c3
--aabbcc123
--abc

-- | 패턴을 OR 연산을 수행할 때 사용합니다.
--영문소문자로 시작하거나 OR 숫자로 시작하는 데이터 출력
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'^[a-z]|^[0-9]');
--TEXT
----------------------
--abc 123
--abc  123
--a1b2c3
--aabbcc123
--123123
--123abc
--abc

--id가 MO or MA로 시작하는 데이터 출력
-- () 괄호안의 문자를 하나의 문자로 인식합니다.
SELECT name, id
FROM student
WHERE REGEXP_LIKE(id,'^M(o|a)');
--NAME                                                         ID
-------------------------------------------------------------- ----------------------------------------
--Demi Moore                                                   Moore
--Steve Martin                                                 Martin

-- $ 문자열 종료
--영문자로 끝나는 데이터 출력
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[a-zA-z]$');
--WHERE REGEXP_LIKE(text,'[[:alpha:]]$');
--TEXT
----------------------
--123abc
--abc

-- [^] 해당문자에 해당하지 않는 한 문자
-- 소문자로 시작하지 않는 데이터 출력
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'^[^a-z]');
--TEXT
----------------------
--ABC123
--ABC 123
--ABC  123
--?/!@#$*&
--\~*().,
--123123
--123abc

--지역번호 2자리, 국번 4자리가 나오는 값을 출력
--괄호는 역슬래쉬(\)를 붙혀 사용한다.
SELECT name, tel
FROM student
WHERE REGEXP_LIKE(tel,'^[0-9]{2}\)[0-9]{4}');
--NAME                                                         TEL
-------------------------------------------------------------- ------------------------------
--Demi Moore                                                   02)6255-9875
--Richard Dreyfus                                              02)6788-4861
--Steve Martin                                                 02)6175-3945
--Anthony Hopkins                                              02)6122-2345

-- . 임의의 문자 [단 ‘'는 넣을 수 없습니다.]
--id에서 네 번째 글자가 'r'인 데이터 출력
SELECT name, id
FROM student
WHERE REGEXP_LIKE(id,'^...r');
--NAME                                                         ID
-------------------------------------------------------------- ----------------------------------------
--James Seo                                                    75true
--Demi Moore                                                   Moore
--Bill Murray                                                  Murray

-- ip 172.61.168.2 뽑아내기
--        NO IP
------------ ----------------------------------------
--         1 10.10.0.1
--         2 10.10.10.1
--         3 172.16.5.100
--         4 172.61.186.2
--         5 172.61.168.2
--         6 255.255.255.0
SELECT no, ip
FROM t_reg2
WHERE REGEXP_LIKE(ip,'^[172]{3}\.[61]{2}\.[168]{3}\.');

--not을 붙히면 서술한 정규식의 데이터는 제외하고 출력한다는 것
SELECT *
FROM t_reg
WHERE NOT REGEXP_LIKE(text,'[a-zA-Z]');
--TEXT
----------------------
--?/!@#$*&
--\~*().,
--123123

-- \ 특수문자를 사용시 역슬래쉬(\)사용
-- '*' 는 모든 데이터 출력
-- '\*' 는 *이 들어있는 데이터 출력
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'\*');

--REGEXP_REPLACE: 정규식을 검색하여 대체 문자열로 변경

--숫자를 찾아서 * 로 치환
COL "REGEXP_REPLACE" FOR a15
SELECT text
	,REGEXP_REPLACE(text,'[0-9]','*') "REGEXP_REPLACE"
FROM t_reg;
--TEXT                 REGEXP_REPLACE
---------------------- ---------------
--ABC123               ABC***
--ABC 123              ABC ***
--ABC  123             ABC  ***
--abc 123              abc ***
--abc  123             abc  ***
--a1b2c3               a*b*c*
--aabbcc123            aabbcc***
--?/!@#$*&             ?/!@#$*&
--\~*().,              \~*().,
--123123               ******
--123abc               ***abc
--abc                  abc

-- REGEXP_SUBSTR: 정규식을 검색하여 문자추출

--REGEXP_REPLACE ( source_char, pattern
--                 [, replace_string
--                    [, position
--                       [, occurrence
--                          [, match_param ]
--                       ]
--                    ]
--                 ]
--               )
--[^ ]: 공백이 아님
SELECT 'ABC* *DEF $GHI %KLM'"SENTENCE"
	,REGEXP_SUBSTR('ABC* *DEF $GHI %KLM','[^ ]+[DEF]')"EXTRACT"
FROM dual;
--SENTENCE                               EXTRACT
---------------------------------------- --------
--ABC* *DEF $GHI %KLM                    *DEF

--홈페이지 주소에서 'http://' 부분 제거, '.'으로 구분되는 필드 3~4개 출력
COL name FOR a20
COL hpage FOR a30
COL "URL" FOR a20
SELECT name, hpage
	,LTRIM(REGEXP_SUBSTR(hpage,'/([A-Za-z0-9]+\.?){3,4}'),'/')"URL"
FROM professor
WHERE hpage IS NOT NULL;
--NAME                 HPAGE                          URL
---------------------- ------------------------------ --------------------
--Audie Murphy         http://www.abc.net             www.abc.net
--Angela Bassett       http://www.abc.net             www.abc.net
--Jessica Lange        http://www.power.com           www.power.com
--Michelle Pfeiffer    http://num1.naver.com          num1.naver.com

--REGEXP_COUNT(11g): 정규식을 검색하여 발견한 횟수
--REGEXP_COUNT (source_char, pattern [, position [, match_param]])
SELECT text,
	REGEXP_COUNT(text,'a')"COUNT"
FROM t_reg;
--TEXT                      COUNT
---------------------- ----------
--ABC123                        0
--ABC 123                       0
--ABC  123                      0
--abc 123                       1
--abc  123                      1
--a1b2c3                        1
--aabbcc123                     2
--?/!@#$*&                      0
--\~*().,                       0
--123123                        0
--123abc                        1
--abc                           1








