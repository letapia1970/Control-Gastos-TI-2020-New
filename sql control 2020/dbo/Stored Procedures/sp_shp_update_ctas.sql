CREATE PROCEDURE [dbo].[sp_shp_update_ctas]
	--@param1 int = 0,
	--@param2 int
AS
update dim_jerarquias
set id='RAIZ.ctas.g01.'+g01.valor+'.'+ctas.node
from
	dim_jerarquias ctas
		left outer join lookup_shp('ctas_g01') g01
			on g01.spid=LEFT(
							REPLACE(ctas.id,'RAIZ.ctas.g01.',''),
							CHARINDEX('.',REPLACE(ctas.id,'RAIZ.ctas.g01.',''))-1		
						)
where
	ctas.id like 'RAIZ.ctas.g01.%'
	and LEN(node)=10


update dim_jerarquias
set id='RAIZ.ctas.g02.'+g02.valor+'.'+ctas.node
from
	dim_jerarquias ctas
		left outer join lookup_shp('ctas_g02') g02
			on g02.spid=LEFT(
							REPLACE(ctas.id,'RAIZ.ctas.g02.',''),
							CHARINDEX('.',REPLACE(ctas.id,'RAIZ.ctas.g02.',''))-1		
						)
where
	ctas.id like 'RAIZ.ctas.g02.%'
	and LEN(node)=10
RETURN 0
