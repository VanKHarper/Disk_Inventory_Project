------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
---------------------------------	MODIFICATION LOGS	----------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
----  Name  --------------  Info  -----------  Date  -------------------------------------------------------
-- Van Harper -- Initial deployment -- 2/28/2019 -----------------------------------------------------------
-- Van Harper -- Fixed database creation -- 3/1/2019 -------------------------------------------------------
-- Van Harper -- Finished creating tables and added login creators -- 3/2/2019 -----------------------------
------------------------------------------------------------------------------------------------------------
-- Van Harper -- Fixed issue with dropping and recreating Database -- 3/8/2019 -----------------------------
-- Van Harper -- Corrected order in which tables are created -- 3/8/2019 -----------------------------------
-- Van Harper -- Began inserting data into all tables -- 3/8/2019 ------------------------------------------
------------------------------------------------------------------------------------------------------------
-- Van Harper -- Finsihed inserting data into all tables -- 3/9/2019 ---------------------------------------
-- Van Harper -- Added a WHERE commands onto tables -- 3/9/2019---------------------------------------------
-- Van Harper -- Fixed issue with disk_has borrower table, -------------------------------------------------
--            -- by adding an additional row to the borrowers table -- 3/9/2019-----------------------------
-- Van Harper -- Added a WHERE commands onto tables -- 3/9/2019---------------------------------------------
------------------------------------------------------------------------------------------------------------
-- Van Harper -- Fixed flaws in instantiating tables -- 3/14-2019 ------------------------------------------
-- Van Harper -- Added times borrowed to disk has borrower table -- 3/14-2019 ------------------------------
------------------------------------------------------------------------------------------------------------
-- Van Harper -- Began adding sort by commands to the Artist and Disk Name tables -- 3/15/2019 -------------
------------------------------------------------------------------------------------------------------------
-- Van Harper -- Finished adding sort by commands and added a View for individual artists -- 3/16/2019 -----
-- Van Harper -- Created view for individual artist -- 3/16/2019 -------------------------------------------
---Van Harper -- Created select command for outstanding books -- 3/16/2019 ---------------------------------
------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------


-- Drops Disk_DB and re-creates it --
USE master
GO
DROP DATABASE Disk_DB
GO
CREATE DATABASE Disk_DB
GO
USE Disk_DB
GO


-- Creates initial tables --
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

create TABLE borrower
	(
		borrower_id int not null identity primary key,
		FirstName varchar(100) not null,
		LastName varchar(100) not null,
		phone_num varchar(50) not null
	)
go

create TABLE artist
	(
		artist_id int not null primary key identity,
		Artist_Type int not null foreign key references artist_type(artist_type_id),
		Artist_FName varchar(100) not null,
		Artist_LName varchar(100) null
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
		disk_artist_id int not null foreign key references artist(artist_id),		
		disk_id int not null foreign key references compact_disk(disk_id),
		primary key (disk_artist_id, disk_id)
	)
go

create TABLE disk_has_borrower
	(
		disk_borrower_id int not null foreign key references borrower(borrower_id),		
		disk_id int not null foreign key references compact_disk(disk_id),
		borrowed_date datetime not null,	
		expected_date datetime not null,
		returned_date datetime null,
		times_borrowed int null,
		primary key (borrowed_date, disk_borrower_id, disk_id)	
	)
go

-- Inserts data in the tables --
INSERT into [dbo].[artist_type]
([artist_type_desc])
	VALUES
		('Solo')
		,('Group')		
GO

INSERT into [dbo].[disk_type]
([disk_type_desc])
	VALUES
		('CD')
		,('Vinyl')
		,('8Track')
		,('DVD')		
GO

INSERT into [dbo].[disk_genre]
([disk_genre_desc])
	VALUES
		('Rap')
		,('Rock')
		,('Jazz')
		,('Country')
		,('Metal')
		,('Polka')		
GO

INSERT into [dbo].[disk_status]
([disk_status_desc])
	VALUES
		('In-Stock')
		,('Out-of-Stock')
		,('On-Hold')
		,('Unkown')		
GO

