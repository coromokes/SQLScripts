Declare --@searchterm nvarchar(50) = 'sta0ns40dm', --where clause value
		@replacepattern1 nvarchar(150)= '\DATA\', --Value to be replaced
		@replacevalue1 nvarchar(150) = '\DATA\BizTalkQA\'; --the value as you want it to be

SELECT d.name [DB_Name],mf.name DB_File,ROUND(SUM(mf.size) * 8 / 1024, 0) DB_FileSize_MBs, 
mf.physical_name Current_DB_FileLocation
--, LEFT(mf.physical_name,19) + '2' + Right(physical_name,Len(mf.physical_name)-20) New_DB_FileLocation
,replace(mf.physical_name,@replacepattern1,@replacevalue1) New_DB_FileLocation
,'ALTER DATABASE '+d.name+' MODIFY FILE ( NAME ='+mf.name+' , FILENAME = '''+replace(mf.physical_name,@replacepattern1,@replacevalue1)+''' );' ALTER_Statement
FROM sys.master_files mf
INNER JOIN sys.databases d ON d.database_id = mf.database_id
WHERE d.name like 'E%'
GROUP BY d.name, mf.name, mf.physical_name
ORDER BY d.name

--Run the following statement. To bring DB offline.
ALTER DATABASE EsbExceptionDb SET OFFLINE WITH ROLLBACK IMMEDIATE;

--**IMPORTANT!!--Move the file or files to the new location--!!IMPORTANT**
--For each file moved, run the following statement.
--ALTER DATABASE [DB] MODIFY FILE ( NAME = , FILENAME = '' );

ALTER DATABASE EsbExceptionDb MODIFY FILE ( NAME =EsbExceptionDb_Log , FILENAME = 'Q:\Q_NIVSSQ07_Data01\MSSQL10_50.NIVSSQ07\MSSQL\DATA\BizTalkQA\EsbExceptionDb_Log.ldf' );
ALTER DATABASE EsbExceptionDb MODIFY FILE ( NAME =EsbExceptionDb_SysData , FILENAME = 'Q:\Q_NIVSSQ07_Data01\MSSQL10_50.NIVSSQ07\MSSQL\DATA\BizTalkQA\EsbExceptionDb_SysData.mdf' );
--Run the following statement. To bring DB back online.

ALTER DATABASE EsbExceptionDb SET ONLINE;

--Verify the file change by running the following query.
SELECT name, physical_name AS CurrentLocation, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'DataServices');
