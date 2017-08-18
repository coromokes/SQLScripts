SELECT CAST(
                  REPLACE(
                        REPLACE(XEventData.XEvent.value('(data/value)[1]', 'varchar(max)'), 
                        '', ''),
                  '','')
            AS XML) AS DeadlockGraph
FROM
(SELECT CAST(target_data AS XML) AS TargetData
from sys.dm_xe_session_targets st
join sys.dm_xe_sessions s on s.address = st.event_session_address
where name = 'system_health') AS Data
CROSS APPLY TargetData.nodes ('//RingBufferTarget/event') AS XEventData (XEvent)
where XEventData.XEvent.value('@name', 'varchar(4000)') = 'xml_deadlock_report'  