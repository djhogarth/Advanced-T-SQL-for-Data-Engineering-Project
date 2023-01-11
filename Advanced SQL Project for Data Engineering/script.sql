
USE ChicagoDataDB
GO
--	Listing the school names, community names and average attendance for communities with a hardship index of 98.
SELECT CPS.NAME_OF_SCHOOL, CPS.COMMUNITY_AREA_NAME, CPS.AVERAGE_STUDENT_ATTENDANCE
FROM ChicagoPublicSchools AS CPS 
LEFT JOIN dbo.CensusData AS CD ON CPS.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER 
WHERE CD.HARDSHIP_INDEX = 98;
-- Listing all crimes that took place at a school. Show the case number, crime type and community name.
SELECT CRIME.CASE_NUMBER, CRIME.PRIMARY_TYPE, SCHOOLS.COMMUNITY_AREA_NAME  FROM dbo.ChicagoCrimeData AS CRIME INNER JOIN dbo.ChicagoPublicSchools AS SCHOOLS 
ON CRIME.COMMUNITY_AREA_NUMBER = SCHOOLS.COMMUNITY_AREA_NUMBER WHERE CRIME.LOCATION_DESCRIPTION LIKE '%SCHOOL%';
--	I create a view that enables users to select just the school name and the icon fields from the CHICAGO_PUBLIC_SCHOOLS table. 
--	By providing a view, I ensure that users cannot see the actual scores given to a school, just the icon associated with their score.

IF EXISTS (
	SELECT name 
		FROM sys.views
		WHERE name = N'SCHOOL_NAMES_AND_ICON_FIELDS_VIEW'	
) 
	drop view dbo.SCHOOL_NAMES_AND_ICON_FIELDS_VIEW
GO
IF NOT EXISTS (
	SELECT name 
		FROM sys.views
		WHERE name = N'SCHOOL_NAMES_AND_ICON_FIELDS_VIEW'
)
	PRINT 'CREATING VIEW'
	GO

--	Define a view that serves to censors private information from the Chicago Public Schools Table
	CREATE VIEW 
	SCHOOL_NAMES_AND_ICON_FIELDS_VIEW
	(School_Name, Safetly_Rating, Family_Rating, Environment_Rating, Instruction_Rating, Leaders_Rating, 
	Teachers_Rating) 
	AS 
	SELECT NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, Environment_Icon, Instruction_Icon, Leaders_Icon, Teachers_Icon
	FROM dbo.ChicagoPublicSchools;
GO

---- Returning all of the columns from the view
SELECT * FROM SCHOOL_NAMES_AND_ICON_FIELDS_VIEW;

---- Returning just the school name and leaders rating from the view
SELECT SCHOOL_NAME, LEADERS_RATING FROM dbo.SCHOOL_NAMES_AND_ICON_FIELDS_VIEW;

-- The icon fields are calculated based on the value in the corresponding score field. When a score field is updated, the icon field is updated too. 
-- To accomplish this, a stored procedure is written which receives the school id and a leaders score as input parameters, 
-- calculates the icon setting and updates the fields appropriately.


PRINT 'CREATING PROCEDURE'
GO
--	Drop the UPDATE_LEADERS_SCORE stored procedure if it already exists
IF EXISTS (
	SELECT name 
		FROM sys.procedures
		WHERE name = N'UPDATE_LEADERS_SCORE'
)
	DROP PROCEDURE UPDATE_LEADERS_SCORE;
GO 

--	Define the stored procedure
CREATE PROCEDURE dbo.UPDATE_LEADERS_SCORE ( 
@_in_School_ID INTEGER, 
@_in_Leader_Score INTEGER
)
AS
BEGIN

	UPDATE dbo.ChicagoPublicSchools
	SET LEADERS_SCORE = @_in_Leader_Score 
	WHERE SCHOOL_ID = @_in_School_ID;

	BEGIN TRAN T
	
	IF @_in_Leader_Score >= 80 AND @_in_Leader_Score <= 99 
	BEGIN
		UPDATE dbo.ChicagoPublicSchools 
		SET LEADERS_ICON = 'Very Strong'
		WHERE SCHOOL_ID = @_in_School_ID;
	END

  	IF @_in_Leader_Score >= 60 AND @_in_Leader_Score <= 79 
	BEGIN
		UPDATE dbo.ChicagoPublicSchools 
		SET LEADERS_ICON = 'Strong'
		WHERE SCHOOL_ID = @_in_School_ID;
	END

	IF @_in_Leader_Score >= 40 AND @_in_Leader_Score <= 59 
	BEGIN
		UPDATE dbo.ChicagoPublicSchools 
		SET LEADERS_ICON = 'Average'
		WHERE SCHOOL_ID = @_in_School_ID; 
	END

	IF @_in_Leader_Score >= 20 AND @_in_Leader_Score <= 39 
	BEGIN
      UPDATE dbo.ChicagoPublicSchools 
		SET LEADERS_ICON = 'Weak'
		WHERE SCHOOL_ID = @_in_School_ID;
	END

	IF @_in_Leader_Score >= 0 AND @_in_Leader_Score <= 19 
	BEGIN
      UPDATE dbo.ChicagoPublicSchools 
		SET LEADERS_ICON = 'Very Weak'
		WHERE SCHOOL_ID = @_in_School_ID;
	END

	ELSE
	BEGIN
		PRINT 'NONE OF THE CONDITIONS MATCH, SO ROLLBACK TRANSACTION'
		ROLLBACK TRAN T
	END
	
COMMIT TRAN T
END

PRINT 'STORED PROCEDURE CREATED'
GO
--	Increase the variable length of Leader_Icon column in the Public Schools Table, 
--	so thatUPDATE_LEADERS_SCORE Can successfully update them
ALTER TABLE dbo.ChicagoPublicSchools 
ALTER COLUMN LEADERS_ICON  VARCHAR(16);

--Run the Stored Procedure, UPDATE_LEADERS_SCORE and provide it a School ID of 610212 and a leader score of 50
EXEC dbo.UPDATE_LEADERS_SCORE @_in_School_ID=610212,@_in_Leader_Score=50;

--The Leader Icon should now display 'Average' for this specific school. It was orginally on 'Weak'.
SELECT LEADERS_SCORE, LEADERS_ICON FROM dbo.ChicagoPublicSchools WHERE SCHOOL_ID = 610212;  

