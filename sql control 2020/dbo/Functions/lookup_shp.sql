CREATE FUNCTION [dbo].[lookup_shp]
(
	@tipo as nvarchar(255)
)
RETURNS @returntable TABLE
(
	spid nvarchar(255),
	valor nvarchar(255)
)
AS
BEGIN
	INSERT @returntable
--	SELECT @param1, @param2
	select
		sp.node spid,
		sp.xml_data.query('/node/text()').value('.','nvarchar(255)') valor
	from 
		dim_jerarquias sp
	where 
		sp.id like 'RAIZ.shp.%'+ @tipo +'.%'
	RETURN

END
