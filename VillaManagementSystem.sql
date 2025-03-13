--------Villa Management System------------

CREATE DATABASE VillaManagementSystem

USE VillaManagementSystem

-------Gender Table----------------
CREATE TABLE Gender (GenderID int Primary Key, Gender Varchar(20) );

insert into Gender values (1,'Male'),(2,'Female'),(3,'Others');
Select * from Gender;

------Highest Education Table-------------
Create table HighestEducation (EducationID int Primary Key, Education Varchar(100));

INSERT INTO HighestEducation VALUES (1,'B.Tech'), (2,'MBA'), (3,'Diploma'), (4,'M.Tech'), (5,'B.Sc');
Select * from HighestEducation;

---------BloodGroup table-------------------
Create table BloodGroup (BloodGroupID int primary key, BloodGroup Varchar(10) );

Insert Into BloodGroup Values (1,'A+'), (2,'A-'), (3,'B+'), (4,'B-'), (5,'O+'), (6,'O-'), (7,'AB+'), (8,'AB-');
Select * from BloodGroup;

-------Relation Table-------------------------
Create table Relation (RelationID int Primary Key, Relation Varchar(50) );

Insert into Relation values (1,'Father'),(2,'Mother'),(3,'Husband'),(4,'Wife');
Select * from Relation;

-----------------Employee Table ----------------------

CREATE TABLE Employee ( EmployeeID INT PRIMARY KEY Identity(101,1),
                         FirstName VARCHAR(50) NOT NULL,
						 MiddleName VARCHAR(50),
						 LastName VARCHAR(50) NOT NULL,
						 GenderID INT FOREIGN KEY REFERENCES Gender(GenderID),
                         DateOfBirth DATE NOT NULL,
						 OfficialEmail VARCHAR(100) NOT NULL UNIQUE,
						 PresentAddress VARCHAR(500) NOT NULL,
						 PermanentAddress VARCHAR(500) NOT NULL, 
						 PrimaryMobile CHAR(10) NOT NULL,             
                         AlternateMobile CHAR(10), 
						 AadhaarNumber CHAR(12) NOT NULL UNIQUE, 
						 PANNumber CHAR(10) NOT NULL UNIQUE, 
                         DateOfJoining DATE NOT NULL, 
						 CTC DECIMAL(10,2) NOT NULL, 
						 Designation VARCHAR(50) NOT NULL, 
						 Experience VARCHAR(50) NOT NULL,
                         EducationID INT FOREIGN KEY REFERENCES HighestEducation(EducationID), 
						 YearOfPassing INT NOT NULL, 
						 BankName VARCHAR(50) NOT NULL, 
                         AccountNumber VARCHAR(20) NOT NULL, 
						 IFSCCode VARCHAR(11) NOT NULL, 
						 BranchAddress VARCHAR(200) NOT NULL,
                         BloodGroupID INT FOREIGN KEY REFERENCES BloodGroup(BloodGroupID), 
						 RelationID INT FOREIGN KEY REFERENCES Relation(RelationID),
                         RelativeName VARCHAR(100), 
						 RelativeMobile CHAR(10), 
						 IsActive BIT DEFAULT 1, 
						 LastWorkingDay DATE, 
                         CONSTRAINT CHK_Year CHECK (YearOfPassing BETWEEN 1900 AND YEAR(GETDATE())) ); 

Select * from Employee;
-------------------- Stored Procedures ---------------------------------

