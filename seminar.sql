create database seminar;
use seminar;

CREATE TABLE students (
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
  cpassword VARCHAR(255) NOT NULL,
  confirmPassword VARCHAR(255) NOT NULL
);
select * from students;
truncate table students;

CREATE TABLE coordinators (
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  cpassword VARCHAR(255) NOT NULL,
  confirmPassword VARCHAR(255) NOT NULL
);
select * from coordinators;
truncate table  coordinators;

CREATE TABLE guides (
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) PRIMARY KEY UNIQUE NOT NULL,
  cpassword VARCHAR(255) NOT NULL,
  confirmPassword VARCHAR(255) NOT NULL
);
select * from guides;
truncate table guides;

create table selected_pairs (student_id int,student_name VARCHAR(255) ,student_email VARCHAR(255), guide_id int,guide_name VARCHAR(255) ,guide_email VARCHAR(255));
select * from selected_pairs;
truncate table  selected_pairs;
drop table selected_pairs;


CREATE TABLE review1 (
  guideEmail VARCHAR(255) NOT NULL,
  studentEmail VARCHAR(255) NOT NULL,
  topic1 VARCHAR(255) UNIQUE NOT NULL,
  topic2 VARCHAR(255) UNIQUE NOT NULL,
  topic3 VARCHAR(255) UNIQUE NOT NULL,
  FOREIGN KEY (guideEmail) REFERENCES guides(email),
  FOREIGN KEY (studentEmail) REFERENCES students(email)
);
select * from review1s;

drop table review1s;
truncate table review1s;

CREATE TABLE review1_results (
  email VARCHAR(255) NOT NULL,
  topic VARCHAR(255) UNIQUE NOT NULL,
  marks VARCHAR(255) NOT NULL
);
select * from review1_results;
truncate table review1_results;

CREATE TABLE review2_results (
  email VARCHAR(255) NOT NULL,
  marks VARCHAR(255) NOT NULL
);
select * from review2_results;
drop table review2_results;
truncate table review2_results;

CREATE TABLE review3_results (
  email VARCHAR(255) NOT NULL,
  marks VARCHAR(255) NOT NULL
);
select * from review3_results;
truncate table review3_results;

CREATE TABLE Ppt (
  guideEmail VARCHAR(255) NOT NULL,
  studentEmail VARCHAR(255) NOT NULL,
  filename VARCHAR(255) NOT NULL,
  pptData LONGBLOB NOT NULL,
  FOREIGN KEY (guideEmail) REFERENCES guides(email),
  FOREIGN KEY (studentEmail) REFERENCES students(email)
);
select * from ppts;
drop table ppts;
truncate table ppts;

CREATE TABLE Ppt3 (
  guideEmail VARCHAR(255) NOT NULL,
  studentEmail VARCHAR(255) NOT NULL,
  filename VARCHAR(255) NOT NULL,
  pptData LONGBLOB NOT NULL,
  FOREIGN KEY (guideEmail) REFERENCES guides(email),
  FOREIGN KEY (studentEmail) REFERENCES students(email)
);
select * from ppt3s;
truncate table ppt3s;
drop table ppt3s;




-- ****************************  PL/SQL code ****************************************
-- stored procedure
DELIMITER $$
--  A stored procedure that updates a student's email address
CREATE PROCEDURE update_student_email(
  IN old_email VARCHAR(255),
  IN new_email VARCHAR(255)
)
BEGIN
  -- Update the email address for the specified student
  UPDATE students SET email = new_email WHERE email = old_email;
END$$
DELIMITER ;
-- Call the stored procedure to update a student's email address
CALL update_student_email('sid@gmail.com', 'new_sid@gmail.com');

-- Trigger
DELIMITER $$
-- Define a trigger that checks if a student's email address is valid
CREATE TRIGGER validate_email
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
  -- Check if the email address is valid
  IF NOT REGEXP_LIKE(NEW.email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email address';
  END IF;
END $$
DELIMITER ;
INSERT INTO students (name, email, cpassword, confirmPassword, createdAt,updatedAt)
VALUES ('Ameya Khire', 'ameya@gmail.com', 'password123', 'password123', NOW(),NOW());


-- a. Insertion of data:
INSERT INTO students (name, email, cpassword, confirmPassword)
VALUES ('John Smith', 'john@example.com', 'password123', 'password123');

INSERT INTO guides (name, email, cpassword, confirmPassword)
VALUES ('Jane Doe', 'jane@example.com', 'password123', 'password123');

-- To create a relationship between the student and guide, we can insert a record into the selected_pairs table:
INSERT INTO selected_pairs (student_id, student_name, student_email, guide_id, guide_name, guide_email)
VALUES ((SELECT COUNT() FROM students), 'John Smith', 'john@example.com', (SELECT COUNT() FROM guides), 'Jane Doe', 'jane@example.com');

-- We can also set up the foreign key constraints for the selected_pairs table to ensure that any changes made to the referenced tables will cascade to this table:
ALTER TABLE selected_pairs ADD CONSTRAINT fk_student FOREIGN KEY (student_email) REFERENCES students(email) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE selected_pairs ADD CONSTRAINT fk_guide FOREIGN KEY (guide_email) REFERENCES guides(email) ON DELETE CASCADE ON UPDATE CASCADE;

-- b. Updation of data:
UPDATE students SET email = 'parasraut@example.com' WHERE name = 'paras raut';

-- c. Deletion of data:
DELETE FROM guides WHERE email = 'sid@example.com';

-- d. Searching of data:
SELECT * FROM selected_pairs WHERE guide_email = 'sid@example.com';















