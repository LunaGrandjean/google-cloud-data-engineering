import pandas as pd

df = pd.read_csv("order_items.csv")
df.to_parquet("order_items.parquet", compression="snappy")

print("Conversion CSV vers Parquet terminee !")
print(f"Nombre de lignes : {len(df)}")