-------------------1.AddEmployee----------------------------------------
CREATE PROCEDURE AddEmployee (@FirstName VARCHAR(50),@MiddleName VARCHAR(50),
                              @LastName VARCHAR(50),  @GenderID INT, 
                              @DateOfBirth DATE,  @OfficialEmail VARCHAR(100), @PresentAddress VARCHAR(500),
                              @PermanentAddress VARCHAR(500), @PrimaryMobile CHAR(10), 
                              @AlternateMobile CHAR(10), @AadhaarNumber CHAR(12),   @PANNumber CHAR(10), 
                              @DateOfJoining DATE, @CTC DECIMAL(10,2), @Designation VARCHAR(50), 
							  @Experience VARCHAR(50), @EducationID INT, @YearOfPassing INT,  
							  @BankName VARCHAR(50),   @AccountNumber VARCHAR(20), @IFSCCode VARCHAR(11),   
							  @BranchAddress VARCHAR(200),   @BloodGroupID INT,   @RelationID INT,
                              @RelativeName VARCHAR(100),   @RelativeMobile CHAR(10) )
     AS
          BEGIN 
                 INSERT INTO Employee ( FirstName, MiddleName, LastName, GenderID, DateOfBirth, OfficialEmail, PresentAddress, PermanentAddress,
                                         PrimaryMobile, AlternateMobile, AadhaarNumber, PANNumber, DateOfJoining, CTC, Designation,   
                                         Experience, EducationID,YearOfPassing, BankName, AccountNumber, IFSCCode, BranchAddress,
                                         BloodGroupID, RelationID, RelativeName, RelativeMobile )
                       VALUES ( @FirstName, @MiddleName, @LastName, @GenderID, @DateOfBirth, @OfficialEmail, @PresentAddress, @PermanentAddress,
                                    @PrimaryMobile,@AlternateMobile, @AadhaarNumber, @PANNumber, @DateOfJoining, @CTC, @Designation,
                                    @Experience, @EducationID, @YearOfPassing, @BankName, @AccountNumber, @IFSCCode, @BranchAddress,
                                    @BloodGroupID, @RelationID, @RelativeName, @RelativeMobile
                               )
       END 

------------------------2. Update Employee-----------------------------------------------------------------
CREATE PROCEDURE UpdateEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @MiddleName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @OfficialEmail VARCHAR(100),
    @PresentAddress VARCHAR(500),
    @PermanentAddress VARCHAR(500),
    @PrimaryMobile CHAR(10),
    @AlternateMobile CHAR(10),
    @DateOfJoining DATE,
    @CTC DECIMAL(10,2),
    @Designation VARCHAR(50),
    @Experience VARCHAR(50),
    @EducationID INT,
    @YearOfPassing INT,
    @BankName VARCHAR(50),
    @AccountNumber VARCHAR(20),
    @IFSCCode VARCHAR(11),
    @BranchAddress VARCHAR(200),
    @BloodGroupID INT,
    @RelationID INT,
    @RelativeName VARCHAR(100),
    @RelativeMobile CHAR(10)
AS
BEGIN
    UPDATE Employee SET
        FirstName = @FirstName,
        MiddleName = @MiddleName,
        LastName = @LastName,
        DateOfBirth = @DateOfBirth,
        OfficialEmail = @OfficialEmail,
        PresentAddress = @PresentAddress,
        PermanentAddress = @PermanentAddress,
        PrimaryMobile = @PrimaryMobile,
        AlternateMobile = @AlternateMobile,
        DateOfJoining = @DateOfJoining,
        CTC = @CTC,
        Designation = @Designation,
        Experience = @Experience,
        EducationID = @EducationID,
        YearOfPassing = @YearOfPassing,
        BankName = @BankName,
        AccountNumber = @AccountNumber,
        IFSCCode = @IFSCCode,
        BranchAddress = @BranchAddress,
        BloodGroupID = @BloodGroupID,
        RelationID = @RelationID,
        RelativeName = @RelativeName,
        RelativeMobile = @RelativeMobile
    WHERE EmployeeID = @EmployeeID
END

-----------------------3. Relive Employee----------------------------------------
CREATE PROCEDURE RelieveEmployee ( @EmployeeID INT)
AS              
  BEGIN                           
        UPDATE Employee SET IsActive = 0, LastWorkingDay = GETDATE() WHERE EmployeeID = @EmployeeID
END 

-----------------------3. Get Active Employees------------------------------------
CREATE PROCEDURE GetActiveEmployees
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.DateOfBirth,
        g.Gender,
        e.DateOfJoining,
        e.Designation,
        e.CTC,
        e.PrimaryMobile,
        e.OfficialEmail
    FROM 
        Employee e
    INNER JOIN 
        Gender g ON e.GenderID = g.GenderID
    WHERE 
        e.IsActive = 1  
    ORDER BY 
        e.EmployeeID
END
------------------------------Get InActive Employees ----------------------------
CREATE PROCEDURE GetInActiveEmployees
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.DateOfBirth,
        g.Gender,
        e.DateOfJoining,
        e.Designation,
        e.CTC,
        e.PrimaryMobile,
        e.OfficialEmail,
		e.LastWorkingDay
    FROM 
        Employee e
    INNER JOIN 
        Gender g ON e.GenderID = g.GenderID
    WHERE 
        e.IsActive = 0 
    ORDER BY 
        e.EmployeeID
END
-----------------------------------------------------------------------------------------------------

