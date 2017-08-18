--Reset replication after a restore on a non prod instance
--Use this is you get the following : 
--Error:  The log was not truncated because records at the beginning of the log are pending replication

EXEC sp_dboption 'rmqa', 'published', 'true'
GO
use rmqa
go
EXEC sp_repldone @xactid = NULL, @xact_segno = NULL, @numtrans = 0, @time = 0, @reset = 1
GO
EXEC sp_dboption 'rmqa', 'published', 'false'
GO

