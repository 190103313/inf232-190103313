SELECT * FROM employees;
--PART 1
/*1.Write a query to display the name ( first name and last name ) 
for those employee who get smore salary than the employee whose ID is 163.*/

/*SELECT * FROM employees
WHERE employee_id=163;*/

SELECT first_name, last_name 
FROM employees 
WHERE salary > ( SELECT salary  
FROM employees 
WHERE employee_id=163); 

/*2.Write a query to display the name ( first name and last name ), salary, department id, 
job id for those employees who works in same designation as the employee works whose id is 169*/

/*SELECT job_id
FROM employees
WHERE employee_id=169;*/

SELECT first_name, last_name, salary, department_id, job_id
FROM employees
WHERE job_id = (SELECT job_id 
FROM employees
WHERE employee_id=169);

/*3.Write a query to display the name ( first name and last name ), salary, 
department id for those employees who earn such amount of salary which is the smallest salary of any of the departments.*/  

SELECT first_name, last_name, salary, department_id  
FROM employees  
WHERE salary IN  ( SELECT MIN(salary)  
FROM employees  
GROUP BY department_id 
);

/*4.Write a query to display the employee id, employee name (first name and last name )
for all employees who earn more than the average salary.*/  

/*SELECT AVG(salary)
FROM employees;*/

SELECT employee_id, first_name,last_name  
FROM employees  
WHERE salary >  ( SELECT AVG(salary)  
FROM employees 
);

/*5.Write a query to display the employee name ( first name and last name ), employee id and salary of all employees who report 
to Payam. */

/*SELECT employee_id
FROM employees
WHERE first_name='Payam';*/

SELECT first_name, last_name, employee_id, salary
FROM employees  
WHERE manager_id = (SELECT employee_id  
FROM employees  
WHERE first_name = 'Payam' 
);

/*6.Write a query to display the department number, name ( first name and last name ), job and department name for all employees 
in the Finance department.  */

SELECT e.department_id, e.first_name, e.job_id , d.department_name  
FROM employees e , departments d  
WHERE e.department_id = d.department_id  
AND  d.department_name = 'Finance';

--PART 2
/*7. Write a query to display all the information of an employee whose salary and reporting person id is 3000 and 121 
respectively.

SELECT * FROM employees WHERE (salary,manager_id)=(SELECT 3000,121);*/

--8. Display all the information of an employee whose id is any of the number 134, 159 and 183

SELECT * 
FROM employees 
WHERE employee_id IN (134,159,183);

--9.Write a query to display all the information of the employees whose salary is within the range 1000 and 3000.  

SELECT * FROM employees 
WHERE salary BETWEEN 1000 and 3000;

--10.Write a query to display all the information of the employees whose salary if within the range of smallest salary and 2500

/*SELECT MIN(salary)
FROM employees;*/

SELECT * 
FROM employees 
WHERE salary BETWEEN  
(SELECT MIN(salary) 
FROM employees) AND 2500;

/*11. Write a query to display all the information of the employees who does not works in those departments where some employees 
works whose id within the range 100 and 200.  */

SELECT * 
FROM employees 
WHERE department_id NOT IN 
(SELECT department_id 
FROM departments 
WHERE manager_id BETWEEN 100 AND 200);

--12. Write a query to display all the information for those employees whose id is any id who earn second highest salary.  

SELECT * 
FROM employees 
WHERE employee_id IN 
(SELECT employee_id 
FROM employees  
WHERE salary = (SELECT MAX(salary) 
FROM employees 
WHERE salary < (SELECT MAX(salary) 
FROM employees)));

/*13. Write a query to display the employee name( first name and last name ) and hiredate for all employees in the same 
department as Clara. Exclude Clara.*/

SELECT first_name, last_name, hire_date  
FROM employees  
WHERE department_id =  ( SELECT department_id  
FROM employees  
WHERE first_name = 'Clara')  
AND first_name <> 'Clara';

/*14. Write a query to display the employee number and name( first name and last name ) for all employees who work in 
a department with any employee whose name contains a T.*/

SELECT employee_id, first_name, last_name 
FROM employees  
WHERE department_id IN  
( SELECT department_id  
FROM employees  
WHERE first_name LIKE '%T%' );

/*15.Write a query to display the employee number, name( first name and last name ), and salary for all employees who earn more 
than the average salary and who work in a department with any employee with a J in their name.*/

SELECT employee_id, first_name , salary  
FROM employees  
WHERE salary > 
(SELECT AVG (salary)  
FROM employees ) 
AND  department_id IN 
( SELECT department_id  
FROM employees  
WHERE first_name LIKE '%J%');

/*16. Display the employee name( first name and last name ), employee id, and job title for all employees whose department 
location is Toronto.*/

SELECT  first_name, last_name, employee_id, job_id  
FROM employees  
WHERE department_id = (SELECT department_id  
FROM departments 
WHERE location_id = (SELECT location_id 
FROM locations  
WHERE city ='Toronto'));

/*17. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose 
salary is smaller than any salary of those employees whose job title is MK_MAN.*/

SELECT employee_id,first_name,last_name,job_id
FROM employees 
 WHERE salary < ANY 
 ( SELECT salary  
 FROM employees  
 WHERE job_id = 'MK_MAN' );
 
 /*18. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose 
 salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN*/

