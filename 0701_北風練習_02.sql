-- Union or Intersec or except

SELECT	A.FirstName + ' ' + A.LastName AS �m�W,
		A.Title AS ¾��,
		--IIF(A.TitleOfCourtesy = 'Ms.','Madam','Gentleman'),--�Ѯv��٩I�N�����@�k
		REPLACE(REPLACE(A.TitleOfCourtesy,'Ms.','Madam'),'Mr.','Gentleman') AS �٩I,
		DATEDIFF(yy,A.BirthDate,GETDATE()) AS �~��,
		DATEADD(yy,25,A.HireDate) AS �h����,
		A.City AS �~����,
		B.FirstName + ' ' + B.LastName AS �D�ީm�W
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