update
	fact_gasto_ppto
set
	unidad_control='6CL0101694'
from
	fact_gasto_ppto gp
where
		gp.version ='v20.10'
	and gp.moneda='USD'
	and gp.cuenta_id='6450450600'
	and gp.unidad_control in ('6CL0101692') --,'6CL0101694')
	and gp.partida in (
		'Antimalware',
		'Consolidacion Logs',
		'Escaneo Vulnerabilidad',
		'GEstion Inv Activos HW y SW',
		'HIPS',
		'Soc',
		'Soporte Microsoft',
		'WAF')
