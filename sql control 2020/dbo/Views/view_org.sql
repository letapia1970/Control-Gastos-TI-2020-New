






CREATE VIEW [dbo].[view_org]
AS
/********************** view org *********************/
select
	org.id,
	dbo.get_element('nombre',org.xml_data) nombre,
	dbo.get_element('tipo',org.xml_data) tipo,
	CASE
		WHEN org.LEVEL <= 2 THEN NULL
		ELSE org_parent.id
	END AS id_parent,
	org.node,
	
	case dbo.get_element('tipo',org.xml_data) 
		when 'Unidad' then org.node +' - '+ dbo.get_element('nombre', org.xml_data)
		else null
	end unidad,
		case dbo.get_element('tipo',org.xml_data) 
		when 'Unidad' then org.node
		else null
	end unidad_ceco,
	case
		when CHARINDEX('.TI.',org.id)<>0 then 'C'
		else
			case CHARINDEX(sc.id,org.id)
				when 0 then 'F'
				when 1 then 'D' 
			end 
	end directo
	/***********************************************
	 2020-02-05 Incorpora pais a nivel de sociedad y Jerarquias de Negocio y Sociedad
	 ***********************************************/
	,
	case dbo.get_element('tipo',org.xml_data) 
		when 'Sociedad' then dbo.get_element('pais_sigla', org.xml_data)
		when 'Unidad' then org_sociedades.pais_sigla
		else null
	end pais_sigla,
	
	case dbo.get_element('tipo',org.xml_data) 
		when 'Sociedad' then dbo.get_element('pais_nombre', org.xml_data)
		when 'Unidad' then org_sociedades.pais_nombre
		else null
	end pais_nombre,
	/*************** Sociedad y Negocio **********/
	org_sociedades.nombre sociedad
   ,

	org_negocio.nombre negocio

FROM
  dbo.dim_jerarquias AS org
    LEFT OUTER JOIN
      dbo.dim_jerarquias AS org_parent
        ON
          org_parent.id = org.id_parent

    left outer join view_org_soc_cecos sc
		on sc.ceco=org.node

	left outer join view_org_negocio as org_negocio
		on org_negocio.id = 'RAIZ.org.' + LEFT( substring(org.id,10,1) ,1)

	left outer join view_org_sociedades org_sociedades
		on org_sociedades.id =
			case dbo.get_element('tipo',org.xml_data)
				when 'Sociedad' then org.id
				when 'Unidad' then
					case CHARINDEX(SUBSTRING(org.id,12,2),'SKCO')
						when 0 then
							LEFT(org.id,CHARINDEX('.',org.id,len('RAIZ.org.N.S'))-1)		
						else LEFT(org.id,CHARINDEX('.',org.id,len('RAIZ.org.P.SG.S'))-1)
							
					end
			end		
		

WHERE
  org.id LIKE 'RAIZ.org.%'

--  /********* BORRAR ******/
--order by
--	org.id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_org';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_org';

