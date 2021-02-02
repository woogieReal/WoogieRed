-- REGEXP_LIKE: LIKE����� ������ ���Խ�
-- REGEXP_REPLACE: ���Խ��� �˻��Ͽ� ��ü ���ڿ��� ����
-- REGEXP_INSTR: ���Խ��� �˻��Ͽ� ��ġ��ȯ
-- REGEXP_SUBSTR: ���Խ��� �˻��Ͽ� ��������
-- REGEXP_COUNT(11g): ���Խ��� �˻��Ͽ� �߰��� Ƚ��
--^	    ���ڿ� ����
--$	    ���ڿ� ����
--.	    ������ ���� [�� ��'�� ���� �� �����ϴ�.]
--*	    �� ���ڰ� 0�� �̻��� ������ ������ �� �ֽ��ϴ�.
--+	    �� ���ڰ� 1�� �̻��� ������ ������ �� �ֽ��ϴ�.
--?	    �� ���ڰ� ���ų� �ϳ� ���� �� �ֽ��ϴ�.
--[]	������ �����̳� ������ ǥ���մϴ�. -��ȣ�� ���� ������ ��Ÿ�� �� �ֽ��ϴ�. ^�� �����ϸ� not�� ��Ÿ���ϴ�.
--{}	Ƚ�� �Ǵ� ������ ��Ÿ���ϴ�.
--()	��ȣ���� ���ڸ� �ϳ��� ���ڷ� �ν��մϴ�.
--|	    ������ OR ������ ������ �� ����մϴ�.
--\s	���� ����
--\S	���� ���ڰ� �ƴ� ������ ����
--\w	���ĺ��̳� ����
--\W	���ĺ��̳� ���ڸ� ������ ����
--\d	[0-9] ����
--\D	���ڸ� ������ ��� ����
--(?i)	��ҹ��ڸ� �������� �ʽ��ϴ�.

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

-- REGEXP_LIKE: LIKE����� ������ ���Խ�

--������
--�ҹ��ڰ� ����ִ� �ؽ�Ʈ ����('[a-z]')
--�빮�ڰ� ����ִ� �ؽ�Ʈ ����('[A-Z]')
--�����ڰ� ����ִ� �ؽ�Ʈ ����('[a-zA-Z]')
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

--�����ڷν���, ������ �ϳ��̻� �ִ� �� ���
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[a-zA-Z] ');
--TEXT
----------------------
--ABC 123
--ABC  123
--abc 123
--abc  123

--�����ڷν���, ������ �ϳ�, ���ڰ� �ִ� �� ���
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[a-zA-Z] [0-9]');
--TEXT
----------------------
--ABC 123
--abc 123

-- {} Ƚ�� �Ǵ� ������ ��Ÿ���ϴ�.
--�����빮�� 3���ݺ��ϴ� �� ���
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[A-Z]{3}');
--TEXT
----------------------
--ABC123
--ABC 123
--ABC  123

--POSIX���� Ŭ���� ����
--[:alnum:] ���ĺ��� ���� [A-Za-z0-9]
--[:alpha:] ���ĺ� [A-Za-z]
--[:cntrl:] ���� ����
--[:blank:] �ǰ� ���� ����
--[:digit:] ���� [0-9]
--[:graph:] ����ڿ� ���� ���ڸ� ������ ����
--[:lower:] �ҹ��� [a-z]
--[:upper:] �빮�� [A-Z]
--[:print:] ����ڸ� ������ ����, �� ������ �� �� �ִ� ����
--[:punct:] [:graph:]���� �� [:alnum:]�� ������ ����. ex)!,@,#,$,%,^....
--[:space:] ȭ��Ʈ�����̽� ex)����, ��, �ɸ��� ����, ����, ������, ���ʵ�
--[:xdigit:] 16����
--[]:�ش� ���ڿ� �ش��ϴ� �� ����
--[:space:] ȭ��Ʈ�����̽� ex)����, ��, �ɸ��� ����, ����, ������, ���ʵ�
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[[:space:]]');
--TEXT
----------------------
--ABC 123
--ABC  123
--abc 123
--abc  123

