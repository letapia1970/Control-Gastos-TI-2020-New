CREATE FUNCTION [dbo].[Split] ( @strString varchar(4000),@separator as nvarchar(1))

RETURNS  @Result TABLE(Value nvarchar(max))

AS

BEGIN

 

      DECLARE @x XML 

      SELECT @x = CAST('<A>'+ REPLACE(@strString,@separator,'</A><A>')+ '</A>' AS XML)

     

      INSERT INTO @Result            

      SELECT t.value('.', 'nvarchar(max)') AS inVal

      FROM @x.nodes('/A') AS x(t)


 

    RETURN

END
