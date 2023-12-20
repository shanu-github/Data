# -*- coding: utf-8 -*-
"""
Created on Mon Oct 16 10:46:21 2023

@author: HAG5KOR
"""

from pyspark.sql import SparkSession
from pyspark.sql.functions import asc, desc

# Create a Spark session
spark = SparkSession.builder.appName("OrderByExample").getOrCreate()

#ordering in Pyspark
# Sample data
data = [("Alice", 30),
        ("Bob", 25),
        ("Charlie", 22),
        ("David", 28),
        ("Eva", 35)]

columns = ["Name", "Age"]

# Create a DataFrame
df = spark.createDataFrame(data, columns)

# Order the DataFrame by the "Age" column in ascending order (default)
ordered_df = df.orderBy(asc("Age"))