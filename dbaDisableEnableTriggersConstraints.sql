sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

sp_msforeachtable "ALTER TABLE ? DISABLE TRIGGER  all"

 

/*

To enable them back, you can reverse the function. Let's get a little more creative this time. We'll explicitly set the parameters and list each table before enabling them so we can verify any errors easily.

*/

 

sp_msforeachtable @command1="print '?'", @command2="ALTER TABLE ? CHECK CONSTRAINT all"

sp_msforeachtable @command1="print '?'", @command2="ALTER TABLE ? ENABLE TRIGGER  all"
