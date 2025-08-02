## Sales Reporting System – Advanced SQL Server Project
Overview
This project demonstrates advanced SQL Server querying and performance tuning techniques using a sales reporting system.
It is fully containerized using Docker and designed for portability, reproducibility, and professional showcasing of SQL expertise.

## Features
Advanced SQL queries using:

CTEs (Common Table Expressions)

Window Functions: RANK, LAG, DATEDIFF

PIVOT and CASE

GROUPING SETS

Recursive CTE

Performance Optimization:

Use of Indexes and Filtered Indexes

Analysis with Execution Plans

I/O and Time Statistics via SET STATISTICS

Containerized SQL Server via Docker Compose

Modular and clean project structure for easy navigation

 
## Quick Start

Clone this repository
git clone https://github.com/mgolozar/sqlserver-docker-project.git
cd sqlserver-docker-project
Start SQL Server with Docker Compose

cd docker
docker-compose up -d
Connect using VSCode

Use SQL Server extension.

Server: localhost, Port: 1433, Login: sa, Password: YourStrong!Pass123

Run Scripts

Execute init.sql and sample_data.sql to prepare the database.

Explore and run queries/advanced_queries.sql.

## Sample Queries & Techniques
✅ Customer Spending with RANK
Ranks customers by total amount spent using RANK() over total purchases.

✅ Sales Category Classification
Categorizes products based on total units sold using CASE.

✅ Multi-level Aggregation with GROUPING SETS
Provides flexible aggregation in a single query.

✅ Purchase Behavior Analysis
Uses LAG() and DATEDIFF() to calculate time between customer purchases.

✅ Recursive CTE for Order Hierarchy
Demonstrates hierarchical query patterns.

📈 Performance Tuning Highlights
Created Index on OrderItems (OrderID, ProductID) to improve join speed.

Used Filtered Index for products with price > 1000.

Enabled SET STATISTICS IO/TIME for query tuning.

Sample Output (Execution Stats)
 
Logical Reads: 12
CPU Time: 5 ms
Elapsed Time: 7 ms
Execution Plan shows Index Seek (90%) instead of Table Scan.

 

## Technologies Used
Tool/Tech	Purpose
SQL Server 2022	Core database engine
Docker Compose	Containerized database
VSCode + mssql	Query writing and connection
GitHub	Version control and code sharing

## Learning Goals
Write professional, production-level SQL.

Optimize queries for speed and resource efficiency.

Work in Docker-based environments for real-world deployment.

## License
MIT License – feel free to fork, use, or adapt.

## Author
Your Name
DevOps / Data Engineer | LinkedIn | GitHub

## Next Steps?
Add real-world data for deeper analytics.

Extend with stored procedures or views.

Integrate with Power BI / Grafana for dashboarding.

