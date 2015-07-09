-- �m��01 - �ϥ��ܼ�

DECLARE @���u�s�� varchar(10),
		@���u�W�� varchar(10),
		@���u���y�~�� varchar(10)

SET		@���u�s�� = ''
SET		@���u�W�� = ''
SET		@���u���y�~�� = ''

SELECT	@���u�s�� = ���u.���u�s��,
		@���u�W�� = ���u.�m�W,
		@���u���y�~�� = ���u���y��.�~��
FROM	���u JOIN ���u���y�� ON ���u.���u�s�� = ���u���y��.���u�s��
WHERE	���u.���u�s�� = 11

PRINT	'���u�s���G' + @���u�s��
PRINT	'���u�m�W�G' + @���u�W��
PRINT	'���y���~�סG' + @���u���y�~��

GO

------------
-- �Ѯv�� --
------------
DECLARE	@EmpNum int
DECLARE	@EmpName varchar(20)
DECLARE	@EmpPrizeYear int
DECLARE	@setEmpNum int

SET		@EmpNum = 0
SET		@EmpName = ''
SET		@EmpPrizeYear = 0
SET		@setEmpNum = 11

SELECT	@EmpNum = ���u�s��,
		@EmpName = �m�W
FROM	���u
WHERE	���u�s�� = @setEmpNum

SELECT	@EmpPrizeYear = �~��
FROM	���u���y��
WHERE	���u�s�� = @setEmpNum

PRINT	'���u�s���G' + CONVERT(varchar, @EmpNum)
PRINT	'���u�m�W�G' + @EmpName
PRINT	'���y���~�סG' + CONVERT(varchar, @EmpPrizeYear)

GO


--===================================================================
-- �m��02 - �ϥ� Table ���O�ܼ�

DECLARE	@Emp TABLE (EmpNum int Primary key,
					EmpName varchar(20),
					EmpBath date)

DECLARE @Ord TABLE (OrderNum varchar(8) Primary key,
					EmpNum int)

INSERT	@Emp
SELECT	���u�s��, �m�W, �X�ͤ��
FROM	���u

INSERT	@Ord
SELECT	�q��s��, ���u�s��
FROM	�q��

SELECT	E.EmpNum, EmpName,E.EmpBath, O.OrderNum
FROM	@Emp AS E JOIN @Ord AS O ON E.EmpNum = O.EmpNum
WHERE	YEAR(E.EmpBath) >= 1960 AND YEAR(E.EmpBath) <= 1975
ORDER BY	E.EmpBath DESC

GO

------------
-- �Ѯv�� --
------------
declare @birthEmp table
(
empNo int Primary key,
empName varchar(20),
emBir nvarchar(10)
)


declare @Orderlist table
(
orderNum varchar(8) not null,
empNo int
)

insert @birthEmp
select ���u�s��,�m�W,�X�ͤ��
from ���u
where datepart(year,convert(datetime,���u.�X�ͤ��)) between 1960 and 1975

insert @Orderlist
select �q��s��,���u�s��
from �q��
where �q��.���u�s�� in (select B.empNo from @birthEmp as B)

select B.*, O.orderNum
from @birthEmp as B inner join @Orderlist as O
on B.empNo = O.empNo
order by B.emBir DESC

GO


--===================================================================
-- �m��03 ����P�_(�浧)

DECLARE	@Season int
DECLARE	@SeasonSub varchar(20)
DECLARE	@OrderNum varchar(8)
DECLARE	@Count int

SET		@OrderNum = 94010104

SELECT	@Season = DATEPART(qq, CONVERT(date, �q��.�q�f���))
FROM	�q��
WHERE	�q��.�q��s�� = @OrderNum

SET		@Count = @@ROWCOUNT

PRINT	'�q���`���ơG' + CONVERT(varchar, @Count)
PRINT	@OrderNum +
		CASE
			WHEN @Season = 1 THEN ' --�Ĥ@�u�q�f--'
			WHEN @Season = 2 THEN ' --�ĤG�u�q�f--'
			WHEN @Season = 3 THEN ' --�ĤT�u�q�f--'
			WHEN @Season = 4 THEN ' --�ĥ|�u�q�f--'
		END

GO

--------------
-- �Ѯv��-1 --
--------------
DECLARE @�q��ƶq int
DECLARE @�q��s�� INT
DECLARE @�q�f��� VARCHAR(10)
SET @�q��s�� = '94010104'

SELECT @�q��s�� = �q��s��,@�q�f��� = �q�f���
  FROM �q��
  WHERE �q��s�� = @�q��s��

SELECT @�q��ƶq = @@ROWCOUNT

Print '�q���`���ơG' + convert(varchar,@�q��ƶq)
PRINT CONVERT(VARCHAR,@�q��s��) +
CASE
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@�q�f���))) = 1 THEN ' --�Ĥ@�u�q�f-- '
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@�q�f���))) = 2 THEN ' --�ĤG�u�q�f-- '
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@�q�f���))) = 3 THEN ' --�ĤT�u�q�f-- '
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@�q�f���))) = 4 THEN ' --�ĥ|�u�q�f-- '
         ELSE ' --�L�q�f-- '
      END
GO

--------------
-- �Ѯv��-2 --
--------------
DECLARE @�q��ƶq int
DECLARE @�q��s�� INT
DECLARE @�q�f��� VARCHAR(10)
SET @�q��s�� = '94010501'

SELECT @�q��s�� = �q��s��,@�q�f��� = �q�f���
  FROM �q��
  WHERE �q��s�� = @�q��s��

SELECT @�q��ƶq = @@ROWCOUNT

Print '�q���`���ơG' + convert(varchar,@�q��ƶq)
if DATEPART(QQ, CONVERT(DATETIME,@�q�f���)) = 1
print CONVERT(VARCHAR,@�q��s��) +' --�Ĥ@�u�q�f-- '
else if DATEPART(QQ, CONVERT(DATETIME,@�q�f���)) = 2
         Print CONVERT(VARCHAR,@�q��s��) +' --�ĤG�u�q�f-- '
		 else if DATEPART(QQ, CONVERT(DATETIME,@�q�f���)) = 3
                 Print CONVERT(VARCHAR,@�q��s��) +' --�ĤT�u�q�f-- '
				 else 
				      Print CONVERT(VARCHAR,@�q��s��) +' --�ĥ|�u�q�f-- '
GO