USE master;
GO

DROP DATABASE IF EXISTS FinalGroupProject;
CREATE DATABASE FinalGroupProject;
GO

USE FinalGroupProject;

--Semesters Table
DROP TABLE IF EXISTS Semesters;
CREATE TABLE Semesters
	( SemesterID		SMALLINT NOT NULL IDENTITY(1,1),
	  [Year]			SMALLINT NOT NULL,
	  Semester			VARCHAR(6) NOT NULL,
	  BeginDate			DATE NOT NULL,
	  EndDate			DATE NOT NULL
	  CONSTRAINT PK_Semesters_SemesterID PRIMARY KEY ( SemesterID ),
	  CONSTRAINT CHECK_Semesters_Semester CHECK ( Semester IN ( 'Summer', 'Fall', 'Spring') )
);

INSERT INTO Semesters( Year, Semester, BeginDate, EndDate )
VALUES  ( '2017', 'Spring', '2017-01-01', '2017-05-30'), --1
		( '2017', 'Summer', '2017-06-01', '2017-07-31'), --2
		( '2017', 'Fall', '2017-08-01', '2017-11-30' ), --3
		( '2018', 'Spring', '2018-01-01', '2018-05-30' ), --4
		( '2018', 'Summer', '2018-06-01', '2018-07-31' ), --5
		( '2018', 'Fall', '2018-08-01', '2018-11-30' ), --6
		( '2019', 'Spring', '2019-01-01', '2019-05-30' ), --7
		( '2019', 'Summer', '2019-06-01', '2019-07-31' ), --8
		( '2019', 'Fall', '2019-08-01', '2019-11-20' ), --9
		( '2020', 'Spring', '2020-01-01', '2020-05-30' ), --10
		( '2020', 'Summer', '2020-06-01', '2020-07-31' ), --11
		( '2020', 'Fall', '2020-08-01', '2020-11-30' ), --12
		( '2021', 'Spring', '2021-01-01', '2021-05-30' ), --13
		( '2021', 'Summer', '2021-06-01', '2021-07-31' ), --14
		( '2021', 'Fall', '2021-08-01', '2021-11-30' ); --15


--Students Table
DROP TABLE IF EXISTS Students;
CREATE TABLE Students
	( StudentID						INT NOT NULL IDENTITY(1,1),
	  FirstName						VARCHAR(30) NOT NULL,
	  MiddleName					VARCHAR(30) DEFAULT NULL,
	  LastName						VARCHAR(30) NOT NULL,
	  BirthDate						DATE NOT NULL,
	  EnrollmentSemester			SMALLINT NOT NULL,
	  IsAResidentialAdvisor			CHAR(2) NOT NULL,
	  IsASocialJusticeAdvocate		VARCHAR(10) NOT NULL
	  CONSTRAINT PK_Students_StudentID PRIMARY KEY ( StudentID ),
	  CONSTRAINT FK_Students_EnrollmentSemester FOREIGN KEY ( EnrollmentSemester ) REFERENCES Semesters ( SemesterID ),
	  CONSTRAINT CHECK_Students_IsAResidentialAdvisor CHECK ( IsAResidentialAdvisor IN ( 'Y', 'N' ) ),
	  CONSTRAINT CHECK_Students_IsASocialJusticeAdvocate CHECK ( IsASocialJusticeAdvocate IN ( 'Y', 'N' ) )
);

INSERT INTO Students ( FirstName, MiddleName, LastName, BirthDate, EnrollmentSemester, IsAResidentialAdvisor, IsASocialJusticeAdvocate)
VALUES   ( 'Kamri', NULL, 'Garcia', '2000-06-22', '3', 'Y', 'N' ),  --1
		( 'James', 'Farler', 'Hamilton', '2001-05-14','3','Y', 'N' ), --2
		( 'Luis', NULL, 'Ramirez', '2001-05-13', '3', 'Y', 'N '), --3
		( 'William', 'Ezra', 'Tross', '1988-06-06', '3', 'Y', 'N' ), --4
		( 'Conner', 'Typical', 'UtahName', '2000-10-10', '3', 'Y', 'N' ), --5
		( 'Toothless', NULL, 'Joe', '1999-09-02', '6', 'N', 'Y' ), --6
		( 'Homer', 'J', 'Simpson', '1952-11-29', '6', 'N', 'Y' ), --7
		( 'Jacob', 'Tedd', 'Case', '1945-08-21', '6', 'N', 'Y' ), --8
		( 'Alex', 'Bill', 'Connor', '2001-05-26', '6', 'N', 'Y' ), --9
		( 'Orange', 'is', 'Orangne', '1984-02-02', '6', 'N', 'Y' ), --10
		( 'Text', 'ed', 'itor', '2000-04-03', '9', 'N', 'N' ), --11
		( 'Anna', 'Caj', 'Cell', '1998-08-11', '9', 'N', 'N' ), --12
		( 'Guy', 'Pal', 'Buddy', '2001-01-01', '9', 'N', 'N' ), --13
		( 'Sal', NULL, 'Goodman', '1990-01-01', '9', 'N', 'N' ), --14
		( 'Walter', NULL, 'White', '1990-05-07', '9', 'N', 'N'); --15


--ResidentialAdvisors Table
DROP TABLE IF EXISTS ResidentialAdvisors;
CREATE TABLE ResidentialAdvisors
	( StudentID				INT NOT NULL,
	  NumberOfResidents		TINYINT NOT NULL
	  CONSTRAINT PK_ResidentialAdvisors_StudentID PRIMARY KEY ( StudentID ),
	  CONSTRAINT FK_ResidentialAdvisors_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID )
);

INSERT INTO ResidentialAdvisors ( StudentID, NumberOfResidents )
VALUES  ( '1', '2' ), --1
		( '2', '2' ), --2
		( '3', '2' ), --3
		( '4', '2' ), --4
		( '5', '2' ); --5


--SocialJusticeAdvocates Table
DROP TABLE IF EXISTS SocialJusticeAdvocates;
CREATE TABLE SocialJusticeAdvocates
	( StudentID				INT NOT NULL,
	  NumberOfMentees		TINYINT NOT NULL
	  CONSTRAINT PK_SocialJusticeAdvocates_StudentID PRIMARY KEY ( StudentID ),
	  CONSTRAINT FK_SocialJusticeAdvocates_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID )
);

