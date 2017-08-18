select 
    a.filename,
    a.name,
    a.size * 8.0 / 1024.0 as originalsize_MB,
    f.size * 8.0 / 1024.0 as currentsize_MB
  from master..sysaltfiles a 
    inner join tempdb..sysfiles f on a.fileid = f.fileid
  where dbid = db_id('tempdb')
    and a.size != f.size