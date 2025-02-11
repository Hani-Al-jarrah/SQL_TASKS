create database SchoolManagementSystem;
use SchoolManagementSystem;

create table Students (
ID INT primary key identity(1,1),
name varchar(50) not null,
family_name varchar(50),
birth date ,
addres varchar(50),
);



create table family_info (
ID INT primary key identity(1,1),
father_name varchar(50),
family_name varchar(50),
phone varchar(50) ,
Students_ID int unique ,
foreign key (Students_ID) references Students (ID),  
);

create table coureses (
ID INT primary key identity(1,1),
name varchar(50) not null,
descriptions varchar(200),
Resources varchar(50),
);

create table Students_coureses(
Students_ID int  ,
coureses_ID int  ,
foreign key (Students_ID) references Students (ID),
foreign key (coureses_ID) references coureses (ID),
);




create table class (
ID INT primary key identity(1,1),
class_code varchar(50),
room_number varchar(50),
schedule varchar(50),
coureses_ID int unique ,
foreign key (coureses_ID) references coureses (ID),
);



create table assignments (
ID INT primary key identity(1,1),
name varchar(50) not null,
descriptions varchar(200),
due_date date ,
status bit ,
coureses_ID int unique ,
foreign key (coureses_ID) references coureses (ID)
);


create table Students_assignments(
Students_ID int unique ,
foreign key (Students_ID) references Students (ID),
assignments_ID int unique,
foreign key (assignments_ID) references assignments (ID),
);

create table attendance(
ID INT primary key identity(1,1),
attendance_date date ,
Type_of_absence varchar(50),
reason varchar(50),

Students_ID int not null ,
foreign key (Students_ID) references Students (ID)

);


drop table attendance ;



-- Insert data into the Students table
INSERT INTO Students (name,family_name,birth, addres)
VALUES 
  ('Ahmed','Alomari', '2000-05-10', 'King Abdullah Street'),
  ('Maryam', 'Khashashneh','1999-03-20', 'West Neighborhood'),
  ('Salman','Aljarrah', '2001-07-15', 'University Street'),
  ('Sersa','Khashashneh', '2001-07-15', 'University Street');

-- Insert data into the family_info table
INSERT INTO family_info (father_name,family_name, phone, Students_ID)
VALUES
  ('Ali','Alomari', '0501234567', 1), -- Link to Student 1 (Ahmed Ali)
  ('Ahmed','Khashashneh', '0502345678', 2), -- Link to Student 2 (Maryam Ahmed)
  ('Mohammed','Aljarrah', '0503456789', 3), -- Link to Student 3 (Salman Mohammed)
  ('Ahmed','Khashashneh', '0502345678', 4);


-- Insert data into the courses table
INSERT INTO coureses (name, descriptions, Resources)
VALUES
  ('Mathematics 101', 'Introduction to basic mathematics concepts', 'Book A, Software B'),
  ('Physics 202', 'Fundamentals of classical physics', 'Book X, Software Y'),
  ('Computer Science 303', 'Advanced topics in computer science', 'Book Z, Software X');

-- Insert data into the Students_courses table
INSERT INTO Students_coureses (Students_ID, coureses_ID)
VALUES
  (1, 2), -- Ahmed Ali takes Mathematics 101
  (1, 3), -- Ahmed Ali also takes Computer Science 303
  (2, 2), -- Maryam Ahmed takes Physics 202
  (3, 1); -- Salman Mohammed takes Mathematics 101

-- Insert data into the class table
INSERT INTO class (class_code, room_number, schedule, coureses_ID)
VALUES
  ('MATH101-A', 'Room 101', 'Mon, Wed 10:00-12:00', 1),
  ('PHYS202-B', 'Room 202', 'Tue, Thu 14:00-16:00', 2),
  ('CS303-C', 'Room 303', 'Mon, Wed 14:00-16:00', 3);

-- Insert data into the assignments table
INSERT INTO assignments (name, descriptions, due_date, status, coureses_ID)
VALUES
  ('Math Assignment 1', 'Solve basic algebraic problems', '2025-03-01', 0, 1),
  ('Physics Lab Report', 'Write a report on the physics lab experiment', '2025-03-10', 0, 2),
  ('CS Project', 'Develop a small project using Python', '2025-03-15', 0, 3);

-- Insert data into the Students_assignments table
INSERT INTO Students_assignments (Students_ID, assignments_ID)
VALUES
  (1, 1), -- Ahmed Ali has Math Assignment 1
  (2, 2), -- Maryam Ahmed has Physics Lab Report
  (3, 3); -- Salman Mohammed has CS Project

-- Insert data into the attendance table
INSERT INTO attendance (attendance_date, Type_of_absence, reason, Students_ID)
VALUES
  ('2024-01-01', 'Present', 'On time', 1), -- Ahmed Ali was present
  ('2024-01-03', 'Absent', 'Medical reason', 1), -- Maryam Ahmed was absent
  ('2024-01-05', 'Present', 'On time', 3); -- Salman Mohammed was present


  select name from Students 
  where birth = '2000-05-10' ;

  select * from coureses 
  where name = 'Mathematics 101';

  alter table Students add Email varchar(50);

 INSERT INTO Students (name,family_name, birth, addres,Email)
VALUES 
  ('Farah','Hatsuk','2000-05-10', 'King Abdullah Street','Farah@gmail');

  --select  Students.name ,family_info.family_name  
  --from Students
  --inner join family_info on Students.family_name = family_info.family_name ;

  SELECT Students.name, family_info.family_name  
FROM Students
INNER JOIN family_info ON Students.ID = family_info.Students_ID;

--SELECT *   FROM Students
--INNER JOIN family_info ON Students.family_name = family_info.family_name;


select Students.name
from Students
inner join Students_coureses on Students.ID = Students_coureses.Students_ID
inner join coureses on Students_coureses.coureses_ID = coureses.ID 
where coureses.name = 'Mathematics 101' ;


select Students.name
from Students
inner join Students_assignments on Students_assignments.Students_ID = Students.ID
inner join assignments on Students_assignments.assignments_ID = assignments.ID
where assignments.status = 0 and assignments.name = 'Math Assignment 1' ;

select Students.name 
from Students
inner join attendance on Students.ID =  attendance.Students_ID
where attendance.Type_of_absence = 'Absent' and attendance.attendance_date > '2024-01-01' and attendance.attendance_date < '2024-01-05'  ;

  