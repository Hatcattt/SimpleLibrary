/****** Object:  Table [dbo].[Author]    Script Date: 23-05-23 14:15:47 ******/
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
/****** Object:  Table [dbo].[AuthorPublication]    Script Date: 23-05-23 14:15:47 ******/
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
/****** Object:  Table [dbo].[Publication]    Script Date: 23-05-23 14:15:47 ******/
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
	[CreateAt] [date] NULL,
	[UpdateAt] [date] NULL,
 CONSTRAINT [PK_Publication] PRIMARY KEY CLUSTERED 
(
	[PublicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicationCopy]    Script Date: 23-05-23 14:15:47 ******/
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
/****** Object:  Table [dbo].[PublicationStateEnum]    Script Date: 23-05-23 14:15:47 ******/
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
/****** Object:  Table [dbo].[Shelf]    Script Date: 23-05-23 14:15:47 ******/
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
/****** Object:  Table [dbo].[ShelfComposition]    Script Date: 23-05-23 14:15:47 ******/
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
/****** Object:  Table [dbo].[Theme]    Script Date: 23-05-23 14:15:47 ******/
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
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (2, N'Tome', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (3, N'Franquin', N'BE')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (4, N'Michel Tognini', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (5, N'Hélène Courtois', N'FR')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (6, N'Jean-Yves Le Gall', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (7, N'Zep', N'CH')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (8, N'Tébo', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (9, N'Rick Barba', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (10, N'Neil Mercer', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (11, N'Joan Swann', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (12, N'Eric Dubon', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (13, N'Francisco del Rey', NULL)
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (14, N'Masashi Kishimoto', N'JP')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (15, N'Hergé', N'BE')
INSERT [dbo].[Author] ([AuthorID], [AuthorName], [Nationality]) VALUES (16, N'Raoul Cauvin', N'FR')
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[AuthorPublication] ON 

INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (1, 1, 1, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (2, 2, 2, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (3, 3, 3, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (4, 3, 4, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (5, 3, 5, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (6, 6, 6, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (7, 7, 6, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (8, 8, 6, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (9, 9, 7, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (10, 10, 7, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (11, 11, 8, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (12, 12, 9, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (13, 13, 10, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (14, 13, 10, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (15, 14, 11, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (16, 14, 12, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (17, 14, 13, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (18, 14, 14, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (19, 14, 15, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (20, 15, 16, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (21, 15, 17, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (22, 15, 18, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (23, 16, 19, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (24, 16, 20, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (25, 16, 21, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (26, 16, 22, NULL)
INSERT [dbo].[AuthorPublication] ([AuthorPublicationID], [AuthorID], [PublicationID], [AuthorFunction]) VALUES (27, 16, 23, NULL)
SET IDENTITY_INSERT [dbo].[AuthorPublication] OFF
GO
SET IDENTITY_INSERT [dbo].[Publication] ON 

INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (1, N'9782331026324', N'Kid Paddle -', N'Panik room', 13, N'K', N'Glénat BD', CAST(N'2016-10-26' AS Date), N'FR', 48, N'On imagine mal Kid, adepte de films gore et de blorks dégommés, faire du baby-sitting. Une fois de plus, Midam nous surprend avec des situations improbables où Kid améliore la réalité à sa sauce. Cet album offre aussi une double lecture où les plus jeunes s''amuseront de la situation en général et où les adultes se reconnaîtront peut-être dans l''idéalisation de leur progéniture. Cette double lecture, omniprésente dans la plupart des gags de Kid Paddle, permet à des lecteurs de tous les âges de s''y retrouver, et d''en rire!', N'http://books.google.com/books/content?id=KLBRDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (2, N'9782800180045', N'Soda - Tome 13 - Resurrection', NULL, 15, N'S', N'Dupuis', CAST(N'2014-11-07' AS Date), N'FR', 57, N'Comme chaque année, ignorant toujours le vrai métier de son fils, Mary Solomon réclame une simple rose pour son anniversaire, mais pas n''importe laquelle : une de ces délicates roses blanches que son ami fleuriste vend désormais à la sauvette dans une proche station de métro. Mère et fils arrivent ensemble sur place, mais tandis que le pasteur Soda négocie avec le vieux vendeur l''achat de tout son stock de roses, Mary a l''attention attirée par un personnage sombre, à la physionomie vaguement orientale, porteur d''un sac à dos. Ce dernier a, par inadvertance, laissé tomber une enveloppe contenant une importante somme que Mary, s''éloignant de son fils pour trottiner dans la foule des navetteurs, tente de lui restituer. Mary est cardiaque, pas bien agile, mais au bout d''une ou deux minutes, elle parvient néanmoins à interpeler timidement l''inquiétant personnage. Dissimulant mal sa surprise, il s''empresse de s''éloigner avec l''enveloppe... avant de se raviser... ... pour glisser à l''oreille de la vieille dame : Ces jours-ci, ne prenez surtout pas le métro ! Soda ne prend connaissance de l''anecdote que Mary lui confesse naïvement que dans la soirée. Il se lance alors avec 8 heures de retard sur la piste de Khalid Cheik.', N'http://books.google.com/books/content?id=9c61BAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (3, N'9782800177274', N'Gaston - tome 17 - La saga des gaffes', NULL, 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'FR', 49, N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=f-joPl7Wri0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (4, N'9782800106588', N'Lagaffe mérite des baffes', NULL, 13, N'L', N'Editions Dupuis', CAST(N'1979-01-01' AS Date), N'FR', 48, N'Autres aventures (1973) farcies de gags tant visuels que littéraux et quelquefois littéraires de l''ineffable gaffeur.', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (5, N'9782800177175', N'Gaston - tome 12 - Le cas Lagaffe', NULL, 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'FR', 49, N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (6, N'9782100796489', N'Explorateurs de l''espace', N'Voyage aux frontières de l''univers', 1, N'E', N'Dunod', CAST(N'2019-04-03' AS Date), N'FR', 192, N'Alors que nous fêtons le cinquantenaire de la mission Apollo 11 et des premiers pas d''un homme sur la Lune, l''exploration spatiale est devenue pour l''humanité un nouveau projet de civilisation. Retourner sur la Lune est au coeur de la stratégie des plus grandes agences spatiales, américaine, européenne, chinoise et russe. Au-delà, c''est le voyage vers Mars qui attise les convoitises mais les défis à relever, humains et technologiques, sont immenses. Dans ce livre, l''astronaute Michel Tognini et l''astrophysicienne Hélène Courtois explorent les difficultés d''un vol habité et comment les surmonter. Des astronautes russes, américains, chinois et français témoignent. Ils nous font partager leurs plus grandes émotions en vol, ouvrant la voie, demain, au tourisme spatial.', N'http://books.google.com/books/content?id=9u6ODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (7, N'9782723445771', N'Captain Biceps l''invincible', NULL, 14, N'C', N'Unknown', CAST(N'2004-01-01' AS Date), N'FR', 31, N'Captain Biceps, dans son costume rouge et jaune, en impose aux superméchants avec son humour !', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (8, N'9782744092176', N'Grand theft auto IV', NULL, 18, N'G', N'Unknown', CAST(N'2008-05-16' AS Date), N'FR', 288, N'MISSIONS : Cartes et stratégies pour venir à bout de toutes les missions de l''histoire principale ainsi que des missions annexes (Assassinats, vols de voiture, Amis, Personnages secondaires...) et terminer le jeu à 100%! CARTES : Trouvez des armes et des armures où que vous soyez dans Liberty City. Nos cartes indiquent leurs positions pour chacune des missions du jeu! Objets à ramasser,à collectionner, centres d''intérêts... tout ce que vous cherchez et tous les lieux à découvrir sont indiqués dans une section dédiées. SECRETS : Nos cartes et nos descriptions détaillées dévoilent la position de tous les sauts uniques et paquets cachés de Liberty City. MULTIJOUEURS : Une fois que vous êtes prêt à plonger dans le jeu en ligne, armez-vous des astuces et tactiques inédites pour tous les modes multijoueurs créés par l''équipe de développement de Rockstar Games. DEPLIANT EN BONUS : Une carte géante de Libery City indique l''emplacement et le détail de tout ce dont vous avez besoin, avec un poster au dos.', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (9, N'9780415131216', N'Learning English', N'Development and Diversity', 12, N'L', N'Psychology Press', CAST(N'1996-01-01' AS Date), N'EN', 398, N'English is learnt, internationally, in a range of diverse settings. This book examines processes of language acquisition in English, as well as what it means to learn English in different parts of the world. It looks at the place of English within formal education, and at some of the controversies that have surrounded the teaching of English.', N'http://books.google.com/books/content?id=ithfgp_WpfUC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (10, N'9782340048010', N'Mathématiques d''excellence 2nd', N'Cours pour lycéens très motivés', 9, N'M', N'Unknown', CAST(N'2021-04-20' AS Date), N'FR', 468, NULL, NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (11, N'9782871294146', N'Naruto : 1 [Naruto Uzumaki]', NULL, 19, N'N', N'Unknown', CAST(N'2002-03-07' AS Date), N'EN', 187, N'Naruto est un garçon un peu spécial. Il est toujours seul et son caractère fougueux ne l''aide pas à se faire apprécier de son village. Malgré cela, il garde l''ambition de devenir un maître Hokage, la plus haute distinction dans l''ordre des ninjas, et ainsi obtenir la reconnaissance de ses pairs.', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (12, N'9782871294177', N'Naruto : 2 [Un client embarrassant]', NULL, 19, N'N', N'Unknown', CAST(N'2002-04-11' AS Date), N'FR', 205, N'Sasuke, Sakura et Naruto passent un test dont le but est de s''emparer des clochettes que détient le professeur kakashi. Il leur fait bien réaliser leur inferiorité et leur manque d''expérience et finit par leur annoncer qu''ils n''ont aucune chance de devenir Ninjas...', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (13, N'9782871294276', N'Naruto : 3 [Se battre pour ses rêves!!]', NULL, 19, N'N', N'Unknown', CAST(N'2002-07-04' AS Date), N'FR', 204, N'Avec Sasuke et Sakura, Naruto, le pire garnement de l''école de ninjas de Konoha, un village caché, réussit avec brio le test de survie imposé par maître Kakashi. Les trois jeunes gens forment une vraie équipe, mais ils ne sont encore que des ninjas de rang inférieur.', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (14, N'9782871294412', N'Naruto : 4 [Le pont des héros!]', NULL, 19, N'N', N'Unknown', CAST(N'2002-10-17' AS Date), N'FR', 180, N'Sasuke s''effondre après avoir voulu protéger Naruto ! Déclenché à la fois par la rage et la tristesse un étrange bouleversement se produit en Naruto. Haku est alors subitement balayé par le poing rageur de Naruto.', NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (15, N'9782871294917', N'Naruto : 5 [Les rivaux]', NULL, 19, N'N', N'Unknown', CAST(N'2003-01-23' AS Date), N'FR', 181, NULL, NULL, NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (16, N'9782203001152', N'Tintin : Objectif Lune', NULL, 15, N'T', N'Editions Moulinsart', CAST(N'1953-01-01' AS Date), N'FR', 62, N'Le Professeur Tournesol invite Tintin et le Capitaine Haddock à le rejoindre en Syldavie où il travaille sur le plus grand projet du siècle : l''envoi d''une fusée sur la Lune. Le défi s''annonce palpitant, d''autant plus qu''au grand effarement du Capitaine, le Professeur leur suggère d''être du voyage !', N'http://books.google.com/books/content?id=Ya4_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (17, N'9782203001169', N'Tintin : On a marché sur la Lune', NULL, 15, N'T', N'Editions Moulinsart', CAST(N'1954-01-01' AS Date), N'FR', 62, N'L''expédition lunaire de nos héros est pleine de rebondissements et de surprises. Deux exemples marquants : l''arrivée des Dupondt, embarqués malgré eux dans le voyage vers notre satellite naturel, et le sort funeste de Frank Wolff. Sur le plan scientifique, Hergé réussit pleinement à nous faire goûter les mystères du moteur atomique ou des phénomènes d''apesanteur. De la même manière, il invite le lecteur à participer au pilotage d''une fusée interplanétaire tout en nous faisant voyager dans le monde spatial.', N'http://books.google.com/books/content?id=Y64_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (18, N'9782203001107', N'Tintin : Le Secret de La Licorne', NULL, 15, N'T', N'Editions Moulinsart', CAST(N'1943-01-01' AS Date), N'FR', 62, N'En fouillant le grenier, le capitaine Haddock retrouve la trace de son ancêtre, le chevalier de Haddoque. Ce légendaire loup des mers s''est rendu célèbre par ses déboires avec le cruel pirate Rackham le Rouge. Un roman maritime de plus ? Certainement pas! Car le chevalier devient le dépositaire d''un fabuleux trésor. Pour Tintin, Haddock et une série de malfrats, il s''agit de le retrouver. Mais les pistes et les énigmes se multiplient.', N'http://books.google.com/books/content?id=V64_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (19, N'9782800189093', N'Cédric - Tome 1 - Premières classes', NULL, 13, N'C', N'Dupuis', CAST(N'2013-06-20' AS Date), N'FR', 49, N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=ewgRQwpDwUEC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (20, N'9782800189086', N'Cédric - Tome 2 - Classes de neige', NULL, 13, N'C', N'Dupuis', CAST(N'2013-06-20' AS Date), N'FR', 49, N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=5VMTCE-q5K4C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (21, N'9782800189079', N'Cédric - Tome 3 - Classe tous risques', NULL, 13, N'C', N'Dupuis', CAST(N'2013-06-20' AS Date), N'FR', 49, N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=P658kjdJHnkC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (22, N'9782800189062', N'Cédric - Tome 4 - Papa a de la classe', NULL, 13, N'C', N'Dupuis', CAST(N'2010-03-26' AS Date), N'FR', 49, N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=7z4KJtFxfKUC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (23, N'9782800195193', N'Cédric - Tome 5 - Quelle mouche le pique?', NULL, 13, N'C', N'Dupuis', CAST(N'2010-03-26' AS Date), N'FR', 50, N'Dur, dur, d''être un petit garçon... Entre la maîtresse, le psychologue de l''école, les parents trop curieux, les copains chahuteurs, une cousine odieuse et une petite copine capricieuse, Cédric a fort à faire pour préserver sa tranquillité. Heureusement, Pépé est toujours là, pour les mauvais coups comme les coups de blues. La nouvelle star des enfants est déjà un classique de la BD familiale et séduit avec la même complicité toutes les générations.', N'http://books.google.com/books/content?id=kKB5D7M9WtsC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (37, N'9782800189291', N'Boule et Bill - Tome 5 - Bulles et Bill', N'', 13, N'B', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', NULL, N'Boule, un petit garçon comme les autres, a comme meilleur copain Bill, son adorable et facétieux cocker. Outre Boule, Bill a une autre grande passion : Caroline, la mignonne tortue... Dans un univers familial plein de gentillesse et de joie de vivre, les bêtises et les espiègleries de Boule et Bill déchainent les éclats de rire des lecteurs de tout âge.', N'http://books.google.com/books/content?id=WVqlDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (75, N'1591164419', N'Bleach, Vol. 1 ', N'', 19, N'B', N'VIZ Media LLC', CAST(N'2004-07-06' AS Date), N'en', NULL, N'Part-time student, full-time Soul Reaper, Ichigo is one of the chosen few guardians of the afterlife. Ichigo Kurosaki never asked for the ability to see ghosts—he was born with the gift. When his family is attacked by a Hollow—a malevolent lost soul—Ichigo becomes a Soul Reaper, dedicating his life to protecting the innocent and helping the tortured spirits themselves find peace. Find out why Tite Kubo’s Bleach has become an international manga smash-hit! Ichigo Kurosaki has always been able to see ghosts, but this ability doesn''t change his life nearly as much as his close encounter with Rukia Kuchiki, a Soul Reaper and member of the mysterious Soul Society. While fighting a Hollow, an evil spirit that preys on humans who display psychic energy, Rukia attempts to lend Ichigo some of her powers so that he can save his family; but much to her surprise, Ichigo absorbs every last drop of her energy. Now a full-fledged Soul Reaper himself, Ichigo quickly learns that the world he inhabits is one full of dangerous spirits and, along with Rukia--who is slowly regaining her powers--it''s Ichigo''s job to protect the innocent from Hollows and help the spirits themselves find peace.', N'http://books.google.com/books/content?id=H6YT1otBVgkC&printsec=frontcover&img=1&zoom=1&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (78, N'1593079494', N'Gantz ', N'', 19, N'G', N'Gantz', NULL, N'en', NULL, N'Two teenagers, struck and killed by a subway train, find that their new "lives" are controlled by a sadistic alien.', N'http://books.google.com/books/content?id=dSfPHAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (80, N'9782203001114', N'Tintin : Le Trésor de Rackham le Rouge ', N'', 15, N'T', N'Editions Moulinsart', CAST(N'1944-01-01' AS Date), N'fr', NULL, N'Dans Le Secret de La Licorne (1943) et Le Trésor de Rackham le Rouge qui en est la suite, Tintin accompagne le capitaine Haddock sur les traces de son glorieux ancêtre, le chevalier François de Hadoque. Inventeur d''un sous-marin de poche en forme de requin, un certain Tryphon Tournesol contribue à la découverte du trésor, avant d''offrir au Capitaine le château de ses aïeux : Moulinsart. Tintin, Haddock et les Dupondt s''embarquent, munis des parchemins laissés par l''illustre ancêtre du Capitaine, à la recherche du Trésor de Rackham Le Rouge. L''aventure n''ira pas sans aléas ni surprises, d''autant plus que le professeur Tournesol a présenté à Tintin et au Capitaine un nouvel appareil d''exploration sous-marine...', N'http://books.google.com/books/content?id=Wa4_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', NULL, NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (82, N'9782800180120', N'Marsupilami - Tome 28 - Biba ', N'', 13, N'M', N'Marsu', CAST(N'2014-11-14' AS Date), N'fr', NULL, N'Pas évident de survivre dans la jungle palombienne quand on est toute seule pour se débrouiller au milieu des serpents sournois, des oiseaux mauvais coucheurs et des alligators voraces. Sans compter le pire prédateur de tous (et le plus bête) : le braconnier. Biba, jolie petite marsupilamie, en sait quelque chose... Mais elle ignore encore qu''elle est loin d''être seule au monde !', N'http://books.google.com/books/content?id=aeIuBQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (83, N'9782800177113', N'Gaston - tome 09 - Un gaffeur sachant gaffer ', N'', 13, N'G', N'Dupuis', CAST(N'2013-04-08' AS Date), N'fr', NULL, N'Dupuis et Marsu Productions rééditent la totalité des gags de Gaston Lagaffe, regroupés dans l''ordre chronologique en 19 albums. À l''occasion de cette nouvelle édition, on retrouve enfin les couvertures signées Franquin. En 1997, pour les quarante ans du personnage, les gags de Gaston Lagaffe avaient été réédités selon un ordre strictement chronologique. Les lecteurs disposaient enfin d''une édition cohérente : fini les R1, R2, etc.,... sans tome R5, qui apparaissait malgré tout quelques années plus tard !... Malheureusement, on perdit au passage les belles illustrations dessinées par Franquin. Douze ans après cette dernière réédition, les lecteurs vont enfin pouvoir retrouver les couvertures du maître... tout en conservant les bénéfices d''une édition chronologique des gags. Bref, c''est une version 100% Franquin de Gaston Lagaffe que Dupuis et Marsu Productions proposent aux amateurs, qui pourront compléter leur collection, sans craindre de faire de doublons.', N'http://books.google.com/books/content?id=KHYnfBpFecQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (84, N'9782800189307', N'Boule et Bill - Tome 4 - Système Bill ', N'', 13, N'B', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', NULL, N'Boule, un petit garçon comme les autres, a comme meilleur copain Bill, son adorable et facétieux cocker. Outre Boule, Bill a une autre grande passion : Caroline, la mignonne tortue... Dans un univers familial plein de gentillesse et de joie de vivre, les bêtises et les espiègleries de Boule et Bill déchainent les éclats de rire des lecteurs de tout âge.', N'http://books.google.com/books/content?id=NFqlDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (85, N'9782800186788', N'Nelson tome 1 - Diablotin à domicile ', N'', 13, N'N', N'Dupuis', CAST(N'2013-06-26' AS Date), N'fr', NULL, N'Quand NELSON débarque chez vous... c''est l''ENFER !Nelson, c''est l''insupportable diablotin qui vient s''incruster dans la vie de Julie, une jeune et jolie célibataire, et de Floyd, un labrador engourdi. Mais attention, personne n''est à l''abri de cette malédiction orange! Nelson a largement assez de défauts pour dynamiter le quotidien de tous les infortunés qui croisent son chemin.Nelson : star des strips, star en Suisse !Nelson est né le 11 février 2001 dans LE MATIN, sous la plume de Christophe Bertschy (également auteur de Smax dans TCHÔ !). Depuis, c''est plus de 700 strips qui ont réjoui les lecteurs du premier quotidien francophone de Suisse. Le journal a même édité un album en bichro reprenant 180 strips qui s''est vendu à près de 5000 exemplaires rien qu''en Suisse Romande ! Les Éditions Dupuis ont eu une idée diabolique : rassembler tous les strips du petit démon domestique pour en faire de beaux albums de BD tout en couleurs. Le premier volume sera disponible en janvier 2004 d''autres suivront... à un rythme d''enfer !', N'http://books.google.com/books/content?id=teJkJHyOCjYC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (86, N'9782800186740', N'Nelson tome 2 - Catastrophe naturelle ', N'', 13, N'N', N'Dupuis', CAST(N'2013-06-26' AS Date), N'fr', NULL, N'Catastrophe pas très naturelle !Nelson, c''est l''insupportable diablotin qui vient s''incruster dans la vie de Julie, une jeune et jolie célibataire, et de Floyd, un labrador engourdi. Véritable catastrophe surnaturelle, Nelson n''a pas son pareil pour empoisonner chaque instant de la vie de ses deux victimes favorites. Mais, attention : personne n''est à l''abri de cette malédiction orange ! Car Nelson a largement assez de défauts pour dynamiter le quotidien de tous les infortunés qui croisent son chemin...Quand, en février 2001, Christophe Bertschy propose au MATIN de publier les strips de Nelson, il ne sait pas encore dans quel enfer il plonge ! Car, en quelques mois à peine, son diablotin orange est devenu la mascotte du plus important quotidien francophone de Suisse. Et des centaines de milliers de lecteurs attendent, chaque jour, leur ration de catastrophes en tout genre. Depuis, un très large public francophone a succombé au charme infernal du diablotin domestique... Christophe Bertschy est également l''auteur de Smax, une série à gags publiée dans TCHÔ !', N'http://books.google.com/books/content?id=2J5zVHqjv3UC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-15' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (88, N'2033200280', N'LE PLUS PETIT LAROUSSE', N'', 69, N'L', N'Larousse', CAST(N'1980-05-01' AS Date), N'fr', NULL, N'Ce tout petit dictionnaire se veut d''abord un outil extrêmement maniable mais cherche aussi à apporter au lecteur un maximum d''informations. On y trouvera le plus de mots possible, sélectionnés avec soin, accompagnés d''une courte définition, ou de plusieurs pour les mots qui ont diverses acceptions, souvent d''un exemple, et, chaque fois que c''est utile, de la prononciation ou de précisions sur le fonctionnement grammatical. Cette nouvelle édition tient compte de l''évolution de la langue, des sciences et des techniques.', NULL, CAST(N'2023-05-16' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (89, N'9782800186719', N'Chinaman - tome 7 - Affrontements à Blue Hill', N'', 14, N'C', N'Dupuis', CAST(N'2013-06-21' AS Date), N'fr', NULL, N'Au coeur de la tourmenteÀ Blue Hill, l''installation de nouvelles familles chinoises attise le mécontement de la population qui voit d''un mauvais oeil l''arrivée de ces étrangers, alors même que les lois d''exclusion qui interdisent l''immigration des Chinois pendant dix ans et leur droit d''être naturalisés viennent d''être votées. C''est dans ce climat social tendu qu''arrivent dans la région le maître d''une école d''arts martiaux et ses élèves, venus affronter en combats singuliers le légendaire Chinaman. Alors qu''Ada, en intégrant les enfants chinois dans sa classe, va être boycottée par les gens du village, Chen va devoir, à nouveau, prendre les armes.Chinaman, les aventures d''un Chinois dans l''Ouest américainEn s''attachant à décrire le quotidien des émigrants chinois aux États-Unis, alors que le pays connaît de violentes émeutes après le vote des lois d''exclusion, Serge Le Tendre et Olivier TaDuc signent, avec Affrontements à Blue Hill, un épisode plus que jamais humaniste et attachant. Ce septième album marque également un tournant dans la relation entre Chen et sa compagne Ada, un tournant qui va marquer durablement la suite de la série. En six albums, cette série animée par Olivier TaDuc au dessin et Serge Le Tendre au scénario s''est imposée auprès des libraires et du public comme LA série western du moment.', N'http://books.google.com/books/content?id=HiSkwaBqXCwC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-16' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (90, N'9782800189451', N'L''Agent 212 - Tome 7 - UN FLIC A L''OMBRE', N'', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', NULL, N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=3bBHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-17' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (91, N'9782800189444', N'L''Agent 212 - Tome 8 - PAS DE PANIQUE', N'', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', NULL, N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=ubBHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-17' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (92, N'9782800189420', N'L''Agent 212 - Tome 11 - SIFFLEZ DANS LE BALLON !', N'', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', NULL, N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=ArFHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-17' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (93, N'9782800189406', N'L''Agent 212 - Tome 13 - UN FLIC FLANCHE', N'', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', NULL, N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=k7BHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-17' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (94, N'9782800189413', N'L''Agent 212 - Tome 12 - RIS,O POULET', N'', 13, N'L', N'Dupuis', CAST(N'2010-03-26' AS Date), N'fr', NULL, N'Rondouillard, naïf et sympathique, l''Agent 212 est la cible de tous les ennuis et de toutes les mésaventures auxquels un agent de police peut se trouver exposé. Délinquants, conducteurs imprudents ou suicidaires obstinés se succèdent, pour la plus grande joie des lecteurs et de ses auteurs, Kox et Cauvin.', N'http://books.google.com/books/content?id=cbFHBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-17' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (95, N'9781595823939', N'Blacksad', N'', 15, N'B', N'National Geographic Books', CAST(N'2010-06-22' AS Date), N'en', NULL, N'Private investigator John Blacksad is up to his feline ears in mystery, digging into the backstories behind murders, child abductions, and nuclear secrets. Guarnido''s sumptuously painted pages and rich cinematic style bring the world of 1950s America to vibrant life, with Canales weaving in fascinating tales of conspiracy, racial tension, and the "red scare" Communist witch hunts of the time. Guarnido reinvents anthropomorphism in these pages, and industry colleagues no less than Will Eisner, Jim Steranko, and Tim Sale are fans! Whether John Blacksad is falling for dangerous women or getting beaten to within an inch of his life, his stories are, simply put, unforgettable. * Dark Horse is very proud to present the first three Blacksad stories in a beautiful hardcover collection, completely relettered to the artist''s specifications and with the latest album, Red Soul, in English for the very first time. * This internationally acclaimed series has won nearly a dozen prestigious awards — including the Angoulême Comics Festival prizes for Best Series and Best Artwork-and is a three-time Eisner Award nominee.', N'http://books.google.com/books/content?id=REqQEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', CAST(N'2023-05-17' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (96, N'9782203001022', N'Tintin en Amérique', N'', 15, N'T', N'Editions Moulinsart', CAST(N'1932-01-01' AS Date), N'fr', NULL, N'Tintin confirme sa vocation de redresseur de torts, en s''opposant au mafioso Al Capone, aux gangsters de Chicago et aux fripouilles de tout acabit. Sa renommée s''étend au-delà de l''Atlantique. Si bien que lorsqu''il arrive à Chicago, en pleine prohibition, tous les bandits et malfaiteurs associés lui préparent une réception des moins confortables. Tintin devra user de tout son courage et de toute son intelligence pour survivre !', N'http://books.google.com/books/content?id=P64_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-18' AS Date), NULL)
INSERT [dbo].[Publication] ([PublicationID], [ISBN], [Title], [SubTitle], [Location], [LetterRow], [Publisher], [PublishedDate], [Language], [NumberOfPages], [Description], [CoverFilePath], [CreateAt], [UpdateAt]) VALUES (97, N'9782800180083', N'Largo Winch - intégrale', N'', 15, N'L', N'Dupuis', CAST(N'2014-10-17' AS Date), N'fr', NULL, N'À vingt-six ans, Largo Winch hérite d’un cartel financier de dix milliards de dollars. Contestataire, séducteur et anticonformiste, on l’appelle « le milliardaire humaniste ». Mais peut-on garder les mains propres à la tête d’un tel empire ? Entre femmes aux charmes meurtriers et banquiers trompeusement complices, entre combinaisons financières et trafics douteux, Largo Winch rend coup pour coup. Parfois à la limite de la légalité. Lancez-vous dans les 3 premières aventures avec cette intégrale à prix découverte !', N'http://books.google.com/books/content?id=cvrKBAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', CAST(N'2023-05-19' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Publication] OFF
GO
SET IDENTITY_INSERT [dbo].[PublicationCopy] ON 

INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (1, 1, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (2, 1, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (3, 1, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (4, 1, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (5, 2, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (6, 2, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (7, 2, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (8, 2, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (9, 3, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (10, 4, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (11, 4, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (12, 4, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (13, 4, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (14, 5, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (15, 6, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (16, 6, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (17, 7, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (18, 7, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (19, 7, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (20, 7, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (21, 8, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (22, 8, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (23, 8, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (24, 9, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (25, 9, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (26, 9, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (27, 9, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (28, 10, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (29, 11, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (30, 11, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (31, 12, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (32, 13, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (33, 14, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (34, 14, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (35, 14, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (36, 14, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (37, 15, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (38, 15, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (39, 15, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (40, 16, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (41, 16, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (42, 17, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (43, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (44, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (45, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (46, 18, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (47, 1, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (48, 1, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (49, 1, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (50, 2, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (51, 2, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (52, 3, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (53, 3, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (54, 4, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (55, 4, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (56, 4, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (57, 4, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (58, 5, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (59, 5, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (60, 5, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (61, 5, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (78, 75, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (79, 75, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (80, 75, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (81, 75, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (86, 78, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (87, 78, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (88, 78, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (92, 80, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (93, 80, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (96, 82, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (97, 82, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (98, 83, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (99, 83, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (100, 83, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (101, 83, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (102, 84, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (103, 84, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (104, 84, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (105, 85, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (106, 85, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (107, 85, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (108, 86, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (109, 86, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (110, 86, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (114, 88, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (115, 88, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (116, 89, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (117, 89, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (118, 90, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (119, 90, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (120, 91, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (121, 91, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (122, 91, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (123, 91, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (124, 92, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (125, 92, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (126, 92, 0)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (127, 93, 1)
GO
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (128, 94, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (129, 94, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (130, 94, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (131, 95, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (132, 95, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (133, 95, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (134, 96, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (135, 96, -1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (136, 97, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (137, 97, 1)
INSERT [dbo].[PublicationCopy] ([PublicationCopyID], [PublicationID], [PublicationState]) VALUES (138, 97, 1)
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
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (69, 8, 22)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (71, 5, 8)
INSERT [dbo].[ShelfComposition] ([ShelfCompositionID], [ShelfID], [ThemeID]) VALUES (73, 1, 23)
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
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (20, N'Polonais')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (21, N'English')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (22, N'French')
INSERT [dbo].[Theme] ([ThemeID], [ThemeName]) VALUES (23, N'Computer Science')
SET IDENTITY_INSERT [dbo].[Theme] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Publication]    Script Date: 23-05-23 14:15:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Publication] ON [dbo].[Publication]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Unique_Publication_ISBN]    Script Date: 23-05-23 14:15:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Unique_Publication_ISBN] ON [dbo].[Publication]
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
