-- =============================================
-- Author:		Lusi Tapia (CMP TIC)
-- Create date: 23-nov-2017
-- Description:	Busca el ID del padre un @id
-- =============================================
CREATE FUNCTION [dbo].[get_parent_id] 
(
	-- Add the parameters for the function here
	@id nvarchar(255)
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(255)

	-- Add the T-SQL statements to compute the return value here
	declare @parent_id as nvarchar(255)
	set @parent_id = 
		case
			when charindex('.',@id)=0 then Null
			else REVERSE(SUBSTRING(REVERSE(@id),1+CHARINDEX('.', REVERSE(@id)),LEN(@id)))
		end
	
	SELECT @Result = @parent_id

	-- Return the result of the function
	RETURN @Result

END
