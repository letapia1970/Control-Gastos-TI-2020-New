CREATE TABLE [dbo].[fact_cobro_real] (
    [GUID]      UNIQUEIDENTIFIER CONSTRAINT [DF_fact_cobros_real_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [fecha]     DATE             NOT NULL,
    [cuenta]    NVARCHAR (50)    NOT NULL,
    [texto]     NVARCHAR (MAX)   NOT NULL,
    [monto]     FLOAT (53)       NOT NULL,
    [monto usd] FLOAT (53)       NOT NULL,
    [unidad]    NVARCHAR (50)    NULL,
    [proyecto]  NVARCHAR (50)    NULL,
    [directo]   NVARCHAR (3)     NOT NULL,
    [moneda]    NVARCHAR (3)     NOT NULL,
    [prv_id]    NVARCHAR (50)    NULL,
    CONSTRAINT [PK_fact_cobros_real] PRIMARY KEY CLUSTERED ([GUID] ASC)
);

