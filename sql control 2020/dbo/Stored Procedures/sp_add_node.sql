-- =============================================
-- Author:		Lusi Tapia Peralta (CMPC TIC)
-- Create date: 02/08/2019 11:52:56
-- Description:	Agrega un nodo a la jerarquía
-- =============================================
CREATE PROCEDURE [dbo].[sp_add_node] 
	-- Add the parameters for the stored procedure here
	@id nvarchar(255) = null, 
	@xml_text nvarchar(max) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	---- 1.- Busco el hid del padre de @id
	--declare @hid_parent as hierarchyid
	--select
	--	@hid_parent=h.hid
	--from
	--	dim_jerarquias h
	--where
	--	h.id=dbo.get_parent_id(@id)
	
	---- 2.- Busco el lugar que le corresponde en la jerarquía
	----set transaction isolation level serializable
	--set transaction isolation level READ UNCOMMITTED
	--declare @lc as hierarchyid
	begin transaction
	--	select
	--		@lc=max(h.hid)
	--	from
	--		dim_jerarquias h
	--	where
	--		h.hid.GetAncestor(1)=@hid_parent;
			
	-- 3.- Inserto los valores en la jerarquía
	--	
		insert dim_jerarquias (id,xml_data)
		values(
			--ISNULL(@hid_parent.GetDescendant(@lc, NULL),hierarchyid::GetRoot()),
			@id,
			Cast(replace(@xml_text,'&','y') as xml)
		)
	commit

	
END
