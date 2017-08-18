truncate table dbaAdminXOnCallSchedule

--select * from dbaAdminXOnCallSchedule
insert into dbaAdminXOnCallSchedule 
  ( AdminID, priorityid, oncallscheduleid )
select 1, 1, (select OncallScheduleID from dbaoncallschedule where fromdate = '2009-03-23')
union
select 6, 2, (select OncallScheduleID from dbaoncallschedule where fromdate = '2009-03-23')

declare @date datetime
select @date = max(todate) 
  from dbaoncallschedule o 
    inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID

while @date <= '01-07-2010'
  begin
--select * from dbaadmin
--Rajitha	Mark
--Mark	Steven 
--Sophie	Mike
--Mike 	Rajitha

insert into dbaAdminXOnCallSchedule 
  ( AdminID, priorityid, oncallscheduleid )
select (select adminid from dbaadmin where lname = 'Dundigalla'), 1, (select OncallScheduleID from dbaoncallschedule o where fromdate =(select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))
union
select (select adminid from dbaadmin where lname = 'Schroer'), 2, (select OncallScheduleID from dbaoncallschedule where fromdate = (select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))

insert into dbaAdminXOnCallSchedule 
  ( AdminID, priorityid, oncallscheduleid )
select (select adminid from dbaadmin where lname = 'Schroer'), 1, (select OncallScheduleID from dbaoncallschedule o where fromdate =(select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))
union
select (select adminid from dbaadmin where lname = 'Smith'), 2, (select OncallScheduleID from dbaoncallschedule where fromdate = (select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))

insert into dbaAdminXOnCallSchedule 
  ( AdminID, priorityid, oncallscheduleid )
select (select adminid from dbaadmin where lname = 'Masud'), 1, (select OncallScheduleID from dbaoncallschedule o where fromdate =(select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))
union
select (select adminid from dbaadmin where lname = 'Brown'), 2, (select OncallScheduleID from dbaoncallschedule where fromdate = (select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))

insert into dbaAdminXOnCallSchedule 
  ( AdminID, priorityid, oncallscheduleid )
select (select adminid from dbaadmin where lname = 'brown'), 1, (select OncallScheduleID from dbaoncallschedule o where fromdate =(select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))
union
select (select adminid from dbaadmin where lname = 'Dundigalla'), 2, (select OncallScheduleID from dbaoncallschedule where fromdate = (select dateadd(d, 1, max(todate)) from dbaoncallschedule o 
inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID))

  select @date = max(todate)
  from dbaoncallschedule o 
    inner join dbaAdminXOnCallSchedule x on x.OncallScheduleID = o.OncallScheduleID

  end






