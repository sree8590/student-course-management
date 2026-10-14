


CREATE DATABASE IF NOT EXISTS institute_db;
USE institute_db;


CREATE TABLE IF NOT EXISTS Students(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    fee DECIMAL(10,2) NOT NULL CHECK (fee >= 0)
);

CREATE TABLE IF NOT EXISTS Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks DECIMAL(5,2) CHECK (marks BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    UNIQUE (student_id, course_id)
);


INSERT INTO Students (name, email, city)
VALUES
('Anu', 'anu@gmail.com', 'Kochi'),
('Rahul', 'rahul@gmail.com', 'Thrissur'),
('Meera', 'meera@gmail.com', 'Kochi'),
('Arjun', 'arjun@gmail.com', 'Kozhikode'),
('Diya', 'diya@gmail.com', 'Thrissur');


INSERT INTO Courses (course_name, fee)
VALUES
('Python Programming', 5000),
('Web Development', 7000),
('Database Management', 6000);

INSERT INTO Enrollments (student_id, course_id, marks)
VALUES
(1, 1, 85),
(1, 2, 78),
(2, 1, 72),
(2, 3, 88),
(3, 1, 92),
(3, 2, 81),
(4, 2, 67),


UPDATE Students
SET city = 'Alappuzha'
WHERE student_id = 4;


DELETE FROM Enrollments
WHERE enrollment_id = 7;

SELECT * FROM Students;


SELECT * FROM Students
WHERE city = 'Kochi';


SELECT s.name, c.course_name, e.marks
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.marks > 75;


SELECT * FROM Courses
WHERE fee > 5500;

e
SELECT c.course_name, AVG(e.marks) AS average_marks
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


SELECT c.course_name,
       COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

SELECT c.course_name, MAX(e.marks) AS highest_marks
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


SELECT DISTINCT s.student_id, s.name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.marks > (
    SELECT AVG(marks) FROM Enrollments
);

SELECT c.course_name, AVG(e.marks) AS average_marks
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING AVG(e.marks) = (
    SELECT MAX(course_average)
    FROM (
        SELECT AVG(marks) AS course_average
        FROM Enrollments
        GROUP BY course_id
    ) AS averages
);


SELECT s.name, c.course_name, e.marks
FROM Students s
INNER JOIN Enrollments e ON s.student_id = e.student_id
INNER JOIN Courses c ON e.course_id = c.course_id;


SELECT s.name, c.course_name, e.marks
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Courses c ON e.course_id = c.course_id;
