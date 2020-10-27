-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-11-13
-- Description:	Inicializa las jerarquías de partidas de ppto
-- =============================================
CREATE PROCEDURE [dbo].[sp_init_partidas_ppto] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	exec sp_init_hierarchy 'RAIZ.partidas';
	
	insert into dim_jerarquias (id, xml_data)
	select
		distinct
		'RAIZ.partidas.'+REPLACE(gp.version,'.','-')+'.'+ gp.origen_id id,
		(
			select
				gp_xml.version,
				gp_xml.origen_id,
				gp_xml.partida,
				gp_xml.item,
				gp_xml.detalle,
				gp_xml.origen_fuente_str origen_fuente,
				gp_xml.responsable,
				gp_xml.creado_por,
				gp_xml.modificado_por
			from
				fact_gasto_ppto gp_xml
			where
				gp.GUID=gp_xml.GUID
			for xml raw('nodes'), elements
		) xml_text
	from
		fact_gasto_ppto gp 
	where
		not gp.origen_fuente like '/Ppto/Filiales/%'
		and gp.version in (
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
					
	/*************************************************************************
	 * 2020-03-01 Carga partidas de ppto versión v20.08 de Softys
	 ***************************************************************************/
	 union all
	 select
		distinct
		'RAIZ.partidas.'+REPLACE(gp.version,'.','-')+'.'+ gp.origen_id id,
		(
			select
				gp_xml.version,
				gp_xml.origen_id,
				gp_xml.partida,
				gp_xml.item,
				gp_xml.detalle,
				gp_xml.origen_fuente_str origen_fuente,
				gp_xml.responsable,
				gp_xml.creado_por,
				gp_xml.modificado_por
			from
				fact_gasto_ppto gp_xml
			where
				gp.GUID=gp_xml.GUID
			for xml raw('nodes'), elements
		) xml_text
	from
		fact_gasto_ppto gp
			left outer join view_org org
				on org.id like 'RAIZ.org.%.'+ gp.unidad 
	where
		not gp.origen_fuente like '/Ppto/Filiales/%'
		and gp.version ='v20.08'
END