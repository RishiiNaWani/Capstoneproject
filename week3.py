import mysql.connector as connector

# Establish the connection
connection = connector.connect(
    user='root',
    password='rfiTbos@12',
    database='mydb'
)

# Create a cursor object
cursor = connection.cursor()

# Execute the query to select the database
cursor.execute('USE mydb')

# Define the query to show tables
show_tables_query = "SHOW TABLES"

# Execute the query
cursor.execute(show_tables_query)

# Fetch the results
results = cursor.fetchall()


join_table_query = (
    """SELECT c.FullName, c.ContactNumber, o.TotalCost  
       FROM customers c 
       INNER JOIN orders o 
       ON c.CustomerID = o.CustomerID 
       WHERE o.TotalCost > 60;
    """)
cursor.execute(join_table_query)
result1 = cursor.fetchall()

for i in result1:
    print(i)
