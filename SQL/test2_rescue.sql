USE [test2]
GO
/****** Object:  Table [dbo].[users]    Script Date: 05/05/2009 13:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[fullname] [varchar](255) NULL,
	[email] [varchar](50) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[templates]    Script Date: 05/05/2009 13:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[templates](
	[template_id] [int] IDENTITY(1,1) NOT NULL,
	[template_code] [text] NULL,
	[template_description] [varchar](max) NULL,
 CONSTRAINT [PK_templates] PRIMARY KEY CLUSTERED 
(
	[template_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pages]    Script Date: 05/05/2009 13:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pages](
	[page_id] [int] IDENTITY(1,1) NOT NULL,
	[page_name] [varchar](50) NOT NULL,
	[page_meta_description] [varchar](max) NULL,
	[page_meta_keywords] [varchar](max) NULL,
 CONSTRAINT [PK_pages] PRIMARY KEY CLUSTERED 
(
	[page_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[viewtree]    Script Date: 05/05/2009 13:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[viewtree](
	[node_id] [int] IDENTITY(1,1) NOT NULL,
	[page_id] [int] NOT NULL,
	[parent_id] [int] NULL,
	[template_id] [int] NULL,
	[template_inherit] [bit] NOT NULL CONSTRAINT [DF_viewtree_template_inherit]  DEFAULT ((1))
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[content]    Script Date: 05/05/2009 13:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[content](
	[content_id] [int] IDENTITY(1,1) NOT NULL,
	[page_id] [int] NOT NULL,
	[content_description] [varchar](max) NULL,
	[content_text] [text] NULL,
 CONSTRAINT [PK_content] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_content_pages]    Script Date: 05/05/2009 13:51:03 ******/
ALTER TABLE [dbo].[content]  WITH CHECK ADD  CONSTRAINT [FK_content_pages] FOREIGN KEY([page_id])
REFERENCES [dbo].[pages] ([page_id])
GO
ALTER TABLE [dbo].[content] CHECK CONSTRAINT [FK_content_pages]
GO
/****** Object:  ForeignKey [FK_viewtree_pages]    Script Date: 05/05/2009 13:51:03 ******/
ALTER TABLE [dbo].[viewtree]  WITH CHECK ADD  CONSTRAINT [FK_viewtree_pages] FOREIGN KEY([page_id])
REFERENCES [dbo].[pages] ([page_id])
GO
ALTER TABLE [dbo].[viewtree] CHECK CONSTRAINT [FK_viewtree_pages]
GO
/****** Object:  ForeignKey [FK_viewtree_templates]    Script Date: 05/05/2009 13:51:03 ******/
ALTER TABLE [dbo].[viewtree]  WITH CHECK ADD  CONSTRAINT [FK_viewtree_templates] FOREIGN KEY([template_id])
REFERENCES [dbo].[templates] ([template_id])
GO
ALTER TABLE [dbo].[viewtree] CHECK CONSTRAINT [FK_viewtree_templates]
GO
