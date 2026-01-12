-- ================================================
-- HR EMPLOYEE ATTRITION AND PERFORMANCE ANALYSIS
-- Queries to answer key business questions
-- Author: Zulfi Nadhia Cahyani
-- ================================================

USE hr_attrition;
SHOW TABLES;

-- ===========================================
-- 1. Workforce Overview and Attrition Metrics
-- ===========================================

-- 1.1 Overall Employee Attrition Rate

-- Purpose:
-- Compute the company's overall attrition rate by comparing total employees to those who left.

-- Notes:
-- - Attrition counted only for 'Yes'.
-- - DISTINCT ensures employees aren't double-counted.
-- - Shows total employees, attritions, and attrition percentage.

WITH overall_attrition AS (
SELECT COUNT(DISTINCT(EmployeeID)) AS total_employee,
		COUNT(DISTINCT CASE WHEN Attrition = 'Yes' THEN EmployeeID END) AS total_attrition
FROM employee
)

SELECT *,
		ROUND((total_attrition / total_employee * 100),2) AS attrition_rate_percent
FROM overall_attrition;

-- 1.2 Attrition Rate by Department

-- Purpose:
-- Calculate attrition rates for each department and show each department's contribution to total attritions.

-- Notes:
-- - Counts only employees with Attrition = 'Yes'.
-- - DISTINCT prevents double-counting employees.
-- - attrition_rate_percent shows the rate within the department.
-- - percent_attrition_distribution shows each department's share of total attritions.

WITH attrition_by_department AS (
SELECT Department,
		COUNT(DISTINCT(EmployeeID)) AS total_employee,
		COUNT(DISTINCT CASE WHEN Attrition = 'Yes' THEN EmployeeID END) AS total_attrition
FROM employee
GROUP BY Department
)

SELECT *,
		ROUND((total_attrition * 100 / total_employee),2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (),2) AS percent_attrition_distribution
FROM attrition_by_department
ORDER BY attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- 1.3 Attrition Rate by Job Role

-- Purpose:
-- Compute attrition rates for each job role and show each role's contribution to total attritions.

-- Notes:
-- - Counts only employees with Attrition = 'Yes'.
-- - DISTINCT prevents double-counting employees.
-- - attrition_rate_percent shows the rate within the job role.
-- - percent_attrition_distribution shows each role's share of total attritions.

WITH attrition_by_job AS (
SELECT JobRole,
		COUNT(DISTINCT(EmployeeID)) AS total_employee,
		COUNT(DISTINCT CASE WHEN Attrition = 'Yes' THEN EmployeeID END) AS total_attrition
FROM employee
GROUP BY JobRole
)

SELECT *,
		ROUND((total_attrition * 100 / total_employee),2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (),2) AS percent_attrition_distribution
FROM attrition_by_job
ORDER BY attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- 1.4 Attrition Rate by Gender

-- Purpose:
-- Calculate attrition rates by gender and each gender's contribution to overall attritions.

-- Notes:
-- - Counts only employees with Attrition = 'Yes'.
-- - DISTINCT prevents double-counting employees.
-- - attrition_rate_percent shows the rate within each gender.
-- - percent_attrition_distribution shows each gender's share of total attritions.

WITH attrition_by_gender AS (
SELECT Gender,
		COUNT(DISTINCT(EmployeeID)) AS total_employee,
		COUNT(DISTINCT CASE WHEN Attrition = 'Yes' THEN EmployeeID END) AS total_attrition
FROM employee
GROUP BY Gender
)

SELECT *,
		ROUND((total_attrition * 100 / total_employee),2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (),2) AS percent_attrition_distribution
FROM attrition_by_gender
ORDER BY attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- 1.5 Attrition Rate by Age Groups

-- Purpose:
-- Analyze attrition rates across age groups and their contribution to total attritions.

-- Notes:
-- - Employees are grouped by age ranges.
-- - Counts only employees with Attrition = 'Yes'.
-- - attrition_rate_percent shows the rate within each age group.
-- - percent_attrition_distribution shows each group's share of total attritions.

