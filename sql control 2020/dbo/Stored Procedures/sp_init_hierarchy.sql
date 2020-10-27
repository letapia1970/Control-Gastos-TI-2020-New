-- =============================================
-- Author:		Luis Tapia (CMPC TI)
-- Create date: 02/08/2019 11:56:30
-- Description:	Inicializa una jerarquía
-- =============================================
CREATE PROCEDURE [dbo].[sp_init_hierarchy] 
	-- Add the parameters for the stored procedure here
	@id nvarchar(50) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		delete
		from
			dim_jerarquias
		where
			--hid.IsDescendantOf(dbo.id2hid(@id))=1
			id like @id +'%'
	
	begin transaction
		exec dbo.sp_Add_Node @id,null
	commit
	
END
