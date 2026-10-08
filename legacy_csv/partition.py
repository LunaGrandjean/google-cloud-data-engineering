import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

items = pd.read_csv("order_items.csv")
orders = pd.read_csv("orders.csv")[["order_id", "order_date"]]

df = items.merge(orders, on="order_id")
df["dt"] = pd.to_datetime(df["order_date"]).dt.strftime("%Y-%m-%d")

df = df[["order_id", "p_id", "qty", "price_at_purchase", "dt"]]

table = pa.Table.from_pandas(df, preserve_index=False)

pq.write_to_dataset(
    table,
    root_path="by_day",
    partition_cols=["dt"],
    compression="snappy", max_partitions=2000
)

print("Partitionnement termine !")
print(f"Nombre de lignes : {len(df)}")
print(f"Nombre de dates : {df['dt'].nunique()}")

