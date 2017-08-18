While 1=1

Begin

 Select getdate()

 Select * from master..sysprocesses where waittype !=0

 dbcc memorystatus

 dbcc memobjlist(0)

 dbcc activecursors

 waitfor delay '01:00:00'

end
