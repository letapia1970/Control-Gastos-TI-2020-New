CREATE TABLE [dbo].[dim_periodos_facturacion] (
    [periodo] DATE     NOT NULL,
    [desde]   DATE     NOT NULL,
    [hasta]   DATETIME NOT NULL,
    CONSTRAINT [PK_dim_periodos_facturacion] PRIMARY KEY CLUSTERED ([periodo] ASC)
);


GO

CREATE INDEX [IX_dim_periodos_facturacion_desde_hasta] ON [dbo].[dim_periodos_facturacion] ([desde], [hasta])
