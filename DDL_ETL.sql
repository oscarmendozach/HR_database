/*Tables creation following the physical model*/

CREATE TABLE education(
    EDLVL_ID SERIAL PRIMARY KEY,
    ED_LVL VARCHAR(50)
);

CREATE TABLE employee(
    EMP_ID VARCHAR(10) PRIMARY KEY,
    EMP_NM VARCHAR(50),
    EMAIL VARCHAR(50),
    HIRE_DT DATE,
    EDLVL_ID INT REFERENCES education(EDLVL_ID)
);

CREATE TABLE department(
    DEPT_ID SERIAL PRIMARY KEY,
    DEPT_NM VARCHAR(50)
);

CREATE TABLE job(
    JOB_ID SERIAL PRIMARY KEY,
    JOB_NM VARCHAR(50),
    DEPT_ID INT REFERENCES department(DEPT_ID)
);

CREATE TABLE state(
    STATE_ID SERIAL PRIMARY KEY,
    STATE_NM VARCHAR(50)
);

CREATE TABLE city(
    CITY_ID SERIAL PRIMARY KEY,
    CITY_NM VARCHAR(50),
    STATE_ID INT REFERENCES state(STATE_ID)
);

CREATE TABLE location(
    LOC_ID SERIAL PRIMARY KEY,
    LOC_NM VARCHAR(50)
);

CREATE TABLE address(
    ADD_ID SERIAL PRIMARY KEY,
    ADD_NM VARCHAR(100),
    CITY_ID INT REFERENCES city(CITY_ID),
    LOC_ID INT REFERENCES location(LOC_ID)
);

CREATE TABLE jobhist(
    JH_ID SERIAL PRIMARY KEY,
    EMP_ID VARCHAR(10) REFERENCES employee(EMP_ID),
    JOB_ID INT REFERENCES job(JOB_ID),
    ADD_ID INT REFERENCES address(ADD_ID),
    MAN_ID INT REFERENCES employee(EMP_ID),
    START_DT DATE,
    END_DT DATE
);

CREATE TABLE salary(
    SAL_ID SERIAL PRIMARY KEY,
    JH_ID INT REFERENCES jobhist(JH_ID),
    SALARY NUMERIC
);

/*Tables population using CRUD and DML*/

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

INSERT INTO jobhist(EMP_ID, JOB_ID, ADD_ID, MAN_ID, START_DT, END_DT)
SELECT DISTINCT p.EMP_ID, j.JOB_ID, a.ADD_ID, e.EMP_ID AS MAN_ID, START_DT, END_DT
FROM proj_stg p
JOIN job j
ON p.job_title = j.JOB_NM
JOIN address a
ON p.address = a.ADD_NM
JOIN employee
ON p.manager = e.EMP_NM;
