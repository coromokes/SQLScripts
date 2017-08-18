
while 1=1
begin
Select * from master..sysprocesses where waittype !=0
exec sp_blockinfo

waitfor delay '00:00:05'

end