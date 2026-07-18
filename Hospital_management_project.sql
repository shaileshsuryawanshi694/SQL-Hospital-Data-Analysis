DROP TABLE IF EXISTS hospital_data;

--CREATE TABLE hospital_data--

CREATE TABLE hospital_data(
    Hospital_Name VARCHAR(100),
    hospital_Location VARCHAR(100),
    Department VARCHAR(100),
    Doctors_Count INT,
    Patients_Count INT,
    Admission_Date VARCHAR(20),
    Discharge_Date VARCHAR(20),
    Medical_Expenses NUMERIC(10,2)
);

SELECT * FROM hospital_data;

--1. Total Number of Patients--

SELECT SUM(Patients_Count) AS total_patients
FROM hospital_data;

--2. Average Number of Doctors per Hospital--
SELECT Hospital_Name, AVG(Doctors_Count) AS avg_doctors
FROM hospital_data
GROUP BY Hospital_Name;

--3. Top 3 Departments with the Highest Number of Patients--
SELECT Department, SUM(Patients_Count) AS total_patients
FROM hospital_data
GROUP BY Department
ORDER BY total_patients DESC
LIMIT 3;

--4. Hospital with the Maximum Medical Expenses--
SELECT Hospital_Name, SUM(Medical_Expenses) AS total_expenses
FROM hospital_data
GROUP BY Hospital_Name
ORDER BY total_expenses DESC
LIMIT 1;

--5. Daily Average Medical Expenses--
SELECT Hospital_Name , Admission_Date, AVG(Medical_Expenses) AS avg_expenses
FROM hospital_data
GROUP BY Hospital_Name, Admission_Date
ORDER BY Admission_Date;

--6. Longest Hospital Stay--
SELECT Hospital_Name,
Department,
Admission_Date,
Discharge_Date,
(TO_DATE(Discharge_Date,'DD-MM-YYYY')
-
TO_DATE(Admission_Date,'DD-MM-YYYY')) AS stay_days
FROM hospital_data
ORDER BY stay_days DESC
LIMIT 1;

--7. Total Patients Treated Per City--
SELECT Hospital_Location , SUM(Patients_Count) AS total_patients
FROM hospital_data
GROUP BY Hospital_Location
ORDER BY total_patients DESC;

--8. Average Length of Stay Per Department--
SELECT Department,AVG(TO_DATE(Discharge_Date,'DD-MM-YYYY')-TO_DATE(Admission_Date,'DD-MM-YYYY')) AS avg_stay
FROM hospital_data
GROUP BY Department;

--9. Identify the Department with the Lowest Number of Patients--
SELECT Department , SUM(Patients_Count) AS total_patients
FROM hospital_data
GROUP BY Department
ORDER BY total_patients
LIMIT 1;

--10. Monthly Medical Expenses Report--
SELECT
TO_CHAR(TO_DATE(Admission_Date,'DD-MM-YYYY'),'YYYY-MM') AS month,
SUM(Medical_Expenses) AS total_expenses
FROM hospital_data
GROUP BY month
ORDER BY month;