use RMQA 
go
declare @rc int
exec @rc = sys.sp_cdc_enable_db
select @rc
-- new column added to sys.databases: is_cdc_enabled
select name, is_cdc_enabled from sys.databases

select * from sys.dm_cdc_log_scan_sessions

select top 5 * from candidates where candidateid =1

update candidates 
set minit = ''
where candidateid =1

select * from [cdc].[dbo_Candidates_CT]

