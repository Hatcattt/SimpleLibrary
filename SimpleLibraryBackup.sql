/****** Object:  Table [dbo].[Author]    Script Date: 29-01-23 17:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorID] [int] NOT NULL,
	[AuthorName] [nvarchar](50) NOT NULL,
	[Nationality] [nvarchar](3) NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuthorPublication]    Script Date: 29-01-23 17:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthorPublication](
	[AuthorPublicationID] [int] NOT NULL,
	[AuthorID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
	[AuthorFunction] [nvarchar](50) NULL,
 CONSTRAINT [PK_AuthorPublication] PRIMARY KEY CLUSTERED 
(
	[AuthorPublicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication]    Script Date: 29-01-23 17:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication](
	[PublicationID] [int] NOT NULL,
	[ISBN] [nvarchar](20) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[SubTitle] [nchar](100) NULL,
	[Location] [int] NOT NULL,
	[Publisher] [nvarchar](100) NOT NULL,
	[PublishedDate] [date] NULL,
	[Language] [nvarchar](3) NULL,
	[NumberOfPages] [smallint] NULL,
	[Description] [nvarchar](max) NULL,
	[CoverFilePath] [nvarchar](250) NULL,
 CONSTRAINT [PK_Publication] PRIMARY KEY CLUSTERED 
(
	[PublicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicationCopy]    Script Date: 29-01-23 17:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicationCopy](
	[PublicationCopyID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
	[PublicationState] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PublicationCopy] PRIMARY KEY CLUSTERED 
(
	[PublicationCopyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shelf]    Script Date: 29-01-23 17:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shelf](
	[ShelfID] [int] NOT NULL,
	[ShelfName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Shelf] PRIMARY KEY CLUSTERED 
(
	[ShelfID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShelfComposition]    Script Date: 29-01-23 17:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShelfComposition](
	[ShelfCompositionID] [int] NOT NULL,
	[ShelfID] [int] NOT NULL,
	[ThemeID] [int] NOT NULL,
 CONSTRAINT [PK_ShelfComposition] PRIMARY KEY CLUSTERED 
(
	[ShelfCompositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theme]    Script Date: 29-01-23 17:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theme](
	[ThemeID] [int] NOT NULL,
	[ThemeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Theme] PRIMARY KEY CLUSTERED 
(
	[ThemeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1, N'Patrick Süskind', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (2, N'Michel Tognini', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (3, N'Hélène Courtois', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (4, N'Jean-Yves Le Gall', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (5, N'Zep', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (6, N'Tébo', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (7, N'Clélia Renucci', NULL)
GO
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1, 1, 1, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (2, 2, 2, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (3, 3, 2, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (4, 4, 2, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (5, 5, 3, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (6, 6, 3, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (7, 7, 4, NULL)
GO
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (1, N'9782253047421', N'Le pigeon', N'récit                                                                                               ', 14, N'LGF/Le Livre de Poche', CAST(N'1987-01-01' AS Date), N'FR', 88, N'Lorsque lui arriva cette histoire de pigeon qui, du jour au lendemain, bouleversa son existence, Jonathan Noël avait déjà dépassé la cinquantaine, il avait derrière lui une période d''une bonne vingtaine d''année qui n''avait pas été marquée par le moindre événement, et jamais il n''aurait escompté que pût encore lui arriver rien de notable, sauf de mourir un jour. Et cela lui convenait tout à fait. Car il n''aimait pas les événements, et il avait une véritable horreur de ceux qui ébranlaient son équilibre intérieur et chamboulaient ordonnance de sa vie.', NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (2, N'9782100796489', N'Explorateurs de l''espace', N'Voyage aux frontières de l''univers                                                                  ', 12, N'Dunod', CAST(N'2019-04-03' AS Date), N'FR', 192, N'Alors que nous fêtons le cinquantenaire de la mission Apollo 11 et des premiers pas d''un homme sur la Lune, l''exploration spatiale est devenue pour l''humanité un nouveau projet de civilisation. Retourner sur la Lune est au coeur de la stratégie des plus grandes agences spatiales, américaine, européenne, chinoise et russe. Au-delà, c''est le voyage vers Mars qui attise les convoitises mais les défis à relever, humains et technologiques, sont immenses. Dans ce livre, l''astronaute Michel Tognini et l''astrophysicienne Hélène Courtois explorent les difficultés d''un vol habité et comment les surmonter. Des astronautes russes, américains, chinois et français témoignent. Ils nous font partager leurs plus grandes émotions en vol, ouvrant la voie, demain, au tourisme spatial.', NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (3, N'9782723445771', N'Captain Biceps l''invincible', NULL, 9, N'Zep & Co', CAST(N'2004-01-01' AS Date), N'FR', 31, N'Captain Biceps, dans son costume rouge et jaune, en impose aux superméchants avec son humour !', NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (4, N'9782226392015', N'Concours pour le Paradis', NULL, 9, N'Albin Michel', CAST(N'2018-08-22' AS Date), N'FR', 272, N'Tout était dévasté, consumé, calciné. C''est de cet enfer qu''allait renaître le Paradis. Dans le décor spectaculaire de la Venise renaissante, l''immense toile du Paradis devient un personnage vivant, opposant le génie de Véronèse, du Tintoret et des plus grands maîtres de la ville. Entre rivalités artistiques, trahisons familiales, déchirements politiques, Clélia Renucci fait revivre dans ce premier roman le prodige de la création, ses vertiges et ses drames.', NULL)
GO
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1, 1, N'Good')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (2, 1, N'Unknown')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (3, 1, N'Unknown')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (4, 1, N'Bad')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (5, 2, N'Bad')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (6, 2, N'Unknown')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (7, 2, N'Bad')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (8, 3, N'Good')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (9, 3, N'Good')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (10, 3, N'Bad')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (11, 3, N'Bad')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (12, 4, N'Good')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (13, 4, N'Unknown')
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (14, 4, N'Good')
GO
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (1, N'Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (2, N'Magazine')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (3, N'Lesson Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (4, N'Comic Book')
GO
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (1, 1, 1)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (2, 1, 2)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (3, 1, 4)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (4, 1, 5)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (5, 3, 1)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (6, 3, 2)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (7, 3, 9)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (8, 4, 7)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (9, 4, 6)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (10, 1, 8)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (11, 1, 10)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (12, 1, 11)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (13, 1, 12)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (14, 1, 13)
GO
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (1, N'Mathematics')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (2, N'Physics')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (3, N'Sci-Fi')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (4, N'Horror')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (5, N'Romance')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (6, N'Comic')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (7, N'Mystery')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (8, N'Detective')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (9, N'English')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (10, N'Literature')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (11, N'Science')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (12, N'Biography')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (13, N'Novel')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Publication]    Script Date: 29-01-23 17:16:13 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Publication] ON [dbo].[Publication]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuthorPublication]  WITH CHECK ADD  CONSTRAINT [FK_AuthorPublication_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Author] ([AuthorID])
GO
ALTER TABLE [dbo].[AuthorPublication] CHECK CONSTRAINT [FK_AuthorPublication_Author]
GO
ALTER TABLE [dbo].[AuthorPublication]  WITH CHECK ADD  CONSTRAINT [FK_AuthorPublication_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([PublicationID])
GO
ALTER TABLE [dbo].[AuthorPublication] CHECK CONSTRAINT [FK_AuthorPublication_Publication]
GO
ALTER TABLE [dbo].[Publication]  WITH CHECK ADD  CONSTRAINT [FK_Publication_ShelfComposition] FOREIGN KEY([Location])
REFERENCES [dbo].[ShelfComposition] ([ShelfCompositionID])
GO
ALTER TABLE [dbo].[Publication] CHECK CONSTRAINT [FK_Publication_ShelfComposition]
GO
ALTER TABLE [dbo].[PublicationCopy]  WITH CHECK ADD  CONSTRAINT [FK_PublicationCopy_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([PublicationID])
GO
ALTER TABLE [dbo].[PublicationCopy] CHECK CONSTRAINT [FK_PublicationCopy_Publication]
GO
ALTER TABLE [dbo].[ShelfComposition]  WITH CHECK ADD  CONSTRAINT [FK_ShelfComposition_Shelf] FOREIGN KEY([ShelfID])
REFERENCES [dbo].[Shelf] ([ShelfID])
GO
ALTER TABLE [dbo].[ShelfComposition] CHECK CONSTRAINT [FK_ShelfComposition_Shelf]
GO
ALTER TABLE [dbo].[ShelfComposition]  WITH CHECK ADD  CONSTRAINT [FK_ShelfComposition_Theme] FOREIGN KEY([ThemeID])
REFERENCES [dbo].[Theme] ([ThemeID])
GO
ALTER TABLE [dbo].[ShelfComposition] CHECK CONSTRAINT [FK_ShelfComposition_Theme]
GO
