/*ETL*/

INSERT INTO education(ED_LVL)
SELECT DISTINCT education_lvl 
FROM proj_stg;

INSERT INTO employee
SELECT DISTINCT p.emp_id, p.emp_nm, p.email, p.hire_dt, e.edlvl_id
FROM proj_stg p
JOIN education e
ON p.education_lvl = e.ED_LVL;

INSERT INTO department(DEPT_NM)
SELECT DISTINCT department_nm
FROM proj_stg;

INSERT INTO job(JOB_NM)
SELECT DISTINCT job_title
FROM proj_stg;

INSERT INTO state(STATE_NM)
SELECT DISTINCT state
FROM proj_stg;

INSERT INTO city(CITY_NM, STATE_ID)
SELECT DISTINCT p.city, s.STATE_ID
FROM proj_stg p
JOIN state s
ON s.STATE_NM = P.state;

INSERT INTO location(LOC_NM)
SELECT DISTINCT location
FROM proj_stg;

INSERT INTO address(ADD_NM, CITY_ID, LOC_ID)
SELECT DISTINCT p.address, c.CITY_ID, l.LOC_ID
FROM proj_stg p
JOIN city c
ON p.city = c.CITY_NM
JOIN location l
ON p.location = l.LOC_NM;

INSERT INTO jobhist(EMP_ID, JOB_ID, DEPT_ID, ADD_ID, MAN_ID, START_DT, END_DT)
SELECT DISTINCT p.EMP_ID, j.JOB_ID, d.DEPT_ID, a.ADD_ID, e.EMP_ID AS MAN_ID, START_DT, END_DT
FROM proj_stg p
JOIN job j
ON p.job_title = j.JOB_NM
JOIN department d
ON p.department_nm = d.DEPT_NM
JOIN address a
ON p.address = a.ADD_NM
LEFT JOIN employee e
ON p.manager = e.EMP_NM;

INSERT INTO salary(JH_ID, SALARY)
SELECT jh.JH_ID, p.salary
FROM proj_stg p
JOIN jobhist jh
ON p.emp_id = jh.emp_id AND p.start_dt = jh.start_dt AND p.end_dt = jh.end_dt;