select 'insert into ['  + name + '] (' + (select [dbo].[udf_genInsertStatements](name)) + ') 
  select ' + (select [dbo].[udf_genInsertStatements](name)) + '
  from [nivssq21\nivssq21].crm_extract.dbo.' + name + '
  go'
  from sys.all_objects where type = 'u'
    and name in ('Account_BuyingModel','Account_FiscalYear'
,'Account_IndustryCode'
,'Account_Minority'
,'Account_Status'
,'Contact_AccountRoleCode'
,'Contact_BuyingPersona'
,'Contact_Rmx_ValueDriver'
,'Contact_ValueDriver'
,'CRM_Entities'
,'CRM_Organizations'
,'JobOrder_IndustrySector'
,'JobOrder_Process'
,'JobOrder_SecurityClearance'
,'JobOrder_Specialty'
,'JobOrder_Status'
,'JobOrder_Type'
,'PhoneCall_Type')
