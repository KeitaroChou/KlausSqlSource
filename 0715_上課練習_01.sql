-- 上課練習01 (北風資料庫)
----建立一個函式，可顯示某員工所有客戶的訂單總數，一次可以查詢一個員工
----建立一個函式，可顯示目前的員工數
----建立一個函式，可顯示每某季的訂單資訊(含訂單號,客戶名,員工名,訂單日期,產品名,單價,數量,折扣),一次可查詢一季)
----請任寫程式，能夠使用上述三個函式
----參考↓
----create function func_drink(@type varchar(10))
----returns int
----as
----begin

----RETURN (SELECT SUM(p.UnitsInStock) 庫存總量
----FROM Categories c
----INNER JOIN Products p ON p.CategoryID = c.CategoryID
----WHERE c.CategoryName = @type
----GROUP BY c.CategoryName)
----end ;
----go

----declare @stock int = 0
----select @stock=dbo.func_drink('Produce')
----print @stock

----go

ALTER FUNCTION Emp_Orders(@EmpID int = 0)	-- 員工所有客戶的訂單總數
RETURNS INT
AS
BEGIN
	RETURN (SELECT	COUNT(Ord.OrderID) AS OrdTot
			FROM	Employees AS Emp JOIN Orders AS Ord ON Emp.EmployeeID = Ord.EmployeeID
			WHERE	Emp.EmployeeID = @EmpID
			GROUP BY	Emp.EmployeeID
			)
END ;
-----------------------------------------------------------------------------------------

CREATE FUNCTION Emp_Totel(@EmpTotl int)		-- 目前的員工數
RETURNS INT
AS
BEGIN
	RETURN (SELECT	COUNT(Emp.EmployeeID)
			FROM	Employees AS Emp
			)
END ;
-----------------------------------------------------------------------------------------

CREATE FUNCTION OrdersList_qq(@qq int)		-- 某季的訂單資訊
RETURNS @Table TABLE (第幾季訂單 int,
						訂單編號 int,
						客戶公司名稱 nvarchar(40),
						員工全名 nvarchar(40),
						訂單日期 datetime,
						產品名稱 nvarchar(40),
						單價 money,
						數量 smallint,
						折扣 real
						)
AS
BEGIN
	INSERT	@Table
	SELECT	DATEPART(qq, Ord.OrderDate) AS 第幾季訂單,
			Ord.OrderID AS 訂單編號,
			Cut.CompanyName AS 客戶公司名稱,
			Emp.FirstName + ' ' + Emp.LastName AS 員工全名,
			Ord.OrderDate AS 訂單日期,
			Pro.ProductName AS 產品名稱,
			OD.UnitPrice AS 單價,
			OD.Quantity AS 數量,
			OD.Discount AS 折扣
	FROM	Orders AS Ord JOIN [Order Details] AS OD ON Ord.OrderID = OD.OrderID
			JOIN Customers AS Cut ON Ord.CustomerID = Cut.CustomerID
			JOIN Employees AS Emp ON Ord.EmployeeID = Emp.EmployeeID
			JOIN Products AS Pro ON Pro.ProductID = OD.ProductID
	WHERE	DATEPART(qq, Ord.OrderDate) = @qq
RETURN
END ;
--==========================================================================================

-- 10 test
DECLARE @Count int = 0
DECLARE @EmpID int = 0
DECLARE @OrdTotl int = 0

SELECT	Emp.FirstName + ' ' + Emp.LastName
FROM	Employees AS Emp
WHERE	dbo.Emp_Orders(@EmpID)

WHILE ()
PRINT	'各員工訂單總數列表----------------------------'


-- 03 test
SELECT	*
FROM	OrdersList_qq(2)



--==========================================================================================
------------
-- 老師解 --
------------
create function func_ordernum(@empno int=0)
returns int
as
begin

return(
select count(o.orderid) 
from employees as e inner join orders as o 
on e.employeeid = o.employeeid 
where e.EmployeeID = @empno
)

end;
go

create function func_empnumber()
returns int
as
begin

return(
select max(employeeid)
from Employees
)

end;
go

alter function func_Qorderlist(@QQ int =1)
returns @Qorder table ( orderid int,
                       cusName nvarchar(max),
					   empName nvarchar(max),
					   orderdate datetime,
					   proName nvarchar(max),
					   UPrice money,
					   Qty smallint,
					   discount real)

as
begin

insert @Qorder
select 
o.OrderID,
c.CompanyName,
e.FirstName+' '+e.LastName as EmployeeName,
o.OrderDate,
p.ProductName,
od.UnitPrice,
od.Quantity,
od.Discount
from Employees as e inner join orders as o
on e.EmployeeID = o.EmployeeID inner join Customers as c
on o.CustomerID = c.CustomerID inner join [Order Details] as OD
on o.OrderID = od.OrderID inner join Products as P
on od.ProductID = p.ProductID
where datepart(qq,o.OrderDate) =@QQ


Return
end;
go

declare @empNum int = 0
declare @count int = 0
declare @Name varchar(20) = ''
declare @Total int = 0
declare @QQNum int = 0

SET @empNum = dbo.func_empnumber()
   
print '                                                '
print N'各員工訂單總數列表-----------------------------'

while(@count < @empNum)
begin
SET @count=@count+1
select @Name=(firstname + ' ' + lastname) from Employees where employeeid = @count
SET @Total =dbo.func_ordernum(@count)

print N'員工姓名：'+@name+N',訂單總數：' + convert(varchar,@total)
end

SET @count = 0

print '                                                '
print N'各季訂單總數列表-----------------------------'

while(@count < 4)
begin
SET @count=@count+1
select @QQnum=count(orderid)
from func_Qorderlist(@count)

if @count =1 
print N'第一季：訂單總數：' + convert(varchar,@QQnum)
else if @count =2
print N'第二季：訂單總數：' + convert(varchar,@QQnum)
else if @count =3
print N'第三季：訂單總數：' + convert(varchar,@QQnum)
else 
print N'第四季：訂單總數：' + convert(varchar,@QQnum)
end


-- 上課練習02 (CH15)
CREATE TRIGGER Test01
ON 員工
INSTEAD OF INSERT
AS

------------
-- 老師解 --
------------
create trigger tri_inseremp
on 員工
instead of insert
as

print '已有資料新增，但也會去更新地址'
update 員工
SET 地址 = ''
where 員工編號 = (select 主管 from inserted)

insert 員工(員工編號,姓名,主管)
select 員工編號,姓名,主管
from inserted
go

insert 員工(員工編號,姓名,主管)
values (202,'郭國王',6)


-- 上課練習03 (CH16)
------------
-- 老師解 --
------------
DECLARE cur_emp CURSOR
FOR
SELECT 員工編號, 姓名,職稱
FROM 員工           

DECLARE @empID int ,
        @empname varchar(30) ,
        @empTitle varchar(30) ,
		@cntTotal int,
        @empNameList varchar(max)
        
SET @cntTotal = 0
SET @empNameList = ''            

OPEN cur_emp            
 
FETCH NEXT FROM cur_emp INTO @empID,@empname, @empTitle
WHILE (@@FETCH_STATUS = 0)
BEGIN
    if (@empid %2 <> 0)
	begin
    SET @empNameList = @empNameList + (convert(varchar,@empid)+'-'+@empname) + ', '
    SET @cntTotal = @cntTotal + 1
	end
    FETCH NEXT FROM cur_emp INTO @empID,@empname, @empTitle
END

CLOSE cur_emp           -- 關閉資料指標cur_Products
DEALLOCATE cur_emp     -- 移除資料指標cur_Products
PRINT @empnamelist