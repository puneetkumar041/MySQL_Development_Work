<img width="150" alt="Screenshot 2023-02-17 at 9 48 17 AM" src="https://user-images.githubusercontent.com/25247630/219548391-874c9fe8-45c8-46a0-ae7e-425659632eb3.png">


### ⚡ Development Tasks for Day to Day Activities including stored procedures, cursors, triggers, events... 

<img width="180" alt="image" src="https://user-images.githubusercontent.com/25247630/219543934-9b5d5fd8-1b72-4173-b3a4-f16499f954b3.png">

If we consider the enterprise application, we always need to perform specific tasks such as database cleanup, processing payroll, and many more on the database regularly. Such tasks involve multiple SQL statements for executing each task. This process might easy if we group these tasks into a single task. We can fulfill this requirement in MySQL by creating a stored procedure in our database.

### Stored Procedure Features...

*) Stored Procedure increases the performance of the applications. Once stored procedures are created, they are compiled and stored in the database.

*) Stored procedure reduces the traffic between application and database server. Because the application has to send only the stored procedure's name and parameters instead of sending multiple SQL statements.

*) Stored procedures are reusable and transparent to any applications.

*) A procedure is always secure. The database administrator can grant permissions to applications that access stored procedures in the database without giving any permissions on the database tables.

### Procedure without Parameter...

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


### Procedure without Parameter

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


### Features of a MySQL Cursor...

*) A cursor is read-only and cannot update or remove data in the result set from the procedure.

*) A cursor needs to be declared before it can be used. The cursor definition is only a step to tell MySQL that such a cursor exists and does not retrieve and data.

*) You can only retrieve data in the order specified by the select statement and not in any reverse order, commonly known as non-scrollable.

*) You use a cursor by opening it and then perform fetch operations on the data stored.

*) You must close a cursor after the fetch operations complete.

*) cursor makes the specific task easier by iterating each table row. 


### Working with MySQL cursor...

First, declare a cursor by using the DECLARE statement:

    DECLARE cursor_name CURSOR FOR SELECT_statement;
    

The cursor declaration must be after any variable declaration. If you declare a cursor before the variable declarations, MySQL will issue an error. A cursor must always associate with a SELECT statement.

Next, open the cursor by using the OPEN statement. The OPEN statement initializes the result set for the cursor, therefore, you must call the OPEN statement before fetching rows from the result set.

    OPEN cursor_name;


Then, use the FETCH statement to retrieve the next row pointed by the cursor and move the cursor to the next row in the result set.

    FETCH cursor_name INTO variables list;


After that, check if there is any row available before fetching it.

Finally, deactivate the cursor and release the memory associated with it  using the CLOSE statement:

    CLOSE cursor_name;


It is a good practice to always close a cursor when it is no longer used.
When working with MySQL cursor, you must also declare a NOT FOUND handler to handle the situation when the cursor could not find any row.

Because each time you call the FETCH statement, the cursor attempts to read the next row in the result set. When the cursor reaches the end of the result set, it will not be able to get the data, and a condition is raised. The handler is used to handle this condition.

To declare a NOT FOUND handler, you use the following syntax:

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;


The finished is a variable to indicate that the cursor has reached the end of the result set. Notice that the handler declaration must appear after variable and cursor declaration inside the stored procedures.



 
    
### How it works...

### <img width="591" alt="Screenshot 2023-02-17 at 9 58 44 AM" src="https://user-images.githubusercontent.com/25247630/219570739-03b54dc8-f52e-47b5-8b9b-6140ceea2f36.png">


    
 ### Procedure using cursor...
 
 	use tests;

	use DB;

	DELIMITER $$

	DROP PROCEDURE IF EXISTS delete_duplicate_emp_email$$

	CREATE PROCEDURE delete_duplicate_emp_email()

	BEGIN 

	DECLARE v_id int(11);
	DECLARE v_name varchar(20);
	DECLARE v_email varchar(100);
	DECLARE done_handler INT(5) DEFAULT '0';
	DECLARE done INT DEFAULT 0;
	DECLARE crsr CURSOR FOR SELECT id,name,email FROM employees where done_flag=0;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;
	SET done = 0;

	   
	OPEN crsr;

	REPEAT

	FETCH  crsr  INTO v_id,v_name,v_email ;

	IF NOT done THEN 

	delete b.* from employee_email b where  b.uw_item_id= v_id and b.name =v_name and  b.id!=v_email;

	update employees set done_flag=1 where uw_item_id= v_id and name =v_name and email=v_email;

	SET done = done_handler;

	END IF;      

	UNTIL done END REPEAT;

	CLOSE crsr;

	END $$

	DELIMITER ;
 
 
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

Here we have discussed about Range Partitining 
 
 ### MySQL RANGE Partitioning...

This partitioning allows us to partition the rows of a table based on column values that fall within a specified range. The given range is always in a contiguous form but should not overlap each other, and also uses the VALUES LESS THAN operator to define the ranges.

Here we have added script for add partition and remove partition keeping certain number of days partitons and made the process automatic using mysql events




