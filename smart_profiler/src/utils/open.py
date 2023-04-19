from pyspark.sql import DataFrame, SparkSession
import findspark

findspark.add_packages('mysql:mysql-connector-java:8.0.11')


def open_data(spark: SparkSession, table: str) -> DataFrame:
    _query = f'SELECT * FROM {table}'
    _trips_df = spark.read.format("jdbc") \
            .option("url", "jdbc:mysql://mysql_host:3306/mydb") \
            .option("driver", "com.mysql.jdbc.Driver") \
            .option("query", _query) \
            .option("user", "user") \
            .option("password", "user") \
            .load()

    return _trips_df





def open_csv(spark: SparkSession, file_path: str, sep: str):
    df = spark.read.csv(file_path, sep=sep, header=True, inferSchema=True)
    return df