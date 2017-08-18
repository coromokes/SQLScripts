
DECLARE @x XML = 
(select CAST(xet.target_data as xml) from sys.dm_xe_session_targets xet 
join sys.dm_xe_sessions xe 
on (xe.address = xet.event_session_address) 
where xe.name = 'system_health')
SELECT t.e.value('@name', 'varchar(50)') AS EventName
    ,t.e.value('@timestamp', 'datetime') AS DateAndTime
    ,t.e.value('(data[@name="error"]/value)[1]', 'int') AS ErrNo
    ,t.e.value('(data[@name="severity"]/value)[1]', 'int') AS Severity
    ,t.e.value('(data[@name="message"]/value)[1]', 'varchar(max)') AS ErrMsg
    ,t.e.value('(action[@name="sql_text"]/value)[1]', 'varchar(max)') AS sql_text
FROM @x.nodes('//RingBufferTarget/event') AS t(e)
WHERE t.e.value('@name', 'varchar(50)') <> 'wait_info' 
order by 2 desc