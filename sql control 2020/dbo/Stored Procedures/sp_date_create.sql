-- =============================================
-- Author:		Luis Tapia
-- Create date: 09-feb-2018
-- Description:	Genera fechas
-- =============================================
CREATE PROCEDURE [dbo].[sp_date_create] 
	-- Add the parameters for the stored procedure here
	@date_from date = null, 
	@date_to date = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	exec sp_init_hierarchy 'RAIZ.fechas';
	

	WITH sample AS 
		( 
		  SELECT @date_from AS dt
		  UNION ALL
		  SELECT DATEADD(dd, 1, dt)
			FROM sample s
		   WHERE DATEADD(dd, 1, dt) <= @date_to
		)
		
	insert into dim_jerarquias (id)
		
	SELECT 
		('RAIZ.fechas.' + cast(dt as nvarchar(10))) as [fec_key]
	FROM sample
	option (maxrecursion 15000)
END
