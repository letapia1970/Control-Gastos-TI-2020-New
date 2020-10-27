CREATE TABLE [dbo].[dim_jerarquias] (
    [id]        NVARCHAR (255) NOT NULL,
    [level]     AS             (len([id])-len(replace([id],'.',''))),
    [xml_data]  XML            NULL,
    [node]      AS             (case when (len([id])-len(replace([id],'.','')))=(0) then NULL else reverse(substring(reverse([id]),(1),charindex('.',reverse([id]))-(1))) end),
    [id_parent] AS             (case when (len([id])-len(replace([id],'.','')))<=(1) then NULL else reverse(right(reverse([id]),len([id])-charindex('.',reverse([id])))) end),
    CONSTRAINT [PK_dim_jerarquias_1] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_opt]
    ON [dbo].[dim_jerarquias]([id] ASC)
    INCLUDE([node], [id_parent]);

