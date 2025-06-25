# healthcare-no-show-analysis
SQL-based analysis of patient attendance patterns in medical appointment data.
# 🏥 Healthcare Appointment No-Show Analysis (SQL)

## 📌 Objective  
To analyze patient no-show patterns in a medical appointment scheduling system using SQL. The goal was to uncover factors influencing attendance and identify opportunities to reduce missed appointments.

---

## 🗂 Dataset  
The dataset simulates healthcare appointments with the following fields:  
- `appointment_id`, `patient_id`, `sex`, `age`, `age_group`, `appointment_date`, `appointment_time`  
- `scheduling_date`, `lead_time_days`, `status_clean`, `attendence_flag`, `waiting_time_min`, `appointment_duration_min`

---

## 🔧 Tools Used  
- **SQL (MySQL v5.6 via DB Fiddle)** for querying and aggregating insights  
- **Excel** for initial cleaning (not detailed here)

---

## 🧮 Key SQL Queries & Insights  

### 1. Total Appointments  
```sql
SELECT COUNT(*) FROM healthcare_appointments;
```
---

### 2. Appointment Status Breakdown  
```sql
SELECT status_clean, COUNT(*) AS count
FROM healthcare_appointments
GROUP BY status_clean;
```
---

### 3. Attendance Rate  
```sql
SELECT
  ROUND(
    SUM(CASE WHEN status_clean = 'attended' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
  ) AS attendance_rate_percent
FROM healthcare_appointments;
```
---

### 4. Appointments by Day of the Week  
```sql
SELECT 
  DAYNAME(appointment_date) AS weekday,
  COUNT(*) AS appointments
FROM healthcare_appointments
GROUP BY weekday
ORDER BY appointments DESC;
```
---

### 5. No-Show Rate by Age Group  
```sql
SELECT 
  age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) AS no_shows,
  ROUND(
    SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
  ) AS no_show_rate_percent
FROM healthcare_appointments
GROUP BY age_group
ORDER BY no_show_rate_percent DESC;
```
---

### 6. Average Waiting Time (Days)  
```sql
SELECT 
  ROUND(AVG(lead_time_days), 1) AS avg_days_waiting
FROM healthcare_appointments;
```
---

### 7. No-Show by Appointment Hour  
```sql
SELECT 
  HOUR(appointment_time) AS hour_block,
  COUNT(*) AS total_appointments,
  SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) AS no_shows
FROM healthcare_appointments
GROUP BY hour_block
ORDER BY hour_block;
```
---

### 8. No-Show Rate by Gender  
```sql
SELECT 
  sex,
  COUNT(*) AS total_appointments,
  SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) AS total_no_shows,
  ROUND(
    SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
  ) AS no_show_rate
FROM healthcare_appointments
GROUP BY sex;
```
---

## 📌 Summary  
This project demonstrates the use of SQL to uncover operational challenges in healthcare scheduling. By segmenting no-show patterns by age, gender, weekday, and hour, the analysis provides actionable insights for improving patient attendance and clinic efficiency.
