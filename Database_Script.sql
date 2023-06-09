USE [Student]
GO
/****** Object:  UserDefinedTableType [dbo].[TblStudents]    Script Date: 04/06/2023 8:24:46 AM ******/
CREATE TYPE [dbo].[TblStudents] AS TABLE(
	[StudId] [int] NOT NULL,
	[RegNo] [varchar](25) NULL,
	[FullName] [varchar](150) NOT NULL,
	[DOB] [date] NULL,
	[Gender] [varchar](10) NULL,
	[EmailAddr] [varchar](50) NULL,
	[DOA] [date] NOT NULL,
	[ClassId] [int] NOT NULL,
	[SessionId] [int] NOT NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [nvarchar](125) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](125) NULL,
	[UpdatedDate] [datetime] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TblStudentSubjects]    Script Date: 04/06/2023 8:24:46 AM ******/
CREATE TYPE [dbo].[TblStudentSubjects] AS TABLE(
	[StudSubId] [int] NOT NULL,
	[RegNo] [varchar](25) NULL,
	[SubjectId] [int] NULL,
	[SubjectNo] [varchar](125) NULL,
	[CrHours] [varchar](10) NULL,
	[TotalMarks] [decimal](18, 2) NULL,
	[Remarks] [varchar](250) NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [nvarchar](125) NULL,
	[CreatedDate] [datetime] NULL
)
GO
/****** Object:  Table [dbo].[Class]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Class](
	[ClassId] [int] IDENTITY(1,1) NOT NULL,
	[EngName] [varchar](150) NOT NULL,
	[ArbName] [varchar](150) NOT NULL,
	[Deleted] [bit] NULL DEFAULT ((0)),
	[CreatedBy] [nvarchar](125) NOT NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](125) NULL,
	[UpdatedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Session]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Session](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
	[EngName] [varchar](150) NOT NULL,
	[ArbName] [varchar](150) NOT NULL,
	[Deleted] [bit] NULL DEFAULT ((0)),
	[CreatedBy] [nvarchar](125) NOT NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](125) NULL,
	[UpdatedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Students]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Students](
	[StudId] [int] IDENTITY(1,1) NOT NULL,
	[RegNo] [varchar](25) NULL,
	[FullName] [varchar](150) NOT NULL,
	[DOB] [date] NULL,
	[Gender] [varchar](10) NULL,
	[EmailAddr] [varchar](50) NULL,
	[DOA] [date] NOT NULL,
	[ClassId] [int] NOT NULL,
	[SessionId] [int] NOT NULL,
	[Deleted] [bit] NULL DEFAULT ((0)),
	[CreatedBy] [nvarchar](125) NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](125) NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentSubjects]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentSubjects](
	[StudSubId] [int] IDENTITY(1,1) NOT NULL,
	[RegNo] [varchar](25) NOT NULL,
	[SubjectId] [int] NULL,
	[SubjectNo] [varchar](125) NULL,
	[CrHours] [varchar](10) NULL,
	[TotalMarks] [decimal](18, 2) NULL,
	[Remarks] [varchar](250) NULL,
	[Deleted] [bit] NULL DEFAULT ((0)),
	[CreatedBy] [nvarchar](125) NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
	[DeletedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subjects](
	[SubjectId] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
	[SessionId] [int] NULL,
	[SubjectNo] [varchar](125) NULL,
	[EngSubjectName] [varchar](150) NOT NULL,
	[ArbSubjectName] [varchar](150) NOT NULL,
	[CrHours] [varchar](10) NULL,
	[TotalMarks] [decimal](18, 2) NULL,
	[Remarks] [varchar](250) NULL,
	[Deleted] [bit] NULL DEFAULT ((0)),
	[CreatedBy] [nvarchar](125) NOT NULL,
	[CreatedDate] [datetime] NULL DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](125) NULL,
	[UpdatedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, N'Eng-Class-A', N'Arb-Class-A', 0, N'99', CAST(N'2023-06-01 12:48:23.883' AS DateTime), NULL, NULL)
INSERT [dbo].[Class] ([ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, N'Eng-Class-B', N'Arb-Class-B', 0, N'99', CAST(N'2023-06-01 12:48:23.943' AS DateTime), NULL, NULL)
INSERT [dbo].[Class] ([ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (3, N'Eng-Class-C', N'Arb-Class-C', 0, N'99', CAST(N'2023-06-01 12:48:23.983' AS DateTime), NULL, NULL)
INSERT [dbo].[Class] ([ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (4, N'Eng-Class-D', N'Arb-Class-D', 0, N'99', CAST(N'2023-06-01 12:48:24.023' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Class] OFF
SET IDENTITY_INSERT [dbo].[Session] ON 

INSERT [dbo].[Session] ([SessionId], [ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 1, N'Eng-Session-A', N'Arb-Session-A', 0, N'99', CAST(N'2023-06-01 12:51:01.450' AS DateTime), NULL, NULL)
INSERT [dbo].[Session] ([SessionId], [ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 2, N'Eng-Session-B', N'Arb-Session-B', 0, N'99', CAST(N'2023-06-01 12:51:01.503' AS DateTime), NULL, NULL)
INSERT [dbo].[Session] ([SessionId], [ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (3, 3, N'Eng-Session-C', N'Arb-Session-C', 0, N'99', CAST(N'2023-06-01 12:51:01.540' AS DateTime), NULL, NULL)
INSERT [dbo].[Session] ([SessionId], [ClassId], [EngName], [ArbName], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (4, 4, N'Eng-Session-D', N'Arb-Session-D', 0, N'99', CAST(N'2023-06-01 12:51:01.580' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Session] OFF
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([StudId], [RegNo], [FullName], [DOB], [Gender], [EmailAddr], [DOA], [ClassId], [SessionId], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [DeletedDate]) VALUES (2, N'RNO-00001', N'Merajudin', CAST(N'2023-05-04' AS Date), N'Male', N'meraj@gmail.com', CAST(N'2023-06-04' AS Date), 1, 1, 0, NULL, CAST(N'2023-06-04 08:04:30.680' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Students] OFF
SET IDENTITY_INSERT [dbo].[StudentSubjects] ON 

INSERT [dbo].[StudentSubjects] ([StudSubId], [RegNo], [SubjectId], [SubjectNo], [CrHours], [TotalMarks], [Remarks], [Deleted], [CreatedBy], [CreatedDate], [DeletedDate]) VALUES (5, N'RNO-00001', 1, N'Sub-1001', N'40', CAST(100.00 AS Decimal(18, 2)), N'Test', 0, NULL, CAST(N'2023-06-04 08:04:30.680' AS DateTime), NULL)
INSERT [dbo].[StudentSubjects] ([StudSubId], [RegNo], [SubjectId], [SubjectNo], [CrHours], [TotalMarks], [Remarks], [Deleted], [CreatedBy], [CreatedDate], [DeletedDate]) VALUES (6, N'RNO-00001', 5, N'Sub-1002', N'40', CAST(100.00 AS Decimal(18, 2)), N'Test', 0, NULL, CAST(N'2023-06-04 08:04:30.680' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[StudentSubjects] OFF
SET IDENTITY_INSERT [dbo].[Subjects] ON 

INSERT [dbo].[Subjects] ([SubjectId], [ClassId], [SessionId], [SubjectNo], [EngSubjectName], [ArbSubjectName], [CrHours], [TotalMarks], [Remarks], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (1, 1, 1, N'Sub-1001', N'Eng-Subject-1', N'Arb-Subject-1', N'40', CAST(100.00 AS Decimal(18, 2)), N'Test', 0, N'99', CAST(N'2023-06-01 12:56:33.387' AS DateTime), NULL, NULL)
INSERT [dbo].[Subjects] ([SubjectId], [ClassId], [SessionId], [SubjectNo], [EngSubjectName], [ArbSubjectName], [CrHours], [TotalMarks], [Remarks], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (2, 2, 2, N'Sub-1001', N'Eng-Subject-1', N'Arb-Subject-1', N'40', CAST(100.00 AS Decimal(18, 2)), N'Test', 0, N'99', CAST(N'2023-06-01 12:56:33.457' AS DateTime), NULL, NULL)
INSERT [dbo].[Subjects] ([SubjectId], [ClassId], [SessionId], [SubjectNo], [EngSubjectName], [ArbSubjectName], [CrHours], [TotalMarks], [Remarks], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (3, 3, 3, N'Sub-1001', N'Eng-Subject-1', N'Arb-Subject-1', N'40', CAST(100.00 AS Decimal(18, 2)), N'Test', 0, N'99', CAST(N'2023-06-01 12:56:33.497' AS DateTime), NULL, NULL)
INSERT [dbo].[Subjects] ([SubjectId], [ClassId], [SessionId], [SubjectNo], [EngSubjectName], [ArbSubjectName], [CrHours], [TotalMarks], [Remarks], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (4, 4, 4, N'Sub-1001', N'Eng-Subject-1', N'Arb-Subject-1', N'40', CAST(100.00 AS Decimal(18, 2)), N'Test', 0, N'99', CAST(N'2023-06-01 12:56:33.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Subjects] ([SubjectId], [ClassId], [SessionId], [SubjectNo], [EngSubjectName], [ArbSubjectName], [CrHours], [TotalMarks], [Remarks], [Deleted], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate]) VALUES (5, 1, 1, N'Sub-1002', N'Eng-Subject-2', N'Arb-Subject-12', N'40', CAST(100.00 AS Decimal(18, 2)), N'Test', 0, N'99', CAST(N'2023-06-01 12:56:33.387' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Subjects] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Students__2C6FF1E989B0613D]    Script Date: 04/06/2023 8:24:46 AM ******/
ALTER TABLE [dbo].[Students] ADD UNIQUE NONCLUSTERED 
(
	[RegNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Students__67C64AC71937215B]    Script Date: 04/06/2023 8:24:46 AM ******/
ALTER TABLE [dbo].[Students] ADD UNIQUE NONCLUSTERED 
(
	[EmailAddr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[FillStudentData]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[FillStudentData]
@qType int --= 1
,@SearchText varchar(125)--='RNO-00001'
as

if @qType=1 -- look for Reg no 
SELECT [StudId],[RegNo],[FullName],[DOB],[Gender],[EmailAddr],[DOA],[ClassId],[SessionId] FROM Students where [RegNo]  = @SearchText and isnull(Deleted,0)=0

else if @qType=2 
SELECT [StudId],[RegNo],[FullName],[DOB],[Gender],[EmailAddr],[DOA],[ClassId],[SessionId] FROM Students where EmailAddr = @SearchText and isnull(Deleted,0)=0

else if @qType=3
SELECT [StudId],[RegNo],[FullName],[DOB],[Gender],[EmailAddr],[DOA],[ClassId],[SessionId] FROM Students where FullName = @SearchText and isnull(Deleted,0)=0


GO
/****** Object:  StoredProcedure [dbo].[GetAutoCompleteData]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetAutoCompleteData]
@qType int --= 1
,@SearchText varchar(125)--='RNO-00001'
as

if @qType=1 -- look for Reg no 
SELECT top 10 [StudId] Id,[RegNo] as Name FROM Students where [RegNo] like '%'+@SearchText+'%' and isnull(Deleted,0)=0

else if @qType=2 
SELECT top 10 [StudId] Id,EmailAddr as Name FROM Students where EmailAddr like '%'+@SearchText+'%' and isnull(Deleted,0)=0

else if @qType=3
SELECT top 10 [StudId] Id,FullName as Name FROM Students where FullName like '%'+@SearchText+'%' and isnull(Deleted,0)=0


GO
/****** Object:  StoredProcedure [dbo].[GetClass]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetClass]
@lang int =1
as
SELECT [ClassId] Id,case when @lang=1 then [EngName] else [ArbName] end as Name FROM [Class] where isnull(Deleted,0)=0

GO
/****** Object:  StoredProcedure [dbo].[GetNextStudentRegNo]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNextStudentRegNo]

AS
BEGIN

	DECLARE @NewStudentRegNo VARCHAR(25);
	DECLARE @PreFix VARCHAR(10) = 'RNO-';
	DECLARE @Id INT;

	SELECT @Id = ISNULL(MAX(StudId),0) + 1 FROM [Students]

	SELECT @NewStudentRegNo = @PreFix + RIGHT('0000' + CAST(@Id AS VARCHAR(7)), 7)
	 
	select @NewStudentRegNo NewStudentRegNo

END
GO
/****** Object:  StoredProcedure [dbo].[GetSession]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetSession]
@lang int =1,
@ClassId int
as
SELECT [SessionId] Id,case when @lang=1 then [EngName] else [ArbName] end as Name FROM [Session] where ClassId=@ClassId and isnull(Deleted,0)=0

GO
/****** Object:  StoredProcedure [dbo].[GetSubjects]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetSubjects]
@lang int =1,
@ClassId int,
@SessionId int,
@searchValue varchar(125),
@qType int
as

if @qType=0
SELECT  [SubjectId],[SubjectNo],[EngSubjectName],[ArbSubjectName],[CrHours],[TotalMarks],[Remarks] FROM [Subjects] 
where [ClassId]=@ClassId and [SessionId]=@SessionId and isnull(Deleted,0)=0

else if @qType in(1,2,3)
SELECT  a.[SubjectId],a.[SubjectNo],b.[EngSubjectName],b.[ArbSubjectName],a.[CrHours],a.[TotalMarks],a.[Remarks] FROM [StudentSubjects] a
left outer join
[Subjects] b on a.[SubjectId]=b.[SubjectId]
where [RegNo]=@searchValue and isnull(a.Deleted,0)=0  

GO
/****** Object:  StoredProcedure [dbo].[SaveStudentReg]    Script Date: 04/06/2023 8:24:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SaveStudentReg]
@TblStudents TblStudents readonly,
@TblStudentSubjects	TblStudentSubjects readonly,
@qType int=0
as

BEGIN TRY
BEGIN TRANSACTION TRN_SaveStudentReg

	declare @RegNo varchar(25)
	select @RegNo=RegNo from @TblStudents

	if @RegNo is not null and @qType=3 -- Delete Record
	begin

		--update Students set Deleted=1,DeletedDate=GETDATE() where [RegNo]=@RegNo
		--update StudentSubjects set Deleted=1,DeletedDate=GETDATE() where [RegNo]=@RegNo

		delete Students where [RegNo]=@RegNo
		delete StudentSubjects where [RegNo]=@RegNo

		select 3 msg
	end

	else if not exists(select NULL from Students where RegNo=isnull(@RegNo,0)) -- Insert Record
	begin
		print 1
		insert into Students
		(
		[RegNo],[FullName],[DOB],[Gender],[EmailAddr],[DOA],[ClassId],[SessionId],[Deleted],[CreatedDate]
		)
		SELECT 
		[RegNo],[FullName],[DOB],[Gender],[EmailAddr],[DOA],[ClassId],[SessionId],0,GETDATE() 
		FROM @TblStudents



		insert into StudentSubjects
		(
		[RegNo],[SubjectId],[SubjectNo],[CrHours],[TotalMarks],[Remarks],[Deleted],[CreatedDate]
		)
		select 
		@RegNo,[SubjectId],[SubjectNo],[CrHours],[TotalMarks],[Remarks],0,GETDATE()
		from @TblStudentSubjects

		select 1 msg
	end

	else if exists(select NULL from Students where RegNo=isnull(@RegNo,0)) -- Update Record
	begin
		print 2
		UPDATE
		Students
		SET
			Students.[FullName] = stn.[FullName],
			Students.[DOB] = stn.[DOB],
			Students.[Gender] = stn.[Gender],
			Students.EmailAddr = stn.EmailAddr,
			Students.[DOA] = stn.[DOA],
			Students.[ClassId] = stn.[ClassId],
			Students.[SessionId] = stn.[SessionId],
			Students.[Deleted] = 0,
			Students.UpdatedDate = GETDATE()
		FROM
		Students st
		INNER JOIN
		@TblStudents stn
		ON 
		st.[RegNo] = stn.[RegNo]


		update StudentSubjects set Deleted=1,DeletedDate=GETDATE() where [RegNo]=@RegNo
		insert into StudentSubjects
		(
		[RegNo],[SubjectId],[SubjectNo],[CrHours],[TotalMarks],[Remarks],[Deleted],[CreatedDate]
		)
		select 
		@RegNo,[SubjectId],[SubjectNo],[CrHours],[TotalMarks],[Remarks],0,GETDATE()
		from @TblStudentSubjects

		select 2 msg

	end

	

COMMIT TRANSACTION TRN_SaveStudentReg
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION TRN_SaveStudentReg
		--SELECT ERROR_LINE() ERROR_LINE_,ERROR_NUMBER() ERROR_NUMBER_
	SELECT  ERROR_MESSAGE() msg
END CATCH
GO