WITH attrition_by_age_group AS (
SELECT 
    CASE 
		WHEN Age BETWEEN 18 AND 25 THEN '18-25'
		WHEN Age BETWEEN 26 AND 35 THEN '26-35'
		WHEN Age BETWEEN 36 AND 45 THEN '36-45'
		WHEN Age BETWEEN 46 AND 55 THEN '46-55'
		ELSE '55+' 
    END AS age_group,
    COUNT(DISTINCT(EmployeeID)) AS total_employee,
	COUNT(DISTINCT CASE WHEN Attrition = 'Yes' THEN EmployeeID END) AS total_attrition
FROM employee
GROUP BY age_group
)

SELECT *,
		ROUND((total_attrition * 100 / total_employee),2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (),2) AS percent_attrition_distribution
FROM attrition_by_age_group
ORDER BY age_group, attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- ================================
-- 2. Employee Performance Analysis
-- ================================

-- 2.1 Distribution of Employee Performance Ratings

-- Purpose:
-- Analyze the distribution of performance ratings across employees 
-- to understand how many employees fall into each rating level.

-- Notes:
-- - Uses DISTINCT to avoid double-counting employees.
-- - percent_performance_rating shows each rating's share of total employees.
-- - Joins rating_level to get descriptive labels for ManagerRating.

SELECT PR.ManagerRating AS performance_rating,
		RL.RatingLevel AS rating_description, 
		COUNT(DISTINCT(E.EmployeeID)) AS total_employee,
        ROUND(COUNT(DISTINCT E.EmployeeID) * 100 / SUM(COUNT(DISTINCT E.EmployeeID)) OVER (),2) AS percent_performance_rating
FROM employee E
JOIN performance_rating PR
	ON E.EmployeeID = PR.EmployeeID
JOIN rating_level RL
	ON PR.ManagerRating = RL.RatingID
GROUP BY performance_rating, rating_description
ORDER BY performance_rating;

-- 2.2 Impact of Performance on Employee Attrition

-- Purpose:
-- Evaluate how attrition varies by performance rating and determine 
-- each rating's contribution to overall attrition.

-- Notes:
-- - Counts only employees with Attrition = 'Yes' for total_attrition.
-- - DISTINCT ensures employees aren't double-counted.
-- - attrition_rate_percent shows attrition within each rating.
-- - percent_attrition_distribution shows each rating's share of total attritions.

WITH attrition_by_performance AS (
SELECT PR.ManagerRating AS performance_rating,
		RL.RatingLevel AS rating_description,
		COUNT(DISTINCT(E.EmployeeID)) AS total_employee,
		COUNT(DISTINCT CASE WHEN E.Attrition = 'Yes' THEN E.EmployeeID END) AS total_attrition
FROM employee E
JOIN performance_rating PR
	ON E.EmployeeID = PR.EmployeeID
JOIN rating_level RL
	ON PR.ManagerRating = RL.RatingID
GROUP BY performance_rating, rating_description
)

SELECT *,
		ROUND((total_attrition * 100 / total_employee),2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (),2) AS percent_attrition_distribution
FROM attrition_by_performance
ORDER BY performance_rating, attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- =========================================
-- 3. Satisfaction and Compensation Analysis
-- =========================================

-- 3.1 Impact of Satisfaction Levels on Attrition

-- Purpose:
-- Analyze how job satisfaction levels relate to employee attrition and each level's contribution to total attritions.

-- Notes:
-- - Counts only employees with Attrition = 'Yes'.
-- - DISTINCT prevents double-counting employees.
-- - attrition_rate_percent shows attrition within each satisfaction level.
-- - percent_attrition_distribution shows each level's share of total attritions.

WITH attrition_by_satisfaction AS (
SELECT SL.SatisfactionLevel,
		COUNT(DISTINCT(E.EmployeeID)) AS total_employee,
        COUNT(DISTINCT(CASE WHEN E.Attrition='Yes' THEN E.EmployeeID END)) AS total_attrition
FROM employee E
JOIN performance_rating PR
	ON E.EmployeeID = PR.EmployeeID
JOIN satisfied_level SL
	ON PR.JobSatisfaction = SL.SatisfactionID
GROUP BY SatisfactionLevel
)

SELECT *,
		ROUND((total_attrition * 100 / total_employee), 2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (), 2) AS percent_attrition_distribution
FROM attrition_by_satisfaction
ORDER BY attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- 3.2 Impact of Compensation on Employee Attrition

-- Purpose:
-- Evaluate how attrition varies across salary categories and determine each category's share of total attritions.

