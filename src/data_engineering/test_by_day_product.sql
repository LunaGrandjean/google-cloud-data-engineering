SELECT SUM(qty) AS total_unites
FROM `data-engineering-i1.bronze_grandjean.order_items_by_day_product`
WHERE dt BETWEEN DATE '2026-08-01' AND DATE '2026-08-31';
