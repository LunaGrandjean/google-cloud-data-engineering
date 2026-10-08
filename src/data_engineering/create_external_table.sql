CREATE OR REPLACE EXTERNAL TABLE
  `data-engineering-i1.bronze_grandjean.order_items_by_day`
WITH PARTITION COLUMNS (
  dt DATE
)
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://data-engineering-i1-grandjean/bronze/by_day/*'],
  hive_partition_uri_prefix = 'gs://data-engineering-i1-grandjean/bronze/by_day/'
);