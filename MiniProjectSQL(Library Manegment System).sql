	CREATE DATABASE LibManagSys;

	USE LibManagSys;

	CREATE TABLE Books (
		ID INT PRIMARY KEY,
		Title VARCHAR(255) NOT NULL,
		Author VARCHAR(255) NOT NULL,
		Genre VARCHAR(100),
		PublicationYear INT,
		AvailabilityStatus VARCHAR(20) 
	);

	CREATE TABLE Members (
		ID INT PRIMARY KEY,
		Name VARCHAR(255) NOT NULL,
		ContactInfo VARCHAR(255),
		MembershipType VARCHAR(20),
		RegistrationDate DATE
	);

	CREATE TABLE Categories (
		ID INT PRIMARY KEY,
		Name VARCHAR(100) NOT NULL,
		Description VARCHAR(255)
	);

	CREATE TABLE LibraryStaff (
		ID INT PRIMARY KEY,
		Name VARCHAR(255) NOT NULL,
		ContactInfo VARCHAR(255),
		AssignedSection VARCHAR(255),
		EmploymentDate DATE
	);

	CREATE TABLE BookCatigories (
		ID INT PRIMARY KEY,
		BookID INT,
		CategoryID INT,
		FOREIGN KEY (BookID) REFERENCES Books(ID),
		FOREIGN KEY (CategoryID) REFERENCES Categories(ID)
	);

	CREATE TABLE Borrowing (
		ID INT PRIMARY KEY,
		MemberID INT,
		BookID INT,
		BorrowingDate DATE NOT NULL,
		DueDate DATE NOT NULL,
		ReturnDate DATE NULL,
		FOREIGN KEY (MemberID) REFERENCES Members(ID),
		FOREIGN KEY (BookID) REFERENCES Books(ID)
	);

	CREATE TABLE FinancialFines (
		ID INT PRIMARY KEY,
		BorrowingID INT UNIQUE,
		Amount DECIMAL(10,3) NOT NULL,
		PaymentStatus VARCHAR(10) ,
		FOREIGN KEY (BorrowingID) REFERENCES Borrowing(ID)
	);

	CREATE TABLE Reservations (
		ID INT PRIMARY KEY,
		MemberID INT,
		BookID INT,
		ReservationDate DATE NOT NULL,
		Status VARCHAR(20),
		FOREIGN KEY (MemberID) REFERENCES Members(ID),
		FOREIGN KEY (BookID) REFERENCES Books(ID)
	);



	-- Inserting data into Books table
INSERT INTO Books (ID, Title, Author, Genre, PublicationYear, AvailabilityStatus)
VALUES 
(1, 'Database Fundamentals', 'John Doe', 'Database', 2020, 'Available'),
(2, 'SQL for Beginners', 'Jane Smith', 'Programming', 2018, 'Available'),
(3, 'C# Programming', 'Michael Brown', 'Programming', 2022, 'Borrowed'),
(4, 'Advanced SQL', 'Sarah White', 'Database', 2021, 'Available'),
(5, 'Python Basics', 'David Green', 'Programming', 2019, 'Available');

-- Inserting data into Members table
INSERT INTO Members (ID, Name, ContactInfo, MembershipType, RegistrationDate)
VALUES 
(1, 'Alice', '1234567890', 'Student', '2024-01-01'),
(2, 'Bob', '2345678901', 'Teacher', '2024-02-15'),
(3, 'Charlie', '3456789012', 'Visitor', '2024-03-10'),
(4, 'Diana', '4567890123', 'Student', '2024-04-20'),
(5, 'Eve', '5678901234', 'Teacher', '2024-05-25');

-- Inserting data into Categories table
INSERT INTO Categories (ID, Name, Description)
VALUES 
(1, 'Database', 'Books related to database technologies'),
(2, 'Programming', 'Books on various programming languages'),
(3, 'Networking', 'Books related to computer networks'),
(4, 'Cloud Computing', 'Books on cloud technologies'),
(5, 'Artificial Intelligence', 'Books about AI technologies');

-- Inserting data into LibraryStaff table
INSERT INTO LibraryStaff (ID, Name, ContactInfo, AssignedSection, EmploymentDate)
VALUES 
(1, 'Sam', '9876543210', 'Database', '2020-06-01'),
(2, 'Linda', '8765432109', 'Programming', '2021-07-15'),
(3, 'Mike', '7654321098', 'Networking', '2019-03-12'),
(4, 'Olivia', '6543210987', 'Cloud Computing', '2022-09-20'),
(5, 'James', '5432109876', 'Artificial Intelligence', '2023-01-25');

-- Inserting data into BookCategories table (Many-to-Many relationship between Books and Categories)
INSERT INTO BookCatigories (ID, BookID, CategoryID)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 2),
(4, 4, 1),
(5, 5, 2);

