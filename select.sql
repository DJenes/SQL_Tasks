SELECT *
FROM HumanResources.Department
WHERE groupname ilike '%Research%'
ORDER BY departmentid DESC;

SELECT BusinessEntityId,JobTitle,BirthDate,Gender
FROM HumanResources.Employee
WHERE BusinessEntityId >= 50 AND BusinessEntityId <= 100

SELECT BusinessEntityId,JobTitle,BirthDate,Gender
FROM HumanResources.Employee
WHERE date_part('year',BirthDate) = 1980 OR date_part('year',BirthDate) = 1990;

SELECT BusinessEntityId, ShiftId
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY BusinessEntityId, ShiftId

SELECT BusinessEntityId, ShiftId, COUNT(*)
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY BusinessEntityId, ShiftId
HAVING COUNT(*) >= 2;
