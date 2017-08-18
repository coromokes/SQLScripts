EXEC sp_addlinkedserver
    @server = 'rmfs', -- Linked Server
    @provider = 'MSDAORA',
    @datasrc = 'fsrmtest', -- Oracle db
    @srvproduct = 'Oracle'
go
EXEC sp_addlinkedsrvlogin
    @rmtsrvname = 'rmfs', --Linked Server
    @useself = 'False',
    @rmtuser = 'wizclnt',
    @rmtpassword = 'QA4321'
go
