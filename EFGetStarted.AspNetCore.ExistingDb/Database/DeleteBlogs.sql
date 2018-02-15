--  +----------------------------------------+
--  | create database, tables and load data. |
--  +----------------------------------------+

if db_id('Blogging') is not null
begin 
	use [Blogging];
	
	delete from [Blog] where BlogId > 7; 

	dbcc checkident ('Blog')
	--Checking identity information: current identity value '83', current column value '7'.

	dbcc checkident ('Blog', reseed, 7);  

	select * from [Blog] ;
	select * from [Post] ;

end
go
