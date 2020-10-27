-- =============================================
-- Author:		Luis Tapia Peralta (CMPC TIC)
-- Create date: 2019-11-18
-- Description:	Carga inicial del gasto real
-- =============================================
CREATE PROCEDURE [dbo].[sp_init_gasto_real] 
	-- Add the parameters for the stored procedure here
	@fecha_hasta date = '2019-12-31' 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from fact_gasto_real;

	insert into fact_gasto_real (
		id,
		[Fecha Registro],
		[Fecha Contable],
		cuenta,
		texto,
		orden,
		pep,
		ceco,
		moneda,
		monto,
		[monto usd],
		prv_id,
		usr,
		pedido,
		HAS
		)

	select
		id,
		[Fecha Registro],
		[Fecha Contable],
		cuenta,
		texto,
		orden,
		pep,
		ceco,
		moneda,
		monto,
		[monto usd],
		prv_id,
		usr,
		pedido,
		HAS
	from
		[PMO Control Gasto TI 2019].dbo.fact_gasto_real gr
	where
		gr.[Fecha Registro]<=@fecha_hasta


END