INSERT into [dbo].[borrower]
([FirstName], [LastName],[phone_num])
	VALUES
		 ('Jon', 'Jones', '111-555-2324')
		,('Frank', 'Renalds', '222-555-2345')
		,('Dee', 'Renalds', '333-555-4567')
		,('Denis', 'Renalds', '444-555-1267')				
		,('Charlie', 'Kelly', '555-555-5698')				
		,('Ronald', 'MacDonald', '666-555-8894')
		,('Frank', 'Black', '777-555-9090')
		,('Earnist', 'Edwards', '888-555-1223')
		,('Ryan', 'Raynold', '999-555-3453')
		,('Gwen', 'Greenspan', '010-555-3213')
		,('Thomas', 'Turnuckle', '011-555-2345')
		,('Aaron', 'Anderson', '012-555-1235')
		,('Ben', 'Backerson', '013-555-3487')
		,('Caren', 'Crankerson', '014-555-4169')
		,('Dean', 'Del-Real', '015-555-0825')
		,('Edward', 'Everson', '016-555-4391')
		,('Ned', 'Newly', '0171-555-0345')
		,('Mark', 'Mahkerson', '018-555-8741')
		,('Penny', 'Pengren', '019-555-9134')
		,('Logan', 'Looper', '020-555-0165')	
		,('Logan', 'Looper', '020-555-0165')	    			
GO

-- Deletes the 20th borrower -- 
DELETE borrower
WHERE borrower_id = 20
GO

INSERT into [dbo].[artist]
([Artist_Type], [Artist_FName], [Artist_LName])
	VALUES
		 (2, 'Marky Mark and the Funky Bunch', NULL)
		,(2, 'Metalica', NULL)
		,(1, 'Jack', 'Johnson')
		,(1, 'Taylor', 'Swift')				
		,(2, 'D-12', NULL)				
		,(2, 'MacLemore and Ryan Lewis', NULL)
		,(1, 'Skrillex', NULL)
		,(1, 'Frank', 'Ocean')
		,(1, 'Oliver', 'Trees')
		,(1, 'Tim', 'McGraw')
		,(1, 'Miley', 'Cyrus')
		,(2, '21 Pilots', NULL)
		,(1, 'Hank', 'Williams')
		,(1, 'Bob', 'Dylan')
		,(1, 'Travis', 'Scott')
		,(1, 'Jan', 'Lewan')
		,(1, 'Hank', 'Willimas Jr')
		,(2, 'The Pixies', NULL)
		,(1, 'Moby', NULL)
		,(1, 'MF Doom', NULL)				
GO

INSERT into [dbo].[compact_disk]
([Disk_Status], [Disk_Genre], [Disk_Type], [disk_name], [release_date])
	VALUES
		 (3, 1, 2, 'Funky Style', '04/02/1992')
		,(1, 5, 2, 'Enter The Sandman', '01/30/1980')
		,(2, 2, 1, 'Jack Jonhsons Greatist Hits', '03/01/2014')
		,(1, 2, 1, 'Shake it Off', '01/01/2016')				
		,(4, 1, 1, 'Detriot Dayz', '05/09/2002')				
		,(2, 1, 2, 'The Heist', '03/15/2013')
		,(4, 6, 4, 'Spring Breakers', '04/04/2014')
		,(2, 3, 2, 'Ocean Music', '12/24/2015')
		,(3, 1, 1, 'Hurt', '2/20/2019')
		,(1, 4, 3, 'Tim Mcgraw: Greatist Hits', '09/21/2003')
		,(2, 6, 1, 'Cant Stop, Wont Stop', '12/31/2017')
		,(3, 1, 1, 'Stressed Out', '10/17/2016')
		,(4, 1, 1, 'Hank Williams: Greatist Hits', '04/01/1969')
		,(1, 2, 2, 'Bob Dylans Hits Volume 1', '11/20/1999')
		,(1, 1, 1, 'Tavis Scott Style', '01/30/2018')
		,(3, 6, 3, 'Polka Time!', '07/15/1978')
		,(1, 4, 1, 'Outlaw Country', '03/01/2010')
		,(1, 2, 1, 'Waves of Mutalation', '12/24/2009')
		,(2, 6, 2, 'Moby', '12/20/2012')
		,(3, 1, 1, 'Doom vs. Danger Mouse', '07/06/2011')		
		,(3, 1, 1, 'Doom vs. Danger Mouse', '07/06/2011')		
GO

-- Deletes the 21st disk -- 
DELETE compact_disk
WHERE disk_id = 21
GO

-- Changes the release date for the 'Moby' album -- 
UPDATE compact_disk
SET release_date = '12/21/2013'
WHERE disk_name = 'Moby'
GO

INSERT into [dbo].[disk_has_artist]
([disk_artist_id], [disk_id])
	VALUES
		 (1, 1)
		,(2, 2)
		,(3, 3)
		,(4, 4)				
		,(5, 20)				
		,(6, 6)
		,(7, 7)
		,(8, 8)
		,(9, 9)
		,(10, 10)
		,(11, 11)
		,(12, 12)
		,(13, 13)
		,(14, 14)
		,(15, 15)
		,(16, 16)
		,(17, 18)
		,(18, 18)
		,(20, 19)
		,(20, 20)				
