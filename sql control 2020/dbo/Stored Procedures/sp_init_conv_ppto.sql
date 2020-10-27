-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 30-04-2020
-- Description:	Carga los tipos de cambio de ppto
-- =============================================
CREATE PROCEDURE [dbo].[sp_init_conv_ppto] 
	-- Add the parameters for the stored procedure here
	--@p1 int = 0, 
	--@p2 int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT @p1, @p2
	exec sp_init_hierarchy 'RAIZ.conv'
	exec sp_init_hierarchy 'RAIZ.conv.ppto'
	
	insert into dim_jerarquias (id)
		select
			'RAIZ.conv.ppto.'+left(v.version,3) id
		from
			view_versiones_ppto v
			
	--insert into dim_jerarquias (id)
	--	select
	--		'RAIZ.conv.ppto.'+v.version id
	--	from
	--		view_versiones_ppto v
	
	insert into dim_jerarquias (id, xml_data)
		select
			c.id,
			c.xml_data
		from
			[PMO 2020 Ppto PRD].dbo.dim_jerarquias c
		where
			c.id like 'RAIZ.conv.%'
			and c.level>=4
			and LEFT(REPLACE(c.id,'RAIZ.conv.ppto.',''), 6) in
				(select v.version from view_versiones_ppto v)
	
END