CREATE PROCEDURE GetInActiveEmployees2
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.DateOfBirth,
        g.Gender,
        e.DateOfJoining,
        e.Designation,
        e.CTC,
		h.Education,  
        e.PrimaryMobile,
        e.OfficialEmail,
		e.LastWorkingDay
    FROM 
        Employee e
    INNER JOIN 
        Gender g ON e.GenderID = g.GenderID  
	INNER JOIN 
        HighestEducation h ON e.EducationID = h.EducationID
    WHERE 
        e.IsActive = 0 
    ORDER BY 
        e.EmployeeID
END
--------------------------------Search Employee-------------------------------------------------------
CREATE PROCEDURE SearchEmployees
(
@search nvarchar(100) )
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.DateOfBirth,
        g.Gender,
        e.DateOfJoining,
        e.Designation,
        e.CTC,
		h.Education,  
        e.PrimaryMobile,
        e.OfficialEmail,
		e.LastWorkingDay
    FROM 
        Employee e
    INNER JOIN 
        Gender g ON e.GenderID = g.GenderID  
	INNER JOIN 
        HighestEducation h ON e.EducationID = h.EducationID
    WHERE 
       e.EmployeeID = TRY_CAST(@search AS INT) OR e.OfficialEmail = @search OR e.PrimaryMobile = @search 
   
END


------------------------------------------------------------------------------------------------------
ALTER TABLE Employee
ALTER COLUMN EmployeeID Int Primary key Identity(101,1);
------------------------------------------------------------------------------------------------------

-- Employee 101 (Rahul Sharma)
EXEC AddEmployee 
  @FirstName = 'Rahul',
  @MiddleName = NULL,
  @LastName = 'Sharma',
  @GenderID = 1,
  @DateOfBirth = '1990-05-15',
  @OfficialEmail = 'rahul.sharma@company.com',
  @PresentAddress = '12 MG Road, Bangalore',
  @PermanentAddress = '24 Church Street, Mumbai',
  @PrimaryMobile = '9876543210',
  @AlternateMobile = NULL,
  @AadhaarNumber = '123456789012',
  @PANNumber = 'ABCDE1234F',
  @DateOfJoining = '2020-06-01',
  @CTC = 850000.00,
  @Designation = 'Senior Software Engineer',
  @Experience = '5 years',
  @EducationID = 1,
  @YearOfPassing = 2012,
  @BankName = 'State Bank of India',
  @AccountNumber = '12345678901234',
  @IFSCCode = 'SBIN0001234',
  @BranchAddress = 'MG Road Branch, Bangalore',
  @BloodGroupID = 3,
  @RelationID = 1,
  @RelativeName = 'Rajesh Sharma',
  @RelativeMobile = '9876543211';

-- Employee 102 (Priya Verma)
EXEC AddEmployee 
  @FirstName = 'Priya',
  @MiddleName = 'Kumari',
  @LastName = 'Verma',
  @GenderID = 2,
  @DateOfBirth = '1995-11-22',
  @OfficialEmail = 'priya.verma@company.com',
  @PresentAddress = '45 Electronic City, Bangalore',
  @PermanentAddress = '45 Electronic City, Bangalore',
  @PrimaryMobile = '8765432109',
  @AlternateMobile = '7654321098',
  @AadhaarNumber = '234567890123',
  @PANNumber = 'BCDEF2345G',
  @DateOfJoining = '2022-01-10',
  @CTC = 650000.00,
  @Designation = 'QA Analyst',
  @Experience = '2 years',
  @EducationID = 3,
  @YearOfPassing = 2019,
  @BankName = 'HDFC Bank',
  @AccountNumber = '23456789012345',
  @IFSCCode = 'HDFC0005678',
  @BranchAddress = 'Electronic City Branch, Bangalore',
  @BloodGroupID = 5,
  @RelationID = 2,
  @RelativeName = 'Sunita Verma',
  @RelativeMobile = '8765432110';

-- Employee 103 (Amit Singh)
EXEC AddEmployee 
  @FirstName = 'Amit',
  @MiddleName = 'Kumar',
  @LastName = 'Singh',
  @GenderID = 1,
  @DateOfBirth = '1988-08-08',
  @OfficialEmail = 'amit.singh@company.com',
  @PresentAddress = '78 Koramangala, Bangalore',
  @PermanentAddress = '32 Gandhi Nagar, Delhi',
  @PrimaryMobile = '7654321098',
  @AlternateMobile = NULL,
  @AadhaarNumber = '345678901234',
  @PANNumber = 'CDEFG3456H',
  @DateOfJoining = '2018-03-15',
  @CTC = 950000.00,
  @Designation = 'Tech Lead',
  @Experience = '8 years',
  @EducationID = 4,
  @YearOfPassing = 2010,
  @BankName = 'ICICI Bank',
  @AccountNumber = '34567890123456',
  @IFSCCode = 'ICIC0003456',
  @BranchAddress = 'Koramangala Branch, Bangalore',
  @BloodGroupID = 7,
  @RelationID = 3,
  @RelativeName = 'Anjali Singh',
  @RelativeMobile = '7654321099';

