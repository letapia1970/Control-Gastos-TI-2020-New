-- =============================================
-- Author:		Luis Tapia (CMPC TIC)
-- Create date: 05-dic-2017
-- Description:	Convierte un valor de una moneda a otra de acuerdo a los cambios reales
-- =============================================
CREATE FUNCTION [dbo].[conv_real] 
(
	-- Add the parameters for the function here
	@monto as float,
	@fecha date,
	@mon_desde nvarchar(50),
	@mon_hacia nvarchar(50)
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result float
	declare @clave as nvarchar(50)
	declare @factor as float

	-- Add the T-SQL statements to compute the return value here
	
	if @mon_desde=@mon_hacia
		set @factor=1
	else
		set @factor=
		(
		select 
			top 1
			1/conv_real.factor
		from
			fact_conversion_real conv_real
		where
				conv_real.fecha<=@fecha
			and conv_real.clave = @mon_desde +'/'+@mon_hacia
		order by conv_real.fecha DESC
		)
	set @Result = @monto*@factor
	
	-- Return the result of the function
	RETURN @Result

END
