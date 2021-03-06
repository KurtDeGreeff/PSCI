/****** Object:  Table [dbo].[ServerPermission]    Script Date: 07/13/2008 21:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServerPermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServerPermission](
	[PermissionState] [varchar](255) NULL,
	[members] [xml] NULL,
	[Server] [varchar](255) NULL,
	[Grantee] [varchar](255) NULL,
	[PermissionType] [varchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServerPermission]') AND name = N'IX_ServerPermission')
CREATE CLUSTERED INDEX [IX_ServerPermission] ON [dbo].[ServerPermission] 
(
	[timestamp] ASC,
	[Server] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerRole]    Script Date: 07/13/2008 21:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServerRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServerRole](
	[members] [xml] NULL,
	[Server] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServerRole]') AND name = N'IX_ServerRole')
CREATE CLUSTERED INDEX [IX_ServerRole] ON [dbo].[ServerRole] 
(
	[timestamp] ASC,
	[Server] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SqlUser]    Script Date: 07/13/2008 21:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SqlUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SqlUser](
	[LoginType] [varchar](255) NULL,
	[members] [xml] NULL,
	[objects] [xml] NULL,
	[Server] [varchar](255) NULL,
	[dbname] [varchar](255) NULL,
	[Login] [varchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SqlUser]') AND name = N'IX_SqlUser')
CREATE CLUSTERED INDEX [IX_SqlUser] ON [dbo].[SqlUser] 
(
	[timestamp] ASC,
	[Server] ASC,
	[dbname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ObjectPermission]    Script Date: 07/13/2008 21:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObjectPermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ObjectPermission](
	[ObjectClass] [varchar](255) NULL,
	[ColumnName] [varchar](255) NULL,
	[PermissionState] [varchar](255) NULL,
	[members] [xml] NULL,
	[Server] [varchar](255) NULL,
	[dbname] [varchar](255) NULL,
	[Grantee] [varchar](255) NULL,
	[PermissionType] [varchar](255) NULL,
	[ObjectSchema] [varchar](255) NULL,
	[ObjectName] [varchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ObjectPermission]') AND name = N'IX_ObjectPermission')
CREATE CLUSTERED INDEX [IX_ObjectPermission] ON [dbo].[ObjectPermission] 
(
	[timestamp] ASC,
	[Server] ASC,
	[dbname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatabaseRole]    Script Date: 07/13/2008 21:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatabaseRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DatabaseRole](
	[IsFixedRole] [bit] NULL,
	[members] [xml] NULL,
	[Server] [varchar](255) NULL,
	[dbname] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DatabaseRole]') AND name = N'IX_DatabaseRole')
CREATE CLUSTERED INDEX [IX_DatabaseRole] ON [dbo].[DatabaseRole] 
(
	[timestamp] ASC,
	[Server] ASC,
	[dbname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 07/13/2008 21:30:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Login]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Login](
	[LoginType] [varchar](255) NULL,
	[members] [xml] NULL,
	[Server] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Login]') AND name = N'IX_Login')
CREATE CLUSTERED INDEX [IX_Login] ON [dbo].[Login] 
(
	[timestamp] ASC,
	[Server] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_GetMember]    Script Date: 07/13/2008 21:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_GetMember]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufn_GetMember] (@xml_data xml)
RETURNS TABLE
AS
RETURN 
(
	SELECT CONVERT(varchar(max),@xml_data) AS members, members.member.value(''.'', ''nvarchar(100)'') AS member 
	FROM @xml_data.nodes(''/member'')  members(member)

);
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_GetObjectType]    Script Date: 07/13/2008 21:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_GetObjectType]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufn_GetObjectType] (@xml_data xml)
RETURNS TABLE
AS
RETURN 
(
	SELECT CONVERT(varchar(max),@xml_data) AS objects, objects.objecttype.value(''.'', ''nvarchar(100)'') As ObjectType
	FROM @xml_data.nodes(''/Object/@ObjectType'')  objects(objecttype)
);' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_GetObjectName]    Script Date: 07/13/2008 21:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_GetObjectName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufn_GetObjectName] (@xml_data xml)
RETURNS TABLE
AS
RETURN 
(
	SELECT CONVERT(varchar(max),@xml_data) AS objects, objects.objectname.value(''.'', ''nvarchar(100)'') As ObjectName
	FROM @xml_data.nodes(''/Object/@ObjectName'')  objects(objectname)
);' 
END
GO
/****** Object:  Table [dbo].[DatabasePermission]    Script Date: 07/13/2008 21:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatabasePermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DatabasePermission](
	[PermissionState] [varchar](255) NULL,
	[members] [xml] NULL,
	[Server] [varchar](255) NULL,
	[dbname] [varchar](255) NULL,
	[Grantee] [varchar](255) NULL,
	[PermissionType] [varchar](255) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DatabasePermission]') AND name = N'IX_DatabasePermission')
CREATE CLUSTERED INDEX [IX_DatabasePermission] ON [dbo].[DatabasePermission] 
(
	[timestamp] ASC,
	[Server] ASC,
	[dbname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_DatabasePermission]    Script Date: 07/13/2008 21:29:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_DatabasePermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_DatabasePermission]
	@timestamp datetime,
	@Server varchar(255) = ''ALL'',
	@dbname  varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_DatabasePermissionMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

IF @dbname <> ''ALL''
SELECT @sql = @sql + '' AND dbname = @xdbname''

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255),
                     @xdbname    varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server, @dbname
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DatabaseRole]    Script Date: 07/13/2008 21:29:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_DatabaseRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_DatabaseRole]
	@timestamp datetime,
	@Server varchar(255) = ''ALL'',
	@dbname  varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_DatabaseRoleMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

IF @dbname <> ''ALL''
SELECT @sql = @sql + '' AND dbname = @xdbname''

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255),
                     @xdbname    varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server, @dbname
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Login]    Script Date: 07/13/2008 21:30:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_Login]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_Login]
	@timestamp datetime,
	@Server varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_LoginMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ObjectPermission]    Script Date: 07/13/2008 21:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ObjectPermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ObjectPermission]
	@timestamp datetime,
	@Server varchar(255) = ''ALL'',
	@dbname  varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_ObjectPermissionMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

IF @dbname <> ''ALL''
SELECT @sql = @sql + '' AND dbname = @xdbname''

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255),
                     @xdbname    varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server, @dbname
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ServerPermission]    Script Date: 07/13/2008 21:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ServerPermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ServerPermission]
	@timestamp datetime,
	@Server varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_ServerPermissionMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ServerRole]    Script Date: 07/13/2008 21:30:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ServerRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ServerRole]
	@timestamp datetime,
	@Server varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_ServerRoleMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SqlUser]    Script Date: 07/13/2008 21:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SqlUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_SqlUser]
	@timestamp datetime,
	@Server varchar(255) = ''ALL'',
	@dbname  varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_SqlUserMember
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

IF @dbname <> ''ALL''
SELECT @sql = @sql + '' AND dbname = @xdbname''

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255),
                     @xdbname    varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server, @dbname
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SqlUserOwnedObject]    Script Date: 07/13/2008 21:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_SqlUserOwnedObject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_SqlUserOwnedObject]
	@timestamp datetime,
	@Server varchar(255) = ''ALL'',
	@dbname  varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.vw_SqlUserOwnedObject
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

IF @dbname <> ''ALL''
SELECT @sql = @sql + '' AND dbname = @xdbname''

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255),
                     @xdbname    varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server, @dbname
' 
END
GO
/****** Object:  Table [dbo].[SqlServer]    Script Date: 07/13/2008 21:30:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SqlServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SqlServer](
	[Server] [varchar](255) NOT NULL,
	[IsEnabled] [bit] NOT NULL CONSTRAINT [DF__SqlServer__IsEnabled]  DEFAULT ((1)),
 CONSTRAINT [PK_SqlServer] PRIMARY KEY CLUSTERED 
(
	[Server] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_LinkedServerLogin]    Script Date: 07/13/2008 21:30:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_LinkedServerLogin]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_LinkedServerLogin]
	@timestamp datetime,
	@Server varchar(255) = ''ALL''
AS

SET NOCOUNT ON
DECLARE @sql        nvarchar(4000),
        @paramlist  nvarchar(4000)

SELECT @sql = ''SELECT * FROM dbo.SqlLinkedServerLogin
WHERE timestamp = @xtimestamp''

IF @Server <> ''ALL''
SELECT @sql = @sql + '' AND Server = @xServer'' 

SELECT @paramlist = ''@xtimestamp   datetime,
                     @xServer  varchar(255)''

EXEC sp_executesql @sql, @paramlist, @timestamp, @Server
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_del_LinkedServerLogin]    Script Date: 07/13/2008 21:30:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_LinkedServerLogin]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_LinkedServerLogin]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.SqlLinkedServerLogin
GROUP BY timestamp
)
DELETE dbo.SqlLinkedServerLogin WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  Table [dbo].[SqlLinkedServerLogin]    Script Date: 07/13/2008 21:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SqlLinkedServerLogin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SqlLinkedServerLogin](
	[Server] [varchar](255) NULL,
	[timestamp] [datetime] NULL,
	[LinkedServer] [varchar](255) NULL,
	[DataSource] [varchar](255) NULL,
	[Impersonate] [bit] NULL,
	[Name] [varchar](255) NULL,
	[RemoteUser] [varchar](255) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SqlLinkedServerLogin]') AND name = N'IX_SqlLinkedServerLogin')
CREATE CLUSTERED INDEX [IX_SqlLinkedServerLogin] ON [dbo].[SqlLinkedServerLogin] 
(
	[timestamp] ASC,
	[Server] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_del_ServerPermission]    Script Date: 07/13/2008 21:30:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_ServerPermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_ServerPermission]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.ServerPermission
GROUP BY timestamp
)
DELETE dbo.ServerPermission WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  View [dbo].[vw_ServerPermissionMember]    Script Date: 07/13/2008 21:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ServerPermissionMember]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ServerPermissionMember]
AS
SELECT [PermissionState], [Server], [Grantee], [PermissionType], [timestamp], [member]
FROM dbo.ServerPermission p
CROSS APPLY dbo.ufn_GetMember(p.members)'
GO
/****** Object:  View [dbo].[vw_ServerRoleMember]    Script Date: 07/13/2008 21:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ServerRoleMember]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ServerRoleMember]
AS
SELECT [Server], [Name], [timestamp], [member]
FROM dbo.ServerRole r
CROSS APPLY dbo.ufn_GetMember(r.members)'
GO
/****** Object:  StoredProcedure [dbo].[usp_del_ServerRole]    Script Date: 07/13/2008 21:30:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_ServerRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_ServerRole]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.ServerRole
GROUP BY timestamp
)
DELETE dbo.ServerRole WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_del_SqlUser]    Script Date: 07/13/2008 21:30:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_SqlUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_SqlUser]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.SqlUser
GROUP BY timestamp
)
DELETE dbo.SqlUser WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  View [dbo].[vw_SqlUserMember]    Script Date: 07/13/2008 21:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SqlUserMember]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_SqlUserMember]
AS
SELECT [LoginType], [Server], [dbname], [Login], [timestamp], [member]
FROM dbo.SqlUser u
CROSS APPLY dbo.ufn_GetMember(u.members)'
GO
/****** Object:  View [dbo].[vw_SqlUserOwnedObject]    Script Date: 07/13/2008 21:30:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SqlUserOwnedObject]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_SqlUserOwnedObject]
AS
SELECT [LoginType], [Server], [dbname], [Login], [timestamp], [ObjectType], [ObjectName]
FROM dbo.SqlUser u
CROSS APPLY dbo.ufn_GetObjectType(u.objects)
CROSS APPLY dbo.ufn_GetObjectName(u.objects)'
GO
/****** Object:  View [dbo].[vw_ObjectPermissionMember]    Script Date: 07/13/2008 21:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ObjectPermissionMember]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ObjectPermissionMember]
AS
SELECT [ObjectClass], [ColumnName], [PermissionState],[Server], [dbname], [Grantee], [PermissionType]
, [ObjectSchema], [ObjectName], [timestamp], [member]
FROM dbo.ObjectPermission p
CROSS APPLY dbo.ufn_GetMember(p.members)'
GO
/****** Object:  StoredProcedure [dbo].[usp_del_ObjectPermission]    Script Date: 07/13/2008 21:30:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_ObjectPermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_ObjectPermission]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.ObjectPermission
GROUP BY timestamp
)
DELETE dbo.ObjectPermission WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_del_DatabaseRole]    Script Date: 07/13/2008 21:30:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_DatabaseRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_DatabaseRole]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.DatabaseRole
GROUP BY timestamp
)
DELETE dbo.DatabaseRole WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  View [dbo].[vw_DatabaseRoleMember]    Script Date: 07/13/2008 21:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_DatabaseRoleMember]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_DatabaseRoleMember]
AS
SELECT [IsFixedRole], [Server], [dbname], [Name], [timestamp], [member]
FROM dbo.DatabaseRole r
CROSS APPLY dbo.ufn_GetMember(r.members)'
GO
/****** Object:  View [dbo].[vw_LoginMember]    Script Date: 07/13/2008 21:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LoginMember]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LoginMember]
AS
SELECT [LoginType], [Server], [Name], [timestamp], [member]
FROM dbo.Login AS l
CROSS APPLY dbo.ufn_GetMember(l.members)'
GO
/****** Object:  StoredProcedure [dbo].[usp_del_Login]    Script Date: 07/13/2008 21:30:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_Login]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_Login]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.Login
GROUP BY timestamp
)
DELETE dbo.Login WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  View [dbo].[vw_DatabasePermissionMember]    Script Date: 07/13/2008 21:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_DatabasePermissionMember]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_DatabasePermissionMember]
AS
SELECT [PermissionState], [Server], [dbname], [Grantee], [PermissionType], [timestamp], [member]
FROM dbo.DatabasePermission p
CROSS APPLY dbo.ufn_GetMember(p.members)'
GO
/****** Object:  StoredProcedure [dbo].[usp_del_DatabasePermission]    Script Date: 07/13/2008 21:29:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_del_DatabasePermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_del_DatabasePermission]
@histSize int = 3
AS
WITH nthlargest
AS
(
SELECT  timestamp,RANK() OVER (ORDER BY timestamp DESC) AS ''nth''
FROM dbo.DatabasePermission
GROUP BY timestamp
)
DELETE dbo.DatabasePermission WHERE timestamp <= 
(SELECT timestamp FROM nthlargest WHERE nth = @histSize);

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedLogin]    Script Date: 07/13/2008 21:29:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedLogin]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedLogin]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT Server, Name, member
	FROM dbo.vw_LoginMember
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT Server, Name, member
	FROM dbo.vw_LoginMember
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT Server, Name, member
	FROM dbo.vw_LoginMember
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT Server, Name, member
	FROM dbo.vw_LoginMember
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedDatabasePermission]    Script Date: 07/13/2008 21:30:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedDatabasePermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedDatabasePermission]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT PermissionState, Server, dbname, Grantee, PermissionType, member
	FROM dbo.vw_DatabasePermissionMember
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT PermissionState, Server, dbname, Grantee, PermissionType, member
	FROM dbo.vw_DatabasePermissionMember
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT PermissionState, Server, dbname, Grantee, PermissionType, member
	FROM dbo.vw_DatabasePermissionMember
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT PermissionState, Server, dbname, Grantee, PermissionType, member
	FROM dbo.vw_DatabasePermissionMember
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedDatabaseRole]    Script Date: 07/13/2008 21:29:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedDatabaseRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedDatabaseRole]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT Server, dbname, Name, member
	FROM dbo.vw_DatabaseRoleMember
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT Server, dbname, Name, member
	FROM dbo.vw_DatabaseRoleMember
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT Server, dbname, Name, member
	FROM dbo.vw_DatabaseRoleMember
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT Server, dbname, Name, member
	FROM dbo.vw_DatabaseRoleMember
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedObjectPermission]    Script Date: 07/13/2008 21:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedObjectPermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedObjectPermission]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT Server, dbname, Grantee, PermissionState, PermissionType, ObjectSchema, ObjectName, ColumnName, member
	FROM dbo.vw_ObjectPermissionMember
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT Server, dbname, Grantee, PermissionState, PermissionType, ObjectSchema, ObjectName, ColumnName, member
	FROM dbo.vw_ObjectPermissionMember
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT Server, dbname, Grantee, PermissionState, PermissionType, ObjectSchema, ObjectName, ColumnName, member
	FROM dbo.vw_ObjectPermissionMember
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT Server, dbname, Grantee, PermissionState, PermissionType, ObjectSchema, ObjectName, ColumnName, member
	FROM dbo.vw_ObjectPermissionMember
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedServerPermission]    Script Date: 07/13/2008 21:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedServerPermission]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedServerPermission]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT Server, PermissionState, Grantee, PermissionType, member
	FROM dbo.vw_ServerPermissionMember
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT Server, PermissionState, Grantee, PermissionType, member
	FROM dbo.vw_ServerPermissionMember
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT Server, PermissionState, Grantee, PermissionType, member
	FROM dbo.vw_ServerPermissionMember
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT Server, PermissionState, Grantee, PermissionType, member
	FROM dbo.vw_ServerPermissionMember
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedServerRole]    Script Date: 07/13/2008 21:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedServerRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedServerRole]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT Server, Name, member
	FROM dbo.vw_ServerRoleMember
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT Server, Name, member
	FROM dbo.vw_ServerRoleMember
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT Server, Name, member
	FROM dbo.vw_ServerRoleMember
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT Server, Name, member
	FROM dbo.vw_ServerRoleMember
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedSqlUser]    Script Date: 07/13/2008 21:29:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedSqlUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedSqlUser]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT Server, dbname, Login, member
	FROM dbo.vw_SqlUserMember
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT Server, dbname, Login, member
	FROM dbo.vw_SqlUserMember
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT Server, dbname, Login, member
	FROM dbo.vw_SqlUserMember
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT Server, dbname, Login, member
	FROM dbo.vw_SqlUserMember
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;

' 
END
GO
/****** Object:  View [dbo].[vw_SqlUserDistinctServerdbname]    Script Date: 07/13/2008 21:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SqlUserDistinctServerdbname]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_SqlUserDistinctServerdbname]
AS
SELECT DISTINCT member, Server + ''.'' + dbname AS Serverdbname
FROM dbo.vw_SqlUserMember'
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangedSqlUserOwnedObject]    Script Date: 07/13/2008 21:29:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_ChangedSqlUserOwnedObject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_ChangedSqlUserOwnedObject]
@captureDT1 datetime, @captureDT2 datetime
AS
SET NOCOUNT ON
IF @captureDT1 > @captureDT2
BEGIN
	RAISERROR (''@captureDT1 is Greater Than @captureDT2'',16,1)
END;

WITH Added AS
(
	SELECT Server, dbname, Login, ObjectName
	FROM dbo.vw_SqlUserOwnedObject
	WHERE timestamp = @captureDT2
	EXCEPT 
	SELECT Server, dbname, Login, ObjectName
	FROM dbo.vw_SqlUserOwnedObject
	WHERE timestamp = @captureDT1
),
Removed AS
(
	SELECT Server, dbname, Login, ObjectName
	FROM dbo.vw_SqlUserOwnedObject
	WHERE timestamp = @captureDT1
	EXCEPT 
	SELECT Server, dbname, Login, ObjectName
	FROM dbo.vw_SqlUserOwnedObject
	WHERE timestamp = @captureDT2
)
SELECT *, ''Added'' AS ChangeType FROM Added
UNION
SELECT *, ''Removed'' AS ChangeType FROM Removed;

' 
END
GO
