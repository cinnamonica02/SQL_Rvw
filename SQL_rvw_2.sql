/* Specifying the database wel use */
DROP DATABASE IF EXISTS Parks_and_Recreation;
CREATE DATABASE Parks_and_Recreation;
USE Parks_and_Recreation;



DROP TABLE IF EXISTS employee_demographics;

DROP TABLE IF EXISTS employee_salary;

DROP TABLE IF EXISTS parks_departments;

CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);


INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);



CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');

SELECT * FROM Parks_and_Recreation.employee_demographics;

SELECT first_name,
last_name,
birth_date,
age, 
age + 10
FROM Parks_and_Recreation.employee_demographics;


SELECT DISTINCT first_name, gender
FROM Parks_and_Recreation.employee_demographics;



########################################-- WHERE CLAUSE -- #####################################

SELECT * 
FROM employee_salary
WHERE first_name = 'Leslie'
;

SELECT * 
FROM employee_salary
WHERE first_name = 'Leslie'
;


SELECT * 
FROM employee_salary
WHERE salary >= 50000
;

SELECT * 
FROM employee_demographics
WHERE gender = 'Female'
;

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01' 
AND gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;


####################################-- LIKE Statement -- ######################################## 

-- Help us look for patterns 
-- we specify data type using % ( could be any char / val)
-- _ - help us specify the num of chars 

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%'
;

# a comes at the beggining 
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___'
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___'
;

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;


############################-- Group by and order by Clause in MySQL -- #####################

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary 
;

SELECT gender, AVG(age) , MAX(age)
FROM employee_demographics
GROUP BY gender
;

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC
;

SELECT *
FROM employee_demographics
ORDER BY gender, age ASC
;

SELECT *
FROM employee_demographics
ORDER BY age , gender
;

SELECT *
FROM employee_demographics
ORDER BY 5, 4 # getting the positions we want - same o/p - NOT GOOD PRACTICE THO
;

#################################-- HAVING VS WHERE clause :3  ---##############################

SELECT gender, AVG(age) 
FROM employee_demographics
WHERE AVG(age)> 40
GROUP BY gender
;

## Here is where we need to use the having clause !

SELECT gender, AVG(age) 
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40 # as it comes after group by so  we can filter these 
;

# While in general youl end up using WHERE clauses a lot more,
# when you want to filter out agregate functions HAVING comes 
# into play !

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation 
HAVING AVG(salary) > 75000
;

######################################-- Limit and Aliasing --################################## 

# LIMIT helps you select specific no. of rows or columns 

SELECT *
FROM employee_demographics
LIMIT 3 
;


## We can also combine this with ORDER BY 

# Here for eg, we are taking the top 3 oldest members 
SELECT * 
FROM employee_demographics 
ORDER BY age DESC 
LIMIT 3 
;

SELECT * 
FROM employee_demographics 
ORDER BY age DESC 
LIMIT 2, 1 # specifying position - we start at position 2 and select the one after it 
;

-- Aliasing --

# Aliasing is just renaming a column - it can come in helpful when 
# working with joins 

SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 30
;



#########################################-- Joins --#########################################



SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary; 

-- INNER JOIN --

# An inner join is going to return rows that are the same in both
# tables 

SELECT *
FROM employee_demographics AS emp_dem
INNER JOIN employee_salary AS emp_sal
# Using keywor ON specify table and primary key for both tables 
	ON emp_dem.employee_id = emp_sal.employee_id
;

SELECT emp_dem.employee_id, age, occupation
FROM  employee_demographics AS emp_dem
INNER JOIN employee_salary AS emp_sal
# Using keywordON specify table and primary key for both tables 
	ON emp_dem.employee_id = emp_sal.employee_id
;

-- Outer Joins -- 

# We have left (outer ) join - 

# Will take everything from left table and only return 
# matches from right table 

SELECT *
FROM  employee_demographics AS emp_dem
LEFT JOIN employee_salary AS emp_sal
# Using keywordON specify table and primary key for both tables 
	ON emp_dem.employee_id = emp_sal.employee_id
;


# Or right (outer ) join 

SELECT *
FROM  employee_demographics AS emp_dem
RIGHT JOIN employee_salary AS emp_sal
# Using keywordON specify table and primary key for both tables 
	ON emp_dem.employee_id = emp_sal.employee_id
;


-- Self JOIN 

# when were joining the same table together 

SELECT emp1.employee_id AS emp_sampta
FROM employee_salary AS emp1 
JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together -- 

# employee_demographics tied to employee_salary 
# and employee_salary tied to parks_departments => tying multiple
# tables together 
SELECT *
FROM employee_demographics AS emp_dem
INNER JOIN employee_salary AS emp_sal
	ON emp_dem.employee_id = emp_sal.employee_id
INNER JOIN parks_departments AS park_dep
	ON emp_sal.dept_id = park_dep.department_id
;

