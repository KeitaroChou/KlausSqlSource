-- 上課練習01 (自訂預存程序) (CH14)
-- Q：算出現在年齡大於指定年齡的人數

ALTER PROC usp_oldCount
@old int = 80
AS
SELECT	COUNT(DATEDIFF(yy, CONVERT(date, E.出生日期), GETDATE())) AS 年齡大於指定年齡的人數
FROM	員工 AS E
WHERE	DATEDIFF(yy, E.出生日期, GETDATE()) >= @old
GO

EXEC usp_oldCount 50
GO

------------
-- 老師解 --
------------
create proc usp_oldempcount
@age int=0
as

select count(員工編號) as 人數
from 員工
where datediff(yy,convert(datetime,出生日期),getdate()) >= @age
go

exec usp_oldempcount 50
go


-- 上課練習02
-- Q：列出客戶或供應商中，有在指定地區裡的公司

CREATE PROC usp_FindCityList
@Type VARCHAR(10) = '客戶',
@City VARCHAR(10) = '台北'
AS
IF	@Type = '客戶'
	BEGIN
		SELECT	*
		FROM	客戶
		WHERE	客戶.地址 LIKE '%' + @City + '%'
	END
	ELSE IF	@Type = '供應商'
		BEGIN
			SELECT	*
			FROM	供應商
			WHERE	供應商.地址 LIKE '%' + @City + '%'
		END
GO

EXEC usp_FindCityList '客戶', '台中'

------------
-- 老師解 --
------------
create proc usp_findcitylist
@type varchar(10) = '客戶',
@city varchar(10) = '台北'
as

if @type='客戶'
   begin
		select *
		from 客戶
		where 地址 like '%'+@city+'%'
   end
else if @type='供應商'
        begin
		     select *
             from 供應商
             where 地址 like '%'+@city+'%'
        end
go

exec usp_findcitylist
go

exec usp_findcitylist '供應商','屏東'
go


-- 上課練習03
-- Q：輸入某一產品類別名稱，求得該類別所有產品項目的最高建議單價與最低建議單價的價差

CREATE PROC usp_Temp
@Enter varchar(20) = '果汁',
@OutPut int OUTPUT,
@OutPut2 varchar(20) OUTPUT
AS
SET NOCOUNT ON
SET	@OutPut2 = @Enter
SELECT	@OutPut = (MAX(產品資料.建議單價)-MIN(產品資料.建議單價))
FROM	產品類別 JOIN 產品資料 ON 產品類別.類別編號 = 產品資料.類別編號
WHERE	產品類別.類別名稱 = @Enter
GO

DECLARE	@OutPut int
DECLARE	@OutPut2 varchar(20)
EXEC	usp_Temp default, @OutPut OUTPUT, @OutPut2 OUTPUT
PRINT	'產品類別為「' + @OutPut2 + '」的所有產品，「最高單價」與「最低單價」的價差為：' + CAST(@OutPut AS VARCHAR)
GO

------------
-- 老師解 --
------------
Create PROC usp_diffprice
@pcategory varchar(10) = '',
@Diff_Price int OUTPUT  
AS
Declare @High_Price int    
Declare @Low_Price int    
Select @High_Price=MAX(建議單價),@Low_Price=Min(建議單價)
From 產品資料 as p inner join 產品類別 as pc
on p.類別編號 = pc.類別編號
where pc.類別名稱 Like '%'+ @PCategory+'%'

set @Diff_Price=@High_Price-@Low_Price
go

declare @Diff_Price int =0
declare @PCategory varchar(20) ='茶類'
exec usp_diffprice @PCategory, @Diff_Price output
print '產品類別為「'+@PCategory+'」的所有產品，「最高單價」與「最低單價」的價差為：' + convert(varchar,@Diff_Price)
go


-- 上課練習04
-- Q：輸入地區名稱，找尋同地區的員工姓名職稱地址與主管姓名職稱，並印出該地區員工有多少人

CREATE PROC usp_FindCityList02
@Enter varchar(20) = '台北',
@OutPut int OUTPUT,
@OutPut2 varchar(20) OUTPUT
AS
SET NOCOUNT ON
SET	@OutPut2 = @Enter
SELECT	下屬.姓名, 下屬.職稱, 下屬.地址, 上司.姓名
FROM	員工 AS 下屬 LEFT OUTER JOIN 員工 AS 上司 ON 下屬.主管 = 上司.員工編號
WHERE	下屬.地址 like '%'+ @Enter +'%'
SET	@OutPut = @@ROWCOUNT
GO

DECLARE	@OutPut int
DECLARE	@OutPut2 varchar(20)
EXEC	usp_FindCityList02 default, @OutPut OUTPUT, @OutPut2 OUTPUT
PRINT	'有「' + CAST(@OutPut AS VARCHAR) + '」個住在' + @OutPut2 + '區域的員工資料與主管資料'
GO

------------
-- 老師解 --
------------
Alter PROC usp_manager
@addr varchar(10) = '',
@count int output
AS

SET NOCOUNT ON

select e.姓名 as 員工姓名,e.職稱 as 員工職稱 ,e.地址 as 員工地址,m.姓名 as 主管姓名,m.職稱 as 主管職稱
from 員工 as e inner join 員工 as m
on e.主管=m.員工編號
where e.地址 like '%'+ @addr +'%'

SET @count=@@ROWCOUNT

if @count = 0
   begin
   return 1
   end
   else
       begin
       return 0
	   end
go

declare @errcode int =0
declare @addr varchar(10) = '台中'
declare @count int = 0
exec @errcode = usp_manager @addr, @count output


if @errcode = 0
print '有「'+convert(varchar,@count)+'個」住在'+@addr+'區域的員工資料與主管資料'
else
print '有「'+convert(varchar,@count)+'個」住在'+@addr+'區域的員工資料與主管資料'
go


-- 上課練習05 (北風資料庫)
-- 下方改為自訂函式

-- 挑出所有訂單中，原始單價比折扣少於25折後的單價最小者，更高的單價
----SELECT	*
----FROM	Products
----WHERE UnitPrice > ANY (SELECT UnitPrice
----						FROM [Order Details]
----						WHERE Discount >= .25);
------------------------------------------------------
-- 挑出所有訂單中，折扣少於25折的產品
----SELECT	*
----FROM	Products
----WHERE	ProductID IN (SELECT ProductID
----						FROM [Order Details]
----						WHERE Discount >= .25);
-- ===================================================
ALTER FUNCTION Test01 ()
RETURNS	TABLE
AS
	RETURN	(SELECT *
			FROM	Products
			WHERE	UnitPrice > ANY (SELECT UnitPrice
									FROM [Order Details]
									WHERE Discount >= .25)
			)
;
GO

SELECT	*
FROM	dbo.Test01()
GO
------------------------------------------------------
CREATE FUNCTION Test02 ()
RETURNS	TABLE
AS
	RETURN	(SELECT *
			FROM Products 
			WHERE ProductID IN (SELECT ProductID
								FROM [Order Details]
								WHERE Discount >= .25)
			)
;
GO

SELECT	*
FROM	dbo.Test02()
GO
