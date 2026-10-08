SELECT
    DATE_TRUNC(dt, WEEK(MONDAY)) AS semaine,
    SUM(qty) AS total_unites
FROM `data-engineering-i1.bronze_grandjean.order_items_by_day`
GROUP BY semaine
ORDER BY semaine;
