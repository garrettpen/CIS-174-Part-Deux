﻿CREATE TABLE [dbo].[userData] (
    [userName] VARCHAR (50) NOT NULL,
    [password] VARCHAR (50) NOT NULL,
    [email]    VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([userName])
);
