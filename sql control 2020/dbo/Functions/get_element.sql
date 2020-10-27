-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 23-nov-2017
-- Description:	Recupera elemento de un xml
-- =============================================
CREATE FUNCTION [dbo].[get_element] 
(
	-- Add the parameters for the function here
	@nombre nvarchar(255),
	@xml_data xml
)
RETURNS nvarchar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(max)

	-- Add the T-SQL statements to compute the return value here
	select @Result=@xml_data.value('(//*[local-name()=sql:variable("@nombre")]/text())[1]','nvarchar(255)')
	

	-- Return the result of the function
	RETURN @Result

END
