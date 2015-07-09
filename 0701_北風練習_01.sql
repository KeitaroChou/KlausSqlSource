-- CTE

; WITH 庫存 (產品類型, 總庫存量, 平均庫存)
AS (
	SELECT 	Categories.CategoryName,
			SUM(Products.UnitsInStock),
			SUM(Products.UnitsInStock) / COUNT(Products.UnitsInStock)
	FROM	Categories JOIN Products ON Categories.CategoryID = Products.CategoryID
	WHERE	Categories.CategoryID = 1
	GROUP BY	Categories.CategoryName
	)
SELECT	產品類型, 總庫存量, 平均庫存
FROM	庫存
GO


;WITH 庫存表(產品類型,庫存量)
AS (
	SELECT	C.CategoryName,
			P.UnitsInStock 
	FROM	Categories AS C INNER JOIN
			Products AS P ON P.CategoryID = C.CategoryID
	)
SELECT	產品類型,
		SUM(庫存量) AS 總庫存量,
		AVG(庫存量) AS 平均庫存
FROM	庫存表
WHERE	產品類型 = 'Beverages'
GROUP BY	產品類型