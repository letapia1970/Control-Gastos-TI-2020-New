-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 14-feb-2018
-- Description:	obtiene proyecto de un pep
-- =============================================
CREATE FUNCTION [dbo].[pep2proy] 
(
	-- Add the parameters for the function here
	@pep nvarchar(255)=null
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(255)
	DECLARE @IsProy as bit = 0

	-- Add the T-SQL statements to compute the return value here
	if not @pep is null
		
	
	begin
		set @pep=REPLACE(@pep,'.','-')
		select 
			@IsProy=SUM(CHARINDEX(codes.cod,ISNULL(@pep,'')))
		from
			(values
				('SAP-'),
				('TIPR-'),
				('PROY-'),
				('IT-')
			) codes (cod)
		if @IsProy=1
			set @pep=LEFT(@pep,CHARINDEX('-',@pep,CHARINDEX('-',@pep)+1)-1)
	end

	SELECT @Result = @pep

	-- Return the result of the function
	RETURN @Result

END