-- Inserting data into Borrowing table
INSERT INTO Borrowing (ID, MemberID, BookID, BorrowingDate, DueDate, ReturnDate)
VALUES 
(1, 1, 1, '2024-01-01', '2024-01-15', '2024-01-14'),
(2, 2, 2, '2024-02-15', '2024-02-28', '2024-02-25'),
(3, 3, 3, '2024-03-10', '2024-03-24', '2024-03-23'),
(4, 4, 4, '2024-04-20', '2024-05-04', '2024-05-02'),
(5, 5, 5, '2024-05-25', '2024-06-08', NULL);


-- Inserting data into FinancialFines table (One-to-One with Borrowing)
INSERT INTO FinancialFines (ID, BorrowingID, Amount, PaymentStatus)
VALUES 
(1, 1, 5.00, 'Paid'),
(2, 2, 3.00, 'Unpaid'),
(3, 3, 4.00, 'Paid'),
(4, 4, 2.50, 'Unpaid'),
(5, 5, 6.00, 'Unpaid');

-- Inserting data into Reservations table
INSERT INTO Reservations (ID, MemberID, BookID, ReservationDate, Status)
VALUES 
(1, 1, 1, '2024-01-05', 'Completed'),
(2, 2, 3, '2024-02-20', 'Pending'),
(3, 4, 2, '2024-04-25', 'Completed'),
(4, 5, 4, '2024-05-30', 'Pending'),
(5, 3, 5, '2024-03-15', 'Cancelled');


--1
SELECT * FROM Members
WHERE RegistrationDate = '2024-01-01';

--2
SELECT * FROM Books
WHERE Title = 'Database Fundamentals';

--3
ALTER TABLE Members
ADD Email VARCHAR(255);

--4
INSERT INTO Members (ID, Name, ContactInfo, MembershipType, RegistrationDate, Email)
VALUES 
(6, 'Omar', '9876543210', 'Student', '2024-06-05', 'Omar@gmail.com');

--5
SELECT  Members.Name
FROM Members 
INNER JOIN Reservations r ON Members.ID = r.MemberID;


--6
SELECT  Members.Name
FROM Members 
INNER JOIN Borrowing  ON Members.ID = Borrowing.MemberID
INNER JOIN Books  ON Borrowing.BookID = Books.ID
WHERE Books.Title = 'SQL for Beginners';

--7
SELECT  Members.Name
FROM Members 
INNER JOIN Borrowing  ON Members.ID = Borrowing.MemberID
INNER JOIN Books ON Borrowing.BookID = Books.ID
WHERE Books.Title = 'C# Programming' AND Borrowing.ReturnDate IS NOT NULL;

--8
INSERT INTO Borrowing (ID, MemberID, BookID, BorrowingDate, DueDate, ReturnDate)
VALUES 
(8, 6, 5, '2024-01-01', '2024-01-15', '2024-01-16');

SELECT  Members.Name
FROM Members 
JOIN Borrowing  ON Members.ID = Borrowing.MemberID
WHERE Borrowing.ReturnDate > Borrowing.DueDate;

--9
INSERT INTO Borrowing (ID, MemberID, BookID, BorrowingDate, DueDate, ReturnDate)
VALUES 
(6, 6, 5, '2024-01-01', '2024-01-15', '2024-01-16'),
(7, 6, 5, '2024-01-01', '2024-01-15', '2024-01-16'),
(8, 6, 5, '2024-01-01', '2024-01-15', '2024-01-16');


SELECT BookID ,Books.Title FROM  Books inner join Borrowing on Borrowing.BookID=Books.ID;


SELECT Books.Title, COUNT(Borrowing.ID) AS BorrowCount
FROM Books
INNER JOIN Borrowing  ON Books.ID = Borrowing.BookID
GROUP BY Books.Title
HAVING COUNT(Books.ID) > 3;

--10
SELECT  Members.Name
FROM Members 
JOIN Borrowing ON Members.ID = Borrowing.MemberID
WHERE Borrowing.BorrowingDate BETWEEN '2024-01-01' AND '2024-01-10';
--WHERE Borrowing.BorrowingDate > '2024-01-01' AND Borrowing.BorrowingDate < '2024-01-10';


--11
SELECT COUNT(*) AS TotalBooks
FROM Books WHERE Books.AvailabilityStatus='Available';

--12
SELECT  Members.Name
FROM Members 
INNER JOIN Borrowing  ON Members.ID = Borrowing.MemberID
INNER JOIN Books ON Borrowing.BookID = Books.ID
WHERE  Borrowing.ReturnDate IS  NULL;
select * from Members
select * from Borrowing
select * from Books
select * from BookCatigories

--13
SELECT Members.Name
FROM Members 
JOIN Borrowing  ON Members.ID = Borrowing.MemberID
JOIN Books ON Borrowing.BookID = Books.ID
JOIN BookCatigories  ON Books.ID = BookCatigories.BookID
JOIN Categories  ON BookCatigories.CategoryID = Categories.ID
WHERE Categories.Name = 'Database';
