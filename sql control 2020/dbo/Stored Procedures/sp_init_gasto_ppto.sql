-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-11-13
-- Description:	Carga inicial de los presupuestos de años anteriores
-- =============================================
CREATE PROCEDURE [dbo].[sp_init_gasto_ppto] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    
    delete from fact_gasto_ppto;
    
	insert into 
		fact_gasto_ppto (
			origen_id,
			version,
			partida,
			item,
			detalle,
			unidad,
			unidad_control,
			moneda,
			fecha,
			monto,
			monto_usd,
			prv_id,
			cuenta_id,
			origen_fuente,
			responsable,
			creado_por,
			modificado_por,
			proyecto,
			id_app,
			categoria,
			Fijo		)
(
		select 
				origen_id,
				version,
				partida,
				item,
				detalle,
				unidad,
				unidad_control,
				moneda,
				fecha,
				monto,
				[monto usd],
				prv_id,
				cuenta_id,
				origen_fuente,
				responsable,
				creado_por,
				modificado_por,
				proyecto,
				id_app,
				gp.id_cat,
				gp.Fijo
			from
				[PMO 2020 Ppto PRD].dbo.v_gasto_ppto gp
			where
				gp.version in (
					select
						Value
					from
						dbo.Split(
							(
							select
								p.value
							from
								view_param p
							where
								p.param='ver_gasto'
							)
							,','
						)
				)
union all
/* Ppto Softys v20.08 2020-01-03*/
		select 
				origen_id,
				version,
				partida,
				item,
				detalle,
				unidad,
				unidad_control,
				moneda,
				fecha,
				monto,
				[monto usd],
				prv_id,
				cuenta_id,
				origen_fuente,
				responsable,
				creado_por,
				modificado_por,
				proyecto,
				id_app,
				gp.id_cat,
				gp.Fijo
			from
				[PMO 2020 Ppto PRD].dbo.v_gasto_ppto gp
			where
				gp.version ='v20.08'
				and gp.id_org like 'RAIZ.org.T.%'
				
		
				
)				;
END