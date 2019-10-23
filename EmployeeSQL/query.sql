-- Create new tables

CREATE TABLE departments (
  dept_no VARCHAR(10) NOT NULL,
  dept_name varchar(30) NOT NULL
);

CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(10),
  from_date DATE,
  to_date DATE
);

CREATE TABLE dept_manager (
  dept_no VARCHAR(10) NOT NULL,
  emp_no INT,
  from_date DATE,
  to_date DATE
);

CREATE TABLE employees (
  emp_no INT NOT NULL,
  birth_date DATE,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  gender VARCHAR(5),
  hire_date DATE
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT,
  from_date DATE,
  to_date DATE
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR(30),
  from_date DATE,
  to_date DATE
);

-- List the following details of each employee: 
-- employee number, last name, first name, gender, and salary.
Select employees.emp_no As employee_number, employees.last_name As l_name, employees.first_name As f_name,
       employees.gender As gender, salaries.salary As salary
From employees
Left join salaries
On employees.emp_no = salaries.emp_no;

-- List employees who were hired in 1986.
Select * From employees
WHERE    hire_date >= '1986-01-01'
AND      hire_date <  '1987-01-01';

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
Select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
From dept_manager As dm
Left join employees As e On dm.emp_no = e.emp_no
Left join departments As d On dm.dept_no = d.dept_no;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
Select e.emp_no, e.last_name, e.first_name, d.dept_name 
From employees As e
Left join dept_emp As de On e.emp_no = de.emp_no
Left join departments As d On de.dept_no = d.dept_no;

-- List all employees whose first name is "Hercules" and last names begin with "B."
Select emp_no, first_name, last_name From employees
Where first_name = 'Hercules' and last_name LIKE 'B%';


-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
Select e.emp_no, e.last_name, e.first_name, d.dept_name
From employees As e
Left join dept_emp As de On e.emp_no = de.emp_no
Left join departments As d On de.dept_no = d.dept_no
Where d.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
Select e.emp_no, e.last_name, e.first_name, d.dept_name
From employees As e
Left join dept_emp As de On e.emp_no = de.emp_no
Left join departments As d On de.dept_no = d.dept_no
Where d.dept_name = 'Sales' or d.dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
Select count(last_name), last_name
From employees
Group by last_name
Order by last_name desc;
