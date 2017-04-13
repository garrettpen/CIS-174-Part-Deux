CREATE TABLE [dbo].[expense]
(
	[expenseId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [userName] VARCHAR(50) NOT NULL,
	[expCategory] VARCHAR(50) NOT NULL, 
    [expName] VARCHAR(50) NOT NULL, 
    [expAmount] DECIMAL(18, 2) NOT NULL, 
    CONSTRAINT FK_expenseUser FOREIGN KEY ([userName]) REFERENCES userData([userName])
)
