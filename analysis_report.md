# **HR EMPLOYEE ATTRITION AND PERFORMANCE ANALYSIS** 
### Author: Zulfi Nadhia Cahyani 

## **I. PROJECT OVERVIEW**  

This project analyzes the HR Employee Attrition and Performance dataset to uncover patterns and insights that support data-driven decision-making in workforce management. The dataset captures employee demographics, job roles, satisfaction, education, performance ratings, and attrition across the organization. By leveraging SQL and analytical techniques such as joins, aggregations, and trend analysis, the project identifies key drivers of employee attrition, performance, and satisfaction. The findings help interpret HR data to support better understanding of employee retention, performance trends, and workforce planning decisions.

---

## **II. BUSINESS QUESTIONS**  

1. **Workforce Overview and Attrition Metrics**  
    - What is the overall employee attrition rate across the organization?  
    - How do attrition rates and attrition distribution vary by department?  
    - Which job roles exhibit the highest attrition rates, and which contribute most to overall attrition?  
    - How does attrition differ by gender in terms of both rate and distribution?  
    - How do attrition rates and attrition distribution vary across different age groups?  

2. **Employee Performance Analysis**  
    - What is the distribution of employee performance ratings across the workforce?  
    - How do attrition rates and attrition distribution vary across performance rating levels?  

3. **Satisfaction and Compensation Analysis**  
    - How do different job satisfaction levels relate to employee attrition rates and attrition distribution?  
    - Are there differences in attrition rates and attrition distribution across salary categories?  

4. **Education and Career Development Factors**  
    - What is the distribution of education levels across the workforce?
    - How do attrition rates and attrition distribution vary across different education levels?
    - How does career stage relate to employee attrition rates and attrition distribution?

---

## **III. OBJECTIVES**  

1. Analyze overall attrition and variations across departments, roles, gender, and age groups.
2. Examine performance rating distribution and its relationship with attrition.
3. Evaluate how job satisfaction and salaries relate to attrition.
4. Assess the impact of education level and career stage on attrition.
5. Deliver data-driven insights to support workforce planning, strengthen retention, and optimize HR strategies.

---

## **IV. DATASET**  

