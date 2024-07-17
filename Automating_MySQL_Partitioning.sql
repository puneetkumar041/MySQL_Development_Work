-- ----------------------------------------
Step 1: Creating Sample Table
-- ----------------------------------------

CREATE TABLE Partition_Table  (
    id INT AUTO_INCREMENT PRIMARY KEY,
    CreatedAt DATETIME,
    -- Add other columns as needed
) PARTITION BY RANGE (YEAR(CreatedAt)) (
    PARTITION p0 VALUES LESS THAN (1990),
    PARTITION p1 VALUES LESS THAN (1991),
    PARTITION p2 VALUES LESS THAN (1992),
    PARTITION p3 VALUES LESS THAN (1993),
    PARTITION p4 VALUES LESS THAN (1994),
    PARTITION p5 VALUES LESS THAN MAXVALUE
);

-- ----------------------------------------
Step 2: Setting Up Automatic Maintenance
-- ----------------------------------------

DELIMITER $$
CREATE EVENT daily_perform_partition_maintenance_event
 ON SCHEDULE EVERY 1 DAY STARTS NOW()
DO
 CALL perform_partition_maintenance('db_name', 'Partition_Table ', 1, 3, 5);
$$
DELIMITER ;

-- ----------------------------------------
Step 3: Creating New Partitions
-- ----------------------------------------


DROP PROCEDURE IF EXISTS create_new_partitions;
DELIMITER $$
CREATE PROCEDURE create_new_partitions(p_schema varchar(64), p_table varchar(64), p_months_to_add int)
BEGIN 
    DECLARE current_date DATETIME;
    SET current_date = NOW();
    
    DECLARE new_partition_start DATETIME;
    DECLARE new_partition_end DATETIME;
    
    SET new_partition_start = ADDDATE(current_date, INTERVAL p_months_to_add MONTH);
    SET new_partition_end = ADDDATE(new_partition_start, INTERVAL 1 YEAR);

    SET @sql = CONCAT(
        'ALTER TABLE `', p_schema, '`.`', p_table, '` ',
        'ADD PARTITION (',
            'PARTITION p', YEAR(new_partition_start), ' ',
            'VALUES LESS THAN (', YEAR(new_partition_end), ')'
        ')'
    );
    
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;
$$
DELIMITER ;

-- ----------------------------------------
Step 4: Procedure to drop old partitions
-- ----------------------------------------


DROP PROCEDURE IF EXISTS drop_old_partitions;
DELIMITER $$
CREATE PROCEDURE drop_old_partitions(p_schema varchar(64), p_table varchar(64), p_months_to_keep int)
BEGIN 
    DECLARE cutoff_date DATETIME;
    SET cutoff_date = ADDDATE(NOW(), INTERVAL -p_months_to_keep MONTH);
    
    SET @sql = CONCAT(
        'ALTER TABLE `', p_schema, '`.`', p_table, '` ',
        'DROP PARTITION p', YEAR(cutoff_date)
    );
    
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;
$$
DELIMITER ;

-- ----------------------------------------
Step 5: Coordinating Maintenance
-- ----------------------------------------

DELIMITER $$
CREATE PROCEDURE perform_partition_maintenance(p_schema varchar(64), p_table varchar(64), p_months_to_add int, p_months_to_keep int, p_seconds_to_sleep int)
BEGIN 
 CALL drop_old_partitions(p_schema, p_table, p_months_to_keep, p_seconds_to_sleep);
 CALL create_new_partitions(p_schema, p_table, p_months_to_add);
END;
$$
DELIMITER ;