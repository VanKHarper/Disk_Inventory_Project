-----------------------------------------------
------------  MODIFICATION LOGS  --------------
-----------------------------------------------
-- Name ---------- Info ----------- Date ------
-----------------------------------------------
-- Van Harper -- Initial deployment -- 2/28/2019
-- Van Harper -- Fixed database creation -- 3/1/2019
-- Van Harper -- finished creating tables and added login creators -- 3/2/2019
-----------------------------------------------
-----------------------------------------------


-- Drops Disk_DB and re-creates it
IF DB_ID('Disk_DB') IS NOT NULL
	DROP DATABASE Disk_DB
GO
CREATE DATABASE Disk_DB
GO
USE Disk_DB
GO

-- Connects to the right databse and uses master
USE Disk_DB
GO
USE master
GO

create TABLE borrower
	(
		borrower_id int not null identity primary key,
		phone_num varchar(50) not null,
		FirstName varchar(100) not null,
		LastName varchar(100) not null
	)
go

create TABLE artist
	(
		artist_id int not null primary key identity,
		Artist_Type int not null foreign key references artist_type(artist_type_id),
		Artist_FName varchar(100) not null,
		Artist_LName varchar(100) not null
	)
go

create TABLE compact_disk
	(
		disk_id int not null identity primary key,
		Disk_Status int not null foreign key references disk_status(disk_status_id),
		Disk_Genre int not null foreign key references disk_genre(disk_genre_id),
		Disk_Type int not null foreign key references disk_type(disk_type_id),
		disk_name varchar(100) not null,
		release_date datetime not null
	)
go

create TABLE disk_has_artist
	(
		artist_type_id int not null foreign key references artist(artist_id),		
		disk_id int not null foreign key references compact_disk(disk_id),
		primary key (artist_type_id, disk_id)
	)
go

create TABLE disk_has_borrower
	(
		borrowed_date datetime not null,
		artist_type_id int not null foreign key references borrower(borrower_id),		
		disk_id int not null foreign key references compact_disk(disk_id),
		expected_date datetime not null,
		returned_date datetime not null,
		primary key (borrowed_date, artist_type_id, disk_id)
	)
go

create TABLE artist_type
	(
		artist_type_id int not null primary key identity,		
		artist_type_desc varchar(100) not null
	)
go

create TABLE disk_type
	(
		disk_type_id int not null primary key identity,		
		disk_type_desc varchar(100) not null
	)
go

create TABLE disk_genre
	(
		disk_genre_id int not null primary key identity,		
		disk_genre_desc varchar(100) not null
	)
go


create TABLE disk_status
	(
		disk_status_id int not null primary key identity,		
		disk_status_desc varchar(100) not null
	)
go

USE master
GO

if SUSER_ID('diskUsermm') is not null
	drop login diskUsermm
go
create login diskUsermm with password = 'pa$$w0rd',
	default_database = Disk_DB
go
	use Disk_DB
go
if USER_ID('diskUsermm') is not null
	drop user diskUsermm
go
	create user diskUsermm
go
	alter role db_datareader add member diskUsermm
go