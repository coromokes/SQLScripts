select x.*, IoStallMS / (NumberReads+NumberWrites) as IsStall ,
    f.name Filenames, GroupName
    --(select GroupName FileGroupName from )
  from ::fn_virtualfilestats((select db_id()),-1) x
    left join sysfiles f on f.fileid = x.fileid
    left join sysfilegroups g on g.groupid = f.groupid
  order by iostallms desc

