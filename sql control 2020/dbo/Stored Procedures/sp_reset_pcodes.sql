-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-12-26
-- Description:	Borra definición de proyectos en curso
-- =============================================
CREATE PROCEDURE sp_reset_pcodes 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete--select *
	from
		view_proyectos
	where
			[id proyecto]<>'SP'
		and CHARINDEX('-',[id proyecto])>2
END