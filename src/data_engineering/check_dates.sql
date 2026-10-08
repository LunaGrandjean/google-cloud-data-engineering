SELECT
    MIN(dt) AS premiere_date,
    MAX(dt) AS derniere_date,
    COUNT(*) AS nombre_lignes,
    COUNTIF(dt BETWEEN DATE '2026-08-01' AND DATE '2026-08-31') AS lignes_aout_2026
FROM `data-engineering-i1.bronze_grandjean.order_items_by_day`;
