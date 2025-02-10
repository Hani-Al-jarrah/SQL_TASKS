--CREATE DATABASE Library;

USE Library;


CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthYear INT
);


CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublishedYear INT,
    CopiesAvailable INT,
    BookCategory VARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);


INSERT INTO Authors (AuthorID, FirstName, LastName, BirthYear) VALUES
(1, 'Hani', 'Al-Jarrah', 2002),
(2, 'Ahmad', 'Mahfouz', 1911),
(3, 'Moh', 'Khalil Gibran', 1883),
(4, 'Ali', 'Abd al-Quddus', 1919),
(5, 'Abood', 'Shawqi', 1868);


INSERT INTO Books (BookID, Title, AuthorID, PublishedYear, CopiesAvailable, BookCategory) VALUES
(1, 'Programming Web with .NET', 1, 2024, 10, 'Technology'),
(2, 'Children of the Alley', 2, 1959, 5, 'Literature'),
(3, 'The Prophet', 3, 1923, 2, 'Philosophy'),
(4, 'I Do Not Sleep', 4, 1957, 8, 'Novel'),
(5, 'Al-Shawqiyat', 5, 1898, 12, 'Poetry');



SELECT * From Books
SELECT * From Authors




SELECT MAX(CopiesAvailable) FROM Books;
SELECT MIN(CopiesAvailable) FROM Books;


SELECT AVG(PublishedYear) AS AveragePublicationYear FROM Books;


SELECT COUNT(*) AS TotalBooks FROM Books;


TRUNCATE TABLE Books;


ALTER TABLE Authors
ADD Email VARCHAR(100), Phone_Number VARCHAR(15);


DROP TABLE Authors;
