-- Use this sql to add fieldnames to a previously created rmax form.

-- IMPORTANT!! You'll need to change the Form name i.e. 'CRS In-House Services CRA Interview Prompter'
--             to the current form being updated

-- Adding new fields to an existing form
 insert into rmprod.dbo.ApplicationFields
   ( ApplicationSectionID, FieldName, InputType,
     Validate, Require, Active,
     SelectValues, AssociatedField, OrderNumber, LineBreak )
 select 
     x.ApplicationSectionID, FieldName, InputType,
     Validate, Require, f.Active,
     SelectValues, AssociatedField, f.OrderNumber, LineBreak 
   from [STA2MS11\STA2MS11].rmqa.dbo.ApplicationFields f
     inner join [STA2MS11\STA2MS11].rmqa.dbo.ApplicationSections s on s.ApplicationSectionID = f.ApplicationSectionID
     inner join [STA2MS11\STA2MS11].rmqa.dbo.ApplicationTypes t on t.ApplicationTypeID = s.ApplicationTypeID
     inner join (select applicationsectionid, sectionname
                   from rmprod.dbo.ApplicationSections s
                     inner join rmprod.dbo.ApplicationTypes t on t.ApplicationTypeID = s.ApplicationTypeID
                   where ApplicationType = 'CRS Regional CRA Interview Prompter') x on x.SectionName = s.SectionName
   where ApplicationType = 'CRS Regional CRA Interview Prompter'
     and f.ApplicationSectionID = s.ApplicationSectionID
     and not exists (select 1
                       from rmprod.dbo.ApplicationFields ff
                         inner join rmprod.dbo.ApplicationSections ss on ss.ApplicationSectionID = ff.ApplicationSectionID
                       where ff.fieldname = f.fieldname
                            and ss.SectionName = s.SectionName)
   order by x.applicationsectionid, f.ordernumber

-- Update the ordernumber for existing and new fields
begin tran
update ff
    set ordernumber = y.ordernumber
  from rmprod.dbo.applicationfields ff
  inner join (
select 
    x.ApplicationSectionID, FieldName, InputType,
    Validate, Require, f.Active,
    SelectValues, AssociatedField, f.OrderNumber, LineBreak 
  from [STA2MS11\STA2MS11].rmqa.dbo.ApplicationFields f
    inner join [STA2MS11\STA2MS11].rmqa.dbo.ApplicationSections s on s.ApplicationSectionID = f.ApplicationSectionID
    inner join [STA2MS11\STA2MS11].rmqa.dbo.ApplicationTypes t on t.ApplicationTypeID = s.ApplicationTypeID
    inner join (select applicationsectionid, sectionname
                  from rmprod.dbo.ApplicationSections s
                    inner join rmprod.dbo.ApplicationTypes t on t.ApplicationTypeID = s.ApplicationTypeID
                  where ApplicationType = 'CRS Regional CRA Interview Prompter') x on x.SectionName = s.SectionName
  where ApplicationType = 'CRS Regional CRA Interview Prompter'
    and f.ApplicationSectionID = s.ApplicationSectionID ) y on y.ApplicationSectionID = ff.ApplicationSectionID
      and y.fieldname = ff.fieldname

commit
