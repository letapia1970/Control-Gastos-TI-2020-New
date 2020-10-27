CREATE VIEW [dbo].[view_cobro_ppto]
AS
SELECT
  c.*,
  'RAIZ.partidas.' + REPLACE(c.version, '.', '-') + '.' + c.origen_id [id partida],
  isnull(org.id,org_soc.id) [id org],
  isnull(org2.id,org2_soc.id) [id org2],
  d.id [id directo],
  pry.[id proyecto],
  ctas_g01.id [id cuenta],
  CASE
    WHEN SUBSTRING(c.origen_fuente, 1, 14)
      = '/Ppto/Filiales' THEN
      'FIL'
    ELSE
      'CORP'
  END Tipo
FROM
  fact_cobro_ppto c
    LEFT OUTER JOIN
      view_org org
        ON org.id like 'RAIZ.org.%.'+c.unidad
        
    LEFT OUTER JOIN
      view_org_cobro org2
        ON org2.id like 'RAIZ.og2.%.'+ c.unidad         
        
    LEFT OUTER JOIN
      view_directo d
        ON c.directo = d.id
    LEFT OUTER JOIN
      view_proyectos pry
        ON ISNULL('RAIZ.pry.' + c.proyecto, 'RAIZ.pry.SP') = pry.[id proyecto]
    LEFT OUTER JOIN
      view_ctas_g01 ctas_g01
        ON c.cuenta = ctas_g01.node
        
	left outer join 
			(
			values
				('CL', '1'),
				('AR', '2'), 
				('PE', '3'), 
				('UY', '4'), 
				('BR', '5'), 
				('MX', '6'), 
				('EC', 'EC'), 
				('CO', 'CO')
			) p (pais,cod)
			
			on p.pais=SUBSTRING(c.unidad,2,2)

	left outer join view_org org_soc 
		on org_soc.id like 'RAIZ.org.%.'+p.cod+SUBSTRING(c.unidad,4,2)+
			case org.id
				when null then '.'
				else ''
			end

	left outer join view_org_cobro org2_soc
		on org2_soc.id like 'RAIZ.og2.%.'+p.cod+SUBSTRING(c.unidad,4,2)+
			case org2.id
				when null then '.'
				else ''
			end

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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_cobro_ppto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_cobro_ppto';

