-- Question 1
SELECT c.FName, c.LName, t.StudioName
FROM COMPETITOR c
JOIN TEACHER t on c.TeacherID = t.TeacherID;

-- Question 2
SELECT t.StudioName, COUNT(*) AS NumOfStudents
FROM TEACHER t
JOIN COMPETITOR c ON t.TeacherID = c.TeacherID
GROUP BY t.StudioName;

-- Question 3
SELECT StudioName, COUNT(*) AS NumOfTeachers
FROM TEACHER
GROUP BY StudioName;

-- Question 4
SELECT t.LName
FROM TEACHER t 
JOIN COMPETITOR c ON t.TeacherID = c.TeacherID
GROUP BY t.LName
HAVING COUNT(c.CompetitorID) > 1;

-- Question 5
SELECT c.FName, c.LName, co.Title
FROM COMPETITOR c
JOIN PERFORMANCE p on c.CompetitorID = p.CompetitorID
JOIN COMPOSITION co on p.MusicID = co.MusicID
WHERE co.Genre = 'Romantic';

-- Question 6
SELECT co.Title, ca.Genre
FROM COMPOSITION co
LEFT JOIN PERFORMANCE p ON co.MusicID = p.MusicID
LEFT JOIN CATEGORY ca ON p.CategoryID = ca.CategoryID;

-- Question 7
CREATE VIEW SCORE_ANALYSIS AS
SELECT c.Age, p.Score
FROM COMPETITOR c
JOIN PERFORMANCE p ON c.CompetitorID = p.CompetitorID;

-- Question 8
SELECT *
FROM SCORE_ANALYSIS
ORDER BY Score DESC;

-- Question 9
SELECT MAX(Score) AS HighestScore, MIN(Score) AS LowestScore, AVG(Score) AS AverageScore 
FROM SCORE_ANALYSIS;

-- Question 10
ALTER TABLE COMPOSITION
ADD Copyright VARCHAR(50) DEFAULT 'SOCAN';

SELECT * FROM COMPOSITION;

-- Question 11
SELECT c.*
FROM COMPETITOR c
JOIN CATEGORY cat ON c.Age NOT BETWEEN cat.AgeMin AND cat.AgeMax;

-- Question 12
ALTER TABLE COMPETITOR 
ADD CONSTRAINT age_check CHECK(Age >= 5 AND Age <= 18);

-- Question 13
UPDATE STUDIO
SET Name = 'Harmony Studio'
WHERE Name = 'Harmony Inc.';
-- CASCADE updates ensure that the change is made in all related tables

-- Question 14
DELETE FROM COMPOSITION WHERE Composer = 'Beethoven';
-- This statement causes an error due to the foreign key constraint from the PERFORMANCE table. 
-- Compositions by Beethoven are referenced in the PERFORMANCE table. Therefore, it cannot be deleted.

-- Question 15
CREATE TRIGGER Certification
BEFORE UPDATE ON TEACHER FOR EACH ROW
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Proof of certification must be provided to the main office.';
-- The above code will create an action required for the Teacher table and every row in Teacher.
-- It will prompt the user before an update operation is performed. Otherwise it has a generic error code.