-- ^ ���ڿ� ����
--Ư����ġ�� �����Ͽ� ����ϱ�
--�����ڷ� �����ϴ� ������ ���('^[a-zA-Z]')
--���ڿ� �빮�ڷ� �����ϴ� ������ ���('^[0-9A-Z]')
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

-- | ������ OR ������ ������ �� ����մϴ�.
--�����ҹ��ڷ� �����ϰų� OR ���ڷ� �����ϴ� ������ ���
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

--id�� MO or MA�� �����ϴ� ������ ���
-- () ��ȣ���� ���ڸ� �ϳ��� ���ڷ� �ν��մϴ�.
SELECT name, id
FROM student
WHERE REGEXP_LIKE(id,'^M(o|a)');
--NAME                                                         ID
-------------------------------------------------------------- ----------------------------------------
--Demi Moore                                                   Moore
--Steve Martin                                                 Martin

-- $ ���ڿ� ����
--�����ڷ� ������ ������ ���
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'[a-zA-z]$');
--WHERE REGEXP_LIKE(text,'[[:alpha:]]$');
--TEXT
----------------------
--123abc
--abc

-- [^] �ش繮�ڿ� �ش����� �ʴ� �� ����
-- �ҹ��ڷ� �������� �ʴ� ������ ���
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

--������ȣ 2�ڸ�, ���� 4�ڸ��� ������ ���� ���
--��ȣ�� ��������(\)�� ���� ����Ѵ�.
SELECT name, tel
FROM student
WHERE REGEXP_LIKE(tel,'^[0-9]{2}\)[0-9]{4}');
--NAME                                                         TEL
-------------------------------------------------------------- ------------------------------
--Demi Moore                                                   02)6255-9875
--Richard Dreyfus                                              02)6788-4861
--Steve Martin                                                 02)6175-3945
--Anthony Hopkins                                              02)6122-2345

-- . ������ ���� [�� ��'�� ���� �� �����ϴ�.]
--id���� �� ��° ���ڰ� 'r'�� ������ ���
SELECT name, id
FROM student
WHERE REGEXP_LIKE(id,'^...r');
--NAME                                                         ID
-------------------------------------------------------------- ----------------------------------------
--James Seo                                                    75true
--Demi Moore                                                   Moore
--Bill Murray                                                  Murray

-- ip 172.61.168.2 �̾Ƴ���
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

--not�� ������ ������ ���Խ��� �����ʹ� �����ϰ� ����Ѵٴ� ��
SELECT *
FROM t_reg
WHERE NOT REGEXP_LIKE(text,'[a-zA-Z]');
--TEXT
----------------------
--?/!@#$*&
--\~*().,
--123123

-- \ Ư�����ڸ� ���� ��������(\)���
-- '*' �� ��� ������ ���
-- '\*' �� *�� ����ִ� ������ ���
SELECT *
FROM t_reg
WHERE REGEXP_LIKE(text,'\*');

--REGEXP_REPLACE: ���Խ��� �˻��Ͽ� ��ü ���ڿ��� ����

--���ڸ� ã�Ƽ� * �� ġȯ
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

-- REGEXP_SUBSTR: ���Խ��� �˻��Ͽ� ��������

--REGEXP_REPLACE ( source_char, pattern
--                 [, replace_string
--                    [, position
--                       [, occurrence
--                          [, match_param ]
--                       ]
--                    ]
--                 ]
--               )
--[^ ]: ������ �ƴ�
SELECT 'ABC* *DEF $GHI %KLM'"SENTENCE"
	,REGEXP_SUBSTR('ABC* *DEF $GHI %KLM','[^ ]+[DEF]')"EXTRACT"
FROM dual;
--SENTENCE                               EXTRACT
---------------------------------------- --------
--ABC* *DEF $GHI %KLM                    *DEF

--Ȩ������ �ּҿ��� 'http://' �κ� ����, '.'���� ���еǴ� �ʵ� 3~4�� ���
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

--REGEXP_COUNT(11g): ���Խ��� �˻��Ͽ� �߰��� Ƚ��
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