**Source:** [**HR Analytics Employee Attrition & Performance Dataset on Kaggle**](https://www.kaggle.com/datasets/mahmoudemadabdallah/hr-analytics-employee-attrition-and-performance)  

**Tables Used:**  
- **employee:** dimension table storing employee demographic, job, compensation, and attrition information.
- **performance_rating:** fact table containing performance reviews and satisfaction metrics for each employee.
- **satisfied_level:** dimension table defining standardized satisfaction levels.
- **rating_level:** dimension table defining standardized performance rating levels.
- **education_level:** dimension table defining standardized education levels of employees.

---

## **V. DATA MODEL OVERVIEW**  

The HR Employee Attrition and Performance dataset is structured as a **relational model**, with **dimension** and **fact tables** that support join-based analysis for employee demographics, attrition behavior, satisfaction, and performance evaluation. Referential integrity is maintained through **primary key–foreign key relationships**, ensuring accurate joins and reliable aggregations.  

- **Primary Keys (PK)** uniquely identify each record in a table.  
- **Foreign Keys (FK)** reference primary keys in other tables to maintain relationships and ensure referential integrity.  

**Fact Tables:**  
- **performance_rating** (PK: `PerformanceID`, FK: `EmployeeID`, `EnvironmentSatisfaction`, `JobSatisfaction`, `RelationshipSatisfaction`, `WorkLifeBalance`, `SelfRating`, `ManagerRating`)  

**Dimension Tables:**  
- **employee** (PK: `EmployeeID`, FK: `Education`)  
- **education_level** (PK: `EducationLevelID`)  
- **rating_level** (PK: `RatingID`)  
- **satisfied_level** (PK: `SatisfactionID`)  

### **Data Cleaning and Preparation**
Data cleaning was performed using **Python (Pandas)**, including:  
- Handling missing values and duplicates  
- Correcting data types, column names, and inconsistent data  
- Ensuring referential integrity for foreign keys  

Data analysis and SQL queries were executed in **MySQL**, leveraging the relational structure to efficiently extract insights related to employee attrition, performance, satisfaction, and career development.

---

## **VI. KEY INSIGHTS**  

### **VI.1 Workforce Overview and Attrition Metrics**  

#### **VI.1.1 Overall Employee Attrition Rate**  
1. The organization employs 1,470 employees, with 237 employees leaving, resulting in an overall attrition rate of 16.12%, indicating a moderate level of workforce turnover.  
2. This attrition rate serves as a baseline indicator for subsequent analyses, highlighting the need to examine underlying drivers such as performance, satisfaction, compensation, and career stage to identify high-risk employee segments.  

#### **VI.1.2 Attrition Rate by Department**  
1. Sales shows the highest attrition rate (20.63%), with 92 employees leaving, indicating elevated turnover risk despite not being the largest department.  
2. Human Resources also records a relatively high attrition rate (19.05%), but its overall impact remains limited due to the smaller workforce size.  
3. Technology, while having a lower attrition rate (13.84%), accounts for the largest share of total attrition (56.12%) because it has the largest number of employees, making it a key focus for retention efforts.  

#### **VI.1.3 Attrition Rate by Job Role**  
1. Sales Representative and Recruiter roles show the highest attrition rates at 39.76% and 37.50%, respectively, indicating significant turnover risk in these frontline and talent-facing positions.  
2. Data Scientist, Sales Executive, and Software Engineer roles contribute the largest share of total attrition due to both moderate-to-high attrition rates and larger employee populations, together accounting for a substantial portion of employee turnover.  
3. Senior and managerial roles, including Engineering Manager, Manager, and Analytics Manager, exhibit lower attrition rates, suggesting greater workforce stability at higher career levels.  
4. Several HR leadership roles (HR Business Partner and HR Manager) record zero attrition, indicating strong retention within these specialized positions.  

#### **VI.1.4 Attrition Rate by Gender**  
1. Male employees exhibit the highest attrition rate (17.51%) and account for the largest share of total attrition (48.10%), driven by both a higher turnover rate and a large employee base.  
2. Female employees show a moderately lower attrition rate (15.41%) and contribute 43.88% of total attrition, indicating comparable but slightly stronger retention relative to male employees.  
3. Non-binary employees experience a similar attrition rate (15.32%), though their overall impact on total attrition remains smaller (8.02%) due to lower representation in the workforce.  
4. Employees who prefer not to disclose gender record no attrition, but the small group size limits broader interpretation.  

#### **VI.1.5 Attrition Rate by Age Groups**  
1. Early- and mid-career employees (18–35) account for the majority of attrition, contributing over 90% of total attrition, with attrition rates of 18.00% (18–25) and 19.52% (26–35), indicating higher turnover risk among younger employees.
2. The 26–35 age group exhibits the highest attrition rate, suggesting increased mobility or career transitions during this stage.
3. Older age groups (36+) show significantly lower attrition rates and minimal contribution to overall attrition, reflecting stronger retention and workforce stability at later career stages.

### **VI.2 Employee Performance Analysis**  

#### **VI.2.1 Distribution of Employee Performance Ratings**  
1. Employee performance is largely mid-to-high, with “Meets Expectation” (29.02%) and “Exceeds Expectation” (28.58%) forming the majority of the workforce.  
2. High performers (“Above and Beyond”) account for 20.62%, representing a strong talent segment that should be prioritized for retention and growth initiatives.  
3. 21.77% of employees are rated “Needs Improvement,” indicating a sizable group that may benefit from targeted performance support and development.  

#### **VI.2.2 Impact of Performance on Employee Attrition**  
1. Attrition rates are consistently high across all performance levels, ranging from 23.51% to 27.29%, indicating that turnover is not limited to low performers.  
2. High-performing employees (“Above and Beyond”) show the highest attrition rate (27.29%), highlighting a potential risk of losing top talent and the need for stronger retention strategies.  
3. Employees rated “Meets Expectation” and “Exceeds Expectation” contribute the largest shares of total attrition due to their larger population sizes, making them key focus areas for retention efforts.  

### **VI.3 Satisfaction and Compensation Analysis**  

#### **VI.3.1 Impact of Satisfaction Levels on Attrition**  
1. Attrition rates are consistently high across all satisfaction levels (24.38%–27.64%), suggesting job satisfaction alone does not fully explain turnover.  
2. Very dissatisfied employees have the highest attrition rate (27.64%), though they contribute a small share of total attrition (3.72%).  
3. Satisfied and very satisfied employees account for nearly half of total attrition, driven by their larger workforce size, indicating other factors such as compensation and career progression may play a significant role.  

#### **VI.3.2 Impact of Compensation on Employee Attrition**  
1. Lower-salary employees (under $200,000) experience the highest attrition rate (17.54%) and account for the vast majority of total attrition (90.30%), making compensation a key driver of turnover risk.  
2. Attrition declines sharply as salary increases, with medium-salary employees ($200,000 - $400,000) showing a moderate attrition rate (9.91%) and high-salary employees (over $400,000) the lowest (5.26%).  
3. The strong inverse relationship between salary level and attrition highlights competitive compensation as a critical lever for improving employee retention, particularly among lower-paid roles.  

### **VI.4 Education and Career Development Factors**   

#### **VI.4.1 Distribution of Employee Education Level**  
1. The workforce is highly educated, with Bachelor’s (38.91%) and Master’s degrees (27.07%) together accounting for the majority of employees.  
2. Employees with high school education or no formal qualifications represent a smaller but meaningful segment (30.74%), indicating a diverse range of educational backgrounds across roles.  
3. Doctorate holders make up a very small share (3.27%), suggesting advanced academic qualifications are concentrated in specialized or niche positions.  

#### **VI.4.2 Attrition by Education Level**  
1. Employees with no formal qualifications show the highest attrition rate (18.24%), indicating higher turnover risk among less-educated groups.  
2. Although Bachelor’s degree holders have a moderate attrition rate (17.31%), they account for the largest share of total attrition (41.77%) due to their dominant presence in the workforce.  
3. Attrition rates decline with higher education levels, with Master’s (14.57%) and Doctorate holders (10.42%) exhibiting stronger retention, suggesting education may be associated with greater job stability.  

#### **VI.4.3 Attrition by Career Stage**  
1. Early-career employees (less than 3 years of service) experience the highest attrition rate (29.74%) and account for 61.60% of total attrition, indicating that turnover is heavily concentrated among newer employees.  
2. Mid-career employees (3–8 years of service) show a substantially lower attrition rate (11.60%) but still contribute 35.86% of total attrition due to their larger representation in the workforce.  
3. Late-career employees (more than 8 years of service) demonstrate strong retention, with a minimal attrition rate (2.44%) and limited impact on overall attrition, suggesting greater stability among long-tenured staff.  

---

## **VII. RECOMMENDATION**  

1. **Prioritize Early-Career and High-Performer Retention**  
    - Focus retention efforts on early-career employees (29.74% attrition; 61.60% of exits) through structured onboarding, clear career paths, mentorship, and early promotion visibility.  
    - Implement targeted retention strategies for high performers, particularly “Above and Beyond” employees, to reduce the risk of losing top talent.  

2. **Close Compensation Gaps in High-Risk Salary Bands**  
    - Review and adjust pay for employees earning below $200,000, who represent over 90% of total attrition, to ensure market competitiveness and internal equity.  
    - Introduce transparent salary progression and performance-linked pay to reduce turnover in frontline and early-career roles.  

3. **Target High-Attrition Departments and Roles**  
    - Strengthen retention in Sales and HR, especially Sales Representatives and Recruiters, by improving workload balance, incentives, and career mobility.  
    - In large teams such as Technology, prioritize scalable retention initiatives to reduce the organization-wide impact of attrition.   

4. **Strengthen Career Development and Internal Mobility Programs**  
    - Expand upskilling and internal mobility opportunities for Bachelor’s and lower-education segments, which contribute the largest share of attrition.  
    - Formalize mid-career development pathways to prevent stagnation and sustain long-term retention.  

5. **Adopt a Holistic Retention Strategy Beyond Satisfaction Scores**  
    - Since attrition is high across all satisfaction levels, integrate compensation, career growth, performance recognition, and managerial effectiveness into a unified strategy.   
    - Shift from reactive exit management to proactive attrition risk monitoring using performance, tenure, and salary level indicators.  

---

## **VIII. LIMITATION**  

1. **No Causal Insights**  
    The analysis shows associations between attrition, compensation, performance, and career stage, but cannot determine cause-and-effect relationships.   

2. **Limited Temporal Perspective**  
    Attrition is recorded as a binary outcome at a single point in time, preventing trend analysis or understanding when turnover occurs.  

3. **Missing External and Organizational Context**  
    Factors like labor market conditions, company policies, leadership changes, or restructuring are not included, limiting explanation of underlying attrition drivers.    

4. **Simplified Compensation and Performance Data**  
    Salary bands and standardized performance ratings may not capture nuanced differences across roles or individual pay structures.   

5. **Static Dataset**  
    The snapshot approach restricts insights into workforce dynamics, employee movement, and long-term retention patterns.   