SELECT
    lc.city ,dept.department_id
FROM HR.locations lc, HR.departments dept
WHERE dept.location_id = lc.location_id;
SELECT 
    UNIQUE(emp.department_id) , lc.city 
FROM  HR.employees emp, HR.locations lc, HR.departments dept
    WHERE lc.location_id = dept.location_id and lc.city like 'Southlake';
   

;
ORDER BY emp.department_id asc;
SELECT 
    dept.department_id, dept.department_name, dept.manager_id
FROM  HR.departments dept
ORDER BY dept.department_id asc;
    ;
SELECT
     *United States of America
FROM HR.countries;
                                
    JOIN HR.departments dept on emp.last_name LIKE 'King' and dept.department_id = emp.department_id
        jOIN HR.locations lc on lc.location_id = dept.location_id;

/*1 ЗАДАНИЕ*/
SELECT
    emp.last_name,dept.department_name, locations.city, locations.street_address
FROM HR.employees emp
    JOIN HR.departments dept on emp.department_id = dept.department_id and not emp.commission_pct is null
        JOIN HR.locations locations on dept.location_id = locations.location_id;
/*2 ЗАДАНИЕ*/
SELECT
   UNIQUE( jb.job_title), lc.street_address
FROM HR.employees emp
    JOIN  HR.jobs jb on emp.department_id = '80' and jb.job_id = emp.job_id
        JOIN HR.departments dept on dept.department_id = emp.department_id
            JOIN HR.locations lc on lc.location_id = dept.location_id;
             
/*3 ЗАДАНИЕ*/                                                                           
SELECT
    emp.last_name, jb.job_title
FROM HR.employees emp
    JOIN HR.jobs jb on REGEXP_LIKE (emp.last_name, 'a') and jb.job_id = emp.job_id;
    
/*4 ЗАДАНИЕ*/
SELECT
   emp.last_name, jb.job_title, dept.department_id, dept.department_name
FROM HR.locations lc
    JOIN HR.departments dept on REGEXP_LIKE(lc.city, 'Toronto') and dept.location_id = lc.location_id
        JOIN HR.employees emp on dept.department_id = emp.department_id
            JOIN HR.jobs jb on jb.job_id = emp.job_id;
/*5 ЗАДАНИЕ*/          
SELECT 
    emp.last_name Employee, emp.employee_id Emp#, man.last_name Manager, emp.manager_id Mgr#
FROM HR.employees emp, HR.employees man
   WHERE   emp.manager_id is not null and emp.manager_id = man.employee_id
    ORDER BY emp.employee_id, man.manager_id asc;
   
/*6 ЗАДАНИЕ*/
SELECT 
    emp.last_name Employee, emp.employee_id Emp#, man.last_name Manager, emp.manager_id Mgr#
FROM HR.employees emp, HR.employees man
   WHERE   emp.manager_id is null or emp.manager_id = man.employee_id 
    ORDER BY emp.employee_id, man.manager_id asc;
    
/*7 ЗАДАНИЕ*/
SELECT
    emp.last_name Служащий,emp.department_id "id", emp1.last_name "Служащий = id dep", emp1.department_id "id"
FROM HR.employees emp
    JOIN HR.employees emp1 on emp1.department_id = emp.department_id and emp.last_name != emp1.last_name;

/*8 ЗАДАНИЕ*/
SELECT
    emp.last_name, jb.job_title, dept.department_name, emp.salary
FROM HR.employees emp
    JOIN HR.departments dept on dept.department_id = emp.department_id 
        JOIN HR.jobs jb on jb.job_id = emp.job_id
        ORDER BY emp.salary asc;
    
/*9 ЗАДАНИЕ*/
SELECT 
    emp.last_name, emp.hire_date, emp1.last_name, emp1.hire_date
FROM HR.employees emp 
    JOIN HR.employees emp1 on emp.last_name like 'Davies' and emp.hire_date < emp1.hire_date
    order by emp1.hire_date asc;

/*10 ЗАДАНИЕ*/
SELECT
    emp.last_name "Служащий", emp.hire_date "Дата найма №1", man.last_name "Менеджер", man.hire_date "Дата найма №2"
FROM HR.employees man
    JOIN HR.employees emp on emp.hire_date < man.hire_date;



/*ЛАБА 8*/
/*1 ЗАДАНИЕ*/
SELECT
    dept.department_name, max(jb.max_salary), min(jb.min_salary), min(emp.hire_date), max(emp.hire_date), count(emp.employee_id)
FROM HR.employees emp, HR.departments dept, HR.jobs jb
    WHERE dept.department_id = emp.department_id and jb.job_id = emp.job_id
        GROUP BY dept.department_name;
    
 /*2 ЗАДАНИЕ*/
SELECT
    TO_CHAR(emp.hire_date, 'YYYY'), count(emp1.employee_id)
FROM HR.employees emp
   JOIN HR.employees emp1 on TO_CHAR(emp.hire_date, 'YYYY') = TO_CHAR(emp1.hire_date, 'YYYY')   
        GROUP BY emp.hire_date
            ORDER BY count(emp1.employee_id), TO_CHAR(emp.hire_date) asc;
    
/*3 ЗАДАНИЕ*/
SELECT
    emp.manager_id, count(emp.employee_id), sum(emp.salary)
