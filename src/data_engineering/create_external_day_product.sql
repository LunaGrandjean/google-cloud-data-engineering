CREATE OR REPLACE EXTERNAL TABLE
  `data-engineering-i1.bronze_grandjean.order_items_by_day_product`
WITH PARTITION COLUMNS (
  dt DATE,
  p_id STRING
)
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://data-engineering-i1-grandjean/bronze/by_day_product/*'],
  hive_partition_uri_prefix = 'gs://data-engineering-i1-grandjean/bronze/by_day_product/'
);
