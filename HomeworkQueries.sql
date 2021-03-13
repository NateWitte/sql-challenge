-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "Titles" (
    "titleID" varchar(30)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "titleID"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(30)   NOT NULL,
    "birth_date" varchar(30)   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(30)   NOT NULL,
    "hire_date" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

-- Table documentation comment 1 (try the PDF/RTF export)
-- Table documentation comment 2
CREATE TABLE "DeptManager" (
    "dept_no" varchar(30)   NOT NULL,
    -- Field documentation comment 1
    -- Field documentation comment 2
    -- Field documentation comment 3
    "emp_no" int   NOT NULL
);

CREATE TABLE "DeptEmp" (
    "deptempid" serial   NOT NULL,
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL,
    CONSTRAINT "pk_DeptEmp" PRIMARY KEY (
        "deptempid"
     )
);

CREATE TABLE "Departments" (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Salaries" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("titleID");

ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "DeptEmp" ADD CONSTRAINT "fk_DeptEmp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "DeptEmp" ADD CONSTRAINT "fk_DeptEmp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

--Get employee number, last name, first name, sex, and salary
select "Employees".emp_no, "Employees".last_name, 
"Employees".first_name, "Employees".sex, "Salaries".salary
from "Employees"
inner join "Salaries" on 
"Employees".emp_no = "Salaries".emp_no;

--Get first name, last name, and hire date from those who were hired in 1986
select "Employees".first_name, "Employees".last_name, "Employees".hire_date
from "Employees"
where cast(right("Employees".hire_date,4) as int) = 1986;

--Get the department number, department name, the manager's employee number, 
--last name, first name for each manager of each department
select "Departments".dept_no, "Departments".dept_name, "DeptManager".emp_no, 
"Employees".last_name, "Employees".first_name
from "Departments"
inner join "DeptManager" on "Departments".dept_no = "DeptManager".dept_no
inner join "Employees" on "DeptManager".emp_no = "Employees".emp_no;

-- Get employee number, last name, first name, and department name
select "Employees".emp_no, "Employees".last_name, "Employees".first_name, 
"Departments".dept_name
from "Employees"
inner join "DeptEmp" on "Employees".emp_no="DeptEmp".emp_no
inner join "Departments" on "DeptEmp".dept_no = "Departments".dept_no;

-- List first name, last name, and sex for employees whose first name is 
-- "Hercules" and last names begin with "B"
select first_name, last_name, sex
from "Employees"
where first_name = 'Hercules' and last_name like 'B%';

-- List all employees in the sales and development departments, including their 
-- employee number, last name, first name, and department name
select "Employees".emp_no, "Employees".last_name, "Employees".first_name, 
"Departments".dept_name
from "Employees"
inner join "DeptEmp" on "Employees".emp_no = "DeptEmp".emp_no
inner join "Departments" on "DeptEmp".dept_no = "Departments".dept_no
where "Departments".dept_name = 'Sales' or "Departments".dept_name = 'Development';

--In descending order, list the frequency count of employee names
select last_name, count(last_name)
from "Employees"
group by last_name
order by count(last_name) desc;
