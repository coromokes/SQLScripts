 SELECT
       'ALTER TABLE ' +
       QuoteName(OBJECT_NAME(sc.id)) +
       'WITH NOCHECK ADD CONSTRAINT ' +
       QuoteName(OBJECT_NAME(sc.cdefault))+
       ' DEFAULT ' +
       sm.text +
       ' FOR ' + QuoteName(sc.name)
       + '
go'
       + CHAR(13)+CHAR(10)
   FROM
       syscolumns sc
       INNER JOIN
       sysobjects as so on sc.cdefault = so.id
       INNER JOIN
       syscomments as sm on sc.cdefault = sm.id
   WHERE
       OBJECTPROPERTY(so.id, N'IsDefaultCnst') = 1