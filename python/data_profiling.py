
"""
===============================================================================
RetailX Enterprise Analytics
Data Profiling Script
===============================================================================

Objective:
Perform an initial data profiling assessment to understand dataset quality
before importing into MySQL.

Checks Performed:
1. Dataset Shape
2. Data Types
3. Missing Values
4. Duplicate Records
5. Unique Values
6. Summary Statistics
7. Memory Usage

Author: Sourav Prakash
===============================================================================
"""

import pandas as pd

# -----------------------------------------------------------------------------
# Load Dataset
# -----------------------------------------------------------------------------

df = pd.read_csv("../data/temp/orders.csv")

# -----------------------------------------------------------------------------
# Dataset Overview
# -----------------------------------------------------------------------------

print("=" * 70)
print("DATASET OVERVIEW")
print("=" * 70)

print(f"Rows    : {df.shape[0]}")
print(f"Columns : {df.shape[1]}")

# -----------------------------------------------------------------------------
# Data Types
# -----------------------------------------------------------------------------

print("\n" + "=" * 70)
print("DATA TYPES")
print("=" * 70)

print(df.dtypes)

# -----------------------------------------------------------------------------
# Missing Values
# -----------------------------------------------------------------------------

print("\n" + "=" * 70)
print("MISSING VALUES")
print("=" * 70)

missing = df.isnull().sum()

print(pd.DataFrame({
    "Missing Values": missing,
    "Percentage": round((missing / len(df)) * 100, 2)
}))

# -----------------------------------------------------------------------------
# Duplicate Records
# -----------------------------------------------------------------------------

print("\n" + "=" * 70)
print("DUPLICATE RECORDS")
print("=" * 70)

print(f"Duplicate Rows: {df.duplicated().sum()}")

# -----------------------------------------------------------------------------
# Unique Values
# -----------------------------------------------------------------------------

print("\n" + "=" * 70)
print("UNIQUE VALUES")
print("=" * 70)

for column in df.columns:
    print(f"{column}: {df[column].nunique()}")

# -----------------------------------------------------------------------------
# Summary Statistics
# -----------------------------------------------------------------------------

print("\n" + "=" * 70)
print("NUMERICAL SUMMARY")
print("=" * 70)

print(df.describe())

# -----------------------------------------------------------------------------
# Memory Usage
# -----------------------------------------------------------------------------

print("\n" + "=" * 70)
print("MEMORY USAGE")
print("=" * 70)

memory = df.memory_usage(deep=True).sum() / (1024 ** 2)

print(f"{memory:.2f} MB")

# -----------------------------------------------------------------------------
# Data Sample
# -----------------------------------------------------------------------------

print("\n" + "=" * 70)
print("FIRST FIVE RECORDS")
print("=" * 70)

print(df.head())

print("\nData profiling completed successfully.")
