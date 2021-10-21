/*Q1. Return a list of employees with Job Titles and Department Names */
SELECT e.EMP_NM, j.JOB_NM, d.DEPT_NM
FROM employee e
JOIN jobhist jh
ON jh.emp_id = e.emp_id
JOIN job j 
ON jh.job_id = j.job_id
JOIN department d
ON jh.dept_id = d.dept_id;

/*Q2. Insert Web Programmer as a new job title*/
 INSERT INTO job (JOB_NM)
 VALUES('Web Programmer');

/*Q3. Correct the job title from web programmer to web developer*/
UPDATE job
SET JOB_NM = 'Web Developer'
WHERE JOB_NM = 'Web Programmer';

/*Q4. Delete the job title Web Developer from the database*/
DELETE FROM job
WHERE JOB_NM = 'Web Developer';

/*Q5. How many employees are in each department?*/

SELECT d.DEPT_NM AS department, COUNT(jh.EMP_ID) as number_employees
FROM department d
JOIN jobhist jh
ON jobhist.dept_id = d.DEPT_ID
GROUP BY department

/*Write a query that returns current and past jobs (include employee name, job title, department, manager name, start and end date for position) for employee Toni Lembeck.*/
SELECT e.EMP_NM, j.JOB_NM, d.DEPT_NM, jh.MAN_ID, m.EMP_NM AS MAN_NM, START_DT, END_DT
FROM employee e
JOIN jobhist jh
ON e.EMP_ID = jh.EMP_ID
JOIN job j 
ON jh.JOB_ID = j.JOB_ID
JOIN department d
ON d.DEPT_ID = jh.DEPT_ID
JOIN employee m
ON m.EMP_ID = jh.EMP_ID 
WHERE  e.EMP_NM = 'Toni Lembeck';