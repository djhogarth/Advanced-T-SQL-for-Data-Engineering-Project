USE [ChicagoDataDB]
GO

/****** Object:  Table [dbo].[ChicagoCrimeData]    Script Date: 12/20/2022 2:09:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('ChicagoCrimeData') IS NOT NULL
	DROP TABLE ChicagoCrimeData
GO

CREATE TABLE ChicagoCrimeData(
	[ID] [int] NOT NULL,
	[CASE_NUMBER] [nvarchar](50) NULL,
	[DATE] [date] NULL,
	[BLOCK] [nvarchar](50) NULL,
	[IUCR] [nvarchar](50) NULL,
	[PRIMARY_TYPE] [nvarchar](50) NULL,
	[DESCRIPTION] [nvarchar](50) NULL,
	[LOCATION_DESCRIPTION] [nvarchar](50) NULL,
	[ARREST] [nvarchar](6) NULL,
	[DOMESTIC] [nvarchar](6) NULL,
	[BEAT] [int] NULL,
	[DISTRICT] [nvarchar](50) NULL,
	[WARD] [nvarchar](50) NULL,
	[COMMUNITY_AREA_NUMBER] [nvarchar](50) NULL,
	[FBICODE] [nvarchar](50) NULL,
	[X_COORDINATE] [bigint] NULL,
	[Y_COORDINATE] [bigint] NULL,
	[YEAR] [int] NULL,
	[LATITUDE] [float] NULL,
	[LONGITUDE] [float] NULL,
	[LOCATION] [nvarchar](50) NULL,
 CONSTRAINT [PK_ChicagoCrimeData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- import the csv file
-- change the file path to the absolute file path of the csv file on your machine
BULK INSERT ChicagoCrimeData
FROM 'C:\Users\djhog\Python_Projects\SQL Projects\Advanced SQL for Data Engineering Project\ChicagoCrimeData.csv'
WITH
(
        
        FIRSTROW=2,
		FORMAT = 'CSV',
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '0x0a'

)
GO

