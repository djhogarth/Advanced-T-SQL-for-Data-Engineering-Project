USE [ChicagoDataDB]
GO

/****** Object:  Table [dbo].[ChicagoPublicSchools]    Script Date: 12/20/2022 2:12:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('ChicagoPublicSchools') IS NOT NULL
	DROP TABLE ChicagoPublicSchools
GO


CREATE TABLE ChicagoPublicSchools(
	[School_ID] [int] NOT NULL,
	[NAME_OF_SCHOOL] [nvarchar](100) NULL,
	[Elementary_Middle_or_High_School] [nvarchar](50) NULL,
	[Street_Address] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[ZIP_Code] [int] NULL,
	[Phone_Number] [nvarchar](50) NULL,
	[Link] [nvarchar](100) NULL,
	[Network_Manager] [nvarchar](50) NULL,
	[Collaborative_Name] [nvarchar](50) NULL,
	[Adequate_Yearly_Progress_Made] [nvarchar](6) NULL,
	[Track_Schedule] [nvarchar](50) NULL,
	[CPS_Performance_Policy_Status] [nvarchar](50) NULL,
	[CPS_Performance_Policy_Level] [nvarchar](50) NULL,
	[HEALTHY_SCHOOL_CERTIFIED] [nvarchar](6) NULL,
	[Safety_Icon] [nvarchar](50) NULL,
	[SAFETY_SCORE] [tinyint] NULL,
	[Family_Involvement_Icon] [nvarchar](50) NULL,
	[Family_Involvement_Score] [nvarchar](50) NULL,
	[Environment_Icon] [nvarchar](50) NULL,
	[Environment_Score] [tinyint] NULL,
	[Instruction_Icon] [nvarchar](50) NULL,
	[Instruction_Score] [tinyint] NULL,
	[Leaders_Icon] [nvarchar](50) NULL,
	[Leaders_Score] [nvarchar](50) NULL,
	[Teachers_Icon] [nvarchar](50) NULL,
	[Teachers_Score] [nvarchar](50) NULL,
	[Parent_Engagement_Icon] [nvarchar](50) NULL,
	[Parent_Engagement_Score] [nvarchar](50) NULL,
	[Parent_Environment_Icon] [nvarchar](50) NULL,
	[Parent_Environment_Score] [nvarchar](50) NULL,
	[AVERAGE_STUDENT_ATTENDANCE] [nvarchar](50) NULL,
	[Rate_of_Misconducts_per_100_students] [float] NULL,
	[Average_Teacher_Attendance] [nvarchar](50) NULL,
	[Individualized_Education_Program_Compliance_Rate] [nvarchar](50) NULL,
	[Pk_2_Literacy] [nvarchar](50) NULL,
	[Pk_2_Math] [nvarchar](50) NULL,
	[Gr3_5_Grade_Level_Math] [nvarchar](50) NULL,
	[Gr3_5_Grade_Level_Read] [nvarchar](50)NULL,
	[Gr3_5_Keep_Pace_Read] [nvarchar](50)NULL,
	[Gr3_5_Keep_Pace_Math] [nvarchar](50) NULL,
	[Gr6_8_Grade_Level_Math] [nvarchar](50) NULL,
	[Gr6_8_Grade_Level_Read] [nvarchar](50) NULL,
	[Gr6_8_Keep_Pace_Math] [nvarchar](50) NULL,
	[Gr6_8_Keep_Pace_Read] [nvarchar](50) NULL,
	[Gr_8_Explore_Math] [nvarchar](50) NULL,
	[Gr_8_Explore_Read] [nvarchar](50) NULL,
	[ISAT_Exceeding_Math] [nvarchar](50) NULL,
	[ISAT_Exceeding_Reading] [nvarchar](50) NULL,
	[ISAT_Value_Add_Math] [nvarchar](50) NULL,
	[ISAT_Value_Add_Read] [nvarchar](50) NULL,
	[ISAT_Value_Add_Color_Math] [nvarchar](50) NULL,
	[ISAT_Value_Add_Color_Read] [nvarchar](50) NULL,
	[Students_Taking_Algebra] [nvarchar](50) NULL,
	[Students_Passing_Algebra] [nvarchar](50) NULL,
	[_9th_Grade_EXPLORE_2009] [nvarchar](50) NULL,
	[_9th_Grade_EXPLORE_2010] [nvarchar](50) NULL,
	[_10th_Grade_PLAN_2009] [nvarchar](50) NULL,
	[_10th_Grade_PLAN_2010] [nvarchar](50) NULL,
	[Net_Change_EXPLORE_and_PLAN] [nvarchar](50) NULL,
	[_11th_Grade_Average_ACT_2011] [nvarchar](50) NULL,
	[Net_Change_PLAN_and_ACT] [nvarchar](50) NULL,
	[College_Eligibility] [nvarchar](50) NULL,
	[Graduation_Rate] [nvarchar](50) NULL,
	[College_Enrollment_Rate] [nvarchar](50) NULL,
	[COLLEGE_ENROLLMENT] [smallint] NULL,
	[General_Services_Route] [tinyint] NULL,
	[Freshman_on_Track_Rate] [nvarchar](50) NULL,
	[X_COORDINATE] [float] NULL,
	[Y_COORDINATE] [float] NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[COMMUNITY_AREA_NUMBER] [tinyint] NULL,
	[COMMUNITY_AREA_NAME] [nvarchar](50) NULL,
	[Ward] [tinyint] NULL,
	[Police_District] [tinyint] NULL,
	[Location] [nvarchar](50) NULL,
 CONSTRAINT [PK_ChicagoPublicSchools] PRIMARY KEY CLUSTERED 
(
	[School_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- import the csv file
-- change the file path to the absolute file path of the csv file on your machine
BULK INSERT ChicagoPublicSchools
FROM 'C:\Users\djhog\Python_Projects\SQL Projects\Advanced SQL for Data Engineering Project\ChicagoPublicSchools.csv'
WITH
(
        
        FIRSTROW=2,
		FORMAT = 'CSV',
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '0x0a'

)
GO
