--!!!!!!!!!!!!!!check instant file initialization!!!!!!!!!!!!!!!!

USE master;
GO
ALTER DATABASE tempdb 
MODIFY FILE (NAME = tempdev, FILENAME = 'C:\ClusterStorage\CSV_SysData01\MSSQL12.NIVSSQ20\MSSQL\Data\tempdb.mdf', SIZE = 250MB, MAXSIZE = 2000MB, FILEGROWTH = 250MB );
GO
ALTER DATABASE  tempdb 
MODIFY FILE (NAME = templog, FILENAME = 'C:\ClusterStorage\CSV_SysLog01\MSSQL12.NIVSSQ20\MSSQL\Data\templog.ldf', SIZE = 500MB, MAXSIZE = 2500MB, FILEGROWTH = 500MB );
GO


