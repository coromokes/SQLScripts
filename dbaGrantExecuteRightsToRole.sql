CREATE ROLE db_executor

/* Grant stored procedure execute rights  to the role */
GRANT EXECUTE TO db_executor

/* Add a user to the db_executor role */
EXEC sp_addrolemember 'db_executor', 'kforce\CFAS Developers'

