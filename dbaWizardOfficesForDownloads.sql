select *
  from logical_office l
    inner join physical_office p on l.officenum = p.LogicalOfficeNum
  where p.name in ('TAF','BAL','DAO','DIC','TIH')
