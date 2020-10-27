CREATE TABLE [dbo].[fact_conversion_real] (
    [clave]  NVARCHAR (50) NOT NULL,
    [fecha]  DATE          NOT NULL,
    [factor] FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_conversion_real] PRIMARY KEY CLUSTERED ([clave] ASC, [fecha] ASC)
);

