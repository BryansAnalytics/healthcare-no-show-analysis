-- 📁 Healthcare Appointment No-Show Analysis

-- 🔧 Table: healthcare_appointments

-- 1. Total Appointments
SELECT COUNT(*) FROM healthcare_appointments;

-- 2. Total Appointments (Alias)
SELECT COUNT(*) AS total_appointments FROM healthcare_appointments;

-- 3. Appointment Status Breakdown
SELECT status_clean, COUNT(*) AS count
FROM healthcare_appointments
GROUP BY status_clean;

-- 4. Attendance Rate
SELECT
  ROUND(
    SUM(CASE WHEN status_clean = 'attended' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2
  ) AS attendance_rate_percent
FROM healthcare_appointments;

-- 5. Appointments by Weekday
SELECT
  DAYNAME(appointment_date) AS weekday,
  COUNT(*) AS appointments
FROM healthcare_appointments
GROUP BY weekday
ORDER BY appointments DESC;

-- 6. No-Show Rate by Age Group
SELECT
  age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) AS no_shows,
  ROUND(
    SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2
  ) AS no_show_rate_percent
FROM healthcare_appointments
GROUP BY age_group
ORDER BY no_show_rate_percent DESC;

-- 7. Average Waiting Time (Days)
SELECT 
  ROUND(AVG(lead_time_days), 1) AS avg_days_waiting
FROM healthcare_appointments;

-- 8. No-Show Rate by Hour Block
SELECT
  HOUR(appointment_time) AS hour_block,
  COUNT(*) AS total_appointments,
  SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) AS no_shows
FROM healthcare_appointments
GROUP BY hour_block
ORDER BY hour_block;

-- 9. No-Show Rate by Gender
SELECT
  sex,
  COUNT(*) AS total_appointments,
  SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) AS total_no_shows,
  ROUND(
    100.0 * SUM(CASE WHEN status_clean = 'did not attend' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS no_show_rate
FROM healthcare_appointments; 