INSERT INTO SocialJusticeAdvocates ( StudentID, NumberOfMentees )
VALUES  ( '6', '2' ), --1
		( '7', '2' ), --2
		( '8', '2' ), --3
		( '9', '2' ), --4
		( '10', '2' ); --5


--StudentEmails Table
DROP TABLE IF EXISTS StudentEmails;
CREATE TABLE StudentEmails
	( StudentID				INT NOT NULL,
	  EmailAddress			VARCHAR(254) NOT NULL,
	  PrimaryEmailFlag		CHAR(1) NOT NULL
	  CONSTRAINT PK_StudentEmails_StudentID_EmailAddress PRIMARY KEY ( StudentID,EmailAddress ),
	  CONSTRAINT FK_StudentEmails_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID ),
	  CONSTRAINT CHECK_StudentEmails_PrimaryEmailFlag CHECK ( PrimaryEmailFlag IN ( 'Y', 'N' ) )
);

INSERT INTO StudentEmails ( StudentID, EmailAddress, PrimaryEmailFlag )
VALUES	( '1', 'student1@university.com', 'Y' ), --1
		( '1', 'lovelykittens@gmail.com' , 'N' ), --1
		( '2', 'student2@university.com', 'Y' ), --2
		( '3', 'student3@university.com', 'Y' ), --3
		( '4', 'student4@university.com', 'Y' ), --4
		( '4', 'ilovedata@gmail.com', 'N' ), --4
		( '5', 'student5@university.com', 'Y' ), --5
		( '6', 'student6@university.com', 'Y' ), --6
		( '7', 'student7@university.com', 'Y' ), --7
		( '8', 'student8@university.com', 'Y' ), --8
		( '8', 'caseiscool@gmail.com', 'N' ), --8
		( '9', 'student9@university.com', 'Y' ), --9
		( '10', 'student10@university.com', 'Y' ), --10
		( '11', 'student11@university.com', 'Y' ), --11
		( '11', 'coddthegod@gmail.com', 'N' ), --1’
		( '12', 'student12@university.com', 'Y' ), --12
		( '13', 'student13@university.com', 'Y' ), --13
		( '13', 'smallint@gmail.com', 'N' ), --13
		( '14', 'student14@university.com', 'Y' ), --14
		( '15', 'student15@university.com', 'Y' ); --15


--StudentPhoneNumbers
DROP TABLE IF EXISTS StudentPhoneNumbers;
CREATE TABLE StudentPhoneNumbers
	( StudentID				INT NOT NULL,
	  PhoneNumber			CHAR(12) NOT NULL,
	  PrimaryPhoneFlag		CHAR(1) NOT NULL
	  CONSTRAINT PK_StudentPhoneNumbers_StudentID_PhoneNumber PRIMARY KEY ( StudentID,PhoneNumber ),
	  CONSTRAINT FK_StudentPhoneNumbers_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID ),
	  CONSTRAINT CHECK_StudentPhoneNumbers_PrimaryPhoneFlag CHECK ( PrimaryPhoneFlag IN ( 'Y', 'N' ) )
);

INSERT INTO StudentPhoneNumbers ( StudentID, PhoneNumber, PrimaryPhoneFlag )
VALUES	( '1', '801-521-5555', 'Y' ), --1
		( '2', '801-522-5555', 'Y' ), --2
		( '2', '385-521-5555', 'N' ), --2
		( '3', '801-523-5555', 'Y' ), --3
		( '4', '801-524-5555', 'Y' ), --4
		( '4', '385-523-5556', 'N' ), --4
		( '5', '801-525-5556', 'Y' ), --5
		( '6', '801-526-5555', 'Y' ), --6
		( '7', '801-527-5555', 'Y' ), --7
		( '8', '801-528-5555', 'Y' ), --8
		( '8', '385-527-5555', 'N' ), --8
		( '9', '801-529-5555', 'Y' ), --9
		( '10', '801-530-5555', 'Y' ), --10
		( '11', '801-531-5555', 'Y' ), --11
		( '12', '801-532-5555', 'Y' ), --12
		( '12', '385-521-5555', 'N' ), --12
		( '13', '801-533-5555', 'Y' ), --13
		( '14', '801-534-5555', 'Y' ), --14
		( '15', '801-535-5555', 'Y' ), --15
		( '15', '385-529-5555', 'N' ); --15


--Employees Table
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees
	( EmployeeID			SMALLINT NOT NULL IDENTITY(1,1),
	  FirstName				VARCHAR(30) NOT NULL,
	  MiddleName			VARCHAR(30) DEFAULT NULL,
	  LastName				VARCHAR(30) NOT NULL,
	  BirthDate				DATE NOT NULL,
	  PhoneNumber			CHAR(12) NOT NULL,
	  Email					VARCHAR(254) NOT NULL,
	  EmployeeType			CHAR(1) NOT NULL,
	  CONSTRAINT PK_Employees_EmployeeID PRIMARY KEY ( EmployeeID ),
	  CONSTRAINT CHECK_Employeess_EmployeeType CHECK ( EmployeeType IN ( 'C', 'A' ) )
	  --C for Custodian and A for Administrator
);

