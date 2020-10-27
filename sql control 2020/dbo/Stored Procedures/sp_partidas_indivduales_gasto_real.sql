-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2020-06-09
-- Description:	Movimientos de Gasto Real para una Fecha de Facturación
-- =============================================
CREATE PROCEDURE [dbo].[sp_partidas_indivduales_gasto_real] 
	-- Add the parameters for the stored procedure here
	@period date = '2020-01-01'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
	  --id,
	  [Fecha Registro],
	  [Fecha Contable],
	  --[Fecha Facturación],
	  gr.cuenta,
	  texto,
	  --orden,
	  pep,
	  ceco,
	  moneda,
	  monto,
	  [monto usd],
	  gr.prv_id,
	  usr,
	  [id org],
	  [id directo],
	  [id cuenta],
	  [id cuenta2],
	  Registro,
	  pry.proyecto proyecto,
	  --proyecto,
	  id_control,
	  [moneda cobro],
	  [monto cobro],
	  pedido,
	  HAS,
	  Estrategia,
	  [monto usd efecto],
	  cta.cuenta [cta titulo],
	  prv.proveedor,
	  org.id org_id,
	  org.nombre org_nombre,
	  org.tipo org_tipo,
	  org.id_parent org_id_parent,
	  org.unidad org_unidad,
	  org.sociedad org_sociedad,
	  org.negocio org_negocio
	  
	FROM 
		view_gasto_real AS gr
			left outer join view_ctas_g01 cta
				on gr.[id cuenta] = cta.id
				
			left outer join view_proveedores prv
				on gr.prv_id = prv.id
			
			left outer join view_org org
				on gr.[id org] = org.id	
				
			left outer join view_proyectos pry
				on gr.proyecto = pry.[id proyecto]
where
	gr.[Fecha Facturación]=@period
	and gr.[id directo] ='F'
	
END