FROM HR.employees emp   
    JOIN HR.employees emp1 on emp.employee_id = emp1.employee_id
        GROUP BY emp.manager_id
            HAVING count(emp.employee_id) > 5 and sum(emp.salary) > 50000;
    
/*4 ЗАДАНИЕ*/
SELECT 
 emp.department_id, AVG(emp.salary)
FROM HR.employees emp
  GROUP BY emp.department_id
    HAVING  AVG(emp.salary)>= ALL(SELECT AVG(emp1.salary) FROM HR.employees emp1 GROUP BY emp1.department_id);
    
    
/*ЛАБА 9*/
/*1 ЗАДАВНИЕ*/
SELECT
   emp.department_id, dept.department_name "название департамента", concat(emp.first_name, emp.last_name) AS "имя руководителя"
   FROM HR.employees emp, HR.departments dept, 
            (SELECT
                lc.location_id
            FROM HR.employees emp
                JOIN HR.departments dept on emp.last_name LIKE 'King' and dept.department_id = emp.department_id
                jOIN HR.locations lc on lc.location_id = dept.location_id) dept1 
    WHERE dept.location_id = dept1.location_id AND emp.manager_id = dept.manager_id;
       
/*2 ЗАДАНИЕ*/
SELECT
    dept.department_name
FROM HR.departments dept, (SELECT 
                                lc.location_id 
                            FROM HR.countries cn 
                            JOIN HR.locations lc on cn.country_name LIKE 'United States of America' AND lc.country_id = cn.country_id) loc_id
    WHERE dept.location_id =  loc_id.location_id;

/*3 ЗАДАНИЕ*/
SELECT 
    dept.department_name, emp.last_name
FROM  HR.employees emp, (SELECT 
                                lc.location_id 
                            FROM HR.countries cn 
                            JOIN HR.locations lc on cn.country_name LIKE 'United States of America' AND lc.country_id = cn.country_id) loc_id,
                        (SELECT
                            emp.department_id, count(emp.job_id)
                         FROM HR.jobs jb JOIN HR.employees emp on jb.job_title LIKE 'Programmer' AND emp.job_id = jb.job_id
                         GROUP BY emp.department_id
                         HAVING count(emp.job_id) >= 1) dept_id, HR.departments dept
    WHERE  dept.location_id = loc_id.location_id  
           AND dept.department_id = dept_id.department_id 
           AND emp.department_id = dept.department_id;                
 
/*4 ЗАДАНИЕ*/
SELECT
  lc.city "Название города", cou.countDept "Количество департаментов" /*, sum(sumsal.sumSalary) "Сумарная затраты на оплату зарплаты"*/
FROM HR.locations lc, HR.employees emp, HR.departments dept,( SELECT  
                          lc.city AS city1,  count(emp.department_id) AS countDept 
                        FROM HR.locations lc 
                        JOIN HR.departments dept on dept.location_id = lc.location_id 
                        JOIN HR.employees emp on emp.department_id = dept.department_id GROUP BY lc.city) cou , 
                        (SELECT emp.department_id, emp.employee_id, emp.salary FROM 

 WHERE lc.city = cou.city1
 GROUP BY  lc.city, cou.countDept;                       
                       
                        
    /*(SELECT 
        sum(emp.salary) AS sumDeptSal
    FROM HR.employees emp 
        GROUP BY emp.department_id ) sum1,
    (SELECT
        count(emp.employee_id) as countEmpDept
    FROM HR.employees emp 
        JOIN HR.departments dept on dept.department_id = emp.department_id 
            GROUP BY emp.department_id) cou1*/
 SELECT  
        count(dept.department_id) AS countDept
    FROM HR.locations lc, HR.departments dept 
        GROUP BY lc.city;
 
  SELECT emp.department_id as depart_id, sum(emp.salary) as sumSalary FROM HR.locations lc
                                                                JOIN HR.departments dept on dept.location_id = lc.location_id  
                                                                JOIN HR.employees emp on emp.department_id = dept.department_id GROUP BY emp.department_id
 
SELECT count(emp.employee_id)FROM HR.employees emp JOIN HR.departments dept on dept.department_id = emp.department_id GROUP BY emp.department_id;
 
 SELECT emp.department_id, sum(emp.salary) FROM HR.locations lc
                                                                JOIN HR.departments dept on dept.location_id = lc.location_id  
                                                                JOIN HR.employees emp on emp.department_id = dept.department_id GROUP BY emp.department_id;
 
 SELECT lc.city, count(emp.department_id) FROM HR.locations lc JOIN HR.departments dept on dept.location_id = lc.location_id JOIN HR.employees emp on emp.department_id = dept.department_id GROUP BY lc.city;
 
SELECT lc.location_id FROM HR.countries cn JOIN HR.locations lc on cn.country_name LIKE 'United States of America' AND lc.country_id = cn.country_id;

select emp.manager_id "Employees", max(emp.employee_id)
    from HR.employees emp
group by emp.manager_id;

select count(emp.department_id), emp.job_id
from HR.employees emp
group by emp.job_id
having count(emp.department_id) = '80'
                                                   
/*
select emp.last_name, emp.department_id, dept.department_name
from HR.employees emp
join HR.departments dept on emp.department_id = dept.department_id;
*/