


CREATE VIEW [dbo].[view_gasto_real]
AS
/**************** Vista Gastos Reales ******************/
SELECT
  gr.id,
  gr.[Fecha Registro],
  gr.[Fecha Contable],
  pf.periodo [Fecha Facturación],
  gr.cuenta,
  gr.texto,
  gr.orden,
  gr.pep,
  gr.ceco,
  gr.moneda,
  gr.monto,
  gr.[monto usd],
  ISNULL('RAIZ.prv.'+gr.prv_id,'RAIZ.prv.SP') prv_id,
  gr.usr,
  case 
	when gr.pep like 'PROY-0077%' then null 
	else ISNULL(org.id,sc.id)
  end [id org],
 -- case pry.[id proyecto]
	--when 'RAIZ.pry.PROY-0077' then null 
	--else ISNULL(org2.id,org2_soc.id)
 -- end [id org2],

  /*  >>>>>>>>> CAMBIAR org y org_soc <<<<<<<<<<<< */
  --dir.id [id directo],
  ISNULL(org.directo,'D') [id directo],
  --dir.node [id directo node],
  --ctas_01.id [id cuenta],
  ISNULL(ctas_01.id,'RAIZ.ctas.g01.OTROS.UKN') [id cuenta],
  isnull(ctas_02.id,'RAIZ.ctas.g02.ARR') [id cuenta2],

  CAST(gr.[Fecha Registro] AS date) [Registro],
  
  ISNULL(dbo.pep2proy(gr.pep),'SP')[proyecto],
  --ceco_control.unidad_control,
  cc.id id_control,
  CASE
    WHEN gr.moneda = 'CLP' OR gr.moneda = 'UF' THEN 'UF'
    ELSE 'USD'
  END [moneda cobro],
  CASE
    WHEN gr.moneda = 'CLP' OR gr.moneda = 'UF' THEN
      dbo.conv_real(gr.monto, gr.[Fecha Contable], gr.moneda, 'UF')
    ELSE
      dbo.conv_real(gr.monto, gr.[Fecha Contable], gr.moneda, 'USD')
  END [monto cobro],
  gr.pedido,
  gr.HAS,
  gr.Estrategia
  
  /******** Efecto tipo cambio real ******/
  ,
  gr.monto / (
	  case gr.moneda
		when 'USD' then 1
		else cp.factor
	  end
  ) [monto usd efecto]
FROM
  fact_gasto_real gr
    LEFT OUTER JOIN
      view_org org
        ON org.node =gr.ceco
    
    left outer join view_org_soc_cecos sc
		on sc.ceco=gr.ceco
        
    LEFT OUTER JOIN
      view_ctas_g01 ctas_01
        ON gr.cuenta = ctas_01.[cuenta nro]
    LEFT OUTER JOIN
      view_ctas_g02 ctas_02
        ON gr.cuenta = ctas_02.[cuenta nro]
    LEFT OUTER JOIN
      dim_periodos_facturacion pf
        ON gr.[Fecha Registro] BETWEEN pf.desde AND pf.hasta /* <- Pendiente Optimizar */

	left outer join
		view_cecos_control cc
			on cc.node =  ISNULL(CAST(gr.Estrategia as nvarchar(50)),cast(gr.usr as nvarchar(50)))
			
	left outer join
		view_conv_ppto cp
			on (
				cp.clave=gr.moneda+'/USD' and
				cp.fecha=CAST(CONVERT(nvarchar(6),gr.[Fecha Contable],112)+'01' as DATE) 
			)
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_gasto_real';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'view_gasto_real';

