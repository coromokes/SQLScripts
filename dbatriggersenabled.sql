  SELECT 
           T.[name] as TableName
         , TR.[Name] as TriggerName
         , CASE WHEN 1=OBJECTPROPERTY(TR.[id], 'ExecIsTriggerDisabled')
                THEN 'Disabled' ELSE 'Enabled' END Status
         FROM sysobjects T
             INNER JOIN sysobjects TR
                  on t.[ID] = TR.parent_obj
         WHERE (T.xtype = 'U' or T.XType = 'V')
           AND (TR.xtype = 'TR')
		   and OBJECTPROPERTY(TR.[id], 'ExecIsTriggerDisabled') = 1
         ORDER BY T.[name] , TR.[name]



