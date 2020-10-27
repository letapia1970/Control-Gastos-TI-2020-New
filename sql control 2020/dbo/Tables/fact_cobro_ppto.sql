CREATE TABLE [dbo].[fact_cobro_ppto] (
    [GUID]               UNIQUEIDENTIFIER CONSTRAINT [DF_fact_cobro_ppto_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [version]            NVARCHAR (50)    NOT NULL,
    [unidad]             NVARCHAR (50)    NOT NULL,
    [directo]            NVARCHAR (1)     NOT NULL,
    [fecha]              DATE             NOT NULL,
    [moneda]             NVARCHAR (3)     NOT NULL,
    [monto]              FLOAT (53)       NOT NULL,
    [monto usd]          FLOAT (53)       NOT NULL,
    [cuenta]             NVARCHAR (50)    NOT NULL,
    [origen_fuente]      NVARCHAR (MAX)   NULL,
    [origen_id]          NVARCHAR (50)    NULL,
    [proyecto]           NVARCHAR (50)    NULL,
    [crece]              NCHAR (2)        NULL,
    [monto_deloitte]     FLOAT (53)       NULL,
    [monto_deloitte_usd] FLOAT (53)       NULL,
    CONSTRAINT [PK_fact_cobro_ppto] PRIMARY KEY CLUSTERED ([GUID] ASC)
);

