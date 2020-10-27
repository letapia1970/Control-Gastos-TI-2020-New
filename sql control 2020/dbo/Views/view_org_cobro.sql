CREATE VIEW [dbo].[view_org_cobro]
AS
SELECT
  org.id,
  --org.xml_data,
  org.node,
  CASE
    WHEN org.level >= 3 AND LEN(org.node) = 10 THEN
      org.node + ' - ' + dbo.get_element('nombre', org.xml_data)
    ELSE
      dbo.get_element('nombre',
      org.xml_data)
  END AS nombre,
  org.level AS nivel,
  /************************************************************/
	(
	SELECT
		dbo.get_element(N'nombre', xml_data)
	FROM dim_jerarquias AS neg
	WHERE 
		id = LEFT(org.id,10)
	)AS negocio,
  
  /************************************************************/
  (CASE
	when org.level =3 then dbo.get_element('nombre',org.xml_data)
    WHEN org.level > 3 THEN 
     	(SELECT
			dbo.get_element('nombre', soc.xml_data)
		FROM dim_jerarquias soc
		WHERE soc.id = LEFT(org.id,CHARINDEX('.',org.id,12)-1)
		)
    ELSE
      NULL
  END) AS sociedad,
  /****************************************************************/
  (CASE
	when org.level =3 then dbo.get_element('pais_nombre',org.xml_data)
    WHEN org.level > 3 THEN 
     	(SELECT
			dbo.get_element('pais_nombre', soc.xml_data)
		FROM dim_jerarquias soc
		WHERE soc.id = LEFT(org.id,CHARINDEX('.',org.id,12)-1)
		)
    ELSE
      NULL
  END) AS [pais nombre],
  (CASE
	when org.level =3 then dbo.get_element('pais_sigla',org.xml_data)
    WHEN org.level > 3 THEN 
     	(SELECT
			dbo.get_element('pais_sigla', soc.xml_data)
		FROM dim_jerarquias soc
		WHERE soc.id = LEFT(org.id,CHARINDEX('.',org.id,12)-1)
		)
    ELSE
      NULL
  END) AS [pais sigla],

/****************************************************************/
  (CASE
    WHEN org.level > 3 AND
      LEN(org.node)
      = 10 THEN
      org.node + ' - ' + dbo.get_element('nombre', org.xml_data)
    ELSE
      NULL
  END) AS unidad,
/****************************************************************/
  (CASE
    WHEN org.level > 3 AND
      LEN(org.node) = 10 THEN
      org.node
    ELSE
      NULL
  END)
  AS [unidad ceco],
/****************************************************************/
  CASE
    WHEN org.level <= 2 THEN
      NULL
    ELSE
      org_parent.id
  END AS id_parent
  
FROM 
	dbo.dim_jerarquias AS org
		LEFT OUTER JOIN
		dbo.dim_jerarquias AS org_parent
			ON org_parent.id = org.id_parent

WHERE 
	org.id like 'RAIZ.og2.%'

--Order by
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
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
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
      ActivePaneConfig = 5
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
   End
   Begin CriteriaPane = 
      PaneHidden = 
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_org_cobro';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_org_cobro';

