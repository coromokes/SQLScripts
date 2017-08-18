
select * from distribution.dbo.MSsubscriptions
where subscriber_db = 'virtual'
--presence of virtual subscriber_db is the main reason the db is growing.
--execute the results of the following sql on pivssq08\pivssq08 in the rmprod db:
select 
'use rmprod
go' + '
exec sp_helppublication @publication='''+ publication + '''' from distribution.dbo.MSpublications
where publisher_db = 'rmprod'

--then run this for each offending pulication having immediate_sync =1
EXEC  sp_changepublication
 @publication = 'your_publication_name',
@property = 'allow_anonymous', 
 @value = 'false' 
 GO 

EXEC  sp_changepublication  
 @publication = 'your_publication_name',
@property = 'immediate_sync', 
 @value = 'false' 
 GO 

--verify no virtuals are left
select * from distribution.dbo.MSsubscriptions where subscriber_db = 'virtual'

--after updating all pulications execute this to clear out the dist db.
EXEC dbo.sp_MSdistribution_cleanup @min_distretention = 0, @max_distretention = 72

--reference: http://www.replicationanswers.com/TransactionalOptimisation.asp

--You should see these numbers reduce drasctically
SELECT COUNT(*) FROM [distribution].[dbo].[MSrepl_transactions] (nolock);
GO
