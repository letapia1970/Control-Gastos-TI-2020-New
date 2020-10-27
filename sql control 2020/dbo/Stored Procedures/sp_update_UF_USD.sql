-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-12-26
-- Description:	Inserta tipo de cambio UF/USD a partir de CLP/USD y CLP/UF
-- =============================================
CREATE PROCEDURE [dbo].[sp_update_UF_USD] 
	-- Add the parameters for the stored procedure here
	--@p1 int = 0, 
	--@p2 int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- SELECT @p1, @p2
	/**********************************************
 * Inserta cambio UF/USD
 *****************************/
	delete 
	from 
	 fact_conversion_real
	where
	 clave='UF/USD'

	 
	INSERT INTO fact_conversion_real
	  (
		clave,
		fecha,
		factor
	  )
	  SELECT
		N'UF/USD' AS clave,
		fecha,
		(
		SELECT TOP (1) factor FROM fact_conversion_real AS cr_USD
		WHERE		(clave = 'CLP/USD')
				AND (fecha <= cr_UF.fecha)
		ORDER BY fecha DESC
		)
		/ factor AS factor
	  FROM
		fact_conversion_real AS cr_UF
	  WHERE
		(clave = 'CLP/UF')
		AND (fecha > CAST('2015-01-01' AS date))
END