INSERT INTO Employees ( FirstName, MiddleName, LastName, BirthDate, PhoneNumber, Email, EmployeeType )
VALUES  ( 'Michael', NULL, 'Reeve', '1992-09-02', '269-652-4448', 'employee1@university.com', 'C' ), --1
		( 'Maxwell', 'James', 'Smith', '1986-12-06', '761-359-8712', 'employee2@university.com', 'C' ), --2
		( 'Give', 'Me', 'Money', '1984-04-15', '876-427-9833', 'employee3@university.com', 'C' ), --3
		( 'Riley', 'Mac', 'Curtis', '1981-11-21', '976-455-8121', 'employee4@university.com', 'C' ), --4
		( 'Spencer', NULL, 'Thomas', '2000-06-17', '352-771-3417', 'employee5@university.com', 'C' ), --5
		( 'Mary', 'Kate', 'Hopkins', '1997-01-20', '671-809-2254', 'employee6@university.com', 'A' ), --6
		( 'Name', 'Is', 'Null', '1994-03-08', '743-488-9237', 'employee7@university.com', 'A' ), --7
		( 'Taylor', 'Nate', 'Frank', '1992-11-05', '982-447-6985', 'employee8@university.com', 'A' ), --8
		( 'Vanessa', NULL, 'Walker', '2000-07-19', '866-347-2149', 'employee9@university.com', 'A' ), --9
		( 'Bryce', 'Alder', 'Petersen', '1990-10-10', '876-443-6753', 'employee10@university.com', 'A' ), --10
		( 'Gwen', 'Mae', 'Lambert', '2001-08-29', '274-651-1234', 'employee11@university.com', 'A' ), --11
		( 'Wyatt', 'Sully', 'Jackson', '1989-05-22', '947-335-4122', 'employee12@university.com', 'A' ), --12
		( 'Christain', NULL, 'Orange', '1986-01-01', '801-246-1859', 'employee13@university.com', 'A' ), --13
		( 'Nully', NULL, 'Null', '1987-06-21', '876-332-1983', 'employee14@university.com', 'A' ), --14
		( 'Ivey', 'Jane', 'Cowan', '1993-03-19', '976-404-3658', 'employee15@university.com', 'A' ); --15


--Custodians Table
DROP TABLE IF EXISTS CustodianEmployees;
CREATE TABLE CustodianEmployees
	( EmployeeID			SMALLINT NOT NULL,
	  HourlyWage			DECIMAL(5,2) NOT NULL
	  CONSTRAINT PK_CustodianEmployees_EmployeeID PRIMARY KEY ( EmployeeID ),
	  CONSTRAINT FK_CustodianEmployees_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID )
);

INSERT INTO CustodianEmployees ( EmployeeID, HourlyWage )
VALUES  ( '1', '7.25' ), --1
		( '2', '7.25' ), --2
		( '3', '7.25' ), --3
		( '4', '12.50' ), --4
		( '5', '12.50' ); --5


--Administrators Table
DROP TABLE IF EXISTS AdministratorEmployees;
CREATE TABLE AdministratorEmployees
	( EmployeeID			SMALLINT NOT NULL,
	  YearlySalary			DECIMAL(8,2) NOT NULL
	  CONSTRAINT PK_AdministratorEmployees_EmployeeID PRIMARY KEY ( EmployeeID ),
	  CONSTRAINT FK_AdministratorEmployees_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID )
);

INSERT INTO AdministratorEmployees ( EmployeeID, YearlySalary )
VALUES  ( '6', '50000.00' ), --6
		( '7', '60000.00' ), --7
		( '8', '70000.00' ), --8
		( '9', '80000.00' ), --9
		( '10', '90000.00' ), --10
		( '11', '50000.00' ), --11
		( '12', '60000.00' ), --12
		( '13', '70000.00' ), --13
		( '14', '80000.00' ), --14
		( '15', '90000.00' ); --15


--Buildings Table
DROP TABLE IF EXISTS Buildings;
CREATE TABLE Buildings
	( BuildingID			SMALLINT NOT NULL IDENTITY(1,1),
	  BuildingName			VARCHAR(30) NOT NULL,
	  StreetAddress			VARCHAR(40) DEFAULT NULL,
	  City					VARCHAR(30) NOT NULL,
	  [State]				CHAR(2) NOT NULL,
	  Zip					VARCHAR(10) NOT NULL,
	  Floors				TINYINT NOT NULL
	  CONSTRAINT PK_Buildings_BuildingID PRIMARY KEY ( BuildingID ),
);

INSERT INTO Buildings ( BuildingName, StreetAddress, City, State, Zip, Floors )
VALUES  ( 'Marriott Community', '1234 S 5671 E', 'Salt Lake City', 'UT', '84112', '5' ), --1
		( 'Lassonde Studios', '1234 S 5672 E', 'Salt Lake City', 'UT', '84112', '5' ), --2
		( 'Shoreline', '1234 S 5673 E', 'Salt Lake City', 'UT', '82112', '3' ), --3
		( 'Kalhert Village', '1234 S 5674 E', 'Salt Lake City', 'UT', '84112', '6' ), --4
		( 'Foothills Gardens', '1234 S 5675 E', 'Salt Lake City', 'UT', '84112', '2' ); --5


--Rooms Table
DROP TABLE IF EXISTS Rooms;
CREATE TABLE Rooms
	( RoomID			INT NOT NULL IDENTITY(1,1),
	  BuildingID		SMALLINT NOT NULL,
	  [Floor]			TINYINT NOT NULL,
	  NumberOfBeds		TINYINT NOT NULL,
	  CONSTRAINT PK_Rooms_RoomID PRIMARY KEY ( RoomID ),
	  CONSTRAINT FK_Rooms_BuildingID FOREIGN KEY ( BuildingID ) REFERENCES Buildings ( BuildingID )
);

INSERT INTO Rooms ( BuildingID, [Floor], NumberOfBeds )
VALUES  ( '1', '1', '2' ), --1
		( '1', '2', '2' ), --2
		( '1', '3', '2' ), --3
		( '2', '1', '2' ), --4
		( '2', '2', '2' ), --5
		( '2', '3', '2' ), --6
		( '3', '1', '2' ), --7
		( '3', '2', '2' ), --8
		( '3', '3', '2' ), --9
		( '4', '1', '2' ), --10
		( '4', '2', '2' ), --11
		( '4', '3', '2' ), --12
		( '5', '1', '2' ), --13
		( '5', '2', '2' ), --14
		( '5', '2', '2' ); --15


--MaintenanceRequests
DROP TABLE IF EXISTS MaintenanceRequests;
CREATE TABLE MaintenanceRequests
	( RoomID			INT NOT NULL,
	  StudentID			INT NOT NULL,
	  EmployeeID		SMALLINT NOT NULL,
	  [Date]			DATE NOT NULL,
	  Problem			VARCHAR(100) NOT NULL
	  CONSTRAINT PK_MaintenanceRequests_RoomID_StudentID_EmployeeID_Date PRIMARY KEY ( RoomID, StudentID, EmployeeID, Date ),
	  CONSTRAINT FK_MaintenanceRequests_RoomID FOREIGN KEY ( RoomID ) REFERENCES Rooms ( RoomID ),
	  CONSTRAINT FK_MaintenanceRequests_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID ),
	  CONSTRAINT FK_MaintenanceRequests_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID )
);

