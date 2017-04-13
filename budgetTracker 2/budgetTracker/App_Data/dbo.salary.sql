CREATE TABLE [dbo].[salary] (
    [salaryId] INT             IDENTITY (1, 1) NOT NULL,
    [userName] VARCHAR (50)    NOT NULL,
    [salaryAmount]   DECIMAL (18, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([salaryId] ASC),
    CONSTRAINT [FK_salaryUser] FOREIGN KEY ([userName]) REFERENCES [dbo].[userData] ([userName])
);

