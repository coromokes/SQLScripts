/* msb 

Note	Use these script for researching data collected from traces

*/

SELECT  *--TextData, Duration, Reads, Writes, CPU 
FROM    [20030919_Trace]
WHERE   EventClass = 12 -- SQL:BatchCompleted events
AND     Duration >= 100000 --1000 = 1 second, 10000 = 10 seconds, 100000 = 1 minute, etc.


SELECT  count(*) 
FROM    [20030919_Trace]
WHERE   EventClass = 12 -- SQL:BatchCompleted events
AND     Duration >= 100000 --1000 = 1 second, 10000 = 10 seconds, 100000 = 1 minute, etc.


SELECT  convert(varchar(8000),TextData), count(*), sum(duration) 
FROM    [20030919_Trace]
WHERE   EventClass = 12 -- SQL:BatchCompleted events
AND     Duration >= 100000 --1000 = 1 second, 10000 = 10 seconds, 100000 = 1 minute, etc.
group by convert(varchar(8000),textdata)

/* 
 Top 5 read operations
*/
select top 5 reads, textdata, writes, duration, cpu
from [20030915_Trace]
where reads is not null
order by reads desc
/*
 Top 5 write operations
*/
select top 5 *--writes, textdata, reads, duration, cpu
from  [20030915_Trace]
where reads is not null
order by writes desc
