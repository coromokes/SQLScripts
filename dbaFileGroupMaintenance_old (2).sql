declare @dbname         varchar(100), 
        @FreeSpacePct   varchar(7),
        @command        VARCHAR(5000) 

select  @FreeSpacePct   = '9.00%'
select  @dbname         = 'rmqa'

IF OBJECT_ID(N'tempdb..#dbinfo', N'U') IS NOT NULL 
    DROP TABLE #dbinfo;

create table #DBInfo  
(   ServerName          VARCHAR(100),  
    DatabaseName        VARCHAR(100),  
    FileSizeMB          INT,  
    LogicalFileName     sysname,  
    PhysicalFileName    NVARCHAR(520),  
    Status              sysname,  
    Updateability       sysname,  
    RecoveryMode        sysname,  
    FreeSpaceMB         INT,  
    FreeSpacePct        VARCHAR(7),  
    FreeSpacePages      INT,  
    PollDate            datetime)  
 

SELECT @command = 'Use [' + '?' + '] SELECT  
@@servername as ServerName,  
' + '''' + '?' + '''' + ' AS DatabaseName,  
CAST(sysfiles.size/128.0 AS int) AS FileSize,  
sysfiles.name AS LogicalFileName, sysfiles.filename AS PhysicalFileName,  
CONVERT(sysname,DatabasePropertyEx(''?'',''Status'')) AS Status,  
CONVERT(sysname,DatabasePropertyEx(''?'',''Updateability'')) AS Updateability,  
CONVERT(sysname,DatabasePropertyEx(''?'',''Recovery'')) AS RecoveryMode,  
CAST(sysfiles.size/128.0 - CAST(FILEPROPERTY(sysfiles.name, ' + '''' +  
       'SpaceUsed' + '''' + ' ) AS int)/128.0 AS int) AS FreeSpaceMB,  
CAST(100 * (CAST (((sysfiles.size/128.0 -CAST(FILEPROPERTY(sysfiles.name,  
' + '''' + 'SpaceUsed' + '''' + ' ) AS int)/128.0)/(sysfiles.size/128.0))  
AS decimal(4,2))) AS varchar(8)) + ' + '''' + '%' + '''' + ' AS FreeSpacePct,  
GETDATE() as PollDate FROM dbo.sysfiles'  
INSERT INTO #DBInfo  
   (ServerName,  
    DatabaseName,  
    FileSizeMB,  
    LogicalFileName,  
    PhysicalFileName,  
    Status,  
    Updateability,  
    RecoveryMode,  
    FreeSpaceMB,  
    FreeSpacePct,  
    PollDate)  
EXEC sp_MSForEachDB @command  

select 'dbcc shrinkfile (''' + rtrim(name) + ''', ' 
    + cast(round((cast(FILEPROPERTY( rtrim(name) ,'SpaceUsed') as float)/128),0) as varchar)
    + ') go'
  from sysfiles sf with (nolock)  
  where groupid <> 0
    and exists
    (SELECT 1
     FROM   #DBInfo  
     where  DatabaseName = @dbname
     and    LogicalFileName = rtrim(sf.name)
     and    FreeSpacePct > @FreeSpacePct
     and    FreeSpaceMB  > 0
     )
  order by name

