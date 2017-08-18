CREATE TRIGGER [deny_customer_db_drop]
ON ALL SERVER
FOR DROP_database
AS
IF IS_SRVROLEMEMBER('sysadmin') = 0
BEGIN
    PRINT 'You are not permitted to drop this database'
    ROLLBACK
END
GO

