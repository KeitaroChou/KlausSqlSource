-- �W�ҽm��01 (�_����Ʈw)
----�إߤ@�Ө禡�A�i��ܬY���u�Ҧ��Ȥ᪺�q���`�ơA�@���i�H�d�ߤ@�ӭ��u
----�إߤ@�Ө禡�A�i��ܥثe�����u��
----�إߤ@�Ө禡�A�i��ܨC�Y�u���q���T(�t�q�渹,�Ȥ�W,���u�W,�q����,���~�W,���,�ƶq,�馩),�@���i�d�ߤ@�u)
----�Х��g�{���A����ϥΤW�z�T�Ө禡
----�Ѧҡ�
----create function func_drink(@type varchar(10))
----returns int
----as
----begin

----RETURN (SELECT SUM(p.UnitsInStock) �w�s�`�q
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

ALTER FUNCTION Emp_Orders(@EmpID int = 0)	-- ���u�Ҧ��Ȥ᪺�q���`��
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

CREATE FUNCTION Emp_Totel(@EmpTotl int)		-- �ثe�����u��
RETURNS INT
AS
BEGIN
	RETURN (SELECT	COUNT(Emp.EmployeeID)
			FROM	Employees AS Emp
			)
END ;
-----------------------------------------------------------------------------------------

CREATE FUNCTION OrdersList_qq(@qq int)		-- �Y�u���q���T
RETURNS @Table TABLE (�ĴX�u�q�� int,
						�q��s�� int,
						�Ȥ᤽�q�W�� nvarchar(40),
						���u���W nvarchar(40),
						�q���� datetime,
						���~�W�� nvarchar(40),
						��� money,
						�ƶq smallint,
						�馩 real
						)
AS
BEGIN
	INSERT	@Table
	SELECT	DATEPART(qq, Ord.OrderDate) AS �ĴX�u�q��,
			Ord.OrderID AS �q��s��,
			Cut.CompanyName AS �Ȥ᤽�q�W��,
			Emp.FirstName + ' ' + Emp.LastName AS ���u���W,
			Ord.OrderDate AS �q����,
			Pro.ProductName AS ���~�W��,
			OD.UnitPrice AS ���,
			OD.Quantity AS �ƶq,
			OD.Discount AS �馩
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
PRINT	'�U���u�q���`�ƦC��----------------------------'


-- 03 test
SELECT	*
FROM	OrdersList_qq(2)



--==========================================================================================
------------
-- �Ѯv�� --
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
print N'�U���u�q���`�ƦC��-----------------------------'

while(@count < @empNum)
begin
SET @count=@count+1
select @Name=(firstname + ' ' + lastname) from Employees where employeeid = @count
SET @Total =dbo.func_ordernum(@count)

print N'���u�m�W�G'+@name+N',�q���`�ơG' + convert(varchar,@total)
end

SET @count = 0

print '                                                '
print N'�U�u�q���`�ƦC��-----------------------------'

while(@count < 4)
begin
SET @count=@count+1
select @QQnum=count(orderid)
from func_Qorderlist(@count)

if @count =1 
print N'�Ĥ@�u�G�q���`�ơG' + convert(varchar,@QQnum)
else if @count =2
print N'�ĤG�u�G�q���`�ơG' + convert(varchar,@QQnum)
else if @count =3
print N'�ĤT�u�G�q���`�ơG' + convert(varchar,@QQnum)
else 
print N'�ĥ|�u�G�q���`�ơG' + convert(varchar,@QQnum)
end


-- �W�ҽm��02 (CH15)
CREATE TRIGGER Test01
ON ���u
INSTEAD OF INSERT
AS

------------
-- �Ѯv�� --
------------
create trigger tri_inseremp
on ���u
instead of insert
as

print '�w����Ʒs�W�A���]�|�h��s�a�}'
update ���u
SET �a�} = ''
where ���u�s�� = (select �D�� from inserted)

insert ���u(���u�s��,�m�W,�D��)
select ���u�s��,�m�W,�D��
from inserted
go

insert ���u(���u�s��,�m�W,�D��)
values (202,'�����',6)


-- �W�ҽm��03 (CH16)
------------
-- �Ѯv�� --
------------
DECLARE cur_emp CURSOR
FOR
SELECT ���u�s��, �m�W,¾��
FROM ���u           

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

CLOSE cur_emp           -- ������ƫ���cur_Products
DEALLOCATE cur_emp     -- ������ƫ���cur_Products
PRINT @empnamelist