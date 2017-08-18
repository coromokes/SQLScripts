--config file for add node run from cmd prompt
--update ZZZZZ with appropriate password
--update config file as needed and update with appropriate instance info
--update svc accounts as needed for prod (or nonprod)
d:\srvapps\SQLServer2008R2_SP2_DEV\setup /ConfigurationFile=d:\srvapps\addnodeconfig_2008R2.ini /SQLSVCPASSWORD="ZZZZZ" /AGTSVCPASSWORD="ZZZZZ" /SQLSVCACCOUNT="kforce\SVC-NPSQLSDE" /AGTSVCACCOUNT="kforce\SVC-NPSQLSA" /IACCEPTSQLSERVERLICENSETERMS