-- Employee 104 (Neha Reddy)
EXEC AddEmployee 
  @FirstName = 'Neha',
  @MiddleName = NULL,
  @LastName = 'Reddy',
  @GenderID = 2,
  @DateOfBirth = '1993-04-17',
  @OfficialEmail = 'neha.reddy@company.com',
  @PresentAddress = '9B HSR Layout, Bangalore',
  @PermanentAddress = '9B HSR Layout, Bangalore',
  @PrimaryMobile = '6543210987',
  @AlternateMobile = '9876543210',
  @AadhaarNumber = '456789012345',
  @PANNumber = 'DEFGH4567I',
  @DateOfJoining = '2021-07-01',
  @CTC = 750000.00,
  @Designation = 'UX Designer',
  @Experience = '3 years',
  @EducationID = 2,
  @YearOfPassing = 2015,
  @BankName = 'Axis Bank',
  @AccountNumber = '45678901234567',
  @IFSCCode = 'UTIB0004567',
  @BranchAddress = 'HSR Branch, Bangalore',
  @BloodGroupID = 2,
  @RelationID = 4,
  @RelativeName = 'Ravi Reddy',
  @RelativeMobile = '6543210988';

  Select * from Employee

  -- Employee 105
EXEC AddEmployee 
  @FirstName = 'Rajesh',
  @MiddleName = NULL,
  @LastName = 'Patel',
  @GenderID = 1,
  @DateOfBirth = '1992-09-10',
  @OfficialEmail = 'rajesh.patel@company.com',
  @PresentAddress = '22 Indiranagar, Bangalore',
  @PermanentAddress = '5 Ahmedabad Road, Gujarat',
  @PrimaryMobile = '9123456789',
  @AlternateMobile = NULL,
  @AadhaarNumber = '567890123456',
  @PANNumber = 'EFGHI5678J',
  @DateOfJoining = '2023-02-15',
  @CTC = 600000.00,
  @Designation = 'Junior Developer',
  @Experience = '1 year',
  @EducationID = 5,
  @YearOfPassing = 2018,
  @BankName = 'Kotak Mahindra Bank',
  @AccountNumber = '56789012345678',
  @IFSCCode = 'KKBK0005678',
  @BranchAddress = 'Indiranagar Branch, Bangalore',
  @BloodGroupID = 1,
  @RelationID = 1,
  @RelativeName = 'Manoj Patel',
  @RelativeMobile = '9123456790';

-- Employee 106
EXEC AddEmployee 
  @FirstName = 'Sneha',
  @MiddleName = 'Rani',
  @LastName = 'Gupta',
  @GenderID = 2,
  @DateOfBirth = '1998-12-05',
  @OfficialEmail = 'sneha.gupta@company.com',
  @PresentAddress = '44 Whitefield, Bangalore',
  @PermanentAddress = '77 Park Street, Kolkata',
  @PrimaryMobile = '8765490123',
  @AlternateMobile = '7654321098',
  @AadhaarNumber = '678901234567',
  @PANNumber = 'FGHIJ6789K',
  @DateOfJoining = '2024-01-10',
  @CTC = 550000.00,
  @Designation = 'HR Executive',
  @Experience = 'Fresher',
  @EducationID = 2,
  @YearOfPassing = 2023,
  @BankName = 'Yes Bank',
  @AccountNumber = '67890123456789',
  @IFSCCode = 'YESB0006789',
  @BranchAddress = 'Whitefield Branch, Bangalore',
  @BloodGroupID = 6,
  @RelationID = 2,
  @RelativeName = 'Rina Gupta',
  @RelativeMobile = '8765490124';


  -----------------------------------------
  -- Employee 110 (Sneha Gupta)
