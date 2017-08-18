
select 'grant ' + 
    case xtype
      when 'FN' then 'execute'
      when 'IF' then 'select'
      when 'TF' then 'select'
    end +
    ' on ' +
    o.name + 
    ' to ProdSupport
go'
  from sysobjects o
  where xtype in ('fn', 'if', 'tf')