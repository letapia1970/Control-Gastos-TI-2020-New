-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 15-abr-2019
-- Description:	Actualiza código de proyecto de ppto con el código real asignado por acta
-- =============================================
CREATE PROCEDURE [dbo].[sp_update_proy_code] 
	-- Add the parameters for the stored procedure here
	@ppto_code nvarchar(50) = null, 
	@new_code nvarchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- SELECT @ppto_code, @new_code
	
	/***********************************
	  1.- Borrar de la jerarquía de proyectos
	  2.- Actualizar todas las tablas de hechos (fact_*
	 ***********************************/
	delete
	from
		view_proyectos
	where
		codigo=@ppto_code
		
	update
		fact_gasto_ppto
	set
		proyecto=@new_code
	where
		proyecto=@ppto_code	
	

	update
		fact_cobro_ppto
	set
		proyecto=@new_code
	where
		proyecto=@ppto_code	
		
	update
		fact_cobro_real
	set
		proyecto=@new_code
	where
		proyecto=@ppto_code
	
END
