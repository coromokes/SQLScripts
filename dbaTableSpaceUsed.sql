Declare
@Table_Name varchar(255),
@SQL varchar(max)

---------------------------------------------------------------------------
-- Create a temporary table for storing result of sp_tables
---------------------------------------------------------------------------

Create Table #tServerTables
(
Table_Cat varchar(255),
Table_schem varchar(255),
Table_Name varchar(255),
Table_Type varchar(255),
Remarks varchar(255)
)

CREATE TABLE #tSpaceUsed
(
[name] varchar(255),
rows varchar(255),
reserved varchar(255),
data varchar(255),
index_size varchar(255),
unused varchar(255)
)

---------------------------------------------------------------------------
-- Populate Temporary table with the results of the sp_tables command
-- NOTE: the paramater passed to sp_spaceused MUST be the name of a 
-- valid table
---------------------------------------------------------------------------

Insert Into #tServerTables exec sp_tables 

---------------------------------------------------------------------------
-- Create cursor for selecting the Table names
---------------------------------------------------------------------------

Declare crsServerTables Cursor For 
Select table_name 
From #tServerTables
WHERE TABLE_TYPE='TABLE'

-- Open the cursor defined above

Open crsServerTables

Fetch Next From crsServerTables Into @Table_Name 

While @@Fetch_Status = 0 Begin -- 0 = more records to process

  INSERT INTO #tSpaceUsed exec sp_spaceused @Table_Name
  -- Move to the next record
  Fetch Next From crsServerTables Into @Table_Name

End

--SELECT * FROM #tSpaceUsed
--  order by cast(rows as int) desc
---------------------------------------------------------------------------
-- Clean up (drop temp tables, remove cursors)
---------------------------------------------------------------------------
SELECT * FROM #tSpaceUsed
order by cast(rows as int) desc

drop table #tServerTables
drop table #tSpaceUsed
Close crsServerTables
Deallocate crsServerTables


