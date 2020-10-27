


CREATE VIEW [dbo].[view_gasto_ppto_softys]
AS
/******************************* Vista Gasto Ppto *******************/
SELECT
  GUID,
  origen_id,
  version,
  partida,
  item,
  detalle,
  gp.unidad,
  cc.id id_control,
  gp.unidad_control,
  moneda,
  fecha,
  monto,
  ISNULL(gp.prv_id,'RAIZ.prv.SP') prv_id,
  cuenta_id,
  --directo,
  origen_fuente,
  responsable,
  creado_por,
  modificado_por,
  ISNULL(gp.proyecto,'SP') proyecto,
  monto_usd,
  isnull(org.id,soc_cecos.id) [id org],
    /****************** NUEVA ORG COBRO ******************/
  --(CASE
  --  WHEN org2.id IS NULL THEN
  --    (
  --      SELECT
  --        soc.id
  --      FROM view_org_cobro soc
  --          LEFT OUTER JOIN
  --            (
		--		VALUES 
		--			('CL', '1'), 
		--			('AR', '2'), 
		--			('PE', '3'), 
		--			('UY', '4'), 
		--			('BR', '5'), 
		--			('MX', '6'), 
		--			('EC', 'EC'), 
		--			('CO', 'CO')
		--		) pais (p_in, p_out)
  --              ON pais.p_in = SUBSTRING(gp.unidad, 2, 2)
  --      WHERE 
		--	soc.node = pais.p_out + SUBSTRING(gp.unidad, 4, 2)
		--)
  --  ELSE
  --    org2.id
  --END) [id org2],    
    /****************** NUEVA ORG COBRO ******************/
  
  --dir.id [id directo],
  ISNULL(org.directo,'D') [id directo],
  'RAIZ.partidas.' + REPLACE(gp.version,'.','-') + '.' + gp.origen_id [id partida],
  --pry.[id proyecto],
  isnull(ctas_01.id,'RAIZ.ctas.g01.OTROS.UKN') [id cuenta],
  ISNULL(ctas_02.id,'RAIZ.ctas.g02.ARR') [id cuenta2],
  
  CASE
    WHEN SUBSTRING(gp.origen_fuente, 1, 14)
      = '/Ppto/Filiales' THEN
      'FIL'
    ELSE
      'CORP'
  END Tipo,
  gp.categoria
  
  --dcta.id [id_dcta]
  
FROM fact_gasto_ppto gp
    LEFT OUTER JOIN
      view_org org
        ON org.node = gp.unidad
    left outer join view_org_soc_cecos soc_cecos
		on soc_cecos.ceco=gp.unidad
 --   LEFT OUTER JOIN
 --     view_directo dir
 --       ON dir.node =
 --                    CASE
 --                      WHEN CHARINDEX('.TI.', org.id) <> 0 THEN
 --                        'C'
 --                      ELSE
 --                        gp.directo
 --                    END
 --   /****************** NUEVA ORG COBRO ******************/
 --   LEFT OUTER JOIN
 --     view_org_cobro org2
 --       ON gp.unidad = org2.node
 --   /****************** NUEVA ORG COBRO ******************/
 --   LEFT OUTER JOIN
 --     view_proyectos pry
 --       ON ISNULL('RAIZ.pry.' + gp.proyecto,'RAIZ.pry.SP') = pry.[id proyecto]
    LEFT OUTER JOIN
      view_ctas_g01 ctas_01
        ON gp.cuenta_id = ctas_01.[cuenta nro]
    LEFT OUTER JOIN
      view_ctas_g02 ctas_02
        ON gp.cuenta_id = ctas_02.[cuenta nro]
 --   LEFT OUTER JOIN
 --     view_proveedores prv
 --       ON prv.id = gp.prv_id
	
	left outer join 
		view_cecos_control cc
			on gp.unidad_control = cc.node
			
	--left outer join 
	--	view_d_cta dcta
	--		on dcta.id = 'RAIZ.dcta.' +
	--		     case
	--				when gp.directo ='C' then 'C.' +REPLACE(ctas_02.id,'RAIZ.ctas.g02.','')
	--				else 'D.'+REPLACE(ctas_01.id,'RAIZ.ctas.g01.','')
	--		     end

/****************************************
 * 2020-03-01 Filtra versión especial de Softys
 ************************************************/
where
	gp.version='v20.08'
	--and org.id like 'RAIZ.org.T.%'