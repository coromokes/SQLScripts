--use to create an sp_attach_db script
select '  @filename' + cast(fileid as varchar) 
    + ' = ''' + filename + ''','
  from sysfiles with (nolock)
