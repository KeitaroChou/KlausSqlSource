-- 練習01 - 使用變數

DECLARE @員工編號 varchar(10),
		@員工名稱 varchar(10),
		@員工獎勵年度 varchar(10)

SET		@員工編號 = ''
SET		@員工名稱 = ''
SET		@員工獎勵年度 = ''

SELECT	@員工編號 = 員工.員工編號,
		@員工名稱 = 員工.姓名,
		@員工獎勵年度 = 員工獎勵金.年度
FROM	員工 JOIN 員工獎勵金 ON 員工.員工編號 = 員工獎勵金.員工編號
WHERE	員工.員工編號 = 11

PRINT	'員工編號：' + @員工編號
PRINT	'員工姓名：' + @員工名稱
PRINT	'獎勵金年度：' + @員工獎勵年度

GO

------------
-- 老師解 --
------------
DECLARE	@EmpNum int
DECLARE	@EmpName varchar(20)
DECLARE	@EmpPrizeYear int
DECLARE	@setEmpNum int

SET		@EmpNum = 0
SET		@EmpName = ''
SET		@EmpPrizeYear = 0
SET		@setEmpNum = 11

SELECT	@EmpNum = 員工編號,
		@EmpName = 姓名
FROM	員工
WHERE	員工編號 = @setEmpNum

SELECT	@EmpPrizeYear = 年度
FROM	員工獎勵金
WHERE	員工編號 = @setEmpNum

PRINT	'員工編號：' + CONVERT(varchar, @EmpNum)
PRINT	'員工姓名：' + @EmpName
PRINT	'獎勵金年度：' + CONVERT(varchar, @EmpPrizeYear)

GO


--===================================================================
-- 練習02 - 使用 Table 型別變數

DECLARE	@Emp TABLE (EmpNum int Primary key,
					EmpName varchar(20),
					EmpBath date)

DECLARE @Ord TABLE (OrderNum varchar(8) Primary key,
					EmpNum int)

INSERT	@Emp
SELECT	員工編號, 姓名, 出生日期
FROM	員工

INSERT	@Ord
SELECT	訂單編號, 員工編號
FROM	訂單

SELECT	E.EmpNum, EmpName,E.EmpBath, O.OrderNum
FROM	@Emp AS E JOIN @Ord AS O ON E.EmpNum = O.EmpNum
WHERE	YEAR(E.EmpBath) >= 1960 AND YEAR(E.EmpBath) <= 1975
ORDER BY	E.EmpBath DESC

GO

------------
-- 老師解 --
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
select 員工編號,姓名,出生日期
from 員工
where datepart(year,convert(datetime,員工.出生日期)) between 1960 and 1975

insert @Orderlist
select 訂單編號,員工編號
from 訂單
where 訂單.員工編號 in (select B.empNo from @birthEmp as B)

select B.*, O.orderNum
from @birthEmp as B inner join @Orderlist as O
on B.empNo = O.empNo
order by B.emBir DESC

GO


--===================================================================
-- 練習03 條件判斷(單筆)

DECLARE	@Season int
DECLARE	@SeasonSub varchar(20)
DECLARE	@OrderNum varchar(8)
DECLARE	@Count int

SET		@OrderNum = 94010104

SELECT	@Season = DATEPART(qq, CONVERT(date, 訂單.訂貨日期))
FROM	訂單
WHERE	訂單.訂單編號 = @OrderNum

SET		@Count = @@ROWCOUNT

PRINT	'訂單總筆數：' + CONVERT(varchar, @Count)
PRINT	@OrderNum +
		CASE
			WHEN @Season = 1 THEN ' --第一季訂貨--'
			WHEN @Season = 2 THEN ' --第二季訂貨--'
			WHEN @Season = 3 THEN ' --第三季訂貨--'
			WHEN @Season = 4 THEN ' --第四季訂貨--'
		END

GO

--------------
-- 老師解-1 --
--------------
DECLARE @訂單數量 int
DECLARE @訂單編號 INT
DECLARE @訂貨日期 VARCHAR(10)
SET @訂單編號 = '94010104'

SELECT @訂單編號 = 訂單編號,@訂貨日期 = 訂貨日期
  FROM 訂單
  WHERE 訂單編號 = @訂單編號

SELECT @訂單數量 = @@ROWCOUNT

Print '訂單總筆數：' + convert(varchar,@訂單數量)
PRINT CONVERT(VARCHAR,@訂單編號) +
CASE
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@訂貨日期))) = 1 THEN ' --第一季訂貨-- '
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@訂貨日期))) = 2 THEN ' --第二季訂貨-- '
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@訂貨日期))) = 3 THEN ' --第三季訂貨-- '
         WHEN (DATEPART(QQ, CONVERT(DATETIME,@訂貨日期))) = 4 THEN ' --第四季訂貨-- '
         ELSE ' --無訂貨-- '
      END
GO

--------------
-- 老師解-2 --
--------------
DECLARE @訂單數量 int
DECLARE @訂單編號 INT
DECLARE @訂貨日期 VARCHAR(10)
SET @訂單編號 = '94010501'

SELECT @訂單編號 = 訂單編號,@訂貨日期 = 訂貨日期
  FROM 訂單
  WHERE 訂單編號 = @訂單編號

SELECT @訂單數量 = @@ROWCOUNT

Print '訂單總筆數：' + convert(varchar,@訂單數量)
if DATEPART(QQ, CONVERT(DATETIME,@訂貨日期)) = 1
print CONVERT(VARCHAR,@訂單編號) +' --第一季訂貨-- '
else if DATEPART(QQ, CONVERT(DATETIME,@訂貨日期)) = 2
         Print CONVERT(VARCHAR,@訂單編號) +' --第二季訂貨-- '
		 else if DATEPART(QQ, CONVERT(DATETIME,@訂貨日期)) = 3
                 Print CONVERT(VARCHAR,@訂單編號) +' --第三季訂貨-- '
				 else 
				      Print CONVERT(VARCHAR,@訂單編號) +' --第四季訂貨-- '
GO