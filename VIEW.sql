/* CREATE VIEW */
CREATE VIEW report AS
SELECT jh.EMP_ID AS EMP_ID, 
        e.EMP_NM AS EMP_NM,
        e.email AS EMAIL,
        e.HIRE_DT AS HIRE_DT,
        j.JOB_NM AS JOB_TITLE,
        s.SALARY AS SALARY,
        d.DEPT_NM AS DEPARTMENT,
        m.EMP_NM AS MANAGER,
        jh.START_DT AS START_DT,
        jh.END_DT AS END_DT,
        l.LOC_NM AS LOCATION,
        a.ADD_NM AS ADDRESS,
        c.CITY_NM AS CITY,
        st.STATE_NM AS STATE,
        ed.ED_LVL AS EDUCATION_LEVEL
FROM employee e
JOIN education ed
ON e.edlvl_id = ed.edlvl_id
JOIN jobhist jh
ON e.emp_id = jh.emp_id
JOIN job j
ON jh.job_id = j.job_id
JOIN salary s
ON jh.jh_id = s.jh_id
JOIN employee m
ON jh.man_id = m.emp_id
JOIN department d
ON d.dept_id = jh.dept_id
JOIN address a
ON a.add_id = jh.add_id
JOIN location l
ON a.loc_id = l.loc_id
JOIN city c
ON a.city_id = c.city_id
JOIN state st
ON st.state_id = c.state_id
