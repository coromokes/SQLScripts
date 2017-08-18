--Generate a random number from 1 - @num
declare @num as int
set @num = 100

--2000
select cast(rand() * @num as int) + 1
--2005
select 1 + abs(checksum(newid())) % @num