INSERT INTO MaintenanceRequests ( RoomID, StudentID, EmployeeID, [Date], Problem )
VALUES  ( '6', '1', '2', '2017-08-01', 'Toilet broke'), --1
		( '6', '2', '1', '2017-08-02', 'hole in the ceiling'), --2
		( '7', '3', '2', '2017-08-03', 'my desk broke in half'), --3
		( '7', '4', '3', '2017-08-04', 'a bear broke into my room'), --4 
		( '8', '5', '4', '2017-08-05', 'Toilet broke'), --5
		( '6', '1', '5', '2018-01-05', 'monster under my bed' ), --6
		( '6', '2', '1', '2018-01-06', 'all the lights went out'), --7
		( '7', '3', '2', '2018-01-07', 'I fell through the floor and can’t get out' ), --8
		( '7', '4', '3', '2018-01-08', 'need new pillow case' ), --9
		( '8', '5', '4', '2018-01-09', 'flooding' ), --10
		( '1', '3', '5', '2018-06-10', 'There’s beer all over the floor' ), --11
		( '1', '4', '1', '2018-06-12', 'toilet broke again' ), --12
		( '8', '1', '2', '2018-08-13', 'floor needs to be waxed' ), --13
		( '8', '2', '3', '2018-08-14', 'door handle is broken' ), --14
		( '9', '3', '4', '2018-08-15', 'can you please kick my roommate out' ), --15
		( '9', '4', '5', '2018-08-16', 'Need more beer' ), --16
		( '10', '5', '1', '2018-08-17', 'the sink is clogged' ), --17
		( '10', '6', '2', '2018-08-18', 'a cat is living with us' ), --18
		( '11', '7', '3', '2018-08-19', 'the chair at my desk is broken' ), --19
		( '11', '8', '4', '2018-08-20', 'Can the maintenance employee write my paper?' ), --20
		( '12', '9', '5', '2018-08-21', 'need new keys to the room'), --21
		( '12', '10', '1', '2018-08-22', 'toilet is clogged' ), --22
		( '8', '1', '2', '2019-01-03', 'my roommate got battled' ), --23
		( '8', '2', '3', '2019-01-04', 'floor is sticky from beer' ), --24
		( '9', '3', '4', '2019-01-05', 'sink is clogged' ), --25
		( '9', '4', '5', '2019-01-07', 'a/c won’t turn on' ), --26
		( '10', '5', '1', '2019-01-08', 'window is broken' ), --27
		( '10', '6', '2', '2019-01-09', 'I need help with my math homework' ), --28
		( '11', '7', '3', '2019-01-10', 'dog ate my homework' ), --29
		( '11', '8', '4', '2019-01-11', 'my room is overflowing with pizza hut boxes' ), --30
		( '12', '9', '5', '2019-01-12', 'toilet is broken' ), --31
		( '12', '10', '1', '2019-01-13', 'there’s a hole in the wall' ), --32
		( '2', '7', '2', '2019-06-04', 'sink is clogged' ), --33
		( '2', '8', '3', '2019-06-05', 'need more beer' ), --34
		( '3', '9', '4', '2019-06-06', 'can you install a bookshelf?' ), --35
		( '12', '11', '5', '2019-08-07', 'hole in the floor' ), --36
		( '12', '12', '1', '2019-08-08', 'My roommate is annoying me' ), --37
		( '14', '13', '1', '2019-08-08', 'I need help with my IS 4420 Final'), --38
		( '14', '14', '2', '2019-08-09', 'bed is broken' ), --39
		( '15', '15', '3', '2019-08-10', 'door handle broke' ); --40


--Beds Table
DROP TABLE IF EXISTS Beds;
CREATE TABLE Beds
	( BedID				INT NOT NULL IDENTITY(1,1),
	  RoomID			INT NOT NULL,
	  BedType			VARCHAR(6) NOT NULL,
	  CurrentPrice		DECIMAL(7,2) NOT NULL
	  CONSTRAINT PK_Beds_BedID PRIMARY KEY ( BedID ),
	  CONSTRAINT FK_Beds_RoomID FOREIGN KEY ( RoomID ) REFERENCES Rooms ( RoomID ),
	  CONSTRAINT CHECK_Beds_BedType CHECK ( BedType IN ( 'Full', 'TwinXL') )
);

INSERT INTO Beds ( RoomID, BedType, CurrentPrice )
VALUES  ( '1', 'Full', '2100.00' ), --1
		( '1', 'Full', '2100.00' ), --2
		( '2', 'Full', '2100.00' ), --3
		( '2', 'Full', '2100.00' ), --4
		( '3', 'TwinXL', '2100.00' ), --5
		( '3', 'TwinXL', '2100.00' ), --6
		( '4', 'TwinXL', '2100.00' ), --7
		( '4', 'TwinXL', '2100.00' ), --8
		( '5', 'Full', '2100.00' ), --9
		( '5', 'Full', '2100.00' ), --10
		( '6', 'Full', '2100.00' ), --11
		( '6', 'Full', '2100.00' ), --12
		( '7', 'Full', '2100.00' ), --13
		( '7', 'Full', '2100.00' ), --14
		( '8', 'Full', '2100.00' ), --15
		( '8', 'Full', '2100.00' ), --16
		( '9', 'Full', '2100.00' ), --17
		( '9', 'Full', '2100.00' ), --18
		( '10', 'TwinXL', '2100.00' ), --19
		( '10', 'TwinXL', '2100.00' ), --20
		( '11', 'TwinXL', '2100.00' ), --21
		( '11', 'TwinXL', '2100.00' ), --22
		( '12', 'Full', '2100.00' ), --23
		( '12', 'Full', '2100.00' ), --24
		( '13', 'TwinXL', '2100.00' ), --25
		( '13', 'TwinXL', '2100.00' ), --26
		( '14', 'TwinXL', '2100.00' ), --27
		( '14', 'TwinXL', '2100.00' ), --28
		( '15', 'Full', '2100.00' ), --29
		( '15', 'Full', '2100.00' ); --30


