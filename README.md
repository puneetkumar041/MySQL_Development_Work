<img width="150" alt="Screenshot 2023-02-17 at 9 48 17 AM" src="https://user-images.githubusercontent.com/25247630/219548391-874c9fe8-45c8-46a0-ae7e-425659632eb3.png">


### Development Tasks for Day to Day Activities including stored procedure, cursor, event 

<img width="180" alt="image" src="https://user-images.githubusercontent.com/25247630/219543934-9b5d5fd8-1b72-4173-b3a4-f16499f954b3.png">

If we consider the enterprise application, we always need to perform specific tasks such as database cleanup, processing payroll, and many more on the database regularly. Such tasks involve multiple SQL statements for executing each task. This process might easy if we group these tasks into a single task. We can fulfill this requirement in MySQL by creating a stored procedure in our database.

### Stored Procedure Features

*) Stored Procedure increases the performance of the applications. Once stored procedures are created, they are compiled and stored in the database.

*) Stored procedure reduces the traffic between application and database server. Because the application has to send only the stored procedure's name and parameters instead of sending multiple SQL statements.

*) Stored procedures are reusable and transparent to any applications.

*) A procedure is always secure. The database administrator can grant permissions to applications that access stored procedures in the database without giving any permissions on the database tables.

    ###Procedure without Parameter

    DELIMITER $$
    
    DROP PROCEDURE IF EXISTS `getcount_student` $$
    
    CREATE PROCEDURE `getcount_student`()
    
    BEGIN 
    
    SELECT * FROM student_info WHERE marks > 70;  
    
    SELECT COUNT(stud_code) AS Total_Student FROM student_info;    

    END $$
   
    DELIMITER ;

Let us call the procedure to verify the output:

    CALL getcount_student();  



    ###Procedure without Parameter

    DELIMITER $$
    
    DROP PROCEDURE IF EXISTS `getcount_student` $$
    
    CREATE PROCEDURE `getcount_student`()
    
    BEGIN 
    
    SELECT * FROM student_info WHERE marks > 70;  
    
    SELECT COUNT(stud_code) AS Total_Student FROM student_info;    

    END $$
   
    DELIMITER ;

Let us call the procedure to verify the output:

    CALL getcount_student(); 
    
    
    
<img width="98" alt="Screenshot 2023-02-17 at 9 53 52 AM" src="https://user-images.githubusercontent.com/25247630/219549151-1ff5eaaa-edab-471c-b4ca-5e218f19d640.png">

To handle a result set inside a stored procedure, you use a cursor. A cursor allows you to iterate a set of rows returned by a query and process each row individually.




<img width="144" alt="Screenshot 2023-02-17 at 9 54 23 AM" src="https://user-images.githubusercontent.com/25247630/219549075-24d2b924-f81d-4904-a17d-cfe09b951bc6.png">

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