# Reference table
SELECT *
FROM parks_departments;




###################################### -- Unions -- ############################################

 -- UNIONS allow us to combine rows together from separate or same tables --
 -- unlike columns (like in JOINS) -- we do this by taking two SELECT statements
 -- and taking UNION to combine them 
 
SELECT *
FROM employee_demographics
UNION
SELECT *
FROM employee_salary
;
 -- and tada! weve done a union
 
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary
;

-- by default when we perform these UNION(s) it will be UNION DISTINCT
-- which means wel only be getting the unique values , thus we have much 
-- less entries when executing this query. 

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;

-- Here we are using UNION ALL and now we also get the duplicates 



SELECT first_name, last_name, 'Old Male Employee' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'Old Female Employee' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Expensive' AS Label
FROM employee_salary AS emp_sal
WHERE emp_sal.salary > 70000
ORDER BY first_name, last_name
;

-- In this particular query we have used UNIONs to filter out the old employees
-- and the high pay employees and found both old and high paying ones
-- stay safe folks T^T the job market is tough out there 


################################# -- String Functions -- #####################################

-- String functions help use strings and build strings differently in MySQL

--  LENGTH --

SELECT LENGTH('puertorico');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2
;

-- UPPER --

SELECT UPPER('y si tu la vez');
SELECT LOWER('y si tu la vez');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;


################################-- TRIM / SUBSTRINGS --###########################

-- LEFT trim
-- RIGHT trim 
-- SUBSTRING -- 
-- Trim gets rid of white spaces
SELECT TRIM('             tqm                ');
SELECT LTRIM('             tqm                ');
SELECT RTRIM('             tqm                ');

-- Here we are getting rid of the left chars except for first 4 -- 

SELECT first_name,
 LEFT(first_name, 4),
 RIGHT(first_name, 4)
FROM employee_demographics
;

-- Substring -- 
-- using substring here we pulled out the birthdate month from the employees

SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3,2),
birth_date,
SUBSTRING(birth_date, 6,2) AS birth_month
FROM employee_demographics
;


-- Replace -- 
-- Replace will replace specific chars with a different char that you want 
SELECT first_name, REPLACE(first_name, 'a','z') -- replacing lowercase a w/ z
FROM employee_demographics
;

-- LOCATE -- 

SELECT LOCATE('x', 'Alexander');
; 
-- looking for ppl that have 'An' in their name 
SELECT first_name, LOCATE('An', first_name) -- replacing lowercase a w/ z
FROM employee_demographics
;

-- CONCAT -- 
-- Concatenation of multiple columns 

SELECT first_name, last_name,
CONCAT(first_name, ' ' ,last_name) AS full_name
FROM employee_demographics
;



########################### -- Case Statements -- ############################

-- Alow us to make sort of  if - else statements in SQL -- 

SELECT first_name, last_name, age,
CASE 
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN 'Close to retiring'
END AS Youth_status
FROM employee_demographics
;

-- Say were asked to determine which employees are going to get a bonus 
-- at the end of the year and which are not --

-- Pay Increase and Bonus --
-- < 50000 = 5% 
-- > 50000 = 7% 
-- Finance dpt = 10% 


SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
	WHEN salary > 50000 THEN salary + (salary * 0.07)
END AS salary_with_bonus_non_fin,
CASE 
	WHEN dept_id = 6 THEN salary * .10
END AS salary_with_bonus
FROM employee_salary
;

SELECT *
FROM employee_salary
;
SELECT *
FROM parks_departments
;


############################ -- Subqueries -- ###############################

-- Query w/in another query --
-- We can do subqueries in several ways - using WHERE, SELECT and FRONT
-- clauses. --


-- Say we want to select the employees that work in the parks and rec deprt
-- we could join the two tables but we dont want to do this - so this is 
-- where  a subqueries come into play 
SELECT *
FROM employee_demographics
WHERE employee_id IN
					-- subquery --
					( SELECT employee_id
						FROM employee_salary
                        WHERE dept_id = 1
)
;

SELECT first_name, salary,
(SELECT AVG(salary) FROM employee_salary)  AS avg_emp_sal
FROM employee_salary
;

SELECT max_age
FROM
-- subquery --
	(SELECT gender,
	 AVG(age) AS avg_age, -- aliasing --
	 MAX(age) AS max_age,
	 MIN(age) AS min_age,
	 COUNT(age) AS age_count
	FROM employee_demographics
	GROUP BY gender) AS agg_table
;


SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;





############################ -- Window Functions -- #######################

-- Window functions allow us to look at a partition or group but they each
-- keep their own unique rows in the o/p

-- Now lets see how to get avg salary by gender 
-- using GROUP BY vs with window function 

SELECT gender, AVG(salary) AS avg_sal
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
	GROUP BY gender
;

-- We use  OVER() and it sort of 'looks' through the entire col --

SELECT gender, AVG(salary) OVER() AS avg_salary_of_col
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
;

