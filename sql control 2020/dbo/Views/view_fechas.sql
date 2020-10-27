CREATE VIEW [dbo].[view_fechas]
AS
SELECT
  CAST(fec.node AS date) fec_key,
  YEAR(CAST(fec.node AS date)) año,
  CONVERT(nvarchar(6), CAST(fec.node AS date), 112) [año-mes],
  meses.nombre + RIGHT(YEAR( CAST(fec.node AS date) ),2) [mes],
  DAY(CAST(fec.node AS date)) dia
FROM
  dim_jerarquias fec
    LEFT OUTER JOIN
      (VALUES (1, 'Ene'), (2, 'Feb'), (3, 'Mar'), (4, 'Abr'), (5, 'May'), (6, 'Jun'), (7, 'Jul'), (8, 'Ago'), (9, 'Sep'), (10, 'Oct'), (11, 'Nov'), (12, 'Dic')) meses (num, nombre)
        ON meses.num = MONTH(CAST(fec.node AS date))
WHERE
  fec.id like 'RAIZ.fechas.%'

GO
