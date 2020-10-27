CREATE TABLE [dbo].[fact_gasto_real] (
    [id]             NVARCHAR (255) NOT NULL,
    [Fecha Registro] DATETIME       NOT NULL,
    [Fecha Contable] DATE           NOT NULL,
    [cuenta]         NVARCHAR (50)  NOT NULL,
    [texto]          NVARCHAR (MAX) NULL,
    [orden]          NVARCHAR (50)  NULL,
    [pep]            NVARCHAR (50)  NULL,
    [ceco]           NVARCHAR (50)  NULL,
    [moneda]         NVARCHAR (3)   NOT NULL,
    [monto]          MONEY     NOT NULL,
    [monto usd]      MONEY     NOT NULL,
    [prv_id]         NVARCHAR (50)  NULL,
    [usr]            NVARCHAR (50)  NULL,
    [pedido]         NVARCHAR (50)  NULL,
    [HAS]            NVARCHAR (50)  NULL,
    [Estrategia]     NVARCHAR (10)  NULL,
    [factura]        NVARCHAR (50)  NULL,
    CONSTRAINT [PK_fact_gasto_real] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_fact_gasto_real]
    ON [dbo].[fact_gasto_real]([Fecha Registro] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Usuario que registra el gasto', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'fact_gasto_real', @level2type = N'COLUMN', @level2name = N'usr';