--BedOccupancy Table
DROP TABLE IF EXISTS BedOccupancy;
CREATE TABLE BedOccupancy
	( OccupancyID		INT NOT NULL IDENTITY(1,1),
	 StudentID			INT NOT NULL,
	 BedID				INT NOT NULL,
	 SemesterID			SMALLINT NOT NULL,
	 Price				DECIMAL(7,2) NOT NULL
	 CONSTRAINT PK_BedOccupancy_OccupancyID PRIMARY KEY ( OccupancyID ),
	 CONSTRAINT FK_BedOccupancy_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID ),
	 CONSTRAINT FK_BedOccupancy_BedID FOREIGN KEY ( BedID ) REFERENCES Beds ( BedID ),
	 CONSTRAINT FK_BedOccupancy_SemesterID FOREIGN KEY ( SemesterID ) REFERENCES Semesters ( SemesterID )
);

INSERT INTO BedOccupancy ( StudentID, BedID, SemesterID, Price )
VALUES  ( '1', '11', '3', '1500.00' ), --1
		( '2', '12', '3', '1500.00' ), --2
		( '3', '13', '3', '1500.00' ), --3
		( '4', '14', '3', '1500.00' ), --4
		( '5', '15', '3', '1500.00' ), --5
		( '1', '11', '4', '1600.00' ), --6
		( '2', '12', '4', '1600.00' ), --7
		( '3', '13', '4', '1600.00' ), --8
		( '4', '14', '4', '1600.00' ), --9
		( '5', '15', '4', '1600.00' ), --10
		( '3', '1', '5', '1600.00' ), --11
		( '4', '2', '5', '1600.00' ), --12
		( '1', '15', '6', '1700.00' ), --13
		( '2', '16', '6', '1700.00' ), --14
		( '3', '17', '6', '1700.00' ), --15
		( '4', '18', '6', '1700.00' ), --16
		( '5', '19', '6', '1700.00' ), --17
		( '6', '20', '6', '1700.00' ), --18
		( '7', '21', '6', '1700.00' ), --19
		( '8', '22', '6', '1700.00' ), --20
		( '9', '23', '6', '1700.00' ), --21
		( '10', '24', '6', '1700.00' ), --22
		( '1', '15', '7', '1800.00' ), --23
		( '2', '16', '7', '1800.00' ), --24
		( '3', '17', '7', '1800.00' ), --25
		( '4', '18', '7', '1800.00' ), --26
		( '5', '19', '7', '1800.00' ), --27
		( '6', '20', '7', '1800.00' ), --28
		( '7', '21', '7', '1800.00' ), --29
		( '8', '22', '7', '1800.00' ), --30
		( '9', '23', '7', '1800.00' ), --31
		( '10', '24', '7', '1800.00' ), --32
		( '7', '3', '8', '1900.00' ), --33
		( '8', '4', '8', '1900.00' ), --34
		( '9', '5', '8', '1900.00' ), --35
		( '11', '25', '9', '2000.00' ), --36
		( '12', '26', '9', '2000.00' ), --37
		( '13', '27', '9', '2000.00' ), --38
		( '14', '28', '9', '2000.00' ), --39
		( '15', '24', '9', '2000.00' ), --40
		( '1', '23', '9', '2000.00' ), --41
		( '2', '22', '9', '2000.00' ), --42
		( '3', '21', '9', '2000.00' ), --43
		( '4', '20', '9', '2000.00' ), --44
		( '5', '19', '9', '2000.00' ), --45
		( '6', '18', '9', '2000.00' ), --41
		( '7', '17', '9', '2000.00' ), --42
		( '8', '16', '9', '2000.00' ), --43
		( '9', '15', '9', '2000.00' ), --44
		( '10', '14', '9', '2000.00' ); --45


--MealPlans Table
DROP TABLE IF EXISTS MealPlans;
CREATE TABLE MealPlans
	( MealPlanID		TINYINT NOT NULL IDENTITY(1,1),
	  MealsPerWeek		TINYINT NOT NULL,
	  CurrentPrice		DECIMAL(6,2) NOT NULL,
	  CONSTRAINT PK_MealPlans_MealPlanID PRIMARY KEY ( MealPlanID )
);

INSERT INTO MealPlans ( MealsPerWeek, CurrentPrice )
VALUES  ( '21', '2500.00' ), --1
		( '14', '2200.00' ), --2
		( '7', '1600.00' ); --3


--MealPlanPayments Table
DROP TABLE IF EXISTS MealPlanPayments;
CREATE TABLE MealPlanPayments
	( OccupancyID		INT NOT NULL,
	  MealPlanID		TINYINT NOT NULL,
	  [Date]			DATE NOT NULL,
	  Amount			DECIMAL(7,2) NOT NULL
	  CONSTRAINT PK_MealPlanPayments_OccupancyID_Date PRIMARY KEY ( OccupancyID, MealPlanID, [Date] ),
	  CONSTRAINT FK_MealPlanPayments_MealPlanID FOREIGN KEY ( MealPlanID ) REFERENCES MealPlans ( MealPlanID ),
	  CONSTRAINT FK_MealPlanPayments_OccupancyID FOREIGN KEY ( OccupancyID ) REFERENCES BedOccupancy ( OccupancyID )
);