EXEC AddEmployee 
  @FirstName = 'Sneha',
  @MiddleName = 'Rani',
  @LastName = 'Gupta',
  @GenderID = 2,
  @DateOfBirth = '1998-12-05',
  @OfficialEmail = 'sneha.gupta@company.com',
  @PresentAddress = '44 Whitefield, Bangalore',
  @PermanentAddress = '77 Park Street, Kolkata',
  @PrimaryMobile = '8765490123',
  @AlternateMobile = '7654321098',
  @AadhaarNumber = '678901234567',
  @PANNumber = 'FGHIJ6789K',
  @DateOfJoining = '2024-01-10',
  @CTC = 550000.00,
  @Designation = 'HR Executive',
  @Experience = 'Fresher',
  @EducationID = 2,
  @YearOfPassing = 2023,
  @BankName = 'Yes Bank',
  @AccountNumber = '67890123456789',
  @IFSCCode = 'YESB0006789',
  @BranchAddress = 'Whitefield Branch, Bangalore',
  @BloodGroupID = 6,
  @RelationID = 2,
  @RelativeName = 'Rina Gupta',
  @RelativeMobile = '8765490124';

-- Employee 111 (Rajiv Menon)
EXEC AddEmployee 
  @FirstName = 'Rajiv',
  @MiddleName = NULL,
  @LastName = 'Menon',
  @GenderID = 1,
  @DateOfBirth = '1993-02-14',
  @OfficialEmail = 'rajiv.menon@company.com',
  @PresentAddress = '15 Brigade Road, Bangalore',
  @PermanentAddress = '22 Marine Lines, Mumbai',
  @PrimaryMobile = '9876541230',
  @AlternateMobile = NULL,
  @AadhaarNumber = '789012345679',
  @PANNumber = 'JKLMN0123O',
  @DateOfJoining = '2020-08-22',
  @CTC = 820000.00,
  @Designation = 'Full Stack Developer',
  @Experience = '4 years',
  @EducationID = 1,
  @YearOfPassing = 2016,
  @BankName = 'SBI',
  @AccountNumber = '78901234567901',
  @IFSCCode = 'SBIN0012345',
  @BranchAddress = 'Brigade Road Branch, Bangalore',
  @BloodGroupID = 3,
  @RelationID = 1,
  @RelativeName = 'Vijay Menon',
  @RelativeMobile = '9876541231';

-- Employee 112 (Anjali Kapoor)
EXEC AddEmployee 
  @FirstName = 'Anjali',
  @MiddleName = 'Kumari',
  @LastName = 'Kapoor',
  @GenderID = 2,
  @DateOfBirth = '1997-07-07',
  @OfficialEmail = 'anjali.kapoor@company.com',
  @PresentAddress = '66 HSR Layout, Bangalore',
  @PermanentAddress = '33 Connaught Place, Delhi',
  @PrimaryMobile = '7654390123',
  @AlternateMobile = '6543217890',
  @AadhaarNumber = '890123456790',
  @PANNumber = 'LMNOP1234Q',
  @DateOfJoining = '2023-05-15',
  @CTC = 480000.00,
  @Designation = 'Trainee Engineer',
  @Experience = '6 months',
  @EducationID = 5,
  @YearOfPassing = 2022,
  @BankName = 'Punjab National Bank',
  @AccountNumber = '89012345679012',
  @IFSCCode = 'PUNB0012345',
  @BranchAddress = 'HSR Branch, Bangalore',
  @BloodGroupID = 4,
  @RelationID = 2,
  @RelativeName = 'Sunita Kapoor',
  @RelativeMobile = '7654390124';

-- Employee 113 (Karan Malhotra)
EXEC AddEmployee 
  @FirstName = 'Karan',
  @MiddleName = 'Singh',
  @LastName = 'Malhotra',
  @GenderID = 1,
  @DateOfBirth = '1989-10-31',
  @OfficialEmail = 'karan.malhotra@company.com',
  @PresentAddress = '34 Indiranagar, Bangalore',
  @PermanentAddress = '12 Bandra West, Mumbai',
  @PrimaryMobile = '9123456123',
  @AlternateMobile = NULL,
  @AadhaarNumber = '901234567891',
  @PANNumber = 'MNOPQ2345R',
  @DateOfJoining = '2016-11-01',
  @CTC = 1150000.00,
  @Designation = 'Delivery Manager',
  @Experience = '10 years',
  @EducationID = 4,
  @YearOfPassing = 2012,
  @BankName = 'Axis Bank',
  @AccountNumber = '90123456789123',
  @IFSCCode = 'UTIB0009012',
  @BranchAddress = 'Indiranagar Branch, Bangalore',
  @BloodGroupID = 7,
  @RelationID = 3,
  @RelativeName = 'Rahul Malhotra',
  @RelativeMobile = '9123456124';

