
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/27/2015 17:10:29
-- Generated from EDMX file: D:\GitSource\OnBoard\ServerCode\OnBoardService\OnBoardService\Models\Database\OnBoardModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [CoreDatabase];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_GroupUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_GroupUser];
GO
IF OBJECT_ID(N'[dbo].[FK_UserActiveData]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ActiveDatas] DROP CONSTRAINT [FK_UserActiveData];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Groups]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Groups];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[ActiveDatas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ActiveDatas];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Groups'
CREATE TABLE [dbo].[Groups] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [GroupId] int  NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ActiveDatas'
CREATE TABLE [dbo].[ActiveDatas] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Lat] float  NOT NULL,
    [Lon] float  NOT NULL,
    [StatusCode] nvarchar(max)  NOT NULL,
    [User_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Groups'
ALTER TABLE [dbo].[Groups]
ADD CONSTRAINT [PK_Groups]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ActiveDatas'
ALTER TABLE [dbo].[ActiveDatas]
ADD CONSTRAINT [PK_ActiveDatas]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [GroupId] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [FK_GroupUser]
    FOREIGN KEY ([GroupId])
    REFERENCES [dbo].[Groups]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupUser'
CREATE INDEX [IX_FK_GroupUser]
ON [dbo].[Users]
    ([GroupId]);
GO

-- Creating foreign key on [User_Id] in table 'ActiveDatas'
ALTER TABLE [dbo].[ActiveDatas]
ADD CONSTRAINT [FK_UserActiveData]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserActiveData'
CREATE INDEX [IX_FK_UserActiveData]
ON [dbo].[ActiveDatas]
    ([User_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------