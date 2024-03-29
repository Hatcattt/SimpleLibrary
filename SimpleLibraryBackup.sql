/****** Object:  Database [SimpleLibrary]    Script Date: 03-06-23 13:23:23 ******/
CREATE DATABASE [SimpleLibrary]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SimpleLibrary', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.PGBDSQLSERVEUR\MSSQL\DATA\SimpleLibrary.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SimpleLibrary_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.PGBDSQLSERVEUR\MSSQL\DATA\SimpleLibrary_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SimpleLibrary].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SimpleLibrary] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SimpleLibrary] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SimpleLibrary] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SimpleLibrary] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SimpleLibrary] SET ARITHABORT OFF 
GO
ALTER DATABASE [SimpleLibrary] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SimpleLibrary] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SimpleLibrary] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SimpleLibrary] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SimpleLibrary] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SimpleLibrary] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SimpleLibrary] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SimpleLibrary] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SimpleLibrary] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SimpleLibrary] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SimpleLibrary] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SimpleLibrary] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SimpleLibrary] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SimpleLibrary] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SimpleLibrary] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SimpleLibrary] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SimpleLibrary] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SimpleLibrary] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SimpleLibrary] SET  MULTI_USER 
GO
ALTER DATABASE [SimpleLibrary] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SimpleLibrary] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SimpleLibrary] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SimpleLibrary] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SimpleLibrary] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SimpleLibrary] SET QUERY_STORE = OFF
GO
/****** Object:  Table [dbo].[Author]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [nvarchar](50) NOT NULL,
	[Nationality] [nvarchar](3) NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuthorPublication]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthorPublication](
	[AuthorPublicationID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
	[AuthorFunction] [nvarchar](50) NULL,
 CONSTRAINT [PK_AuthorPublication] PRIMARY KEY CLUSTERED 
(
	[AuthorPublicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication](
	[PublicationID] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [nvarchar](20) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Location] [int] NOT NULL,
	[LetterRow] [char](1) NOT NULL,
	[Publisher] [nvarchar](100) NOT NULL,
	[PublishedDate] [date] NULL,
	[Language] [nvarchar](3) NULL,
	[Description] [nvarchar](max) NULL,
	[CoverFilePath] [nvarchar](max) NULL,
	[CreateAt] [date] NULL,
	[UpdateAt] [date] NULL,
 CONSTRAINT [PK_Publication] PRIMARY KEY CLUSTERED 
(
	[PublicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicationCopy]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicationCopy](
	[PublicationCopyID] [int] IDENTITY(1,1) NOT NULL,
	[PublicationID] [int] NOT NULL,
	[PublicationState] [int] NOT NULL,
 CONSTRAINT [PK_PublicationCopy] PRIMARY KEY CLUSTERED 
(
	[PublicationCopyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicationStateEnum]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicationStateEnum](
	[PublicationStateId] [int] NOT NULL,
	[PublicationState] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PublicationStateEnum] PRIMARY KEY CLUSTERED 
(
	[PublicationStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shelf]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shelf](
	[ShelfID] [int] IDENTITY(1,1) NOT NULL,
	[ShelfName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Shelf] PRIMARY KEY CLUSTERED 
(
	[ShelfID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShelfComposition]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShelfComposition](
	[ShelfCompositionID] [int] IDENTITY(1,1) NOT NULL,
	[ShelfID] [int] NOT NULL,
	[ThemeID] [int] NOT NULL,
 CONSTRAINT [PK_ShelfComposition] PRIMARY KEY CLUSTERED 
(
	[ShelfCompositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theme]    Script Date: 03-06-23 13:23:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theme](
	[ThemeID] [int] IDENTITY(1,1) NOT NULL,
	[ThemeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Theme] PRIMARY KEY CLUSTERED 
(
	[ThemeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1, N'Midam', N'BE')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (3, N'Franquin', N'BE')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (4, N'Michel Tognini', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (5, N'Hélène Courtois', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (6, N'Jean-Yves Le Gall', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (7, N'Zep', N'CH')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (8, N'Tébo', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (9, N'Rick Barba', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (10, N'Neil Mercer', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (11, N'Joan Swann', N'')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (14, N'Masashi Kishimoto', N'JP')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (15, N'Hergé', N'BE')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (16, N'Raoul Cauvin', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (38, N'Tome', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (40, N'Erroc', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (41, N'Sti', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (42, N'Simon Léturgie', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (43, N'Tohru Fujisawa', N'JP')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1035, N'Janry', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1036, N'Bertschy', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1037, N'Jean Roba', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1038, N'Larousse', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1039, N'Angus Stevenson', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1040, N'Jean Graton', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1041, N'Tite Kubo', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1042, N'Colman', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1043, N'Philippe Geluck', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1045, N'René Goscinny', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1046, N'Albert Uderzo', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1047, N'J. K. Rowling', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1048, N'Jean-François Ménard', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1049, N'Daniel Kox', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1051, N'Jean Van Hamme', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1052, N'De Groot', N'FR')
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[AuthorPublication] ON 

INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (20, 15, 16, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (21, 15, 17, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (22, 15, 18, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (44, 16, 180, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (54, 38, 189, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (55, 4, 190, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (56, 5, 190, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (57, 6, 190, N'Preface')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (58, 15, 191, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (62, 40, 194, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (63, 41, 194, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (64, 42, 194, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (65, 40, 195, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (66, 42, 195, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (67, 43, 196, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (68, 43, 197, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (69, 43, 198, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1059, 38, 204, N'Unknown')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1060, 38, 205, N'Unknown')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1066, 1036, 209, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1067, 1037, 210, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1069, 1039, 212, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1070, 1040, 213, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1071, 1040, 214, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1072, 1040, 215, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1073, 7, 216, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1074, 7, 217, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1075, 7, 218, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1076, 7, 219, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1077, 1041, 222, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1079, 1042, 224, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1080, 16, 225, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1081, 16, 226, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1082, 38, 227, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1083, 1043, 228, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1085, 1045, 230, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1086, 1046, 230, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1087, 1045, 231, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1088, 1046, 231, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1089, 38, 232, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1090, 1035, 232, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1091, 15, 234, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1092, 15, 235, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1095, 14, 238, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1096, 14, 239, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1097, 14, 240, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1098, 14, 241, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1127, 3, 3, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1128, 10, 9, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1129, 11, 9, N'Cover')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1130, 1037, 37, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1131, 15, 80, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1132, 3, 83, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1134, 1036, 85, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1135, 1036, 86, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1136, 1049, 90, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1137, 16, 90, N'Writer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1138, 1049, 93, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1139, 16, 93, N'Writer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1140, 16, 94, N'Writer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1141, 1049, 94, N'Drawer')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1142, 15, 96, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1143, 1047, 237, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1144, 1048, 237, N'Unknown')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1145, 16, 19, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1146, 16, 20, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1147, 16, 21, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1148, 16, 22, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1149, 16, 23, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1150, 3, 243, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1152, 3, 244, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1156, 1038, 251, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1157, 15, 252, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1158, 1051, 253, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1159, 1051, 254, N'Creator')
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1160, 1052, 255, N'Creator')
SET IDENTITY_INSERT [dbo].[AuthorPublication] OFF
GO
SET IDENTITY_INSERT [dbo].[Publication] ON 

INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (3, N'9782800177274', N'Gaston - tome 17 - La saga des gaffes', 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'FR', N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=f-joPl7Wri0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (9, N'9780415131216', N'Learning English', 12, N'L', N'Psychology Press', CAST(N'1996-01-01' AS Date), N'EN', N'English is learnt, internationally, in a range of diverse settings. This book examines processes of language acquisition in English, as well as what it means to learn English in different parts of the world. It looks at the place of English within formal education, and at some of the controversies that have surrounded the teaching of English.', N'http://books.google.com/books/content?id=ithfgp_WpfUC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (16, N'9782203001152', N'Tintin : Objectif Lune', 15, N'T', N'Editions Moulinsart', CAST(N'1953-01-01' AS Date), N'FR', N'Le Professeur Tournesol invite Tintin et le Capitaine Haddock à le rejoindre en Syldavie où il travaille sur le plus grand projet du siècle : l''envoi d''une fusée sur la Lune. Le défi s''annonce palpitant, d''autant plus qu''au grand effarement du Capitaine, le Professeur leur suggère d''être du voyage !', N'http://books.google.com/books/content?id=Ya4_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (17, N'9782203001169', N'Tintin : On a marché sur la lune', 15, N'T', N'Editions Moulinsart', CAST(N'1954-01-01' AS Date), N'FR', N'L''expédition lunaire de nos héros est pleine de rebondissements et de surprises. Deux exemples marquants : l''arrivée des Dupondt, embarqués malgré eux dans le voyage vers notre satellite naturel, et le sort funeste de Frank Wolff. Sur le plan scientifique, Hergé réussit pleinement à nous faire goûter les mystères du moteur atomique ou des phénomènes d''apesanteur. De la même manière, il invite le lecteur à participer au pilotage d''une fusée interplanétaire tout en nous faisant voyager dans le monde spatial.', N'http://books.google.com/books/content?id=Y64_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-05-31' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (18, N'9782203001107', N'Tintin : Le Secret de La Licorne', 15, N'T', N'Editions Moulinsart', CAST(N'1943-01-01' AS Date), N'FR', N'En fouillant le grenier, le capitaine Haddock retrouve la trace de son ancêtre, le chevalier de Haddoque. Ce légendaire loup des mers s''est rendu célèbre par ses déboires avec le cruel pirate Rackham le Rouge. Un roman maritime de plus ? Certainement pas! Car le chevalier devient le dépositaire d''un fabuleux trésor. Pour Tintin, Haddock et une série de malfrats, il s''agit de le retrouver. Mais les pistes et les énigmes se multiplient.', N'http://books.google.com/books/content?id=V64_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-01' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (19, N'9782800189093', N'Cédric - Tome 1 - Premières classes', 13, N'C', N'Dupuis', CAST(N'2013-06-20' AS Date), N'FR', N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=ewgRQwpDwUEC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (20, N'9782800189086', N'Cédric - Tome 2 - Classes de neige', 13, N'C', N'Dupuis', CAST(N'2013-06-20' AS Date), N'FR', N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=5VMTCE-q5K4C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (21, N'9782800189079', N'Cédric - Tome 3 - Classe tous risques', 13, N'C', N'Dupuis', CAST(N'2013-06-20' AS Date), N'FR', N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=P658kjdJHnkC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (22, N'9782800189062', N'Cédric - Tome 4 - Papa a de la classe', 13, N'C', N'Dupuis', CAST(N'2010-03-26' AS Date), N'FR', N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=7z4KJtFxfKUC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (23, N'9782800195193', N'Cédric - Tome 5 - Quelle mouche le pique?', 13, N'C', N'Dupuis', CAST(N'2010-03-26' AS Date), N'FR', N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=kKB5D7M9WtsC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (37, N'9782800189291', N'Boule et Bill - Tome 5 - Bulles et Bill', 13, N'B', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Boule, un petit garçon comme les autres, a comme meilleur copain Bill, son adorable et facétieux cocker. Outre Boule, Bill a une autre grande passion : Caroline, la mignonne tortue... Dans un univers familial plein de gentillesse et de joie de vivre, les bêtises et les espiègleries de Boule et Bill déchainent les éclats de rire des lecteurs de tout âge.', N'http://books.google.com/books/content?id=WVqlDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (80, N'9782203001114', N'Tintin : Le Trésor de Rackham le Rouge ', 15, N'T', N'Editions Moulinsart', CAST(N'1944-01-01' AS Date), N'fr', N'Dans Le Secret de La Licorne (1943) et Le Trésor de Rackham le Rouge qui en est la suite, Tintin accompagne le capitaine Haddock sur les traces de son glorieux ancêtre, le chevalier François de Hadoque. Inventeur d''un sous-marin de poche en forme de requin, un certain Tryphon Tournesol contribue à la découverte du trésor, avant d''offrir au Capitaine le château de ses aïeux : Moulinsart. Tintin, Haddock et les Dupondt s''embarquent, munis des parchemins laissés par l''illustre ancêtre du Capitaine, à la recherche du Trésor de Rackham Le Rouge. L''aventure n''ira pas sans aléas ni surprises, d''autant plus que le professeur Tournesol a présenté à Tintin et au Capitaine un nouvel appareil d''exploration sous-marine...', N'http://books.google.com/books/content?id=Wa4_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (83, N'9782800177113', N'Gaston - tome 09 - Un gaffeur sachant gaffer ', 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'fr', N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=KHYnfBpFecQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (85, N'9782800186788', N'Nelson tome 1 - Diablotin à domicile ', 13, N'N', N'Dupuis', CAST(N'2013-06-26' AS Date), N'fr', N'Quand NELSON débarque chez vous... c''est l''ENFER !Nelson, c''est l''insupportable diablotin qui vient s''incruster dans la vie de Julie, une jeune et jolie célibataire, et de Floyd, un labrador engourdi. Mais attention, personne n''est à l''abri de cette malédiction orange! Nelson a largement assez de défauts pour dynamiter le quotidien de tous les infortunés qui croisent son chemin.Nelson : star des strips, star en Suisse !Nelson est né le 11 février 2001 dans LE MATIN, sous la plume de Christophe Bertschy (également auteur de Smax dans TCHÔ !). Depuis, c''est plus de 700 strips qui ont réjoui les lecteurs du premier quotidien francophone de Suisse. Le journal a même édité un album en bichro reprenant 180 strips qui s''est vendu à près de 5000 exemplaires rien qu''en Suisse Romande ! Les Éditions Dupuis ont eu une idée diabolique : rassembler tous les strips du petit démon domestique pour en faire de beaux albums de BD tout en couleurs. Le premier volume sera disponible en janvier 2004 d''autres suivront... à un rythme d''enfer !', N'http://books.google.com/books/content?id=teJkJHyOCjYC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (86, N'9782800186740', N'Nelson tome 2 - Catastrophe naturelle ', 13, N'N', N'Dupuis', CAST(N'2013-06-26' AS Date), N'fr', N'Catastrophe pas très naturelle !Nelson, c''est l''insupportable diablotin qui vient s''incruster dans la vie de Julie, une jeune et jolie célibataire, et de Floyd, un labrador engourdi. Véritable catastrophe surnaturelle, Nelson n''a pas son pareil pour empoisonner chaque instant de la vie de ses deux victimes favorites. Mais, attention : personne n''est à l''abri de cette malédiction orange ! Car Nelson a largement assez de défauts pour dynamiter le quotidien de tous les infortunés qui croisent son chemin...Quand, en février 2001, Christophe Bertschy propose au MATIN de publier les strips de Nelson, il ne sait pas encore dans quel enfer il plonge ! Car, en quelques mois à peine, son diablotin orange est devenu la mascotte du plus important quotidien francophone de Suisse. Et des centaines de milliers de lecteurs attendent, chaque jour, leur ration de catastrophes en tout genre. Depuis, un très large public francophone a succombé au charme infernal du diablotin domestique... Christophe Bertschy est également l''auteur de Smax, une série à gags publiée dans TCHÔ !', N'http://books.google.com/books/content?id=2J5zVHqjv3UC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (90, N'9782800189451', N'L''Agent 212 - Tome 7 - UN FLIC A L''OMBRE', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=3bBHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (93, N'9782800189406', N'L''Agent 212 - Tome 13 - UN FLIC FLANCHE', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=k7BHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-17' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (94, N'9782800189413', N'L''Agent 212 - Tome 12 - RIS,O POULET', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=cbFHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-17' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (96, N'9782203001022', N'Tintin en Amérique', 15, N'T', N'Editions Moulinsart', CAST(N'1932-01-01' AS Date), N'fr', N'Tintin confirme sa vocation de redresseur de torts, en s''opposant au mafioso Al Capone, aux gangsters de Chicago et aux fripouilles de tout acabit. Sa renommée s''étend au-delà de l''Atlantique. Si bien que lorsqu''il arrive à Chicago, en pleine prohibition, tous les bandits et malfaiteurs associés lui préparent une réception des moins confortables. Tintin devra user de tout son courage et de toute son intelligence pour survivre !', N'http://books.google.com/books/content?id=P64_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-18' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (180, N'9782800189420', N'L''Agent 212 - Tome 11 - SIFFLEZ DANS LE BALLON !', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=ArFHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (189, N'9782800180045', N'Soda - Tome 13 - Resurrection', 15, N'S', N'Dupuis', CAST(N'2014-11-07' AS Date), N'fr', N'Comme chaque année, ignorant toujours le vrai métier de son fils, Mary Solomon réclame une simple rose pour son anniversaire, mais pas n''importe laquelle : une de ces délicates roses blanches que son ami fleuriste vend désormais à la sauvette dans une proche station de métro. Mère et fils arrivent ensemble sur place, mais tandis que le "pasteur" Soda négocie avec le vieux vendeur l''achat de tout son stock de roses, Mary a l''attention attirée par un personnage sombre, à la physionomie vaguement orientale, porteur d''un sac à dos. Ce dernier a, par inadvertance, laissé tomber une enveloppe contenant une importante somme que Mary, s''éloignant de son fils pour trottiner dans la foule des navetteurs, tente de lui restituer. Mary est cardiaque, pas bien agile, mais au bout d''une ou deux minutes, elle parvient néanmoins à interpeler timidement l''inquiétant personnage. Dissimulant mal sa surprise, il s''empresse de s''éloigner avec l''enveloppe... avant de se raviser... ... pour glisser à l''oreille de la vieille dame : "Ces jours-ci, ne prenez surtout pas le métro !" Soda ne prend connaissance de l''anecdote que Mary lui confesse naïvement que dans la soirée. Il se lance alors avec 8 heures de retard sur la piste de Khalid Cheik.', N'http://books.google.com/books/content?id=9c61BAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (190, N'9782100796489', N'Explorateurs de l''espace', 1, N'E', N'Dunod', CAST(N'2019-04-03' AS Date), N'fr', N'Alors que nous fêtons le cinquantenaire de la mission Apollo 11 et des premiers pas d''un homme sur la Lune, l''exploration spatiale est devenue pour l''humanité un nouveau projet de civilisation. Retourner sur la Lune est au coeur de la stratégie des plus grandes agences spatiales, américaine, européenne, chinoise et russe. Au-delà, c''est le voyage vers Mars qui attise les convoitises mais les défis à relever, humains et technologiques, sont immenses. Dans ce livre, l''astronaute Michel Tognini et l''astrophysicienne Hélène Courtois explorent les difficultés d''un vol habité et comment les surmonter. Des astronautes russes, américains, chinois et français témoignent. Ils nous font partager leurs plus grandes émotions en vol, ouvrant la voie, demain, au tourisme spatial.', N'http://books.google.com/books/content?id=9u6ODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (191, N'9782203001183', N'Tintin - Coke en stock', 15, N'C', N'Editions Moulinsart', CAST(N'1958-01-01' AS Date), N'fr', N'L''incrédulité du capitaine Haddock n''y changera rien. Le trafic d''êtres humains, cela existait encore au vingtième siècle. Au vingt-et-unième aussi, hélas. Coke en stock met en lumière les pratiques scandaleuses des esclavagistes des temps modernes.', N'http://books.google.com/books/content?id=aa4_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (194, N'9782818971048', N'Les Profs - Tour de contrôles', 13, N'L', N'Bamboo', CAST(N'2019-08-21' AS Date), N'fr', N'Le retour des Profs à la rentrée ! Après leur triomphe au cinéma et leur succès jamais démenti en librairie, Les Profs reviennent avec un nouveau tome en août. Simon Léturgie, après avoir succédé à Pica au dessin en 2016, propose avec Erroc & Sti un nouveau florilège de gags toujours aussi hilarants. Cette fois, c''est le branle-bas de combat au lycée Fanfaron : le ministre de l''Éducation nationale va venir. Pour faire bonne impression, on ne veut que des élèves modèles et propre sur eux ! Du coup c''est comme en boite : chemise et pantalon de costume, sinon on est refoulé à l''entrée... Ça pourrait être une bénédiction pour Boulard, mais il le prend pour un défi : il rentrera en cours coûte que coûte !', N'http://books.google.com/books/content?id=N8WkDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), CAST(N'2023-06-01' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (195, N'9782818939857', N'Les Profs : note to be', 13, N'L', N'Bamboo', CAST(N'2017-09-06' AS Date), N'fr', N'Rien ne va plus au lycée Fanfaron. Tout le monde voit des complots partout, le journal Tohu Bahut colporte les pires ragots, les manifs tombent à l’eau et même Serge est plein d’entrain pour faire cours. La proviseure n’a plus le choix : elle doit mettre en application sa toute nouvelle formation pour gérer les situations délicates. Pendant ce temps, Polochon relève le défi lancé par une machine de correction de copies ultrarapide destinée à mettre les profs au chômage. Qui a dit que la vie de lycée était monotone ?', N'http://books.google.com/books/content?id=wF8wDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-31' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (196, N'1931514933', N'GTO Volume 1', 19, N'G', N'TokyoPop', CAST(N'2002-04-23' AS Date), N'en', N'Eikichi Onizuka, a 22-year-old ex-biker, decides that he is going to become the best teacher in the world but his class is full of bullies, blackmailers, and sadists.', N'http://books.google.com/books/content?id=8wY9wmtYoa4C&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (197, N'1591821371', N'GTO Volume 13', 19, N'G', N'TokyoPop', CAST(N'2003-08-12' AS Date), N'en', N'Onizuka forces his class to dig around an island under the pretense that they are searching for turtle eggs, when in reality he is looking for treasure.', N'http://books.google.com/books/content?id=6dEc158_DrEC&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-05-31' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (198, N'1591821436', N'GTO Volume 19', 19, N'G', N'TokyoPop', CAST(N'2004-07-06' AS Date), N'en', N'When Teshigawara attempts to hold a school hostage, Onizuka is injured. Will Teshigawara carry out his explosive plot to the end?', N'http://books.google.com/books/content?id=V3B3ZlTBkjUC&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-05-31' AS Date), CAST(N'2023-05-31' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (204, N'9782800187730', N'Spirou et Fantasio - Tome 43 - VITO-LA-DEVEINE', 15, N'S', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Spirou et Fantasio viennent en aide à Don Cortizone échoué sur un atoll.', N'http://books.google.com/books/content?id=okc9AbpjBScC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (205, N'9782800187822', N'Spirou et Fantasio - Tome 34 - AVENTURE EN AUSTRALIE', 15, N'S', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Spirou, Fantasio, Seccotine et Champignac aident une tribu d''aborigènes à retrouver une statue qui leur assurerait la propriété des terres qu''ils occupent.', N'http://books.google.com/books/content?id=gjGTlDzmf0EC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (209, N'9782800186597', N'Nelson tome 3 - Calamité à plein temps', 13, N'N', N'Dupuis', CAST(N'2013-06-26' AS Date), N'fr', N'Persécuteur professionnelSi pour vous, un temps plein correspond à 35 heures par semaine, il en est tout autrement pour Nelson, ce diablotin venu sur terre pour empoisonner la vie des humains, et en particulier celles de Julie, jeune célibataire, et de Floyd, son empoté de chien. Avec un dévouement proche de l''excès de zèle et une imagination à toute épreuve, ce petit monstre orange ne leur laisse aucun répit. Il est en service 24 heures sur 24, sans rendez-vous, car incrusté à domicile !L''auteurQuand, en février 2001, Christophe Bertschy proposa au Matinde publier les strips de Nelson, il ne savait pas encore dans quel enfer il plongerait ! Car, en quelques mois à peine, son diablotin orange devint la mascotte du plus important quotidien francophone suisse. Ayant succombé à son charme infernal, des centaines de milliers de lecteurs attendent désormais, chaque jour, leur ration de catastrophes ! Et son métier est devenu un enfer...', N'http://books.google.com/books/content?id=UAR-s2msHzMC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (210, N'9782800189307', N'Boule et Bill - Tome 4 - Système Bill', 13, N'B', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Boule, un petit garçon comme les autres, a comme meilleur copain Bill, son adorable et facétieux cocker. Outre Boule, Bill a une autre grande passion : Caroline, la mignonne tortue... Dans un univers familial plein de gentillesse et de joie de vivre, les bêtises et les espiègleries de Boule et Bill déchainent les éclats de rire des lecteurs de tout âge.', N'http://books.google.com/books/content?id=NFqlDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (212, N'9780199571123', N'Oxford Dictionary of English', 81, N'O', N'Oxford University Press, USA', CAST(N'2010-08-19' AS Date), N'en', N'The Oxford Dictionary of English offers authoritative and in-depth coverage of over 350,000 words, phrases, and meanings. The foremost single-volume authority on the English language.', N'http://books.google.com/books/content?id=anecAQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (213, N'9782800192765', N'Michel Vaillant - tome 22 - Rush', 82, N'M', N'Dupuis', CAST(N'2012-09-24' AS Date), N'fr', N'La course du siècle mêlant voitures de tourisme et prototypes se prépare : 22.795 kilomètres divisés en 15 étapes du nord du Canada à Ushuaia, extrême pointe sud du continent américain. Une course folle pour laquelle l''écurie Vaillante a construit deux Rush, des voitures de grand tourisme, piloté par Michel Vaillant et Steve warson. Mais deux Leader, pilotées par les infects Cramer et Hawkins, sont aussi de la partie.', N'http://books.google.com/books/content?id=QHOPEXsV3gQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (214, N'9782800190198', N'Michel Vaillant - tome 13 - Concerto pour pilotes', 82, N'M', N'Dupuis', CAST(N'2010-09-24' AS Date), N'fr', N'Lors d''une visite à la base aérienne américaine d''Evreux, Steve présente à Michel le major Paul Kauttu, leader des Thunderbirds, la plus célèbre équipe de pilote acrobatique de l''armée américaine. Steve lance un pari aux pilotes : deux des pilotes des Thunderbird tourneront avec eux sur le circuit du Mans, tandis qu''eux même iront voler avec deux des pilotes des Thunderbird. Le pari est lancé, reste à savoir qui des Thunderbird ou de nos deux pilotes aura le coeur le mieux accroché.', N'http://books.google.com/books/content?id=1Ez5C_62KyoC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (215, N'9782800198088', N'Michel Vaillant - tome 18 - De l''huile sur la piste', 82, N'M', N'Dupuis', CAST(N'2012-09-24' AS Date), N'fr', N'Afin de garder des voitures au top, Jean-Pierre Vaillant fait part à ses pilotes de son désir de modifier certains détails techniques des formules 1 de l''écurie Vaillante. Mais pour ce faire, il doit déjà faire quelques tests sur les voitures actuelles. Jacky Icks, Steve Warson et Michel Vaillant vont endosser la casquette de pilote d''essai pour une semaine, avant de se lancer corps et âme dans la lutte pour décrocher le titre de champion du monde.', N'http://books.google.com/books/content?id=ZYHIkt0nQ9MC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (216, N'9782331052415', N'Titeuf - Tome 17 - La grande aventure', 13, N'T', N'Glénat BD', CAST(N'2021-06-02' AS Date), N'fr', N'C’est la jungle ! Titeuf et Manu partent en colo ! Ils auraient préféré aller au camp de jeux vidéo mais bon, il n’y avait plus de place. C’est donc pour le camp du Bois des ours qu’ils prennent le train ! On leur a vendu un grand bol d''air frais et Titeuf le citadin découvre la vie en pleine nature. Préparer à manger, faire de la randonnée et du camping, c’est sympa, mais si c’est pour se faire bouffer le zizi par un loup, faut pô compter sur lui ! Heureusement, il y a les nouveaux copains et copines, une monitrice méga cool et puis en colo, on vit quand même plein d’aventures. On fait de l’escalade, on se baigne dans les rivières et il paraît même qu’on découvre parfois des trésors... Un peu déboussolé, loin du bitume et des klaxons, Titeuf découvre la vie en communauté, les toilettes sèches et le compost. Ça fait beaucoup d’un coup, mais il est pô une mauviette et il est prêt à plonger dans l’enfer vert, peuplé de bêtes sauvages comme... des hérissons, des sauterelles et des moustiques. Un nouveau tome pour une grande aventure dans laquelle la célèbre mèche blonde se frotte à l’écologie, aux nouvelles amitiés et aux amours de vacances !', N'http://books.google.com/books/content?id=9GwsEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (217, N'9782331001468', N'Titeuf - Tome 02 - L''amour c''est pô propre!', 13, N'T', N'Glénat BD', CAST(N'2013-03-20' AS Date), N'fr', N'À l''occasion de la sortie de Titeuf le Film, les éditions Glénat ont imaginé une version collector en tirage limité : la couverture ainsi que le dos et la 4e de couverture habillés spécialement pour Titeuf le film.. Si on est amoureux, il faut mettre sa langue dans la bouche d''une fille et puis tourner dedans (pour chercher quelque chose sûrement)... Si on trouve rien, il faut prendre une pelle et puis on lui roule une pelle (enfin, je crois). Enfant des années 90, Titeuf connaît les joies de l''apprentissage du savoir. Comment marche une Game Boy ? Paul Verlaine est-il un écrivain rigolo ? Pourquoi les filles c''est pas fait pareil que les garçons ?... Le chômage c''est quoi ? Bref, le B.A. BA de l''éducation d''un futur grand petit homme défile en une succession de gags succulents. Grand reporter des cours d''écoles,Zep traque le rire avec un zeste de sensibilité et un soupçon de vacherie.', N'http://books.google.com/books/content?id=bSoVnCcKu3EC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (218, N'9782331001499', N'Titeuf - Tome 5 - Et le derrière des choses', 13, N'T', N'Glénat BD', CAST(N'2013-03-20' AS Date), N'fr', N'Mes parents m''envoient chez le psychologue à cause de mes notes comme si j''étais malade-des-maths. Encore que j''ai du bol, parce que Hugo il est malade-du-français et c''est son père qui le soigne à coups de pied au cul. Ne tournons pas autour du pot, cet album de Titeuf marque une étape décisive dans l''évolution de notre "grand petit homme". Inutile de le cacher, cette fois-ci Titeuf devra apprendre à découvrir les miracles de l''anatomie féminine et ses secrets... Résister à la passion déchaînée d''une plus petite que lui, regarder ses parents se débattre avec de drôles de problèmes qui ont pour nom course à l''emploi, stage de réinsertion, bref, les aléas de la vie moderne.', N'http://books.google.com/books/content?id=DSa1dAw2mRQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (219, N'9782331001512', N'Titeuf - Tome 7 - Le miracle de la vie', 13, N'T', N'Glénat BD', CAST(N'2013-03-20' AS Date), N'fr', N'Titeuf est un ethnologue en culotte courte qui passe ses journées à étudier ces tribus énigmatiques que sont les parents, les grands, ou les filles... Or, voilà que son champ d''observation va s''enrichir d''un nouveau phénomène intéressant : un bébé... A première vue, il s''agit de quelque chose de pas très gros, tout rouge, plutôt laid et très bruyant. Un intrus pénible en quelque sorte. Mais alors comment se fait-il que tout le monde le trouve beau, s''extasie devant lui, et qu''il soit devenu l''occupation première des parents ? Est-ce cela le fameux mystère de la vie ? Chaque gag de Titeuf pose un regard complice sur les problèmes de la vie d''un grand petit enfant qui saute à pieds joints dans cette fin de siècle avec une énergie débordante... Un feu d''artifice de couleur, de dialogue et d''imagination qui a propulsé cette série au rang des best-sellers.', N'http://books.google.com/books/content?id=Hjd-TMxaU0MC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (222, N'1591164419', N'Bleach, Vol. 1', 19, N'B', N'VIZ Media LLC', CAST(N'2004-07-06' AS Date), N'en', N'Part-time student, full-time Soul Reaper, Ichigo is one of the chosen few guardians of the afterlife. Ichigo Kurosaki never asked for the ability to see ghosts—he was born with the gift. When his family is attacked by a Hollow—a malevolent lost soul—Ichigo becomes a Soul Reaper, dedicating his life to protecting the innocent and helping the tortured spirits themselves find peace. Find out why Tite Kubo’s Bleach has become an international manga smash-hit! Ichigo Kurosaki has always been able to see ghosts, but this ability doesn''t change his life nearly as much as his close encounter with Rukia Kuchiki, a Soul Reaper and member of the mysterious Soul Society. While fighting a Hollow, an evil spirit that preys on humans who display psychic energy, Rukia attempts to lend Ichigo some of her powers so that he can save his family; but much to her surprise, Ichigo absorbs every last drop of her energy. Now a full-fledged Soul Reaper himself, Ichigo quickly learns that the world he inhabits is one full of dangerous spirits and, along with Rukia--who is slowly regaining her powers--it''s Ichigo''s job to protect the innocent from Hollows and help the spirits themselves find peace.', N'http://books.google.com/books/content?id=H6YT1otBVgkC&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (224, N'9782800180120', N'Marsupilami - Tome 28 - Biba', 13, N'M', N'Marsu', CAST(N'2014-11-14' AS Date), N'fr', N'Pas évident de survivre dans la jungle palombienne quand on est toute seule pour se débrouiller au milieu des serpents sournois, des oiseaux mauvais coucheurs et des alligators voraces. Sans compter le pire prédateur de tous (et le plus bête) : le braconnier. Biba, jolie petite marsupilamie, en sait quelque chose... Mais elle ignore encore qu''elle est loin d''être seule au monde !', N'http://books.google.com/books/content?id=aeIuBQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (225, N'9782800186849', N'Les Psy - Tome 11', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Une série qui ne vous laissera pas de glace Avec les Psy, rassurez-vous : découvrez qu''il y a toujours plus givré que vous. Entrez dans le secret des consultations et découvrez les petites phobies et les gros soucis de vos pairs. Rassurez-vous, chaque cas est traité avec le grain de folie nécessaire et la confidentialité est respectée, à quelques dizaines de milliers de lecteurs près.', N'http://books.google.com/books/content?id=a9uwBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (226, N'9782800186115', N'Les Psy - Tome 14 - Zen !', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', N'Allez-y, je vous écoute... Votre comportement est instable et, en une fraction de seconde, vous balancez par la fenêtre tout ce qui se trouve à votre portée ? Vos mains sont sans cesse en conflit ? Vous ne supportez plus le regard des autres ? Tous les soirs, vous faites le même rêve et cela vous obsède? Pas de panique, le docteur Médard est là ! Allongez-vous et dites-lui tout ! Phobies loufoques et angoisses en tout genre sont le lot quotidien de notre psy préféré. À consulter sans modération !C''est grave, docteur ? Une fois l''an, les Éditions Dupuis ont la joyeuse habitude de nous ouvrir les portes du cabinet de consultation le plus célèbre de la bande dessinée. Ironiques mais professionnels jusqu''au bout de leur divan, Les Psy continuent à traiter les petits travers de notre société, au fil de gags savoureux. La plume toujours trempée dans la bonne humeur, Cauvin en profite pour mettre en scène les patients les plus disjonctés que Bédu prend un plaisir certain à croquer dans les positions les plus cocasses. Chaque visite est ponctuée d''un grand éclat de rire, finalement le meilleur antidote à la morosité.', N'http://books.google.com/books/content?id=mVbZBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (227, N'2800163089', N'Soda : Tome 1 - Un ange trépasse', 15, N'S', N'Depuis', CAST(N'2014-11-04' AS Date), N'fr', N'On m''appelle Soda, mais mon vrai nom, c''est Solomon. David Elliot Hanneth Solomon. Si elle savait, ma mère vous dirait sans doute que je suis policier, mais à New York, il n''y a pas de policiers, juste des flics. De toute façon, elle ne sait pas, ça l''inquiéterait, elle m''a toujours cru pasteur. Depuis quelque temps, elle habite avec moi ; elle ne sort jamais et ne lit pas les journaux qui sont pleins de violence. C''est pas plus mal : les types que j''arrête sont parfois un peu morts.', N'pack://application:,,,/Images/Covers/DEFAULT.jpg', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (228, N'2203340223', N'Le chat est content', 13, N'L', N'Casterman', NULL, N'fr', N'Créé par Philippe Geluck, le Chat apporte ses réflexions pertinentes et ses calembours délirants au monde depuis 1983.', N'http://books.google.com/books/content?id=_8C1AAAAIAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (230, N'9782864973027', N'Astérix - La Galère d''Obélix - n°30', 13, N'A', N'Editions Albert René', CAST(N'2013-09-15' AS Date), N'fr', N'Décidemment Obélix est incorrigible ! Malgré les avertissements répétés du druide Panoramix, il a bu de la potion magique. Et le résultat est surprenant : il redevient petit garçon...sans défense, à la merci des légions romaines qui le capturent! Asterix partant à leur poursuite, naviguera jusqu''en Atlantide pays de la jeunesse éternelle. Y trouvera-t-il l''antidote qui guérira son inséparable ami ?', N'http://books.google.com/books/content?id=Xeq9AAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (231, N'9782012103825', N'Astérix - Obélix et Compagnie - n°23', 13, N'A', N'Hachette Asterixxx', CAST(N'2013-09-15' AS Date), N'fr', N'Après la défaite des légionnaires romains du camp de Babaorum face à Obélix, César cherche - une fois de plus - le moyen de vaincre les Gaulois. Saugrenus, son jeune conseiller, lui propose de les affaiblir grâce à l''argent. Une fois arrivé en Gaule, Saugrenus se met à acheter tous les menhirs d''Obélix. Ce dernier, pour pouvoir répondre à la demande, est conduit à créer une véritable PME qui lui rapporte beaucoup de sesterces. Obélix devient alors de fait l''homme le plus puissant du village, ce qui ne va pas sans créer de vives tensions avec les autres habitants du village. Ces derniers, sur les conseils de Panoramix, se mettent alors à leur tour à faire des menhirs et à concurrencer Obélix. Les Gaulois sont effectivement occupés à autre chose qu''à faire la guerre aux Romains, mais le trésor de Rome qui paie les menhirs achetés aux Gaulois commence à s''épuiser. Malgré toutes les ressources publicitaires de Saugrenus, l''économie romaine risque de s''effondrer..', N'http://books.google.com/books/content?id=weq9AAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-01' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (232, N'2800117273', N'Le petit Spirou : Dis bonjour à la dame!', 13, N'L', N'Editions Dupuis', NULL, N'fr', N'Spirou mature fait rire les enfants, Spirou enfant fait rire les aînés. Plus éveillé à l''autre sexe, le petit Spirou a des idées plus frivoles. [SDM].', N'D:\SimpleLibrary\Covers\9782800117270-couv-M700x1200.jpg', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-01' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (234, N'2203007648', N'Tintin au Tibet', 15, N'T', N'Édition Moulinsart', CAST(N'2006-12-01' AS Date), N'fr', N'Tintin est au tibet. Suivez ses aventures!', N'http://books.google.com/books/content?id=RiVVIAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (235, N'9782203003040', N'Tintin au Congo', 15, N'T', N'Éditions Moulinsart', NULL, N'fr', N'Tintin au Congo !', N'http://books.google.com/books/content?id=1lU_AQAAIAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (237, N'2070615375', N'Harry Potter et les reliques de la mort', 4, N'H', N'Gallimard-Jeunesse', CAST(N'2011-03-08' AS Date), N'fr', N'Cette année, Harry a dix-sept ans et ne retourne pas à Poudlard. Avec Ron et Hermione, il se consacre à la dernière mission confiée par Dumbledore. Mais le Seigneur des Ténèbres règne en maître. Traqués, les trois fidèles amis sont contraints et la clandestinité. D''épreuves en révélations, le courage les choix et les sacrifices de Harry seront déterminants dans la lutte contre les forces du Mal. Avec le dénouement de l''héroïque histoire de Harry Potter, J.K. Rowling signe un chef-d''œuvre d''une grande humanité et d''une maîtrise incomparable.', N'pack://application:,,,/Images/Covers/DEFAULT.jpg', CAST(N'2023-06-01' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (238, N'9781421544328', N'Naruto, Vol. 1', 19, N'N', N'VIZ Media LLC', CAST(N'2010-11-02' AS Date), N'en', N'Twelve years ago the Village Hidden in the Leaves was attacked by a fearsome threat. A nine-tailed fox spirit claimed the life of the village leader, the Hokage, and many others. Today, the village is at peace and a troublemaking kid named Naruto is struggling to graduate from Ninja Academy. His goal may be to become the next Hokage, but his true destiny will be much more complicated. The adventure begins now! -- VIZ Media', N'http://books.google.com/books/content?id=bQbwAQAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (239, N'9781421544342', N'Naruto, Vol. 2', 19, N'N', N'VIZ Media LLC', CAST(N'2010-11-02' AS Date), N'en', N'Tired of menial tasks, Naruto, Sasuke and Sakura ask for a tougher assignment. But you should always be careful what you wish for! Along with their teacher, Kakashi, the trio must now guard a cranky old man from the Land of the Waves. But Tazuna the bridgebuilder is in more danger than anyone could have imagined. And now the young ninja are too! -- VIZ Media', N'http://books.google.com/books/content?id=nUnwAQAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (240, N'9781421544366', N'Naruto, Vol. 3', 19, N'N', N'VIZ Media LLC', CAST(N'2010-11-16' AS Date), N'en', N'Naruto’s sensei Kakashi believes that the diablolical Zabuza survived their last battle. Now, in anticipation of their enemy’s return, Kakashi puts Naruto, Sasuke and Sakura through rigorous training programs to increase their focus and control. This time, the job of protecting the old bridge builder Tazuna and his family will be a hundred times more difficult! -- VIZ Media', N'http://books.google.com/books/content?id=VYfwAQAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (241, N'9781421544410', N'Naruto, Vol. 4', 19, N'N', N'VIZ Media LLC', CAST(N'2010-11-16' AS Date), N'en', N'In the Land of Waves, Naruto and his teammates Sakura and Sasuke, along with their sensei Kakashi, struggle to protect the bridge builder Tazuna and his family from Gato’s hired thugs. When one of Naruto’s friends falls in battle, Naruto is faced with the most difficult choice of his life. How far will he go to protect his friends? And does he have what it takes to be a hero? -- VIZ Media', N'http://books.google.com/books/content?id=xYXwAQAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-01' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (243, N'9782800177151', N'Gaston - tome 11 - Le repos du gaffeur', 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'fr', N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=rU9N-hmFaawC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-02' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (244, N'9782800177250', N'Gaston - tome 16 - Lagaffe mérite des baffes', 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'fr', N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=qOYsdnio8HcC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-02' AS Date), CAST(N'2023-06-02' AS Date))
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (251, N'2035938619', N'Le petit Larousse illustré', 92, N'L', N'Larousse', CAST(N'2020-01-02' AS Date), N'fr', N'Avec plus de 63500 mots, 125000 sens et 20000 locutions, 28000 noms propres.Et aussi : 1500 remarques de langue ou d''orthographe. 2000 régionalismes et mots de la francophonie. 4500 compléments encyclopédiques. 5500 cartes, dessins, photographies, schémas et planches. Avec une carte d''activation pour bénéficier d''un accès privilégié au Dictionnaire Internet Larousse 2020 contenant plus de 80000 mots, 9600 verbes conjugués et des dossiers encyclopédiques sur les notions clés de la culture générale.Le plus de l''édition 2020 : une couverture moderne et raffinée. 150 nouveaux mots, sens et expressions et 50 nouvelles notices de personnalités.', N'http://books.google.com/books/content?id=yVeSzQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-06-02' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (252, N'9782203001121', N'Les 7 Boules de cristal', 13, N'L', N'Editions Moulinsart', CAST(N'1948-01-01' AS Date), N'fr', N'Dans Les 7 Boules de cristal, sept savants sont mystérieusement frappés de léthargie à leur retour d''une expédition dans les Andes. Le professeur Tournesol ayant disparu, Tintin et le Capitaine partent à sa recherche.', N'http://books.google.com/books/content?id=W64_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-02' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (253, N'9782803638376', N'Thorgal - Tome 24 - Arachnéa', 95, N'T', N'Le Lombard', CAST(N'2010-03-26' AS Date), N'fr', N'Séparés des autres membres de leur famille par une tempête, Thorgal et sa fille abordent dans une île de rêve. Isolée du reste du monde par les Brumes du Néant, cette île paradisiaque est sous la dépendance totale de son immortelle et suprême maîtresse : Arachnéa. En échange des bienfaits dont elle les gratifie, cette redoutable déesse exige que deux fois par an, aux équinoxes d''automne et de printemps, les habitants lui fournissent un jeune homme capable de la féconder et de lui insuffler ainsi l''énergie indispensable pour survivre dans l''éternité...', N'http://books.google.com/books/content?id=t7yC7eo1vgwC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-02' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (254, N'9782803638345', N'Thorgal - Tome 21 - Couronne d''Ogotaï (La)', 95, N'T', N'Le Lombard', CAST(N'2010-03-26' AS Date), N'fr', N'Shaïgan-sans-merci a été assassiné par ses propres hommes, Kriss de Valnor s''est suicidée, Aaricia et Louve ont également été tuées et Jolan brave une effroyable tempête. C''est alors que survient Jaax le Veilleur, envoyé d''un lointain futur pour récupérer "La Couronne d''Ogotaï", le casque d''amplification d''énergie mentale qui risque de faire dévier le destin de l''Humanité ! Pour réussir sa mission, Jaax a besoin de Jolan et ce dernier a besoin de ce voyageur temporel pour mettre fin aux malheurs qui frappent les siens.', N'http://books.google.com/books/content?id=XAr7nphUFXcC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-02' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (255, N'9782803638383', N'Léonard - tome 01 - Léonard est un génie', 13, N'L', N'Le Lombard', CAST(N'2012-09-25' AS Date), N'fr', N'Léonard est un génie. Parfois un peu flemmard, il invente un tas d''objets pour faciliter la vie au quotidien. Plein d''imagination, découvrez dans cet album comment Léonard invente l''aspirateur, l''appareil photo, le détecteur à métaux et bien d''autres machines délirantes !', N'http://books.google.com/books/content?id=f75pHUXwtGsC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-06-02' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Publication] OFF
GO
SET IDENTITY_INSERT [dbo].[PublicationCopy] ON 

INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (24, 9, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (25, 9, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (26, 9, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (27, 9, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (40, 16, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (41, 16, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (42, 17, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (43, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (44, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (45, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (46, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (92, 80, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (93, 80, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (98, 83, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (99, 83, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (100, 83, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (101, 83, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (108, 86, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (109, 86, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (110, 86, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (118, 90, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (119, 90, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (127, 93, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (128, 94, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (129, 94, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (130, 94, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (134, 96, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (135, 96, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (184, 180, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (185, 180, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (197, 191, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (204, 194, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (205, 194, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (206, 194, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (207, 195, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (208, 195, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (209, 195, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (210, 196, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (211, 196, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (212, 197, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (213, 197, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (214, 198, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (215, 198, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1198, 204, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1199, 204, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1200, 205, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1201, 205, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1208, 209, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1209, 209, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1210, 210, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1211, 210, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1218, 212, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1219, 212, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1220, 213, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1221, 213, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1222, 214, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1223, 214, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1224, 215, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1225, 215, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1226, 216, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1227, 216, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1228, 216, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1229, 217, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1230, 217, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1231, 217, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1233, 219, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1234, 219, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1235, 222, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1236, 222, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1239, 224, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1240, 224, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1241, 225, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1242, 225, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1243, 226, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1244, 226, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1245, 226, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1246, 227, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1247, 228, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1248, 228, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1252, 230, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1253, 230, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1254, 231, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1255, 232, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1256, 232, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1257, 234, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1258, 235, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1259, 235, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1260, 235, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1261, 237, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1262, 237, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1263, 237, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1264, 238, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1265, 238, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1266, 238, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1267, 239, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1268, 239, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1269, 240, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1270, 240, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1271, 240, 1)
GO
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1272, 241, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1273, 241, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1274, 241, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1304, 3, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1313, 16, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1314, 3, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1315, 3, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1316, 19, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1317, 19, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1318, 19, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1319, 20, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1320, 20, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1321, 20, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1322, 21, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1323, 21, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1324, 21, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1325, 21, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1326, 21, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1331, 22, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1332, 23, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1333, 23, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1334, 22, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1335, 22, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1336, 22, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1337, 37, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1338, 37, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1339, 37, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1340, 190, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1341, 190, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1342, 189, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1343, 189, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1344, 189, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1345, 218, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1346, 218, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1350, 85, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1351, 85, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1352, 243, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1353, 243, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1354, 243, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1355, 244, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1356, 244, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1357, 244, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1364, 251, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1365, 251, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1366, 251, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1367, 251, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1368, 251, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1369, 251, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1370, 252, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1371, 252, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1372, 253, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1373, 253, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1374, 253, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1375, 254, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1376, 254, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1377, 254, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1378, 255, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1379, 255, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1380, 255, 1)
SET IDENTITY_INSERT [dbo].[PublicationCopy] OFF
GO
INSERT [dbo].[PublicationStateEnum] ([PublicationStateId], [PublicationState]) VALUES (-1, N'Unreadable')
INSERT [dbo].[PublicationStateEnum] ([PublicationStateId], [PublicationState]) VALUES (0, N'Unkown')
INSERT [dbo].[PublicationStateEnum] ([PublicationStateId], [PublicationState]) VALUES (1, N'Readable')
GO
SET IDENTITY_INSERT [dbo].[Shelf] ON 

INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (1, N'Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (2, N'Magazine')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (3, N'Comic Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (4, N'Lesson Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (5, N'Mangas')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (8, N'Dictionary')
SET IDENTITY_INSERT [dbo].[Shelf] OFF
GO
SET IDENTITY_INSERT [dbo].[ShelfComposition] ON 

INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (1, 1, 3)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (2, 1, 4)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (3, 1, 5)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (4, 1, 7)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (5, 1, 8)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (6, 1, 10)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (7, 1, 12)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (8, 1, 13)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (9, 4, 1)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (10, 4, 2)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (11, 4, 11)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (12, 4, 9)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (13, 3, 6)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (14, 3, 14)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (15, 3, 8)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (16, 2, 11)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (17, 2, 15)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (18, 2, 16)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (19, 5, 17)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (71, 5, 8)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (73, 1, 23)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (75, 1, 8)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (81, 8, 9)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (82, 3, 24)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (92, 8, 22)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (95, 3, 26)
SET IDENTITY_INSERT [dbo].[ShelfComposition] OFF
GO
SET IDENTITY_INSERT [dbo].[Theme] ON 

INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (1, N'Mathematics')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (2, N'Physics')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (3, N'Sci-Fi')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (4, N'Horror')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (5, N'Romance')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (6, N'Comic')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (7, N'Mystic')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (8, N'Detective')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (9, N'English')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (10, N'Literature')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (11, N'Science')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (12, N'Bio')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (13, N'Novel')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (14, N'Super Hero')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (15, N'Nature')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (16, N'Gaming')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (17, N'Anime')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (22, N'French')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (23, N'Computer Science')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (24, N'Sport')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (26, N'Adventure')
SET IDENTITY_INSERT [dbo].[Theme] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Publication]    Script Date: 03-06-23 13:23:23 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Publication] ON [dbo].[Publication]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Unique_Publication_ISBN]    Script Date: 03-06-23 13:23:23 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Unique_Publication_ISBN] ON [dbo].[Publication]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuthorPublication]  WITH CHECK ADD  CONSTRAINT [FK_AuthorPublication_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Author] ([AuthorID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AuthorPublication] CHECK CONSTRAINT [FK_AuthorPublication_Author]
GO
ALTER TABLE [dbo].[AuthorPublication]  WITH CHECK ADD  CONSTRAINT [FK_AuthorPublication_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([PublicationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AuthorPublication] CHECK CONSTRAINT [FK_AuthorPublication_Publication]
GO
ALTER TABLE [dbo].[Publication]  WITH CHECK ADD  CONSTRAINT [FK_Publication_ShelfComposition] FOREIGN KEY([Location])
REFERENCES [dbo].[ShelfComposition] ([ShelfCompositionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Publication] CHECK CONSTRAINT [FK_Publication_ShelfComposition]
GO
ALTER TABLE [dbo].[PublicationCopy]  WITH CHECK ADD  CONSTRAINT [FK_PublicationCopy_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([PublicationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PublicationCopy] CHECK CONSTRAINT [FK_PublicationCopy_Publication]
GO
ALTER TABLE [dbo].[PublicationCopy]  WITH CHECK ADD  CONSTRAINT [FK_PublicationCopy_PublicationStateEnum] FOREIGN KEY([PublicationState])
REFERENCES [dbo].[PublicationStateEnum] ([PublicationStateId])
GO
ALTER TABLE [dbo].[PublicationCopy] CHECK CONSTRAINT [FK_PublicationCopy_PublicationStateEnum]
GO
ALTER TABLE [dbo].[ShelfComposition]  WITH CHECK ADD  CONSTRAINT [FK_ShelfComposition_Shelf] FOREIGN KEY([ShelfID])
REFERENCES [dbo].[Shelf] ([ShelfID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShelfComposition] CHECK CONSTRAINT [FK_ShelfComposition_Shelf]
GO
ALTER TABLE [dbo].[ShelfComposition]  WITH CHECK ADD  CONSTRAINT [FK_ShelfComposition_Theme] FOREIGN KEY([ThemeID])
REFERENCES [dbo].[Theme] ([ThemeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShelfComposition] CHECK CONSTRAINT [FK_ShelfComposition_Theme]
GO
ALTER DATABASE [SimpleLibrary] SET  READ_WRITE 
GO
