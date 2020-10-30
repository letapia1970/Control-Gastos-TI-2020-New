CREATE PROCEDURE [dbo].[sp_shp_update_forecast]

AS
	update fact_gasto_forecast
	set moneda = ISNULL(m.valor,f.moneda),
	    cuenta = isnull(cta.valor,f.cuenta),
		ceco   = ISNULL(u.valor,f.ceco),
		prv_id = ISNULL(p.valor,f.prv_id),
		usr    = ISNULL(usr.valor,f.usr)


	from fact_gasto_forecast f
		left outer join lookup_shp('monedas') m   on m.spid  =f.moneda
		left outer join lookup_shp('ctas')    cta on cta.spid=f.cuenta
		left outer join lookup_shp('unidad')  u   on u.spid  =f.ceco
		left outer join lookup_shp('prv')     p   on p.spid  =f.prv_id
		left outer join lookup_shp('user')    usr on usr.spid=f.usr
RETURN 0
