-- ================================================
-- HR EMPLOYEE ATTRITION AND PERFORMANCE ANALYSIS
-- Schema Definition
-- Author: Zulfi Nadhia Cahyani
-- ================================================

/*
This schema defines analytical tables derived from the HR Analytics Employee Attrition
and Performance dataset from Kaggle.

Dataset Source:
https://www.kaggle.com/datasets/mahmoudemadabdallah/hr-analytics-employee-attrition-and-performance

The dataset consists of 5 tables:
- employee (employee demographics and attrition status)
- education_level (education reference)
- performance_rating (employee performance reviews)
- rating_level (performance rating reference)
- satisfied_level (satisfaction reference)

The tables are organized in a relational model to support join-based analysis
for employee demographics, attrition behavior, satisfaction, and performance evaluation.
*/

-- ------------------------------
-- 1. Education Level
-- ------------------------------
-- Dimension table storing standardized education levels.

CREATE TABLE education_level (
    EducationLevelID INT PRIMARY KEY,          -- Unique identifier for the education level
    EducationLevel VARCHAR(50)                 -- Education level description
);

-- ------------------------------
-- 2. Rating Level
-- ------------------------------
-- Dimension table storing standardized performance rating levels.

CREATE TABLE rating_level (
    RatingID INT PRIMARY KEY,                   -- Unique identifier for the rating level
    RatingLevel VARCHAR(50)                     -- Performance rating description
);

-- ------------------------------
-- 3. Satisfaction Level
-- ------------------------------
-- Dimension table storing standardized satisfaction levels.

CREATE TABLE satisfied_level (
    SatisfactionID INT PRIMARY KEY,             -- Unique identifier for the satisfaction level
    SatisfactionLevel VARCHAR(50)               -- Satisfaction description
);

-- ------------------------------
-- 4. Employee
-- ------------------------------
-- Dimension table storing employee demographic, job, and attrition information.

CREATE TABLE employee (
    EmployeeID CHAR(9) PRIMARY KEY,             -- Unique identifier for each employee
    FirstName VARCHAR(50),                      -- Employee first name
    LastName VARCHAR(50),                       -- Employee last name
    Gender VARCHAR(17),                         -- Gender of the employee
    Age INT,                                    -- Age of the employee
    BusinessTravel VARCHAR(30),                 -- Frequency of business travel
    Department VARCHAR(50),                     -- Department where the employee works
    DistanceFromHome INT,                       -- Distance from home to workplace (in kilometers)
    State VARCHAR(50),                          -- State of residence
    Ethnicity VARCHAR(50),                      -- Ethnicity of the employee
    Education INT,                              -- Education level ID (FK to education_level)
    EducationField VARCHAR(50),                 -- Field of study
    JobRole VARCHAR(50),                        -- Employee job role
    MaritalStatus VARCHAR(20),                  -- Marital status
    Salary INT,                                 -- Annual salary
    StockOptionLevel INT,                       -- Stock option level granted
    OverTime VARCHAR(5),                        -- Whether employee works overtime (Yes/No)
    HireDate DATE,                              -- Date the employee was hired
    Attrition VARCHAR(5),                       -- Whether employee left the company (Yes/No)
    YearsAtCompany INT,                         -- Total years at the company
    YearsInMostRecentRole INT,                  -- Years in the most recent role
    YearsSinceLastPromotion INT,                -- Years since last promotion
    YearsWithCurrManager INT,                   -- Years working with current manager
    CONSTRAINT fk_employee_education FOREIGN KEY (Education)
        REFERENCES education_level(EducationLevelID)
);

-- ------------------------------
-- 5. Performance Rating
-- ------------------------------
-- Fact table storing employee performance reviews and satisfaction metrics.

CREATE TABLE performance_rating (
    PerformanceID CHAR(6) PRIMARY KEY,          -- Unique identifier for each performance review
    EmployeeID CHAR(9) NOT NULL,                -- Employee being reviewed (FK to employee)
    ReviewDate DATE,                            -- Date of the performance review
    EnvironmentSatisfaction INT,                -- Satisfaction with work environment (FK)
    JobSatisfaction INT,                        -- Satisfaction with job role (FK)
    RelationshipSatisfaction INT,               -- Satisfaction with workplace relationships (FK)
    TrainingOpportunitiesWithinYear INT,        -- Number of training opportunities available within the year
    TrainingOpportunitiesTaken INT,             -- Number of training opportunities taken
    WorkLifeBalance INT,                        -- Work-life balance satisfaction rating (FK)
    SelfRating INT,                             -- Employee self-assessment rating (FK)
    ManagerRating INT,                          -- Manager performance rating (FK)
    CONSTRAINT fk_performance_employee FOREIGN KEY (EmployeeID)
        REFERENCES employee(EmployeeID),
    CONSTRAINT fk_env_satisfaction FOREIGN KEY (EnvironmentSatisfaction)
        REFERENCES satisfied_level(SatisfactionID),
    CONSTRAINT fk_job_satisfaction FOREIGN KEY (JobSatisfaction)
        REFERENCES satisfied_level(SatisfactionID),
    CONSTRAINT fk_relationship_satisfaction FOREIGN KEY (RelationshipSatisfaction)
        REFERENCES satisfied_level(SatisfactionID),
    CONSTRAINT fk_worklife_balance FOREIGN KEY (WorkLifeBalance)
        REFERENCES satisfied_level(SatisfactionID),
    CONSTRAINT fk_self_rating FOREIGN KEY (SelfRating)
        REFERENCES rating_level(RatingID),
    CONSTRAINT fk_manager_rating FOREIGN KEY (ManagerRating)
        REFERENCES rating_level(RatingID)
);

