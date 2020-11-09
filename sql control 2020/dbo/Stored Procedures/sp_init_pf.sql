-- =============================================
-- Author:		Luis Tapia Peralta
-- Create date: 23-07-2019
-- Description:	Carga peridoos de facturación a tabla
-- =============================================
CREATE PROCEDURE [dbo].[sp_init_pf] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET DATEFORMAT 'YMD';
    delete from dim_periodos_facturacion;
	insert into dim_periodos_facturacion (periodo,desde,hasta)
		select * from view_periodos_facturacion;
END