INSERT INTO MealPlanPayments ( OccupancyID, MealPlanID, Date, Amount )
VALUES  ( '1', '3', '2017-08-01', '1400.00' ), --1
		( '2', '1', '2017-08-01', '2300.00' ), --2
		( '3', '2', '2017-08-01', '2000.00' ), --3
		( '4', '2', '2017-08-01', '2000.00' ), --4
		( '5', '1', '2017-08-01', '2300.00' ), --5
		( '6', '3', '2018-01-01', '1400.00' ), --6
		( '7', '3', '2018-01-01', '1400.00' ), --7
		( '8', '2', '2018-01-01', '2000.00' ), --8
		( '9', '1', '2018-01-01', '2300.00' ), --9
		( '10', '1', '2018-01-01', '2300.00' ), --10
		( '11', '2', '2018-06-01', '2000.00' ), --11
		( '12', '3', '2018-06-01', '1400.00' ), --12
		( '13', '3', '2018-08-01', '1400.00' ), --13
		( '14', '2', '2018-08-01', '2000.00' ), --14
		( '15', '1', '2018-08-01', '2300.00' ), --15
		( '16', '2', '2018-08-01', '2000.00' ), --16
		( '17', '3', '2018-08-01', '1400.00' ), --17
		( '18', '2', '2018-08-01', '2000.00' ), --18
		( '19', '2', '2018-08-01', '2000.00' ), --19
		( '20', '1', '2018-08-01', '2300.00' ), --20
		( '21', '1', '2018-08-01', '2300.00' ), --21
		( '22', '2', '2018-08-01', '2100.00' ), --22
		( '23', '3', '2019-01-01', '1500.00' ), --23
		( '24', '2', '2019-01-01', '2100.00' ), --24
		( '25', '1', '2019-01-01', '2400.00' ), --25
		( '26', '3', '2019-01-01', '1500.00' ), --26
		( '27', '2', '2019-01-01', '2100.00' ), --27
		( '28', '3', '2019-01-01', '1500.00' ), --28
		( '29', '1', '2019-01-01', '2400.00' ), --29
		( '30', '3', '2019-01-01', '1500.00' ), --30
		( '31', '2', '2019-01-01', '2100.00' ), --31
		( '32', '2', '2019-01-01', '2100.00' ), --32
		( '33', '1', '2019-06-01', '2500.00' ), --33
		( '34', '1', '2019-06-01', '2500.00' ), --34
		( '35', '2', '2019-06-01', '2200.00' ), --35
		( '36', '2', '2019-08-01', '2200.00' ), --36
		( '37', '1', '2019-08-01', '2500.00' ), --37
		( '38', '1', '2019-08-01',  '2500.00' ), --38
		( '39', '1', '2019-08-01', '2500.00' ), --39
		( '40', '1', '2019-08-01', '2500.00' ); --40


--HousingPayments Table
DROP TABLE IF EXISTS HousingPayments;
CREATE TABLE HousingPayments
	( OccupancyID		INT NOT NULL,
	  [Date]			DATE NOT NULL,
	  Amount			DECIMAL(7,2) NOT NULL
	  CONSTRAINT PK_HousingPayments_OccupancyID_Date PRIMARY KEY ( OccupancyID, Date ),
	  CONSTRAINT FK_HousingPayments_OccupancyID FOREIGN KEY ( OccupancyID ) REFERENCES BedOccupancy ( OccupancyID )
);

INSERT INTO HousingPayments ( OccupancyID, [Date], Amount )
VALUES   ( '1', '2017-08-01', '1500.00' ), --1
		 ( '2', '2017-08-01', '1500.00' ), --2
		 ( '3', '2017-08-01', '1500.00' ), --3
		 ( '4', '2017-08-01', '1500.00' ), --4
		 ( '5', '2017-08-01', '1500.00' ), --5
		 ( '6', '2018-01-01', '1600.00' ), --6
		 ( '7', '2018-01-01', '1600.00' ), --7
		 ( '8', '2018-01-01', '1600.00' ), --8
		 ( '9', '2018-01-01', '1600.00' ), --9
		 ( '10', '2018-01-01', '1600.00' ), --10
		 ( '11', '2018-06-01', '1600.00' ), --11
		 ( '12', '2018-06-01', '1600.00' ), --12
		 ( '13', '2018-08-01', '1700.00' ), --13
		 ( '14', '2018-08-01', '1700.00' ), --14
		 ( '15', '2018-08-01', '1700.00' ), --15
		 ( '16', '2018-08-01', '1700.00' ), --16
		 ( '17', '2018-08-01', '1700.00' ), --17
		 ( '18', '2018-08-01', '1700.00' ), --18
		 ( '19', '2018-08-01', '1700.00' ), --19
		 ( '20', '2018-08-01', '1700.00' ), --20
		 ( '21', '2018-08-01', '1700.00' ), --21
		 ( '22', '2018-08-01', '1700.00' ), --22
		 ( '23', '2019-01-01', '1800.00' ), --23
		 ( '24', '2019-01-01', '1800.00' ), --24
		 ( '25', '2019-01-01', '1800.00' ), --25
		 ( '26', '2019-01-01', '1800.00' ), --26
		 ( '27', '2019-01-01', '1800.00' ), --27
		 ( '28', '2019-01-01', '1800.00' ), --28
		 ( '29', '2019-01-01', '1800.00' ), --29
		 ( '30', '2019-01-01', '1800.00' ), --30
		 ( '31', '2019-01-01', '1800.00' ), --31
		 ( '32', '2019-01-01', '1800.00' ), --32
		 ( '33', '2019-06-01', '1900.00' ), --33
		 ( '34', '2019-06-01', '1900.00' ), --34
		 ( '35', '2019-06-01', '1900.00' ), --35
		 ( '36', '2019-08-01', '2000.00' ), --36
		 ( '37', '2019-08-01', '2000.00' ), --37
		 ( '38', '2019-08-01', '2000.00' ), --38
		 ( '39', '2019-08-01', '2000.00' ), --39
		 ( '40', '2019-08-01', '2000.00' ); --40


--Cancellations Table
DROP TABLE IF EXISTS Cancellations;
CREATE TABLE Cancellations
	( OccupancyID		INT NOT NULL,
	  [Date]			DATE NOT NULL,
	  Reason			VARCHAR(100) NOT NULL
	  CONSTRAINT PK_Cancellations_OccupancyID_Date PRIMARY KEY ( OccupancyID, Date ),
	  CONSTRAINT FK_Cancellations_OccupancyID FOREIGN KEY ( OccupancyID ) REFERENCES BedOccupancy ( OccupancyID )
);

INSERT INTO Cancellations ( OccupancyID, [Date], Reason )
VALUES  ( '41', '2019-08-01', 'Broke' ), --1
		( '42', '2019-08-01', 'Too Expensive' ), --2
		( '43', '2019-08-01', 'Expelled' ), --3
		( '44', '2019-08-01', 'Dropped Out' ), --4
		( '45', '2019-08-01', 'Arrested' ), --5
		( '46', '2019-08-01', 'Died' ), --6
		( '47', '2019-08-01', 'Missed Payment' ), --7
		( '48', '2019-08-01', 'Missed Deadline' ), --8
		( '49', '2019-08-01', 'The coronavirus pandemic' ), --9
		( '50', '2019-08-01', 'Data Entry' ); --10


