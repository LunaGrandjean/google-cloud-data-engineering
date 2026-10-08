# Google Cloud Data Engineering — Lab Report

## 1. Cloud Storage and Data Conversion

I started by creating two Google Cloud Storage buckets in my Google Cloud project, `data-engineering-i1`, located in the `europe-west1` region.

I then converted the `order_items.csv` dataset into Parquet format using Snappy compression to optimize storage.

| Format | File size |
|---|---:|
| CSV | 10,373,925 bytes |
| Parquet | 3,546,854 bytes |

By converting the CSV file into Parquet, I reduced the storage size by approximately **65.8%**.

## 2. Data Partitioning and Lifecycle Management

I tested two different partitioning strategies to understand their impact on storage and query performance:

- **Daily partitioning:** using the `dt` column.
- **Daily and product partitioning:** using both `dt` and `p_id`.

I also configured a Cloud Storage lifecycle policy for files stored under the `bronze/` prefix.

I defined the following transitions:

- Move files to Nearline after 30 days.
- Move files to Coldline after 90 days.
- Move files to Archive after 365 days.

My objective was to optimize long-term storage costs by automatically moving older data to cheaper storage classes.

## 3. Identity and Access Management (IAM)

I attempted to create a service account named `ml-reader-grandjean` to manage access permissions.

However, I encountered the following error:

`Permission 'iam.serviceAccounts.create' denied`

This happened because my account did not have sufficient IAM permissions to create service accounts.

I skipped this step and continued with the remaining exercises.

## 4. Partitioning Performance Comparison

I created two external tables in BigQuery to compare the performance of both partitioning strategies.

To ensure a fair comparison, I used the same dataset and restricted my queries to August 2026.

| Metric | Daily | Daily + Product |
|---|---:|---:|
| Rows | 9,893 | 9,893 |
| Parquet files | 45 | 8,649 |
| Storage size | 0.66 MB | 24.78 MB |
| Total units sold | 33,231 | 33,231 |
| Data processed | 0.075 MiB | 0.075 MiB |
| Query execution time | 444 ms | 1,546 ms |
| Slot time | 3,164 slot-ms | 1,367,843 slot-ms |

I first verified that both queries returned the same result: **33,231 units sold**.

I then compared their performance and observed several important differences.

The daily + product strategy generated approximately **192 times more Parquet files** and required **37.5 times more storage**.

I also observed that the daily + product query took approximately **3.5 times longer** to execute, even though both queries processed the same amount of data.

These results helped me understand the *small files problem*. By creating too many small partitions, I increased the number of files BigQuery needed to manage, which introduced additional processing overhead.

I only executed each performance test once, so these results are illustrative rather than a complete benchmark. I also used a date-only filter, meaning that a query filtering on a specific product might produce different results.

## 5. Estimated Storage and Operation Costs

I estimated the storage and operation costs of both strategies using the following pricing assumptions:

- Standard storage: $0.020 per GiB/month.
- Class A operations: $0.005 per 1,000 operations.
- One write operation per Parquet file.

| Estimated cost | Daily | Daily + Product |
|---|---:|---:|
| Monthly storage | $0.000012 | $0.000462 |
| File write operations | $0.000225 | $0.043245 |
| **Illustrative total** | **$0.000237** | **$0.043707** |

I noticed that the daily + product strategy was significantly more expensive in terms of write operations because it generated thousands of small files.

These calculations are estimates and do not include additional Cloud Storage operations, BigQuery charges, or potential billing minimums.

## 6. Conclusion

Through this exercise, I learned how to use several Google Cloud data engineering services and concepts, including Cloud Storage, Parquet compression, data partitioning, lifecycle policies, IAM permissions, and BigQuery external tables.

I also learned how partitioning choices can directly affect storage efficiency, query performance, and infrastructure costs.

Based on my results, **I found daily partitioning to be the most efficient strategy for my test case**. It required less storage, generated fewer files, and achieved faster query execution.

My main takeaway from this exercise is that **more granular partitioning does not always lead to better performance**. Choosing an appropriate partitioning strategy is essential to avoid unnecessary costs and processing overhead.