select newupdatetimestamp, newhomephone, oldhomephone
  from individualaudit with (nolock)
  where newindnum = 354719
    and oldIndOfficeNum = 90
  order by year(newupdatetimestamp) desc, 
month(newupdatetimestamp) desc,            
day(newupdatetimestamp) desc,
datepart(hh,newupdatetimestamp) desc,
datepart(mi,newupdatetimestamp) desc