-- Notes:
-- - Employees are grouped into Lower, Medium, and High salary categories.
-- - Counts only employees with Attrition = 'Yes'.
-- - attrition_rate_percent shows attrition within each salary group.
-- - percent_attrition_distribution shows each group's contribution to total attritions.

WITH attrition_by_salary AS (
SELECT CASE 
			WHEN Salary < 200000 THEN 'Lower Salary' 
            WHEN Salary BETWEEN 200000 AND 400000 THEN 'Medium Salary'
            WHEN Salary > 400000 THEN 'High Salary'
		END AS salary_category,
		COUNT(DISTINCT(EmployeeID)) AS total_employee,
        COUNT(DISTINCT(CASE WHEN Attrition = 'Yes' THEN EmployeeID END)) AS total_attrition
FROM employee
GROUP BY salary_category
)

SELECT *,
		ROUND((total_attrition * 100 /  total_employee), 2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (), 2) AS percent_attrition_distribution
FROM attrition_by_salary
ORDER BY attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- ===========================================
-- 4. Education and Career Development Factors
-- ===========================================

-- 4.1 Distribution of Employee Education Level

-- Purpose:
-- Analyze the distribution of employees across education levels to understand workforce composition.

-- Notes:
-- - Uses DISTINCT to avoid double-counting employees.
-- - percent_education_level shows each education level's share of total employees.
-- - Joins education_level table to get descriptive labels for Education ID.

SELECT EL.EducationLevelID AS education_level,
		EL.EducationLevel AS education_level_description,
		COUNT(DISTINCT(E.EmployeeID)) AS total_employee,
        ROUND(COUNT(DISTINCT(E.EmployeeID)) * 100 / SUM(COUNT(DISTINCT(E.EmployeeID))) OVER(), 2) AS percent_education_level
FROM employee E
JOIN education_level EL
	ON E.Education = EL.EducationLevelID
GROUP BY education_level, education_level_description
ORDER BY education_level;

-- 4.2 Attrition by Education Level

-- Purpose:
-- Examine attrition rates by education level and each level's contribution to total attritions.

-- Notes:
-- - Counts only employees with Attrition = 'Yes'.
-- - DISTINCT ensures employees aren't double-counted.
-- - attrition_rate_percent shows attrition within each education level.
-- - percent_attrition_distribution shows each level's share of total attritions.

WITH attrition_by_education AS (
SELECT EL.EducationLevelID AS education_level,
		EL.EducationLevel AS education_level_description,
		COUNT(DISTINCT(E.EmployeeID)) AS total_employee,
        COUNT(DISTINCT(CASE WHEN E.Attrition = 'Yes' THEN E.EmployeeID END)) AS total_attrition
FROM employee E
JOIN education_level EL
	ON E.Education = EL.EducationLevelID
GROUP BY education_level, education_level_description
)

SELECT *,
		ROUND((total_attrition * 100 /  total_employee), 2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (), 2) AS percent_attrition_distribution
FROM attrition_by_education
ORDER BY education_level, attrition_rate_percent DESC, percent_attrition_distribution DESC;

-- 4.3 Attrition by Career Stage

-- Purpose:
-- Analyze attrition rates by career stage and each stage's contribution to overall attritions.

-- Notes:
-- - Employees grouped as Early, Mid, or Late Career based on tenure.
-- - Counts only employees with Attrition = 'Yes'.
-- - attrition_rate_percent shows attrition within each career stage.
-- - percent_attrition_distribution shows each stage's share of total attritions.

WITH attrition_by_career_stage AS (
SELECT CASE 
			WHEN YearsAtCompany < 3 THEN 'Early Career' 
            WHEN YearsAtCompany BETWEEN 3 AND 8 THEN 'Mid Career'
            WHEN YearsAtCompany > 8 THEN 'Late Career'
		END AS career_stage,
		COUNT(DISTINCT(EmployeeID)) AS total_employee,
        COUNT(DISTINCT(CASE WHEN Attrition = 'Yes' THEN EmployeeID END)) AS total_attrition
FROM employee
GROUP BY career_stage
)

SELECT *,
		ROUND((total_attrition * 100 /  total_employee), 2) AS attrition_rate_percent,
        ROUND(total_attrition * 100 / SUM(total_attrition) OVER (), 2) AS percent_attrition_distribution
FROM attrition_by_career_stage
ORDER BY attrition_rate_percent DESC, percent_attrition_distribution DESC;