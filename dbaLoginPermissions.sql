EXECUTE AS LOGIN = 'KFORCE\WZorilla';
go

SELECT HAS_PERMS_BY_NAME(db_name(), 'DATABASE', 'Any');
--Verify the execution context is now set.
SELECT SUSER_NAME(), USER_NAME();

--Test execution 
Use RMDev

select top 10 C.FirstName from [dbo].[Candidates] C

--The following REVERT statements will reset the execution context to the previous context.
REVERT;
