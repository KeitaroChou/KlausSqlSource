-- �W�ҽm��01 (�ۭq�w�s�{��) (CH14)
-- Q�G��X�{�b�~�֤j����w�~�֪��H��

ALTER PROC usp_oldCount
@old int = 80
AS
SELECT	COUNT(DATEDIFF(yy, CONVERT(date, E.�X�ͤ��), GETDATE())) AS �~�֤j����w�~�֪��H��
FROM	���u AS E
WHERE	DATEDIFF(yy, E.�X�ͤ��, GETDATE()) >= @old
GO

EXEC usp_oldCount 50
GO

------------
-- �Ѯv�� --
------------
create proc usp_oldempcount
@age int=0
as

select count(���u�s��) as �H��
from ���u
where datediff(yy,convert(datetime,�X�ͤ��),getdate()) >= @age
go

exec usp_oldempcount 50
go


-- �W�ҽm��02
-- Q�G�C�X�Ȥ�Ψ����Ӥ��A���b���w�a�ϸ̪����q

CREATE PROC usp_FindCityList
@Type VARCHAR(10) = '�Ȥ�',
@City VARCHAR(10) = '�x�_'
AS
IF	@Type = '�Ȥ�'
	BEGIN
		SELECT	*
		FROM	�Ȥ�
		WHERE	�Ȥ�.�a�} LIKE '%' + @City + '%'
	END
	ELSE IF	@Type = '������'
		BEGIN
			SELECT	*
			FROM	������
			WHERE	������.�a�} LIKE '%' + @City + '%'
		END
GO

EXEC usp_FindCityList '�Ȥ�', '�x��'

------------
-- �Ѯv�� --
------------
create proc usp_findcitylist
@type varchar(10) = '�Ȥ�',
@city varchar(10) = '�x�_'
as

if @type='�Ȥ�'
   begin
		select *
		from �Ȥ�
		where �a�} like '%'+@city+'%'
   end
else if @type='������'
        begin
		     select *
             from ������
             where �a�} like '%'+@city+'%'
        end
go

exec usp_findcitylist
go

exec usp_findcitylist '������','�̪F'
go


-- �W�ҽm��03
-- Q�G��J�Y�@���~���O�W�١A�D�o�����O�Ҧ����~���ت��̰���ĳ����P�̧C��ĳ��������t

CREATE PROC usp_Temp
@Enter varchar(20) = '�G��',
@OutPut int OUTPUT,
@OutPut2 varchar(20) OUTPUT
AS
SET NOCOUNT ON
SET	@OutPut2 = @Enter
SELECT	@OutPut = (MAX(���~���.��ĳ���)-MIN(���~���.��ĳ���))
FROM	���~���O JOIN ���~��� ON ���~���O.���O�s�� = ���~���.���O�s��
WHERE	���~���O.���O�W�� = @Enter
GO

DECLARE	@OutPut int
DECLARE	@OutPut2 varchar(20)
EXEC	usp_Temp default, @OutPut OUTPUT, @OutPut2 OUTPUT
PRINT	'���~���O���u' + @OutPut2 + '�v���Ҧ����~�A�u�̰�����v�P�u�̧C����v�����t���G' + CAST(@OutPut AS VARCHAR)
GO

------------
-- �Ѯv�� --
------------
Create PROC usp_diffprice
@pcategory varchar(10) = '',
@Diff_Price int OUTPUT  
AS
Declare @High_Price int    
Declare @Low_Price int    
Select @High_Price=MAX(��ĳ���),@Low_Price=Min(��ĳ���)
From ���~��� as p inner join ���~���O as pc
on p.���O�s�� = pc.���O�s��
where pc.���O�W�� Like '%'+ @PCategory+'%'

set @Diff_Price=@High_Price-@Low_Price
go

declare @Diff_Price int =0
declare @PCategory varchar(20) ='����'
exec usp_diffprice @PCategory, @Diff_Price output
print '���~���O���u'+@PCategory+'�v���Ҧ����~�A�u�̰�����v�P�u�̧C����v�����t���G' + convert(varchar,@Diff_Price)
go


-- �W�ҽm��04
-- Q�G��J�a�ϦW�١A��M�P�a�Ϫ����u�m�W¾�٦a�}�P�D�ީm�W¾�١A�æL�X�Ӧa�ϭ��u���h�֤H

CREATE PROC usp_FindCityList02
@Enter varchar(20) = '�x�_',
@OutPut int OUTPUT,
@OutPut2 varchar(20) OUTPUT
AS
SET NOCOUNT ON
SET	@OutPut2 = @Enter
SELECT	�U��.�m�W, �U��.¾��, �U��.�a�}, �W�q.�m�W
FROM	���u AS �U�� LEFT OUTER JOIN ���u AS �W�q ON �U��.�D�� = �W�q.���u�s��
WHERE	�U��.�a�} like '%'+ @Enter +'%'
SET	@OutPut = @@ROWCOUNT
GO

DECLARE	@OutPut int
DECLARE	@OutPut2 varchar(20)
EXEC	usp_FindCityList02 default, @OutPut OUTPUT, @OutPut2 OUTPUT
PRINT	'���u' + CAST(@OutPut AS VARCHAR) + '�v�Ӧ�b' + @OutPut2 + '�ϰ쪺���u��ƻP�D�޸��'
GO

------------
-- �Ѯv�� --
------------
Alter PROC usp_manager
@addr varchar(10) = '',
@count int output
AS

SET NOCOUNT ON

select e.�m�W as ���u�m�W,e.¾�� as ���u¾�� ,e.�a�} as ���u�a�},m.�m�W as �D�ީm�W,m.¾�� as �D��¾��
from ���u as e inner join ���u as m
on e.�D��=m.���u�s��
where e.�a�} like '%'+ @addr +'%'

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
declare @addr varchar(10) = '�x��'
declare @count int = 0
exec @errcode = usp_manager @addr, @count output


if @errcode = 0
print '���u'+convert(varchar,@count)+'�ӡv��b'+@addr+'�ϰ쪺���u��ƻP�D�޸��'
else
print '���u'+convert(varchar,@count)+'�ӡv��b'+@addr+'�ϰ쪺���u��ƻP�D�޸��'
go


-- �W�ҽm��05 (�_����Ʈw)
-- �U��אּ�ۭq�禡

-- �D�X�Ҧ��q�椤�A��l�����馩�֩�25��᪺����̤p�̡A�󰪪����
----SELECT	*
----FROM	Products
----WHERE UnitPrice > ANY (SELECT UnitPrice
----						FROM [Order Details]
----						WHERE Discount >= .25);
------------------------------------------------------
-- �D�X�Ҧ��q�椤�A�馩�֩�25�骺���~
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
