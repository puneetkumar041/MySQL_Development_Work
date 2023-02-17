### Scripts for Day to Day tasks and regular DBA activities 

![MySQL](https://img.shields.io/badge/-MySQL-black?style=flat-square&logo=mysql)

### Partitioning

Partitioning in MySQL is used to split or partition the rows of a table into separate tables in different locations, but still, it is treated as a single table. It distributes the portions of the table's data across a file system based on the rules we have set as our requirement. 
Benefits of Partitioning

The following are the benefits of partitioning in MySQL:

*) It optimizes the query performance. When we query on the table, it scans only the portion of a table that will satisfy the particular statement.

*) It is possible to store extensive data in one table that can be held on a single disk or file system partition.

*) It provides more control to manage the data in your database.

Types of MySQL Partitioning
MySQL has mainly six types of partitioning, which are given below:

*) RANGE Partitioning
*) LIST Partitioning
*) COLUMNS Partitioning
*) HASH Partitioning
*) KEY Partitioning
*) Subpartitioning

Here in this branch we have discussed about Range Partitining 
 
 ### MySQL RANGE Partitioning

This partitioning allows us to partition the rows of a table based on column values that fall within a specified range. The given range is always in a contiguous form but should not overlap each other, and also uses the VALUES LESS THAN operator to define the ranges.



### Server Monitoring 

Server monitoring helps to monitor your servers and entire infrastructure for critical performance metrics and stay on top of your data center resources. Get in-depth visibility into key performance indicators of your application servers, mail servers, web servers, virtual servers, and database servers to eliminate outages and performance issues

Monitor below parameters with the help of scripts

*) Service Running or not. 

*) MySQL server's RAM usage 

*) MySQL server's Disk utilization

*) MySQL server's CPU utlization 

*) Load on MySQL Server 

### USER management

MySQL server allows us to create numerous users and databases and grant appropriate privileges so that the users can access and manage databases.
The information_schema, mysql, performance_schema, and sys databases are created at installation time and they are storing information about all other databases, system configuration, users, permission and other important data. These databases are necessary for the proper functionality of the MySQL installation.

*) User creation  

*) Grants privileges to Database and to Tables  

*) Resetting Passwords

*) Revoking permissions

*) User migrations

### Archiving 
As the data in MySQL keeps growing, the performance for all the queries will keep decreasing. Typically, queries that originally took milliseconds can now take seconds (or more). That requires a lot of changes (code, MySQL, etc.) to make faster.

The main goal of archiving the data is to increase performance (“make MySQL fast again”), decrease costs and improve ease of maintenance (backup/restore, cloning the replication slave, etc.)

*) Customize archiving script for n number of days 
