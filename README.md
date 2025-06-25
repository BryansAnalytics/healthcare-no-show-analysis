# healthcare-no-show-analysis
SQL-based analysis of patient attendance patterns in medical appointment data.
# 🏥 Healthcare Appointment No-Show Analysis

## 📌 Objective  
To analyze patient no-show patterns in a medical appointment scheduling system using SQL. The goal was to uncover factors influencing attendance and identify opportunities to reduce missed appointments.

## 🗂 Dataset  
The dataset simulates healthcare appointments with the following fields:  
- `appointment_id`, `patient_id`, `sex`, `age`, `age_group`, `appointment_date`, `appointment_time`  
- `scheduling_date`, `lead_time_days`, `status_clean`, `attendence_flag`, `waiting_time_min`, `appointment_duration_min`

## 🔧 Tools Used  
- **SQL (MySQL v5.6 via DB Fiddle)** for querying and aggregating insights  
- **Excel** (data cleaning – sample file included)
- **Tableau** (dashboard to be added)

## 🧮 Key SQL Queries & Insights  

### 1. Total Appointments  
```sql
SELECT COUNT(*) FROM healthcare_appointments;
```
### 2. Appointment Status Breakdown  
```sql
SELECT status_clean, COUNT(*) AS count
FROM healthcare_appointments
GROUP BY status_clean;
```
### 3. Attendance Rate  
```sql
SELECT
  ROUND(
    SUM(CASE WHEN status_clean = 'attended' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
  ) AS attendance_rate_percent
FROM healthcare_appointments;
```
### 4. Appointments by Day of the Week  
```sql
SELECT 
  DAYNAME(appointment_date) AS weekday,
  COUNT(*) AS appointments
FROM healthcare_appointments
GROUP BY weekday
ORDER BY appointments DESC;
```
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
### 6. Average Waiting Time (Days)  
```sql
SELECT 
  ROUND(AVG(lead_time_days), 1) AS avg_days_waiting
FROM healthcare_appointments;
```
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
## Project Summary

This dashboard analyzes over **111,000 healthcare appointments** to uncover patterns in attendance, wait times, and scheduling behavior, helping providers improve efficiency and reduce no-shows.

### Key Metrics:
- Attended: **77.2%**
- No-Show: **5.9%**
- Cancelled: **16.4%**
- Avg. Wait Time: **44 minutes**

### Key Insights:
- ⏰ **Wait times** increase throughout the day, peaking at nearly **66 minutes** by late afternoon.
- 📅 **No-show rates** are steady across weekdays, showing no clear high-risk day.
- 📆 **Longer lead times** between booking and appointment are linked to more no-shows — suggesting reminder systems or overbooking could help.

## 📊 Tableau Dashboard
[🔗 View the Dashboard on Tableau Public]
(https://public.tableau.com/app/profile/brayan.altamirano/viz/MedicalDatasetKPIn2/KPIs)(https://public.tableau.com/app/profile/brayan.altamirano/viz/MedicalDatasetAppointmentMetrics/AppointmentMetrics) 
(https://public.tableau.com/app/profile/brayan.altamirano/viz/MedicalDataset_17502057142410/Dashboard)  

### 📁 Excel Dataset
[Download the Dataset (Excel)](healthcare_appointments_master_A.csv)




