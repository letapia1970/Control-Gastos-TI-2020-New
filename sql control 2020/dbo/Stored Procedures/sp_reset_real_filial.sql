-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-12-27
-- Description:	Borra gasto real triangulado
-- =============================================
CREATE PROCEDURE [dbo].[sp_reset_real_filial] 
	-- Add the parameters for the stored procedure here
	@year as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--delete
	--from
	-- fact_gasto_real
	--where
	-- LEFT(id,1)='{'
	-- and YEAR([Fecha Contable])>=@year

	delete 
	from 
	 fact_gasto_real
	where
	  YEAR([Fecha Contable])>=@year
	 and LEFT(id,1)<>'{' -- <- No es Directo
END
