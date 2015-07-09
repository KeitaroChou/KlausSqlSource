-- Union or Intersec or except

SELECT	A.FirstName + ' ' + A.LastName AS 姓名,
		A.Title AS 職稱,
		--IIF(A.TitleOfCourtesy = 'Ms.','Madam','Gentleman'),--老師對稱呼代換的作法
		REPLACE(REPLACE(A.TitleOfCourtesy,'Ms.','Madam'),'Mr.','Gentleman') AS 稱呼,
		DATEDIFF(yy,A.BirthDate,GETDATE()) AS 年齡,
		DATEADD(yy,25,A.HireDate) AS 退休日期,
		A.City AS 居住城市,
		B.FirstName + ' ' + B.LastName AS 主管姓名
FROM	Employees AS A LEFT OUTER JOIN
		Employees AS B ON A.ReportsTo = B.EmployeeID
WHERE	A.City IN (
					SELECT	Employees.City
					FROM	Employees
					INTERSECT
					SELECT	Customers.City
					FROM	Customers
					INTERSECT
					SELECT	Suppliers.City
					FROM	Suppliers
					)