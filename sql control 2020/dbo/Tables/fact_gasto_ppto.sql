CREATE TABLE [dbo].[fact_gasto_ppto] (
    [GUID]              UNIQUEIDENTIFIER CONSTRAINT [DF_fact_gasto_ppto_GUID] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [origen_id]         NVARCHAR (50)    NOT NULL,
    [version]           NVARCHAR (50)    NOT NULL,
    [partida]           NVARCHAR (MAX)   NOT NULL,
    [item]              NVARCHAR (MAX)   NULL,
    [detalle]           NVARCHAR (MAX)   NULL,
    [unidad]            NVARCHAR (50)    NOT NULL,
    [unidad_control]    NVARCHAR (50)    NOT NULL,
    [moneda]            NVARCHAR (50)    NOT NULL,
    [fecha]             DATE             NOT NULL,
    [monto]             MONEY       NOT NULL,
    [monto_usd]         MONEY       NOT NULL,
    [prv_id]            NVARCHAR (50)    NULL,
    [cuenta_id]         NVARCHAR (50)    NOT NULL,
    [origen_fuente]     NVARCHAR (MAX)   NOT NULL,
    [responsable]       NVARCHAR (MAX)   NULL,
    [creado_por]        NVARCHAR (MAX)   NOT NULL,
    [modificado_por]    NVARCHAR (MAX)   NOT NULL,
    [proyecto]          NVARCHAR (50)    NULL,
    [origen_fuente_str] AS               (CONVERT([nvarchar](255),[origen_fuente],(0))),
    [id_app]            NVARCHAR (255)   NULL,
    [categoria]         NVARCHAR (255)   NULL,
    [Fijo]              NVARCHAR (50)    NULL,
    CONSTRAINT [PK_fact_gasto_ppto_1] PRIMARY KEY CLUSTERED ([GUID] ASC)
);


GO

CREATE INDEX [IX_fact_gasto_ppto_fecha] ON [dbo].[fact_gasto_ppto] ([fecha])

GO

CREATE INDEX [IX_fact_gasto_ppto_version] ON [dbo].[fact_gasto_ppto] ([version])
