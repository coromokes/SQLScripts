select 'move ' + '''' + rtrim(name) + '''' + ' to ' + '''' + 
    rtrim(filename) + '''' + ','
  from sysfiles with (nolock)
union
select 
    'move ' + '''sysft_' + rtrim(name) + '''' + ' to ' + '''' + 
    'e' + right(rtrim(path),len(rtrim(path)) - 1) + '''' + ','
  from sys.sysfulltextcatalogs




