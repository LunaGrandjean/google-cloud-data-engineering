SELECT
  creation_time,
  job_id,
  ROUND(total_bytes_processed / 1024 / 1024, 3) AS mb_processed,
  total_slot_ms,
  TIMESTAMP_DIFF(end_time, start_time, MILLISECOND) AS duree_ms,
  CASE
    WHEN query LIKE '%order_items_by_day_product%' THEN 'Jour + produit'
    WHEN query LIKE '%order_items_by_day%' THEN 'Jour'
  END AS strategie
FROM `data-engineering-i1.region-europe-west1.INFORMATION_SCHEMA.JOBS_BY_USER`
WHERE creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR)
  AND job_type = 'QUERY'
  AND state = 'DONE'
  AND statement_type = 'SELECT'
  AND (
    query LIKE '%order_items_by_day_product%'
    OR query LIKE '%order_items_by_day%'
  )
ORDER BY creation_time DESC
LIMIT 20;