-- Employee 114 (Divya Iyer)
EXEC AddEmployee 
  @FirstName = 'Divya',
  @MiddleName = NULL,
  @LastName = 'Iyer',
  @GenderID = 2,
  @DateOfBirth = '1995-04-20',
  @OfficialEmail = 'divya.iyer@company.com',
  @PresentAddress = '77 Koramangala, Bangalore',
  @PermanentAddress = '45 T Nagar, Chennai',
  @PrimaryMobile = '8765432101',
  @AlternateMobile = '7654321987',
  @AadhaarNumber = '012345678901',
  @PANNumber = 'OPQRS3456S',
  @DateOfJoining = '2021-02-14',
  @CTC = 720000.00,
  @Designation = 'Product Manager',
  @Experience = '3 years',
  @EducationID = 2,
  @YearOfPassing = 2017,
  @BankName = 'HDFC Bank',
  @AccountNumber = '01234567890123',
  @IFSCCode = 'HDFC0000123',
  @BranchAddress = 'Koramangala Branch, Bangalore',
  @BloodGroupID = 5,
  @RelationID = 4,
  @RelativeName = 'Ramesh Iyer',
  @RelativeMobile = '8765432102';

-- Employee 115 (Aarav Joshi)
EXEC AddEmployee 
  @FirstName = 'Aarav',
  @MiddleName = 'Raj',
  @LastName = 'Joshi',
  @GenderID = 1,
  @DateOfBirth = '1994-09-09',
  @OfficialEmail = 'aarav.joshi@company.com',
  @PresentAddress = '89 Electronic City, Bangalore',
  @PermanentAddress = '23 Deccan Gymkhana, Pune',
  @PrimaryMobile = '7654321098',
  @AlternateMobile = NULL,
  @AadhaarNumber = '123456789013',
  @PANNumber = 'QRSTU4567T',
  @DateOfJoining = '2020-07-01',
  @CTC = 880000.00,
  @Designation = 'Data Scientist',
  @Experience = '4 years',
  @EducationID = 1,
  @YearOfPassing = 2016,
  @BankName = 'ICICI Bank',
  @AccountNumber = '12345678901345',
  @IFSCCode = 'ICIC0001234',
  @BranchAddress = 'Electronic City Branch, Bangalore',
  @BloodGroupID = 2,
  @RelationID = 1,
  @RelativeName = 'Neha Joshi',
  @RelativeMobile = '7654321099';

-- Employee 116 (Meera Nair)
EXEC AddEmployee 
  @FirstName = 'Meera',
  @MiddleName = 'Lakshmi',
  @LastName = 'Nair',
  @GenderID = 2,
  @DateOfBirth = '1999-01-12',
  @OfficialEmail = 'meera.nair@company.com',
  @PresentAddress = '56 Whitefield, Bangalore',
  @PermanentAddress = '56 Whitefield, Bangalore',
  @PrimaryMobile = '6543210987',
  @AlternateMobile = '9876543210',
  @AadhaarNumber = '234567890124',
  @PANNumber = 'STUVW5678U',
  @DateOfJoining = '2023-08-01',
  @CTC = 520000.00,
  @Designation = 'Junior Analyst',
  @Experience = '1 year',
  @EducationID = 3,
  @YearOfPassing = 2021,
  @BankName = 'Kotak Mahindra Bank',
  @AccountNumber = '23456789012456',
  @IFSCCode = 'KKBK0002345',
  @BranchAddress = 'Whitefield Branch, Bangalore',
  @BloodGroupID = 8,
  @RelationID = 2,
  @RelativeName = 'Latha Nair',
  @RelativeMobile = '6543210988';

-- Employee 117 (Rohan Bhatia)
EXEC AddEmployee 
  @FirstName = 'Rohan',
  @MiddleName = NULL,
  @LastName = 'Bhatia',
  @GenderID = 1,
  @DateOfBirth = '1992-03-30',
  @OfficialEmail = 'rohan.bhatia@company.com',
  @PresentAddress = '33 Jayanagar, Bangalore',
  @PermanentAddress = '11 Salt Lake, Kolkata',
  @PrimaryMobile = '9123456789',
  @AlternateMobile = NULL,
  @AadhaarNumber = '345678901235',
  @PANNumber = 'TUVWX6789V',
  @DateOfJoining = '2019-09-10',
  @CTC = 950000.00,
  @Designation = 'Cloud Architect',
  @Experience = '6 years',
  @EducationID = 4,
  @YearOfPassing = 2013,
  @BankName = 'Axis Bank',
  @AccountNumber = '34567890123567',
  @IFSCCode = 'UTIB0003456',
  @BranchAddress = 'Jayanagar Branch, Bangalore',
  @BloodGroupID = 1,
  @RelationID = 3,
  @RelativeName = 'Amit Bhatia',
  @RelativeMobile = '9123456790';