--ParkingPermits Table
DROP TABLE IF EXISTS ParkingPermits;
CREATE TABLE ParkingPermits
	( PermitID				INT NOT NULL IDENTITY(1,1),
	  StudentID				INT DEFAULT NULL,
	  EmployeeID			SMALLINT DEFAULT NULL,
	  LicensePlateNumber	VARCHAR(10) NOT NULL,
	  VehicleMake			VARCHAR(30) NOT NULL,
	  VehicleModel			VARCHAR(30) NOT NULL,
	  Color					VARCHAR(30) NOT NULL
	  CONSTRAINT PK_ParkingPermits_PermitID PRIMARY KEY ( PermitID ),
	  CONSTRAINT FK_ParkingPermits_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID ),
	  CONSTRAINT FK_ParkingPermits_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID )
);

INSERT INTO ParkingPermits ( StudentID, LicensePlateNumber, VehicleMake, VehicleModel, Color )
VALUES  ( '1', 'K939KF', 'Toyota', '4runner', 'Black'), --1
		( '2', 'U9N84S', 'Ford', 'Mustang', 'White'), --2
		( '3', 'X32LR4', 'Toyota', 'Carolla', 'Black'), --3
		( '4', 'MYSQL', 'Honda', 'Civic', 'Blue'), --4
		( '5', 'UN56S4', 'Honda', 'Accord', 'Black'), --5
		( '6', 'KF68R1', 'BMW', 'X3', 'Red'), --6
		( '7', 'B789CQ', 'Subaru', 'Forester', 'Blue'), --7
		( '8', 'YU5R7Y', 'Subaru', 'Forester', 'Silver'), --8
		( '9', 'ACCESS', 'Tesla', 'Model 3', 'Yellow'), --9
		( '10', 'HJ386G', 'Tesla', 'Model 3', 'White'), --10
		( '11', 'N2978F', 'Tesla', 'Model 3', 'Blue'), --11
		( '12', '1DZ70B', 'Honda', 'Civic', 'Black'), --12
		( '13', 'LUCKY', 'Honda', 'Civic', 'Red'), --13
		( '14', 'B1E49T', 'Honda', 'Civic', 'Black'), --14
		( '15', 'D4O2W7', 'Honda', 'Civic', 'White'); --15

INSERT INTO ParkingPermits ( EmployeeID, LicensePlateNumber, VehicleMake, VehicleModel, Color )
VALUES  ( '1', 'K839KF', 'Nissan', 'Frontier', 'Black'), --16
		( '2', 'U8N84S', 'Nissan', 'Pathfinder', 'White'), --17
		( '3', 'TEDDCODD', 'Nissan', 'Altima', 'Black'), --18
		( '4', 'M6Y5J9', 'Tesla', 'Cybertruck', 'Blue'), --19
		( '5', 'UN46S4', 'Tesla', 'Cybertruck', 'Black'), --20
		( '6', 'KF48R1', 'Tesla', 'Model X', 'Red'), --21
		( '7', 'B779CQ', 'Subaru', 'STI', 'Blue'), --22
		( '8', 'DATA', 'Subaru', 'WRX', 'Silver'), --23
		( '9', '1J389H', 'Tesla', 'Model 3', 'Yellow'), --24
		( '10', 'HJ286G', 'Tesla', 'Model S', 'White'), --25
		( '11', 'N2778F', 'Tesla', 'Roadster', 'Blue'), --26
		( '12', '1DA70B', 'Ford', 'F-150', 'Black'), --27
		( '13', 'KARMA', 'Ford', 'F-250', 'Red'), --28
		( '14', 'B1E39T', 'Ford', 'Fusion', 'Black'), --29
		( '15', 'JAXON', 'Lamborghini', 'Aventador', 'White'); --30


--ParkingPayments Table
DROP TABLE IF EXISTS ParkingPayments;
CREATE TABLE ParkingPayments
( PermitID		INT NOT NULL,
  [Date]		DATE NOT NULL,
  Amount		DECIMAL(6,2) NOT NULL
  CONSTRAINT PK_ParkingPayments_PermitID_Date PRIMARY KEY ( PermitID, Date ),
  CONSTRAINT FK_ParkingPayments_PermitID FOREIGN KEY ( PermitID ) REFERENCES ParkingPermits ( PermitID )
);

INSERT INTO ParkingPayments ( PermitID, [Date], Amount )
VALUES  ( '1', '2019-01-01', '200.00' ), --1
		( '2', '2019-01-01', '200.00' ), --2
		( '3', '2019-01-01', '200.00' ), --3
		( '4', '2019-01-01', '200.00' ), --4
		( '5', '2019-01-01', '200.00' ), --5
		( '6', '2019-01-01', '200.00' ), --6
		( '7', '2019-01-01', '200.00' ), --7
		( '8', '2019-01-01', '200.00' ), --8
		( '9', '2019-01-01', '200.00' ), --9
		( '10', '2019-01-01', '200.00' ), --10
		( '11', '2019-08-01', '200.00' ), --11
		( '12', '2019-08-01', '200.00' ), --12
		( '13', '2019-08-01', '200.00' ), --13
		( '14', '2019-08-01', '200.00' ), --14
		( '15', '2019-08-01', '200.00' ), --15
		( '16', '2019-08-01', '200.00' ), --16
		( '17', '2019-08-01', '200.00' ), --17
		( '18', '2019-08-01', '200.00' ), --18
		( '19', '2019-08-01', '200.00' ), --19
		( '20', '2019-08-01', '200.00' ), --20
		( '21', '2019-08-01', '200.00' ), --21
		( '22', '2019-08-01', '200.00' ), --22
		( '23', '2019-08-01', '200.00' ), --23
		( '24', '2019-08-01', '200.00' ), --24
		( '25', '2019-08-01', '200.00' ), --25
		( '26', '2019-08-01', '200.00' ), --26
		( '27', '2019-08-01', '200.00' ), --27
		( '28', '2019-08-01', '200.00' ), --28
		( '29', '2019-08-01', '200.00' ), --29
		( '30', '2019-08-01', '200.00' ); --30


