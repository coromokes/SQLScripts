select  
    max(recordcount) MAXRECS, min(recordcount) MINRECS, 
    max(recordcount) - min(recordcount) DIFF,
    (max(recordcount) - min(recordcount))*24 Projection --24 for weeks projection based on below days
  from dbatablelog
  where tablename = 'candidatephones'
    and datecreated > getdate() - 12 --12 for days back to conversion need to update


