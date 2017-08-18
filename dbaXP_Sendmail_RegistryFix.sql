xp_instance_regwrite N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer',N'NumberOfTimesToRetryOnNetworkError',REG_DWORD,3
go
xp_instance_regwrite N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer',N'WaitIntervalForRetryOnNetworkError',REG_DWORD,3000
go