-- We can combine OVER() with PARTITION BY to get what we want --

SELECT gender, AVG(salary) OVER(PARTITION BY gender) AS sal_by_gender
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
;

SELECT emp_dem.first_name, emp_dem.last_name, gender, AVG(salary)
 OVER(PARTITION BY gender) AS sal_by_gender
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
;

SELECT emp_dem.first_name, emp_dem.last_name, gender, AVG(salary)
 OVER(PARTITION BY gender) AS sal_by_gender
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
;
-- Partitioning by total sum / gender 

SELECT emp_dem.first_name, emp_dem.last_name, gender, SUM(salary)
OVER(PARTITION BY gender) AS sal_by_gender
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
;
-- Performing rolling sum -- 
-- Here for eg, were adding each salary to the already existing total
-- so its sort of like a rolling total 

SELECT emp_dem.first_name, emp_dem.last_name, gender, salary,
	SUM(salary) OVER(PARTITION BY gender
    ORDER BY emp_dem.employee_id) AS rolling_total
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
ON emp_dem.employee_id = emp_sal.employee_id
;

-- Now lets take a look at the things that we can specifically do with WINDOW functions

-- ROW_NUMBER() -- 
-- Sort of like an agregate function --
-- take the entries row and return it 

SELECT emp_dem.first_name, emp_dem.last_name, gender, salary,
ROW_NUMBER() OVER()
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
ON emp_dem.employee_id = emp_sal.employee_id
;

-- RANK -- 

SELECT emp_dem.first_name, emp_dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
ON emp_dem.employee_id = emp_sal.employee_id
;

-- DENSE_RANK -- 

SELECT emp_dem.first_name, emp_dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
DENSE_RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num,
RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
ON emp_dem.employee_id = emp_sal.employee_id
;


############################### -- Advanced SQL -- ################################


-- CTEs -- (Common Table Expression)- allow you to define a subquery block that 
-- you can then reference within the main query. 

-- You can only use CTE's inmediately after you create it 


WITH CTE_examp AS 
(
SELECT gender, AVG(salary) AS avg_sal, MAX(salary) AS max_sal, MIN(salary) AS min_sal, COUNT(salary) AS sal_count
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
	GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Examp
;

-- You can def perform this using a subquery -- its just a little bit harder to read
-- and in professional environments CTEs are preferred
SELECT AVG(avg_sal)
FROM(
SELECT gender, AVG(salary) AS avg_sal, MAX(salary) AS max_sal, MIN(salary) AS min_sal, COUNT(salary) AS sal_count
FROM employee_demographics AS emp_dem
	JOIN employee_salary AS emp_sal -- basic join -- 
		ON emp_dem.employee_id = emp_sal.employee_id
	GROUP BY gender
) AS example_subquery
;

-- As said before, we can only execute CTEs inmediately after we create them--
-- since we are not storing it in memory we are just querying it once 
SELECT AVG(avg_sal)
FROM CTE_Examp
;

-- Joining multiple CTEs at once -- 

WITH CTE_Examp AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics 
WHERE birth_date > '1985-01-01'
),
CTE_Examp2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Examp
JOIN CTE_Examp2
	ON CTE_Examp.employee_id = CTE_Examp2.employee_id
;

############################### -- Temp Tables -- ##################################

-- Temporary Tables (Temp tables ) are only visible to the session they are 
-- created in. 
-- They can be useful to store intermediate results for complex queries ! -- 


CREATE TEMPORARY TABLE temp_table 
(
	first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(50)
);

SELECT *
FROM temp_table

 INSERT INTO temp_table
 VALUES('Pepe', 'Guevara', 'X-Men')
 ;
 
 SELECT *
 FROM temp_table
 ;

 SELECT *
 FROM employee_salary
 ;

-- Naming conventions are important so naming the table `temp_table` is
-- not a good practice in irl scenarios !


-- Were creating a temporary table based of a already existing table
-- and were selecting data into this table -- 

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000





############################## -- Stored Procedures -- #############################

 -- Stored procedures come in useful when were doing more advanced queries,
 -- similar to temp tables but we actually store the data 


CREATE PROCEDURE large_emp_sal()
 SELECT *
 FROM employee_salary
 WHERE salary >= 50000
 ;
 
 CALL large_emp_sal()
 ;
 
 
 -- In reality when using stored procedures a lot more is going on, 
 -- so to avoid confusion instead of using ; as the delimiter we can
 -- customize it using $$ for instance
 
 
DELIMITER $$
CREATE PROCEDURE large_emp_sal2()
BEGIN
	 SELECT *
	 FROM employee_salary
	 WHERE salary >= 50000;
	 SELECT *
	 FROM employee_salary
	 WHERE salary >= 10000;
END $$
-- and for best practice we change it back at the end 
DELIMITER ;

CALL large_emp_sal2()

-- Params -- 

-- Vars stored as i/p into stored procedures -- 



































 






























 





