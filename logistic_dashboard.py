import mysql.connector
import pandas as pd
import schedule
import time
import matplotlib.pyplot as plt
import os
from datetime import datetime

def fetch_data():

    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root123",
        database="logistics_db"
    )

    query = """
    SELECT
        shipment_id,
        shipment_date,
        origin,
        destination,
        vehicle_type,
        distance_km,
        shipping_cost,
        delivery_status,
        delivery_days,
        customer_type
    FROM shipments;
    """

    df = pd.read_sql(query, conn)
    conn.close()

    df["shipment_date"] = pd.to_datetime(df["shipment_date"])

    return df



#  Create Logistics Charts

def create_charts(df):

    # Create reports folder
    os.makedirs("reports", exist_ok=True)

    # 1. Daily Shipment Trend
    daily_shipments = df.groupby("shipment_date")["shipment_id"].count().reset_index()

    plt.figure(figsize=(8, 5))
    plt.plot(
        daily_shipments["shipment_date"],
        daily_shipments["shipment_id"],
        marker="o"
    )
    plt.title("Daily Shipment Trend")
    plt.xlabel("Date")
    plt.ylabel("Number of Shipments")
    plt.grid(True)
    plt.savefig("reports/daily_shipments.png")
    plt.close()

    # 2. Shipments by Vehicle Type
    vehicle_data = df["vehicle_type"].value_counts()

    plt.figure(figsize=(6, 4))
    plt.bar(vehicle_data.index, vehicle_data.values)
    plt.title("Shipments by Vehicle Type")
    plt.xlabel("Vehicle Type")
    plt.ylabel("Number of Shipments")
    plt.savefig("reports/shipments_by_vehicle.png")
    plt.close()

    # 3. Delivered vs Delayed
    status_data = df["delivery_status"].value_counts()

    plt.figure(figsize=(6, 4))
    plt.bar(status_data.index, status_data.values)
    plt.title("Delivered vs Delayed Shipments")
    plt.xlabel("Delivery Status")
    plt.ylabel("Number of Shipments")
    plt.savefig("reports/delivery_status.png")
    plt.close()

    # 4. Shipments by Destination
    destination_data = df["destination"].value_counts()

    plt.figure(figsize=(8, 5))
    plt.bar(destination_data.index, destination_data.values)
    plt.title("Shipments by Destination")
    plt.xlabel("Destination")
    plt.ylabel("Number of Shipments")
    plt.xticks(rotation=45)
    plt.savefig("reports/shipments_by_destination.png")
    plt.close()

    print("\nAll charts generated successfully!")
    print("Charts are saved in the reports folder.")


# . Automated Job

def job():

    print("\n========================================")
    print("Logistics Dashboard Running")
    print("Time:", datetime.now())
    print("========================================")

    df = fetch_data()

    print("\n--- Logistics KPI Report ---")

    print("Total Shipments:", df["shipment_id"].count())
    print("Total Shipping Cost:", df["shipping_cost"].sum())
    print(
        "Average Delivery Days:",
        round(df["delivery_days"].mean(), 2)
    )

    print("\n--- Delivery Status ---")
    print(df["delivery_status"].value_counts())

    print("\n--- Vehicle-wise Shipments ---")
    print(df["vehicle_type"].value_counts())

    print("\n--- Destination-wise Shipments ---")
    print(df["destination"].value_counts())

    print("\nData fetched successfully!")

    create_charts(df)

    #  Schedule the job

schedule.every().day.at("20:41").do(job)

print("Logistics Dashboard Scheduler Started")
print("Waiting for 8:41 PM")

while True:
    schedule.run_pending()
    time.sleep(60)