-- Employee 118 (Shreya Rao)
EXEC AddEmployee 
  @FirstName = 'Shreya',
  @MiddleName = NULL,
  @LastName = 'Rao',
  @GenderID = 2,
  @DateOfBirth = '1996-06-24',
  @OfficialEmail = 'shreya.rao@company.com',
  @PresentAddress = '44 Indiranagar, Bangalore',
  @PermanentAddress = '88 Banjara Hills, Hyderabad',
  @PrimaryMobile = '8765432102',
  @AlternateMobile = '7654321891',
  @AadhaarNumber = '456789012346',
  @PANNumber = 'VWXYA7890W',
  @DateOfJoining = '2022-11-15',
  @CTC = 620000.00,
  @Designation = 'Marketing Specialist',
  @Experience = '2 years',
  @EducationID = 2,
  @YearOfPassing = 2020,
  @BankName = 'Yes Bank',
  @AccountNumber = '45678901234678',
  @IFSCCode = 'YESB0004567',
  @BranchAddress = 'Indiranagar Branch, Bangalore',
  @BloodGroupID = 6,
  @RelationID = 4,
  @RelativeName = 'Rahul Rao',
  @RelativeMobile = '8765432103';

-- Employee 119 (Vivek Choudhary)
EXEC AddEmployee 
  @FirstName = 'Vivek',
  @MiddleName = 'Kumar',
  @LastName = 'Choudhary',
  @GenderID = 1,
  @DateOfBirth = '1990-12-01',
  @OfficialEmail = 'vivek.choudhary@company.com',
  @PresentAddress = '22 MG Road, Bangalore',
  @PermanentAddress = '55 Dadar East, Mumbai',
  @PrimaryMobile = '7654321012',
  @AlternateMobile = NULL,
  @AadhaarNumber = '567890123457',
  @PANNumber = 'WXYZA8901X',
  @DateOfJoining = '2018-04-01',
  @CTC = 1020000.00,
  @Designation = 'Senior Architect',
  @Experience = '8 years',
  @EducationID = 1,
  @YearOfPassing = 2010,
  @BankName = 'SBI',
  @AccountNumber = '56789012345789',
  @IFSCCode = 'SBIN0005678',
  @BranchAddress = 'MG Road Branch, Bangalore',
  @BloodGroupID = 3,
  @RelationID = 1,
  @RelativeName = 'Ravi Choudhary',
  @RelativeMobile = '7654321013';

-- Employee 120 (Nandini Patel)
EXEC AddEmployee 
  @FirstName = 'Nandini',
  @MiddleName = 'Ben',
  @LastName = 'Patel',
  @GenderID = 2,
  @DateOfBirth = '1997-05-19',
  @OfficialEmail = 'nandini.patel@company.com',
  @PresentAddress = '11 HSR Layout, Bangalore',
  @PermanentAddress = '33 Ashram Road, Ahmedabad',
  @PrimaryMobile = '6543210123',
  @AlternateMobile = '9876543219',
  @AadhaarNumber = '678901234568',
  @PANNumber = 'YZABC9012Y',
  @DateOfJoining = '2023-10-01',
  @CTC = 580000.00,
  @Designation = 'Content Writer',
  @Experience = '1 year',
  @EducationID = 5,
  @YearOfPassing = 2022,
  @BankName = 'HDFC Bank',
  @AccountNumber = '67890123456890',
  @IFSCCode = 'HDFC0006789',
  @BranchAddress = 'HSR Branch, Bangalore',
  @BloodGroupID = 4,
  @RelationID = 2,
  @RelativeName = 'Mohan Patel',
  @RelativeMobile = '6543210124';

