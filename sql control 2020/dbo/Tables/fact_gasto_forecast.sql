CREATE TABLE [dbo].[fact_gasto_forecast] (
    [id]             NVARCHAR (255) NOT NULL,
    [Fecha Registro] DATETIME       NOT NULL,
    [Fecha Contable] DATE           NOT NULL,
    [cuenta]         NVARCHAR (50)  NOT NULL,
    [texto]          NVARCHAR (MAX) NULL,
    [ceco]           NVARCHAR (50)  NULL,
    [moneda]         NVARCHAR (3)   NOT NULL,
    [monto]          MONEY     NOT NULL,
    [monto usd]      MONEY     NOT NULL,
    [prv_id]         NVARCHAR (50)  NULL,
    [usr]            NVARCHAR (50)  NULL,
    [id_ppto]        NVARCHAR (50)  NULL,
    CONSTRAINT [PK_fact_gasto_forecast] PRIMARY KEY CLUSTERED ([id] ASC)
);