--1. Student Information Query
SELECT  S.StudentID,
		CONCAT(S.FirstName, ' ', S.MiddleName, ' ', S.LastName ) AS StudentName,
		CONCAT (Sem.Year, ' ', Sem.Semester ) AS EnrollmentYear,
		SE.EmailAddress AS PrimaryEmail,
		SPN.PhoneNumber AS PrimaryPhone,
		S.IsAResidentialAdvisor,
		S.IsASocialJusticeAdvocate
FROM Students AS S
JOIN Semesters AS Sem ON S.EnrollmentSemester = Sem.SemesterID
JOIN StudentEmails AS SE ON S.StudentID = SE.StudentID
JOIN StudentPhoneNumbers AS SPN ON S.StudentID = SPN.StudentID
WHERE PrimaryEmailFlag = 'Y' AND PrimaryPhoneFlag = 'Y';

--2. Administrative Employee Information Query
SELECT  E.EmployeeID,
		CONCAT( E.FirstName, ' ', E.MiddleName, ' ', E.LastName ) AS EmployeeName,
		E.BirthDate,
		E.Email,
		E.PhoneNumber,
		AE.YearlySalary
FROM Employees AS E
JOIN AdministratorEmployees AS AE ON E.EmployeeID = AE.EmployeeID
WHERE E.EmployeeType = 'A';

--3. Maintenance Requests Query
SELECT  B.BuildingName,
		R.Floor,
		MR.RoomID,
		CONCAT( S.FirstName, ' ', S.LastName ) AS StudentResident,
		MR.Problem,
		CONCAT( E.FirstName, ' ', E.LastName ) AS AssignedCustodian
FROM MaintenanceRequests AS MR
JOIN Students AS S ON MR.StudentID = S.StudentID
JOIN Employees AS E ON MR.EmployeeID = E.EmployeeID
JOIN Rooms AS R ON MR.RoomID = R.RoomID
JOIN Buildings AS B ON R.BuildingID = B.BuildingID;

--4. Housing Revenue Per Semester Query
SELECT  S.SemesterID,
		CONCAT( S.Year, ' ', S.Semester) AS Semester,
		SUM( HP.Amount) AS TotalRevenue
FROM HousingPayments AS HP
JOIN BedOccupancy AS BE ON HP.OccupancyID = BE.OccupancyID
JOIN Semesters AS S ON BE.SemesterID = S.SemesterID
GROUP BY S.SemesterID,
		 CONCAT( S.Year, ' ', S.Semester)
ORDER BY S.SemesterID ASC;

--5. Meal Plan Revenue Per Semester Query
SELECT  S.SemesterID,
		CONCAT( S.Year, ' ', S.Semester ) AS Semester,
		SUM( MPP.Amount ) AS TotalRevenue
FROM MealPlanPayments AS MPP
JOIN BedOccupancy AS BO ON MPP.OccupancyID = BO.OccupancyID
JOIN Semesters AS S ON BO.SemesterID = S.SemesterID
GROUP BY S.SemesterID,
		 CONCAT( S.Year, ' ', S.Semester )
ORDER BY S.SemesterID ASC;

/*--Room Information Query
SELECT  B.BedID,
		Build.BuildingName,
		R.Floor,
		R.RoomID
FROM Beds AS B
JOIN Rooms AS R ON B.RoomID = R.RoomID
JOIN Buildings AS Build ON R.BuildingID = Build.BuildingID; */

--Parking Permit Info Stored Procedure
DROP PROCEDURE IF EXISTS GetPermitInfo;
CREATE PROCEDURE
( @LicensePlateNumber		VARCHAR(10)
)
AS
BEGIN
	DECLARE @PermitID INT

	BEGIN TRANSACTION;
	SET @PermitID = (	SELECT PP.PermitID
						FROM ParkingPermits AS PP
						WHERE LicensePlateNumber = @LicensePlateNumber);
	SELECT	S.StudentID,
			CONCAT(S.FirstName, ' ', S.LastName) AS Name,
			PP.LicensePlateNumber,
			PP.VehicleMake,
			PP.VehicleModel,
			PP.Color
	FROM ParkingPermits AS PP
	JOIN Students AS S ON PP.StudentID = S.StudentID
	WHERE PermitID = @PermitID;

	COMMIT;
END;


CREATE TABLE ParkingPermits
	( PermitID				INT NOT NULL IDENTITY(1,1),
	  StudentID				INT DEFAULT NULL,
	  EmployeeID			SMALLINT DEFAULT NULL,
	  LicensePlateNumber	VARCHAR(10) NOT NULL,
	  VehicleMake			VARCHAR(30) NOT NULL,
	  VehicleModel			VARCHAR(30) NOT NULL,
	  Color					VARCHAR(30) NOT NULL
	  CONSTRAINT PK_ParkingPermits_PermitID PRIMARY KEY ( PermitID ),
	  CONSTRAINT FK_ParkingPermits_StudentID FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentID ),
	  CONSTRAINT FK_ParkingPermits_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID )
);

/*
DROP PROCEDURE IF EXISTS GetCustomerInfo;

CREATE PROCEDURE GetCustomerInfo
	(@CustomerEmail		VARCHAR(254)
	)
AS
BEGIN
	DECLARE @CustomerID INT;

	BEGIN TRANSACTION;
		SET @CustomerID = ( SELECT CustomerID
							FROM CustomerEmails
							WHERE EmailAddress = @CustomerEmail);
		SELECT *
		FROM CustomerInfo
		WHERE CustomerID = @CustomerID;

		COMMIT;
END;




SELECT	S.StudentID,
		CONCAT(S.FirstName, ' ', S.LastName) AS Name,
		PP.LicensePlateNumber,
		PP.VehicleMake,
		PP.VehicleModel,
		PP.Color
FROM ParkingPermits AS PP
JOIN Students AS S ON PP.StudentID = S.StudentID
WHERE LicensePlateNumber =

SELECT	*
FROM ParkingPermits AS PP
JOIN Employees AS E ON PP.EmployeeID = E.EmployeeID

SELECT *
FROM ParkingPayments AS PAY
JOIN ParkingPermits AS PER ON PAY.PermitID = PAY.PermitID;
