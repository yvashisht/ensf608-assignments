# ENSF 608 F23 Assignment 3 Suggested Solutions
USE COMPETITION;

# Question 1 (1 mark)
SELECT C.FName, C.LName, T.StudioName
FROM (COMPETITOR AS C JOIN TEACHER AS T ON C.TeacherID = T.TeacherID);

# Question 2 (1 mark)
SELECT T.StudioName, COUNT(*)
FROM (COMPETITOR AS C JOIN TEACHER AS T ON C.TeacherID = T.TeacherID)
GROUP BY T.StudioName;

# Question 3 (1 mark)
SELECT StudioName, COUNT(*)
FROM TEACHER
GROUP BY StudioName;

# Question 4 (1 mark)
SELECT T.LName
FROM (COMPETITOR AS C JOIN TEACHER AS T ON C.TeacherID = T.TeacherID)
GROUP BY C.TeacherID
HAVING COUNT(*) > 1;

# Question 5 (2 marks)
SELECT LName, FName, Title
FROM ((COMPETITOR AS C JOIN PERFORMANCE AS P ON C.CompetitorID = P.CompetitorID) JOIN
COMPOSITION ON P.MusicID = COMPOSITION.MusicID)
WHERE COMPOSITION.Genre = "Romantic";

# Question 6 (2 marks)
SELECT C.Title, P.CategoryID FROM (COMPOSITION AS C LEFT OUTER JOIN PERFORMANCE AS P ON
C.MusicID = P.MusicID);

# Question 7 (1 mark)
DROP VIEW IF EXISTS SCORE_ANALYSIS;
CREATE VIEW SCORE_ANALYSIS(CompAge, Score)
AS SELECT C.Age, P.Score
FROM PERFORMANCE AS P JOIN COMPETITOR AS C ON P.CompetitorID = C.CompetitorID;

# Question 8 (1 mark)
SELECT * FROM SCORE_ANALYSIS
ORDER BY Score DESC;

# Question 9 (1 mark)
SELECT MAX(Score), MIN(Score), AVG(Score)
FROM SCORE_ANALYSIS;

# Question 10 (2 marks)
ALTER TABLE COMPOSITION ADD COLUMN Copyright varchar(15) DEFAULT 'SOCAN';
SELECT * FROM COMPOSITION;

# Question 11 (2 marks)
SELECT Lname, Fname, Age FROM COMPETITOR AS COMP WHERE NOT EXISTS(
SELECT C.Age FROM (COMPETITOR AS C JOIN PERFORMANCE AS P ON C.CompetitorID =
P.CompetitorID) JOIN CATEGORY as G ON P.CategoryID = G.CategoryID
WHERE (C.Age <= G.AgeMax AND C.Age >= AgeMin AND COMP.CompetitorID = C.CompetitorID)
);

# Question 12 (1 mark)
ALTER TABLE COMPETITOR ADD CHECK (Age >= 5 AND Age <= 18);

# Question 13 (2 marks)
# Updated throughout the database due to the ON UPDATE CASCADE when creating the table.
UPDATE STUDIO SET Name = 'Harmony Studio' WHERE Name = 'Harmony Inc.';
SELECT * FROM STUDIO;

# Question 14 (1 mark)
# Deletion creates an error because the selected composter data has referential
# integrity constraints with COMPOSITION and PERFORMANCE.
DELETE FROM COMPOSITION WHERE Composer = 'Beethoven';

# Question 15 (1 mark)
# The following code will prevent any teacher information from being updated. It will
# send an error message asking for documentation to be provided to the office.
#DROP TRIGGER IF EXISTS Certification;
#CREATE TRIGGER Certification
#BEFORE UPDATE ON TEACHER FOR EACH ROW
#SIGNAL SQLSTATE '45000'
#SET MESSAGE_TEXT = 'Proof of certification must be provided to the main office.';

# Example: UPDATE TEACHER SET LName = 'Stone' WHERE LName = 'Steele';