SELECT employee_id,first_name,last_name, job_id, salary 
FROM employees 
WHERE salary < ANY 
( SELECT salary 
FROM employees 
WHERE job_id = 'MK_MAN' ) 
AND job_id <> 'MK_MAN';

/*19. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose 
salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.*/

SELECT employee_id, first_name, last_name, job_id
FROM employees  
WHERE salary > ALL  
( SELECT salary  
FROM employees  
WHERE job_id = 'PU_MAN' )  
AND job_id <> 'PU_MAN';

/*20. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose 
salary is more than any average salary of any department.*/

SELECT employee_id, first_name, last_name, job_id  
FROM employees  
WHERE salary > ALL  
( SELECT AVG(salary)  
FROM employees  
GROUP BY department_id 
);

/*21. Write a query to display the employee name( first name and last name ) and department for all employees for any existence 
of those employees whose salary is more than 3700.*/

SELECT first_name, last_name, department_id 
FROM employees 
WHERE EXISTS 
(SELECT * 
FROM employees
WHERE salary >3700 );

/*22. Write a query to display the department id and the total salary for those departments which contains at least one salaried
employee.  */

SELECT departments.department_id, result1.total_amt 
FROM departments,  
( SELECT employees.department_id, SUM(employees.salary) total_amt  
FROM employees  
GROUP BY department_id) result1 
WHERE result1.department_id = departments.department_id;

/*23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title 
SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.  */

SELECT  employee_id,  first_name, last_name,  
CASE job_id  
WHEN 'ST_MAN' THEN 'SALESMAN'  
WHEN 'IT_PROG' THEN 'DEVELOPER'  
ELSE job_id  
END AS designation,  salary 
FROM employees;

/*24.Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with
title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all 
employees*/

SELECT  employee_id,  first_name, last_name, salary,  
CASE WHEN salary >= (SELECT AVG(salary) 
FROM employees) THEN 'HIGH'  
ELSE 'LOW'  
END AS SalaryStatus 
FROM employees;

--PART 3
/*25. Write a query to display the employee id, name ( first name and last name ), SalaryDrawn,
AvgCompare (salary - average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively 
for those employees whose salary is more than and less than the average salary of all employees.*/

SELECT  employee_id,  first_name, last_name,  salary AS SalaryDrawn,  
ROUND((salary -(SELECT AVG(salary) FROM employees)),1) AS AvgCompare,  
CASE  WHEN salary >= 
(SELECT AVG(salary) 
FROM employees) THEN 'HIGH'  
ELSE 'LOW'  
END AS SalaryStatus 
FROM employees;

/*26. Write a subquery that return a set of rows to find all departments that do actually have one or more employees assigned to
them.*/

SELECT  department_name 
FROM departments 
WHERE department_id IN 
(SELECT DISTINCT(department_id) 
FROM employees);

--27. Write a query that will identify all employees who work in departments located in the United Kingdom.

SELECT first_name 
FROM employees 
WHERE department_id IN 
(SELECT department_id 
FROM departments 
WHERE location_id IN 
(SELECT location_id 
FROM locations 
WHERE country_id = 
(SELECT country_id 
FROM countries 
WHERE country_name='United Kingdom')));

--28. Write a query to identify all the employees who earn more than the average and who work in any of the IT departments. 

SELECT last_name 
FROM employees 
WHERE department_id IN 
(SELECT department_id 
FROM departments 
WHERE department_name LIKE 'IT%') 
AND salary > 
(SELECT avg(salary) 
FROM employees);

--29. Write a query to determine who earns more than Mr. Ozer

SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 
(SELECT salary 
FROM employees 
WHERE last_name='Ozer') 
ORDER BY  last_name;

--30.Write a query to find out which employees have a manager who works for a department based in the US.

SELECT first_name,last_name FROM employees 
WHERE manager_id IN 
(SELECT employee_id 
FROM employees 
WHERE department_id IN 
(SELECT department_id 
FROM departments 
WHERE location_id IN 
(SELECT location_id 
FROM locations 
WHERE country_id='US')));

/*31. Write a query which is looking for the names of all employees whose salary is greater than 50% of their department’s total
salary bill.*/

SELECT e1.first_name, e1.last_name 
FROM employees e1 
WHERE salary > 
( SELECT (SUM(salary))*.5 
FROM employees e2 
WHERE e1.department_id=e2.department_id);

--32. Write a query to get the details of employees who are managers.

SELECT * 
FROM employees 
WHERE EXISTS 
(SELECT * 
FROM departments 
WHERE manager_id = employee_id);

--33. Write a query to get the details of employees who manage a department.

SELECT * 
FROM employees 
WHERE employee_id=ANY 
( SELECT manager_id FROM departments );

/*34. Write a query to display the employee id, name ( first name and last name ), salary,
department name and city for all the employees who gets the salary as the salary earn by the
employee which is maximum within the joining person January 1st 2002 and December 31st
2003.

SELECT a.employee_id, a.first_name, a.last_name, a.salary, b.department_name, c.city  
FROM employees a, departments b, locations c  
WHERE a.salary =  
(SELECT MAX(salary) 
FROM employees 
WHERE hire_date BETWEEN '01/01/2002' AND '12/31/2003') 
AND a.department_id=b.department_id 
AND b.location_id=c.location_id;*/