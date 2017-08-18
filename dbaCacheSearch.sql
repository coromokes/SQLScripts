select top 10 * from master..syscacheobjects
where sql like 'create procedure dsktp_GetActiveJobOrders_mb%'
