-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-11-19
-- Description:	Inicializa proyectos que vienen del presupuesto
-- =============================================
CREATE PROCEDURE [dbo].[sp_init_proyectos] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	exec sp_init_hierarchy 'RAIZ.pry';
	insert into dim_jerarquias(id,xml_data)
	select
		p.id,
		p.xml_data
	from
		[PMO 2020 Ppto PRD].dbo.dim_jerarquias p
	where
		p.id like 'RAIZ.pry.%';
END
