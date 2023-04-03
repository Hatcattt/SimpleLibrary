/****** Object:  Table [dbo].[Author]    Script Date: 03-04-23 15:15:48 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuthorPublication]    Script Date: 03-04-23 15:15:48 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication]    Script Date: 03-04-23 15:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication](
	[PublicationID] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [nvarchar](20) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[SubTitle] [nvarchar](100) NULL,
	[Location] [int] NOT NULL,
	[LetterRow] [char](1) NULL,
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
/****** Object:  Table [dbo].[PublicationCopy]    Script Date: 03-04-23 15:15:48 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicationStateEnum]    Script Date: 03-04-23 15:15:48 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shelf]    Script Date: 03-04-23 15:15:48 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShelfComposition]    Script Date: 03-04-23 15:15:48 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theme]    Script Date: 03-04-23 15:15:48 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (1, N'Midam', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (2, N'Tome', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (3, N'Franquin', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (4, N'Michel Tognini', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (5, N'Hélène Courtois', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (6, N'Jean-Yves Le Gall', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (7, N'Zep', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (8, N'Tébo', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (9, N'Clélia Renucci', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (10, N'Rick Barba', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (11, N'Neil Mercer', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (12, N'Joan Swann', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (13, N'Eric Dubon', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (14, N'Francisco del Rey', NULL)
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[AuthorPublication] ON 

INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1, 1, 1, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (2, 2, 2, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (3, 3, 3, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (4, 3, 4, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (5, 4, 5, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (6, 5, 5, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (7, 6, 5, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (8, 7, 6, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (9, 8, 6, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (10, 9, 7, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (11, 10, 8, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (12, 11, 9, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (13, 12, 9, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (14, 13, 10, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (15, 14, 10, NULL)
SET IDENTITY_INSERT [dbo].[AuthorPublication] OFF
GO
SET IDENTITY_INSERT [dbo].[Publication] ON 

INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (1, N'9782331026324', N'Kid Paddle -', N'Panik room                                                                                          ', 13, N'K', N'Glénat BD', CAST(N'2016-10-26' AS Date), N'FR', 48, N'On imagine mal Kid, adepte de films gore et de blorks dégommés, faire du baby-sitting. Une fois de plus, Midam nous surprend avec des situations improbables où Kid améliore la réalité à sa sauce. Cet album offre aussi une double lecture où les plus jeunes s''amuseront de la situation en général et où les adultes se reconnaîtront peut-être dans l''idéalisation de leur progéniture. Cette double lecture, omniprésente dans la plupart des gags de Kid Paddle, permet à des lecteurs de tous les âges de s''y retrouver, et d''en rire!', N'http://books.google.com/books/content?id=KLBRDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api')
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (2, N'9782800180045', N'Soda - Tome 13 - Resurrection', NULL, 15, N'S', N'Dupuis', CAST(N'2014-11-07' AS Date), N'FR', 57, N'Comme chaque année, ignorant toujours le vrai métier de son fils, Mary Solomon réclame une simple rose pour son anniversaire, mais pas n''importe laquelle : une de ces délicates roses blanches que son ami fleuriste vend désormais à la sauvette dans une proche station de métro. Mère et fils arrivent ensemble sur place, mais tandis que le pasteur Soda négocie avec le vieux vendeur l''achat de tout son stock de roses, Mary a l''attention attirée par un personnage sombre, à la physionomie vaguement orientale, porteur d''un sac à dos. Ce dernier a, par inadvertance, laissé tomber une enveloppe contenant une importante somme que Mary, s''éloignant de son fils pour trottiner dans la foule des navetteurs, tente de lui restituer. Mary est cardiaque, pas bien agile, mais au bout d''une ou deux minutes, elle parvient néanmoins à interpeler timidement l''inquiétant personnage. Dissimulant mal sa surprise, il s''empresse de s''éloigner avec l''enveloppe... avant de se raviser... ... pour glisser à l''oreille de la vieille dame : Ces jours-ci, ne prenez surtout pas le métro ! Soda ne prend connaissance de l''anecdote que Mary lui confesse naïvement que dans la soirée. Il se lance alors avec 8 heures de retard sur la piste de Khalid Cheik.', N'http://books.google.com/books/content?id=9c61BAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api')
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (3, N'9782800177274', N'Gaston - tome 17 - La saga des gaffes', NULL, 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'FR', 49, N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=f-joPl7Wri0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api')
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (4, N'9782800177175', N'Gaston - tome 12 - Le cas Lagaffe', NULL, 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'FR', 49, N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=GgJDNbJpVrAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api')
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (5, N'9782100796489', N'Explorateurs de l''espace', N'Voyage aux frontières de l''univers                                                                  ', 1, N'E', N'Dunod', CAST(N'2019-04-03' AS Date), N'FR', 192, N'Alors que nous fêtons le cinquantenaire de la mission Apollo 11 et des premiers pas d''un homme sur la Lune, l''exploration spatiale est devenue pour l''humanité un nouveau projet de civilisation. Retourner sur la Lune est au coeur de la stratégie des plus grandes agences spatiales, américaine, européenne, chinoise et russe. Au-delà, c''est le voyage vers Mars qui attise les convoitises mais les défis à relever, humains et technologiques, sont immenses. Dans ce livre, l''astronaute Michel Tognini et l''astrophysicienne Hélène Courtois explorent les difficultés d''un vol habité et comment les surmonter. Des astronautes russes, américains, chinois et français témoignent. Ils nous font partager leurs plus grandes émotions en vol, ouvrant la voie, demain, au tourisme spatial.', N'http://books.google.com/books/content?id=9u6ODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api')
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (6, N'9782723445771', N'Captain Biceps l''invincible', NULL, 14, N'C', N'Unknown', CAST(N'2004-01-01' AS Date), N'FR', 31, N'Captain Biceps, dans son costume rouge et jaune, en impose aux superméchants avec son humour !', NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (7, N'9782226392015', N'Concours pour le Paradis', NULL, 3, N'C', N'Unknown', CAST(N'2018-08-22' AS Date), N'FR', 272, N'Tout était dévasté, consumé, calciné. C''est de cet enfer qu''allait renaître le Paradis. Dans le décor spectaculaire de la Venise renaissante, l''immense toile du Paradis devient un personnage vivant, opposant le génie de Véronèse, du Tintoret et des plus grands maîtres de la ville. Entre rivalités artistiques, trahisons familiales, déchirements politiques, Clélia Renucci fait revivre dans ce premier roman le prodige de la création, ses vertiges et ses drames.', NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (8, N'9782744092176', N'Grand theft auto IV', NULL, 18, N'G', N'Unknown', CAST(N'2008-05-16' AS Date), N'FR', 288, N'MISSIONS : Cartes et stratégies pour venir à bout de toutes les missions de l''histoire principale ainsi que des missions annexes (Assassinats, vols de voiture, Amis, Personnages secondaires...) et terminer le jeu à 100%! CARTES : Trouvez des armes et des armures où que vous soyez dans Liberty City. Nos cartes indiquent leurs positions pour chacune des missions du jeu! Objets à ramasser,à collectionner, centres d''intérêts... tout ce que vous cherchez et tous les lieux à découvrir sont indiqués dans une section dédiées. SECRETS : Nos cartes et nos descriptions détaillées dévoilent la position de tous les sauts uniques et paquets cachés de Liberty City. MULTIJOUEURS : Une fois que vous êtes prêt à plonger dans le jeu en ligne, armez-vous des astuces et tactiques inédites pour tous les modes multijoueurs créés par l''équipe de développement de Rockstar Games. DEPLIANT EN BONUS : Une carte géante de Libery City indique l''emplacement et le détail de tout ce dont vous avez besoin, avec un poster au dos.', NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (9, N'9780415131216', N'Learning English', N'Development and Diversity                                                                           ', 12, N'L', N'Psychology Press', CAST(N'1996-01-01' AS Date), N'EN', 398, N'English is learnt, internationally, in a range of diverse settings. This book examines processes of language acquisition in English, as well as what it means to learn English in different parts of the world. It looks at the place of English within formal education, and at some of the controversies that have surrounded the teaching of English.', N'http://books.google.com/books/content?id=ithfgp_WpfUC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api')
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath]) VALUES (10, N'9782340048010', N'Mathématiques d''excellence 2nd', N'Cours pour lycéens très motivés                                                                     ', 9, N'M', N'Unknown', CAST(N'2021-04-20' AS Date), N'FR', 468, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Publication] OFF
GO
SET IDENTITY_INSERT [dbo].[PublicationCopy] ON 

INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1, 1, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (2, 1, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (3, 2, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (4, 2, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (5, 3, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (6, 4, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (7, 5, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (8, 5, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (9, 5, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (10, 6, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (11, 6, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (12, 7, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (13, 7, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (14, 8, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (15, 8, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (16, 8, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (17, 9, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (18, 9, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (19, 9, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (20, 10, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (21, 10, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (22, 10, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (23, 10, 1)
SET IDENTITY_INSERT [dbo].[PublicationCopy] OFF
GO
INSERT [dbo].[PublicationStateEnum] ([PublicationStateId], [PublicationState]) VALUES (-1, N'Unreadable')
INSERT [dbo].[PublicationStateEnum] ([PublicationStateId], [PublicationState]) VALUES (0, N'Unkown')
INSERT [dbo].[PublicationStateEnum] ([PublicationStateId], [PublicationState]) VALUES (1, N'Readable')
GO
SET IDENTITY_INSERT [dbo].[Shelf] ON 

INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (1, N'Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (3, N'Comic Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (4, N'Lesson Book')
INSERT [dbo].[Shelf] ([ShelfID], [ShelfName]) VALUES (2, N'Magazine')
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
SET IDENTITY_INSERT [dbo].[ShelfComposition] OFF
GO
SET IDENTITY_INSERT [dbo].[Theme] ON 

INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (12, N'Bio')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (6, N'Comic')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (8, N'Detective')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (9, N'English')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (16, N'Gaming')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (4, N'Horror')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (10, N'Literature')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (1, N'Mathematics')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (7, N'Mystic')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (15, N'Nature')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (13, N'Novel')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (2, N'Physics')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (5, N'Romance')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (11, N'Science')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (3, N'Sci-Fi')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (14, N'Super Hero')
SET IDENTITY_INSERT [dbo].[Theme] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Publication]    Script Date: 03-04-23 15:15:48 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Publication] ON [dbo].[Publication]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Unique_Publication_ISBN]    Script Date: 03-04-23 15:15:48 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Unique_Publication_ISBN] ON [dbo].[Publication]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Unique_Shelf]    Script Date: 03-04-23 15:15:48 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Unique_Shelf] ON [dbo].[Shelf]
(
	[ShelfName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Unique_Theme]    Script Date: 03-04-23 15:15:48 ******/
ALTER TABLE [dbo].[Theme] ADD  CONSTRAINT [IX_Unique_Theme] UNIQUE NONCLUSTERED 
(
	[ThemeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[PublicationCopy]  WITH CHECK ADD  CONSTRAINT [FK_PublicationCopy_PublicationStateEnum] FOREIGN KEY([PublicationState])
REFERENCES [dbo].[PublicationStateEnum] ([PublicationStateId])
GO
ALTER TABLE [dbo].[PublicationCopy] CHECK CONSTRAINT [FK_PublicationCopy_PublicationStateEnum]
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
