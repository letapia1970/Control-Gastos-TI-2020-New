-- =============================================
-- Author:		Lusi Tapia (CMPC TIC)
-- Create date: 11-mar-2019
-- Description:	Crea una jerarquia D + cta para reportes
-- =============================================
CREATE PROCEDURE [dbo].[sp_crea_D_ctas] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	exec sp_init_hierarchy 'RAIZ.dcta'
	
	insert into dim_jerarquias (id,xml_data)
	select
		'RAIZ.dcta.'+ id,
		'<node><nombre>' + nombre + '</nombre></node>'
	from
		(
		values
			('D','Directo'),
			('C','Compartido')
		) directos (id,nombre)
	

	INSERT INTO dim_jerarquias (id,xml_data)

	select
		N'RAIZ.dcta.C.' + REPLACE(c.id,'RAIZ.ctas.g02.',''),
		'<node><nombre>'+c.nombre+'</nombre></node>'
	from
		view_ctas_g02 c
	where
		c.[cuenta nro] is null

	union all	

	select
		N'RAIZ.dcta.D.' + REPLACE(c.id,'RAIZ.ctas.g01.',''),
		'<node><nombre>'+c.nombre+'</nombre></node>'
	from
		view_ctas_g01 c
	where
		c.[cuenta nro] is null
		
	

	INSERT INTO dim_jerarquias (id,xml_data)
	select
		distinct
		'RAIZ.dcta.'+
		case 
			when gp.[id directo]='C' then 'C.' +  REPLACE(gp.[id cuenta2],'RAIZ.ctas.g02.','')
			else 'D.' + replace(gp.[id cuenta],'RAIZ.ctas.g01.','')
		end [id],
		'<node><nombre>' + 
			case
				when gp.[id directo]='C' then c2.nombre
				else c1.nombre
			end
			+
		'</nombre></node>'
		
	from
		view_gasto_ppto gp
			left outer join view_ctas_g01 c1
				on gp.cuenta_id=c1.[cuenta nro]
			left outer join  view_ctas_g02 c2
				on gp.cuenta_id=c2.[cuenta nro]
	--where
	--	gp.fecha>='2019-01-01'
	order by
		'RAIZ.dcta.'+
		case 
			when gp.[id directo]='C' then 'C.' +  REPLACE(gp.[id cuenta2],'RAIZ.ctas.g02.','')
			else 'D.' + replace(gp.[id cuenta],'RAIZ.ctas.g01.','')
		end    
    -- Insert statements for procedure here
END
