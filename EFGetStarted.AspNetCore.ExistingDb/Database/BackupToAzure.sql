--  +-----------------------------------+
--  | On-Prem or Source Server/Database |
--  +-----------------------------------+
--Create Credential
IF EXISTS  (SELECT * FROM sys.credentials WHERE name = 'hiramupcicstorage1') 
BEGIN DROP CREDENTIAL hiramupcicstorage1 END;
CREATE CREDENTIAL hiramupcicstorage1 WITH IDENTITY= 'hiramupcicstorage1', 
SECRET = '7VIb2hkrC29aQK+AdNVvxWB+LGCSewVOl1DkYbo2kn3W9I15kl+Lh8zgFCF+MepmzR7H9VydHBF+YFI66/u2dQ==';
GO
--Backup to URL
--https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url
BACKUP DATABASE Blogging  
TO URL = 'https://hiramupcicstorage1.blob.core.windows.net/uploads/Blogging.bak'   
     WITH CREDENTIAL = 'hiramupcicstorage1'   
    ,COMPRESSION  
    ,STATS = 5;  
GO
BACKUP DATABASE [ᕙ༼,இܫஇ,༽ᕗ]  --Go see Trollhunters on netflix.com!
TO URL = 'https://hiramupcicstorage1.blob.core.windows.net/uploads/Trollhunters.bak'   
     WITH CREDENTIAL = 'hiramupcicstorage1'   
    ,COMPRESSION  
    ,STATS = 5;  
GO 

--  +-------------------------------+
--  | On Remote Svr (Azure SQL/DWH) |
--  +-------------------------------+
--Create Credential
IF EXISTS  (SELECT * FROM sys.credentials WHERE name = 'hiramupcicstorage1') 
BEGIN DROP CREDENTIAL hiramupcicstorage1 END;
CREATE CREDENTIAL hiramupcicstorage1 WITH IDENTITY= 'hiramupcicstorage1', 
SECRET = '7VIb2hkrC29aQK+AdNVvxWB+LGCSewVOl1DkYbo2kn3W9I15kl+Lh8zgFCF+MepmzR7H9VydHBF+YFI66/u2dQ==';
GO
--Verify
RESTORE FILELISTONLY 
FROM URL = 'https://hiramupcicstorage1.blob.core.windows.net/uploads/Blogging.bak' 
WITH CREDENTIAL = 'hiramupcicstorage1' ;
GO
RESTORE FILELISTONLY 
FROM URL = 'https://hiramupcicstorage1.blob.core.windows.net/uploads/Trollhunters.bak' 
WITH CREDENTIAL = 'hiramupcicstorage1' ;
GO
--Restore...
--Delete *.bak from Container.
IF EXISTS  (SELECT * FROM sys.credentials WHERE credential_identity = 'hiramupcicstorage1')  
BEGIN DROP CREDENTIAL hiramupcicstorage1 END
GO