GO


INSERT into [dbo].[disk_has_borrower]
([disk_borrower_id], [disk_id], [borrowed_date], [expected_date], [returned_date], [times_borrowed] )
	VALUES
		 (1, 1, '3/4/2019', '3/18/2019', NULL, 1)
		,(1, 2, '3/4/2019', '3/25/2019', '3/8/2019', 2)
		,(3, 3, '3/5/2019', '3/26/2019', NULL, 1)
		,(3, 4, '3/5/2019', '3/19/2019', '3/6/2019', 1)				
		,(5, 5, '3/5/2019', '3/22/2019', '3/9/2019', 5)				
		,(6, 6, '3/5/2019', '3/19/2019', NULL, 4)
		,(7, 7, '3/6/2019', '3/20/2019', NULL, 1)
		,(8, 8, '3/6/2019', '3/20/2019', NULL, 6)
		,(9, 9, '3/6/2019', '3/20/2019', NULL, 1)
		,(10, 10, '3/6/2019', '3/20/2019', NULL, 1)
		,(11, 11, '3/6/2019', '3/20/2019', NULL, 4)
		,(12, 12, '3/6/2019', '3/27/2019', NULL, 1)
		,(13, 13, '3/6/2019', '3/27/2019', '3/7/2019', 4)
		,(14, 14, '3/6/2019', '3/20/2019', NULL, 1)
		,(15, 15, '3/7/2019', '3/28/2019', NULL, 4)
		,(17, 16, '3/7/2019', '3/21/2019', '3/8/2019', 3)
		,(17, 17, '3/7/2019', '3/21/2019', NULL, 5)
		,(18, 18, '3/7/2019', '3/28/2019', NULL, 1)
		,(19, 19, '3/8/2019', '3/22/2019', '3/9/2019', 1)
		,(21, 20, '3/8/2019', '3/22/2019', NULL, 3)			
GO

---- Selects the borrowed disks that have null values --
--SELECT disk_borrower_id, disk_id, borrowed_date FROM disk_has_borrower
--	WHERE returned_date is NULL
--GO


---- Select command for DEBUGGING --
--SELECT * FROM disk_has_borrower
--GO

-- Switches to Using Master --
USE master
GO

-- Stores Login Info --
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

-- Switches to Using Disk_DB --
USE Disk_DB
GO

-- Sorts and displays Artist table by Last Name Artist_FName, Artist_LName, and Disk_Name --
SELECT Artist_FName, Artist_LName, disk_name
  FROM Artist, compact_disk
 WHERE disk_id = artist_id
 ORDER BY Artist_FName, Artist_LName, disk_name
GO

 -- Creates view called View_Individual_Artist that views only individual artists --
 CREATE VIEW View_Individual_Artist
	AS
		SELECT Artist_FName, Artist_LName, artist_id
		FROM Artist
		WHERE Artist_LName IS NOT NULL
	GO

 -- Uses the View_Individual_Artist view to display artists names, without their IDs --
 SELECT Artist_FName, Artist_LName 
	FROM View_Individual_Artist
 GO

  -- Uses the View_Individual_Artist view and compact_disk table, to display columns --
 SELECT disk_name, Artist_FName, Artist_LName, release_date
	FROM View_Individual_Artist, compact_disk
	WHERE disk_id = artist_id
 GO

   -- Displays information about borrowed disks and their borrowers --
 SELECT FirstName, LastName, disk_name, borrowed_date, returned_date
	FROM disk_has_borrower, borrower, compact_disk 
	WHERE compact_disk.disk_id = disk_borrower_id and borrower_id = disk_has_borrower.disk_id
 GO

   -- Uses the View_Individual_Artist view and compact_disk table, to display columns --
 SELECT compact_disk.disk_id, disk_name, times_borrowed
	 FROM disk_has_borrower, borrower, compact_disk 
	WHERE compact_disk.disk_id = disk_borrower_id and borrower_id = disk_has_borrower.disk_id
 GO

   -- Displays all oustanding Books and the last names of the books borrowers --
 SELECT  disk_name, borrowed_date, returned_date, LastName
	FROM disk_has_borrower, borrower, compact_disk 
	WHERE compact_disk.disk_id = disk_borrower_id and borrower_id = disk_has_borrower.disk_id  and returned_date IS NULL 
 GO