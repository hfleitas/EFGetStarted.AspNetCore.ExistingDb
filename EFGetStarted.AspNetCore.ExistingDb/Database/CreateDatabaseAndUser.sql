--  +----------------------------------------+
--  | create database, tables and load data. |
--  +----------------------------------------+

if db_id('Blogging') is null
begin 
	create database [Blogging];

	use [Blogging];
	
	create table [Blog] (
		[BlogId] int not null identity,
		[Url] nvarchar(max) not null,
		constraint [PK_Blog] primary key ([BlogId])
	);

	create table [Post] (
		[PostId] int not null identity,
		[BlogId] int not null,
		[Content] nvarchar(max),
		[Title] nvarchar(max),
		constraint [PK_Post] primary key ([PostId]),
		constraint [FK_Post_Blog_BlogId] foreign key ([BlogId]) refrences [Blog] ([BlogId]) on delete cascade 
	);
	
	insert into [Blog] (Url) values
	('http://blogs.msdn.com/dotnet'),
	('http://blogs.msdn.com/webdev'),
	('http://blogs.msdn.com/visualstudio'),
	('http://dba2o.wordpress.com'),
	('http://blogs.microsoft.com/ai'),
	('http://fleitasarts.com'),
	('http://blogs.microsoft.com/ai')
	;

end
go


--  +----------------+
--  | Add User Login |
--  +----------------+

use [master]
go
if not exists (select 1 from syslogins where name = 'core')
begin 
	create login core with password = 'AspNetC0re.ExistingDb'
end 
go
use Blogging
go
if not exists (select 1 from sysusers where name = 'core')
begin 
	create user core for login core
end
go
alter role db_datareader add member core
alter role db_datawriter add member core
go