-- Employee 121 (Aditya Srinivasan)
EXEC AddEmployee 
  @FirstName = 'Aditya',
  @MiddleName = NULL,
  @LastName = 'Srinivasan',
  @GenderID = 1,
  @DateOfBirth = '1991-08-15',
  @OfficialEmail = 'aditya.srinivasan@company.com',
  @PresentAddress = '77 Koramangala, Bangalore',
  @PermanentAddress = '44 Anna Salai, Chennai',
  @PrimaryMobile = '9123456780',
  @AlternateMobile = NULL,
  @AadhaarNumber = '789012345680',
  @PANNumber = 'ZABCD0123Z',
  @DateOfJoining = '2017-12-01',
  @CTC = 980000.00,
  @Designation = 'Tech Lead',
  @Experience = '7 years',
  @EducationID = 4,
  @YearOfPassing = 2014,
  @BankName = 'ICICI Bank',
  @AccountNumber = '78901234568012',
  @IFSCCode = 'ICIC0007890',
  @BranchAddress = 'Koramangala Branch, Bangalore',
  @BloodGroupID = 5,
  @RelationID = 3,
  @RelativeName = 'Karthik Srinivasan',
  @RelativeMobile = '9123456781';

-- Employee 122 (Ishita Reddy)
EXEC AddEmployee 
  @FirstName = 'Ishita',
  @MiddleName = NULL,
  @LastName = 'Reddy',
  @GenderID = 2,
  @DateOfBirth = '1998-02-28',
  @OfficialEmail = 'ishita.reddy@company.com',
  @PresentAddress = '55 Electronic City, Bangalore',
  @PermanentAddress = '55 Electronic City, Bangalore',
  @PrimaryMobile = '8765432104',
  @AlternateMobile = '7654321095',
  @AadhaarNumber = '890123456789',
  @PANNumber = 'ABCDE2345A',
  @DateOfJoining = '2024-03-01',
  @CTC = 500000.00,
  @Designation = 'Intern',
  @Experience = 'Fresher',
  @EducationID = 5,
  @YearOfPassing = 2023,
  @BankName = 'Axis Bank',
  @AccountNumber = '89012345678901',
  @IFSCCode = 'UTIB0008901',
  @BranchAddress = 'Electronic City Branch, Bangalore',
  @BloodGroupID = 7,
  @RelationID = 4,
  @RelativeName = 'Rajesh Reddy',
  @RelativeMobile = '8765432105';

-- Employee 123 (Siddharth Malhotra)
EXEC AddEmployee 
  @FirstName = 'Siddharth',
  @MiddleName = 'Raj',
  @LastName = 'Malhotra',
  @GenderID = 1,
  @DateOfBirth = '1995-11-11',
  @OfficialEmail = 'siddharth.malhotra@company.com',
  @PresentAddress = '66 Indiranagar, Bangalore',
  @PermanentAddress = '22 Worli, Mumbai',
  @PrimaryMobile = '7654321090',
  @AlternateMobile = NULL,
  @AadhaarNumber = '901234567890',
  @PANNumber = 'BCDEF3456B',
  @DateOfJoining = '2021-06-15',
  @CTC = 720000.00,
  @Designation = 'Backend Developer',
  @Experience = '3 years',
  @EducationID = 1,
  @YearOfPassing = 2018,
  @BankName = 'SBI',
  @AccountNumber = '90123456789012',
  @IFSCCode = 'SBIN0009012',
  @BranchAddress = 'Indiranagar Branch, Bangalore',
  @BloodGroupID = 2,
  @RelationID = 1,
  @RelativeName = 'Rohit Malhotra',
  @RelativeMobile = '7654321091';

  EXEC AddEmployee 
  @FirstName = 'Tanvi',
  @MiddleName = NULL,
  @LastName = 'Sharma',
  @GenderID = 2,
  @DateOfBirth = '1999-07-04',
  @OfficialEmail = 'tanvi.sharma@company.com',
  @PresentAddress = '88 Whitefield, Bangalore',
  @PermanentAddress = '44 Sector 18, Noida',
  @PrimaryMobile = '6543210989',
  @AlternateMobile = '9876543213',
  @AadhaarNumber = '012345678902',
  @PANNumber = 'CDEFG4567C',
  @DateOfJoining = '2023-09-01',
  @CTC = 540000.00,
  @Designation = 'UI Designer',
  @Experience = '1 year',
  @EducationID = 3,
  @YearOfPassing = 2022,
  @BankName = 'HDFC Bank',
  @AccountNumber = '01234567890234',
  @IFSCCode = 'HDFC0000123',
  @BranchAddress = 'Whitefield Branch, Bangalore',
  @BloodGroupID = 8,
  @RelationID = 2,
  @RelativeName = 'Anil Sharma',
  @RelativeMobile = '6543210990';