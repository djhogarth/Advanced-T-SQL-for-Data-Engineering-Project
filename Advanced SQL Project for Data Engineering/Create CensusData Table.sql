USE [ChicagoDataDB]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('CensusData') IS NOT NULL
	DROP TABLE CensusData
GO

CREATE TABLE CensusData(
	[COMMUNITY_AREA_NUMBER] [tinyint] NULL,
	[COMMUNITY_AREA_NAME] [nvarchar](50) NOT NULL,
	[PERCENT_OF_HOUSING_CROWDED] [float] NOT NULL,
	[PERCENT_HOUSEHOLDS_BELOW_POVERTY] [float] NOT NULL,
	[PERCENT_AGED_16_UNEMPLOYED] [float] NOT NULL,
	[PERCENT_AGED_25_WITHOUT_HIGH_SCHOOL_DIPLOMA] [float] NOT NULL,
	[PERCENT_AGED_UNDER_18_OR_OVER_64] [float] NOT NULL,
	[PER_CAPITA_INCOME] [int] NOT NULL,
	[HARDSHIP_INDEX] [tinyint] NULL
) ON [PRIMARY]
GO

-- import the file
BULK INSERT CensusData
FROM 'C:\Users\djhog\Python_Projects\SQL Projects\Advanced SQL for Data Engineering Project\ChicagoCensusData.csv'
WITH
(
        FIRSTROW=2,
		FORMAT = 'CSV',
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '0x0a'

)
GO

