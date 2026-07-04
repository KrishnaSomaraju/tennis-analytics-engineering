import pandas as pd
from google.cloud import bigquery

PROJECT_ID = "tennis-analytics-501013"
RAW_DATASET = "raw"
LOCATION = "US"

BASE_URL = "https://raw.githubusercontent.com/Tennismylife/TML-Database/master/"

client = bigquery.Client(project=PROJECT_ID, location=LOCATION)

dataset_ref = bigquery.Dataset(f"{PROJECT_ID}.{RAW_DATASET}")
dataset_ref.location = LOCATION
client.create_dataset(dataset_ref, exists_ok=True)
print(f"Dataset {RAW_DATASET} ready.")


def load_csv_to_bq(url: str, table_name: str, encoding: str = "utf-8"):
    print(f"Loading {table_name} ...")
    df = pd.read_csv(url, encoding=encoding)

    table_id = f"{PROJECT_ID}.{RAW_DATASET}.{table_name}"
    job_config = bigquery.LoadJobConfig(write_disposition="WRITE_TRUNCATE")
    job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
    job.result()

    print(f"  -> {len(df)} rows loaded into {table_name}")


for year in range(2020, 2025):
    load_csv_to_bq(f"{BASE_URL}{year}.csv", f"matches_{year}")

load_csv_to_bq(f"{BASE_URL}ATP_Database.csv", "players", encoding="latin-1")

print("All files loaded.")