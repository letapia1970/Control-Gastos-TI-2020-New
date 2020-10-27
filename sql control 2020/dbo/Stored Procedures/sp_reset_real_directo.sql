-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-12-26
-- Description:	Borra gasto real del año
-- =============================================
CREATE PROCEDURE [sp_reset_real_directo] 
	-- Add the parameters for the stored procedure here
	@year as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete
	from
	 fact_gasto_real
	where
	 LEFT(id,1)='{'
	 and YEAR([Fecha Contable])>=@year

	delete
	from
	 fact_cobro_real
	where
	  [directo]='D'
	 and year([fecha])>=@year
END