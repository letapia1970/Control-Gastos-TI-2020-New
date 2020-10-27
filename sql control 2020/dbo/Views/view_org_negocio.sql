



CREATE VIEW [dbo].[view_org_negocio]
AS
/********************** view org NEGOCIO*********************/
select
	org.id,
	org.node,
	dbo.get_element('nombre',org.xml_data) nombre
	--org.id,
	--dbo.get_element('nombre',org.xml_data) nombre,
	--dbo.get_element('tipo',org.xml_data) tipo,
	--CASE
	--	WHEN org.LEVEL <= 2 THEN NULL
	--	ELSE org_parent.id
	--END AS id_parent,
	--org.node,
	
	--case dbo.get_element('tipo',org.xml_data) 
	--	when 'Unidad' then org.node +' - '+ dbo.get_element('nombre', org.xml_data)
	--	else null
	--end unidad,
	--	case dbo.get_element('tipo',org.xml_data) 
	--	when 'Unidad' then org.node
	--	else null
	--end unidad_ceco,
	--case
	--	when CHARINDEX('.TI.',org.id)<>0 then 'C'
	--	else
	--		case CHARINDEX(sc.id,org.id)
	--			when 0 then 'F'
	--			when 1 then 'D' 
	--		end 
	--end directo
	--/***********************************************
	-- 2020-02-05 Incorpora pais a nivel de sociedad y Jerarquias de Negocio y Sociedad
	-- ***********************************************/
	--,
	--case dbo.get_element('tipo',org.xml_data) 
	--	when 'Sociedad' then dbo.get_element('pais_sigla', org.xml_data)
	--	when 'Unidad' then org_sociedad.pais_sigla
	--	else null
	--end pais_sigla,
	
	--case dbo.get_element('tipo',org.xml_data) 
	--	when 'Sociedad' then dbo.get_element('pais_nombre', org.xml_data)
	--	when 'Unidad' then org_sociedad.pais_nombre
	--	else null
	--end pais_nombre,
	--/*************** Sociedad y Negocio **********/
	--case dbo.get_element('tipo',org.xml_data) 
	--	when 'Sociedad' then dbo.get_element('nombre', org.xml_data)
	--	when 'Unidad' then org_sociedad.nombre
	--	else null
	--end sociedad,
	--org_negocio.nombre negocio

FROM
  dbo.dim_jerarquias AS org


WHERE
  org.id LIKE 'RAIZ.org.%' and org.level=2