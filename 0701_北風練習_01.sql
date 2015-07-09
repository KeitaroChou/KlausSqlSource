-- CTE

; WITH �w�s (���~����, �`�w�s�q, �����w�s)
AS (
	SELECT 	Categories.CategoryName,
			SUM(Products.UnitsInStock),
			SUM(Products.UnitsInStock) / COUNT(Products.UnitsInStock)
	FROM	Categories JOIN Products ON Categories.CategoryID = Products.CategoryID
	WHERE	Categories.CategoryID = 1
	GROUP BY	Categories.CategoryName
	)
SELECT	���~����, �`�w�s�q, �����w�s
FROM	�w�s
GO


;WITH �w�s��(���~����,�w�s�q)
AS (
	SELECT	C.CategoryName,
			P.UnitsInStock 
	FROM	Categories AS C INNER JOIN
			Products AS P ON P.CategoryID = C.CategoryID
	)
SELECT	���~����,
		SUM(�w�s�q) AS �`�w�s�q,
		AVG(�w�s�q) AS �����w�s
FROM	�w�s��
WHERE	���~���� = 'Beverages'
GROUP BY	���~����