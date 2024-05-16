-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/wFjuil
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS titles CASCADE;

CREATE TABLE "departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" VARCHAR(255)   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "emp_no" VARCHAR(255)   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" VARCHAR(255)   NOT NULL,
    "emp_title_id" VARCHAR(255)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(255)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" VARCHAR(255)   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(255)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


------------------------------------------------------------------------------------------
---------------------------------------Analysis-------------------------------------------
------------------------------------------------------------------------------------------

-----List the employee number, last name, first name, sex, and salary of each employee-----
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees INNER JOIN salaries on employees.emp_no = salaries.emp_no

-----List the first name, last name, and hire date for the employees who were hired in 1986-----
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1/1/1986' and hire_date < '1/1/1987'

-----List the manager of each department along with their department number, department name,-----
--employee number, last name, and first name-----
SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.first_name,
employees.last_name
FROM departments LEFT OUTER JOIN dept_manager ON (departments.dept_no = dept_manager.dept_no)
LEFT OUTER JOIN employees ON (dept_manager.emp_no = employees.emp_no)

-----List the department number for each employee along with that employee’s employee number,-----
--last name, first name, and department name-----
SELECT dept_emp.dept_no, dept_emp.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM dept_emp LEFT OUTER JOIN departments ON (dept_emp.dept_no = departments.dept_no)
LEFT OUTER JOIN employees ON (dept_emp.emp_no = employees.emp_no)

-----List first name, last name, and sex of each employee whose first name is Hercules and whose-----
--last name begins with the letter B-----
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%'

-----List each employee in the Sales department, including their employee number, last name,-----
--and first name-----
SELECT employees.emp_no, employees.last_name, employees.first_name
FROM employees LEFT OUTER JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
LEFT OUTER JOIN departments ON (dept_emp.dept_no = departments.dept_no)
WHERE departments.dept_name = 'Sales'

-----List each employee in the Sales and Development departments, including their employee number,-----
--last name, first name, and department name-----
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees LEFT OUTER JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
LEFT OUTER JOIN departments ON (dept_emp.dept_no = departments.dept_no)
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'

-----List the frequency counts, in descending order, of all the employee last names (that is,-----
--how many employees share each last name)-----
SELECT last_name, count(last_name) as total FROM employees
GROUP BY last_name ORDER BY total DESC






