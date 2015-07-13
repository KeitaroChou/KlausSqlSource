-- �m��01 - �E�E���k��(�ϥ� WHILE �P IF)

DECLARE @A INT
DECLARE @B INT
SET @A = 1
SET @B = 1

WHILE	@A <= 9
	BEGIN
		PRINT	CAST(@A AS VARCHAR) + ' * ' + 
				CAST(@B AS VARCHAR) + ' = ' + 
				CAST(@A*@B AS VARCHAR)	-- �L�X A * B = A*B
		SET @B = @B + 1
		IF @B > 9
			BEGIN
				SET @A = @A + 1
				SET @B = 1
				--CONTINUE	-- �O�_���X�O�ѤW�� WHILE ����A�ҥH�o�̤����ϥ� CONTINUE
			END
	END
GO


-- �m��01 - �E�E���k��(�g�J��ƪ�)

--------------
-- �Ѯv��-1 --
--------------
DECLARE @CNTER INT
DECLARE @CNTER1 INT
DECLARE @NINE TABLE ( NINERIGHT INT NULL,
					  NINELEFT INT NULL,
					  NINEMLP INT NULL)
SET @CNTER = 1

WHILE @CNTER <= 9 
  BEGIN
  SET @CNTER1 = 1

       WHILE @CNTER1 <= 9 
         BEGIN

		      INSERT @NINE(NINERIGHT,NINELEFT,NINEMLP)
			  VALUES (@CNTER,@CNTER1,@CNTER*@CNTER1)
						  
			  SET @CNTER1=@CNTER1+1
         END
    SET @CNTER = @CNTER + 1
  END

IF EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='NINETABLE')
   DROP TABLE NINETABLE
  
SELECT * INTO NINETABLE
FROM @NINE

SELECT NINERIGHT AS �k�n��, NINELEFT AS ������, NINEMLP AS ���n
FROM NINETABLE

GO

--------------
-- �Ѯv��-2 --
--------------
DECLARE @CNTER INT
DECLARE @CNTER1 INT
DECLARE @NINE TABLE ( NINERIGHT INT NULL,
					  NINELEFT INT NULL,
					  NINEMLP INT NULL)
SET @CNTER = 1

WHILE @CNTER <= 9 
  BEGIN
  SET @CNTER1 = 1

       WHILE @CNTER1 <= 9 
         BEGIN

		      INSERT @NINE(NINERIGHT,NINELEFT,NINEMLP)
			  VALUES (@CNTER,@CNTER1,@CNTER*@CNTER1)
						  
			  SET @CNTER1=@CNTER1+1
         END
    SET @CNTER = @CNTER + 1
  END

IF EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='NINETABLE')
   DROP TABLE NINETABLE
  
CREATE TABLE NINETABLE ( NINERIGHT INT NULL,
					  NINELEFT INT NULL,
					  NINEMLP INT NULL)

INSERT NINETABLE
SELECT *
FROM @NINE

SELECT NINERIGHT AS �k�n��, NINELEFT AS ������, NINEMLP AS ���n
FROM NINETABLE

GO


-- 1 �[�� 100 �çP�_�`�M���_�Ʃΰ���

DECLARE @A INT
DECLARE @B INT
DECLARE @S VARCHAR(20)

SET	@A = 1
SET @B = 1

WHILE @A <= 100 
	BEGIN
		IF @B % 2 = 1	-- % ���D�l��
			SET @S = '�_�� '
		ELSE
			SET @S = '���� '
		PRINT	'1~100 �M�P�_ ' + @S + CAST(@B AS VARCHAR)
		SET	@A = @A + 1
		SET	@B = @B + @A
		
	END
GO

------------
-- �Ѯv�� --
------------
DECLARE @COUNT INT = 1
DECLARE @SUM INT = 0

WHILE @COUNT <=100 
  BEGIN
       SET @SUM=@SUM + @COUNT
	   
	   IF @SUM % 2 = 0
	      PRINT '1~100�`�M����=' + CAST(@SUM AS VARCHAR)
		  ELSE
		  PRINT '1~100�`�M�_��=' + CAST(@SUM AS VARCHAR)
       
	   SET @COUNT=@COUNT+1
  END
 GO


-- MERGE �m��

IF EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='Tmp')		-- �M�����e����Ӧs�b����ƪ�'Tmp'
	DROP TABLE Tmp

CREATE TABLE Tmp (�����ӽs�� VARCHAR(5) NULL,
					�����ӦW�� VARCHAR(50) NULL,
					�p���H VARCHAR(30) NULL,
					�p���H¾�� VARCHAR(30) NULL,
					�p���H�ʧO VARCHAR(2) NULL,
					�l���ϸ� VARCHAR(10) NULL,
					�a�} VARCHAR(60) NULL,
					�q�� VARCHAR(24) NULL)

INSERT	Tmp
SELECT	*
FROM	������

MERGE	Tmp AS T
USING	�Ȥ� AS B
ON		T.�����ӦW�� = B.���q�W��
WHEN	MATCHED THEN
			DELETE
WHEN	NOT MATCHED BY TARGET AND B.���q�W�� LIKE '%���q%' THEN		-- WHEN NOT MATCHED �l�y���u���\�ӷ���Ʀ�M�l�y�d�򤤪���Ʀ�
			INSERT	(�����ӽs��, �����ӦW��, �p���H, �p���H¾��, �p���H�ʧO, �l���ϸ�, �a�}, �q��)
			VALUES	(B.�Ȥ�s��, B.���q�W��, B.�p���H, B.�p���H¾��, B.�p���H�ʧO, B.�l���ϸ�, B.�a�}, B.�q��)

OUTPUT	$ACTION, INSERTED.*, DELETED.*		-- ��ܦ����次�ʩҦ��Q INSERT �P DELETE ����ƦC
;
GO