-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2020-05-06
-- Description:	Actualiza el monto en USD con tipos de cambio de forecast
-- =============================================
CREATE PROCEDURE sp_update_forecast 
	-- Add the parameters for the stored procedure here
	--@p1 int = 0, 
	--@p2 int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	exec sp_shp_update_forecast

	update
		fact_gasto_forecast
	set
		[monto usd]= gf.monto /
			(
			case gf.moneda 
				when 'USD' then 1
				else cf.factor
			end 
			)	
	from
		fact_gasto_forecast gf
			left outer join view_conv_fcast cf
				on cf.id = 'RAIZ.conv.fcast.' + gf.moneda+'/USD.'+CONVERT(nvarchar(6),gf.[Fecha Contable],112)+'01'
END