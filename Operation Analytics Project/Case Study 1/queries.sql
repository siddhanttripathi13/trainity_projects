create table
  events (
    user_id int,
    occured_at varchar(100),
    event_type varchar(50),
    event_name varchar(50),
    location varchar(50),
    device varchar(100),
    user_type int
  );

select
  *
from
  email_events;

create table
  email_events (
    user_id int,
    occurred_at varchar(100),
    action varchar(100),
    user_type int
  );

alter table
  events
change column
  occured_at occurred_at varchar(100);

show variables
  like 'secure_file_priv';

#Loading large amount of data into table
load data
  infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv' into
table
  email_events fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows;

#Modifying text column to datetime column in email_events
update
  email_events
set
  occurred_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

alter table
  email_events
change column
  occurred_at occurred_at datetime;

#Modifying ds column to date column in job_data
UPDATE
    job_data
SET
    ds = str_to_date(ds, '%m/%d/%Y');

ALTER TABLE
    job_data modify COLUMN ds DATE;

select
  *
from
  job_data;

#Inserting new data into job_data
INSERT INTO
    job_data (ds, job_id, actor_id, event, LANGUAGE, time_spent, org)
VALUES
    ('2020-12-01', 27, 1012, 'skip', 'English', 67, 'C'),
    ('2020-12-01', 29, 1039, 'decision', 'French', 58, 'A'),
    ('2020-12-02', 23, 1013, 'transfer', 'Arabic', 20, 'D'),
    ('2020-12-03', 26, 1032, 'skip', 'Persian', 70, 'B'),
    ('2020-12-03', 30, 1043, 'decision', 'Hindi', 85, 'A'),
    ('2020-12-04', 28, 1044, 'transfer', 'Italian', 36, 'C'),
    ('2020-12-05', 25, 1033, 'skip', 'English', 15, 'D'),
    ('2020-12-06', 29, 1011, 'decision', 'French', 92, 'B'),
    ('2020-12-07', 31, 1035, 'transfer', 'Arabic', 54, 'A'),
    ('2020-12-08', 28, 1047, 'skip', 'Persian', 32, 'C'),
    ('2020-12-08', 32, 1037, 'decision', 'Hindi', 97, 'D'),
    ('2020-12-09', 30, 1036, 'transfer', 'Italian', 29, 'B'),
    ('2020-12-10', 26, 1014, 'skip', 'English', 63, 'A'),
    ('2020-12-10', 33, 1057, 'decision', 'French', 26, 'C'),
    ('2020-12-11', 29, 1045, 'transfer', 'Arabic', 11, 'D'),
    ('2020-12-12', 28, 1025, 'skip', 'Persian', 70, 'B'),
    ('2020-12-13', 31, 1015, 'decision', 'Hindi', 15, 'A'),
    ('2020-12-13', 34, 1059, 'transfer', 'Italian', 62, 'C'),
    ('2020-12-14', 30, 1035, 'skip', 'English', 52, 'D'),
    ('2020-12-15', 27, 1013, 'decision', 'French', 35, 'B'),
    ('2020-12-15', 40, 1043, 'transfer', 'Arabic', 53, 'A'),
    ('2020-12-16', 29, 1041, 'skip', 'Persian', 96, 'C'),
    ('2020-12-17', 28, 1061, 'decision', 'Hindi', 83, 'D'),
    ('2020-12-18', 32, 1031, 'transfer', 'Italian', 44, 'B'),
    ('2020-12-18', 35, 1053, 'skip', 'English', 77, 'A'),
    ('2020-12-19', 31, 1015, 'decision', 'French', 59, 'C'),
    ('2020-12-20', 27, 1027, 'transfer', 'Arabic', 66, 'D'),
    ('2020-12-21', 30, 1063, 'skip', 'Persian', 14, 'B'),
    ('2020-12-21', 33, 1039, 'decision', 'Hindi', 21, 'A'),
    ('2020-12-22', 29, 1065, 'transfer', 'Italian', 38, 'C'),
    ('2020-12-23', 31, 1029, 'skip', 'English', 95, 'D'),
    ('2020-12-24', 28, 1011, 'decision', 'French', 23, 'B'),
    ('2020-12-24', 42, 1045, 'transfer', 'Arabic', 42, 'A'),
    ('2020-12-25', 32, 1073, 'skip', 'Persian', 71, 'C'),
    ('2020-12-26', 31, 1049, 'decision', 'Hindi', 89, 'D'),
    ('2020-12-26', 44, 1047, 'transfer', 'Italian', 100, 'B'),
    ('2020-12-27', 34, 1013, 'skip', 'English', 55, 'A'),
    ('2020-12-28', 32, 1025, 'decision', 'French', 17, 'C'),
    ('2020-12-29', 35, 1017, 'transfer', 'Arabic', 84, 'D'),
    ('2020-12-29', 38, 1033, 'skip', 'Persian', 40, 'B'),
    ('2020-12-30', 32, 1061, 'decision', 'Hindi', 27, 'A'),
    ('2020-12-31', 36, 1019, 'transfer', 'Italian', 78, 'C'),
    ('2020-12-31', 33, 1047, 'skip', 'English', 75, 'D'),
    ('2021-01-01', 37, 1021, 'decision', 'French', 33, 'B'),
    ('2021-01-01', 40, 1031, 'transfer', 'Arabic', 60, 'A'),
    ('2021-01-02', 34, 1067, 'skip', 'Persian', 48, 'C'),
    ('2021-01-03', 33, 1087, 'decision', 'Hindi', 105, 'D'),
    ('2021-01-03', 46, 1045, 'transfer', 'Italian', 80, 'B'),
    ('2021-01-04', 35, 1053, 'skip', 'English', 41, 'A'),
    ('2021-01-05', 34, 1037, 'decision', 'French', 65, 'C'),
    ('2021-01-06', 39, 1089, 'transfer', 'Arabic', 12, 'D'),
    ('2021-01-06', 42, 1031, 'skip', 'Persian', 69, 'B'),
    ('2021-01-07', 36, 1013, 'decision', 'Hindi', 83, 'A'),
    ('2021-01-08', 35, 1045, 'transfer', 'Italian', 24, 'C'),
    ('2021-01-08', 44, 1095, 'skip', 'English', 87, 'D'),
    ('2021-01-09', 36, 1027, 'decision', 'French', 51, 'B'),
    ('2021-01-10', 41, 1097, 'transfer', 'Arabic', 68, 'A'),
    ('2021-01-10', 48, 1061, 'skip', 'Persian', 76, 'C'),
    ('2021-01-11', 38, 1101, 'decision', 'Hindi', 39, 'D'),
    ('2021-01-12', 42, 1039, 'transfer', 'Italian', 56, 'B'),
    ('2021-01-12', 51, 1049, 'skip', 'English', 103, 'A'),
    ('2021-01-13', 38, 1031, 'decision', 'French', 61, 'C'),
    ('2021-01-14', 43, 1103, 'transfer', 'Arabic', 10, 'D'),
    ('2021-01-14', 54, 1083, 'skip', 'Persian', 91, 'B'),
    ('2021-01-15', 39, 1035, 'decision', 'Hindi', 29, 'A'),
    ('2021-01-16', 44, 1047, 'transfer', 'Italian', 88, 'C'),
    ('2021-01-16', 57, 1105, 'skip', 'English', 45, 'D'),
    ('2021-01-17', 41, 1013, 'decision', 'French', 93, 'B'),
    ('2021-01-18', 45, 1107, 'transfer', 'Arabic', 72, 'A'),
    ('2021-01-18', 60, 1067, 'skip', 'Persian', 79, 'C'),
    ('2021-01-19', 42, 1111, 'decision', 'Hindi', 57, 'D'),
    ('2021-01-20', 46, 1045, 'transfer', 'Italian', 64, 'B'),
    ('2021-01-20', 63, 1113, 'skip', 'English', 12, 'A'),
    ('2021-01-21', 43, 1015, 'decision', 'French', 81, 'C'),
    ('2021-01-22', 47, 1117, 'transfer', 'Arabic', 50, 'D'),
    ('2021-01-22', 66, 1087, 'skip', 'Persian', 17, 'B'),
    ('2021-01-23', 44, 1023, 'decision', 'Hindi', 101, 'A'),
    ('2021-01-24', 40, 1033, 'transfer', 'Italian', 32, 'C'),
    ('2021-01-24', 69, 1119, 'skip', 'English', 94, 'D'),
    ('2021-01-25', 43, 1017, 'decision', 'French', 104, 'B'),
    ('2021-01-26', 47, 1121, 'transfer', 'Arabic', 37, 'A'),
    ('2021-01-26', 72, 1111, 'decision', 'Persian', 21, 'C'),
    ('2021-01-27', 46, 1037, 'transfer', 'Italian', 77, 'D'),
    ('2021-01-28', 43, 1053, 'skip', 'English', 102, 'B'),
    ('2021-01-28', 75, 1123, 'decision', 'French', 90, 'A'),
    ('2021-01-29', 47, 1125, 'transfer', 'Arabic', 49, 'C'),
    ('2021-01-30', 46, 1067, 'skip', 'Persian', 45, 'D'),
    ('2021-01-30', 78, 1127, 'decision', 'Hindi', 74, 'B'),
    ('2021-01-31', 48, 1053, 'transfer', 'Italian', 33, 'A'),
    ('2021-02-01', 45, 1129, 'skip', 'English', 70, 'C'),
    ('2021-02-01', 81, 1131, 'decision', 'French', 99, 'D'),
    ('2021-02-02', 49, 1135, 'transfer', 'Arabic', 106, 'B'),
    ('2021-02-03', 48, 1087, 'skip', 'Persian', 82, 'A'),
    ('2021-02-03', 84, 1137, 'decision', 'Hindi', 52, 'C'),
    ('2021-02-04', 51, 1139, 'transfer', 'Italian', 19, 'D'),
    ('2021-02-05', 49, 1141, 'skip', 'English', 98, 'B'),
    ('2021-02-06', 48, 1023, 'decision', 'French', 107, 'A'),
    ('2021-02-06', 87, 1143, 'transfer', 'Arabic', 25, 'C'),
    ('2021-02-07', 52, 1145, 'skip', 'Persian', 42, 'D'),
    ('2021-02-08', 51, 1013, 'decision', 'Hindi', 84, 'B'),
    ('2021-02-08', 90, 1147, 'transfer', 'Italian', 30, 'A'),
    ('2021-02-09', 52, 1149, 'skip', 'English', 76, 'C'),
    ('2021-02-10', 51, 1017, 'decision', 'French', 97, 'D'),
    ('2021-02-10', 93, 1151, 'transfer', 'Arabic', 61, 'B'),
    ('2021-02-11', 55, 1153, 'skip', 'Persian', 67, 'A'),
    ('2021-02-12', 54, 1037, 'decision', 'Hindi', 92, 'C'),
    ('2021-02-12', 96, 1155, 'transfer', 'Italian', 73, 'D'),
    ('2021-02-13', 56, 1157, 'skip', 'English', 22, 'B'),
    ('2021-02-14', 55, 1021, 'decision', 'French', 59, 'A'),
    ('2021-02-15', 40, 1033, 'transfer', 'Arabic', 32, 'C');

#Jobs reviewed per hour per day in Nov 2020
SELECT
    ds AS DATE,
    SUM(time_spent) / 3600 AS hours,
    COUNT(job_id) AS num_jobs,
    ROUND(COUNT(job_id) / SUM(time_spent) * 3600, 2) AS jobs_per_hour
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY
    ds
ORDER BY
    DATE;

#Throughput rolling average
WITH daily_events AS (
    SELECT
        ds,
        COUNT(event) / SUM(time_spent) AS throughput
    FROM
        job_data
    GROUP BY
        ds
)
SELECT
    ds AS DATE,
    AVG(throughput) OVER (
        ORDER BY
            ds ROWS BETWEEN 6 PRECEDING
            AND CURRENT ROW
    ) AS throughput_rolling_avg
FROM
    daily_events;

/* In my opinion, the 7-day rolling average is more useful than the daily metric for throughput. The rolling average smooths out daily fluctuations and gives a better indication of trends. The daily metric can spike up and down day-to-day just due to random variation. I'd rather track the 7-day average over time to see if throughput is trending up, down or remaining steady. Sudden changes in the rolling average could indicate an underlying process change, which warrants further investigation.*/


#Language Share Analysis
select
  max(ds)
from
  job_data;

WITH lang_count AS (
    SELECT
        LANGUAGE,
        COUNT(*) AS num_events
    FROM
        job_data
    WHERE
        ds BETWEEN DATE_SUB(
            (
                SELECT
                    MAX(ds)
                FROM
                    job_data
            ),
            INTERVAL 30 DAY
        )
        AND (
            SELECT
                DATE(MAX(ds))
            FROM
                job_data
        )
    GROUP BY
        LANGUAGE
)
SELECT
    LANGUAGE,
    num_events,
    ROUND(
        (num_events * 100.0) / (
            SELECT
                SUM(num_events)
            FROM
                lang_count
        ),
        2
    ) AS percentage
FROM
    lang_count
ORDER BY
    percentage;
  
#Duplicate detection
INSERT INTO job_data 
  (ds, job_id, actor_id, event, language, time_spent, org)
VALUES
  ('2020-12-01', 27, 1012, 'skip', 'English', 67, 'C'),
  ('2020-12-01', 27, 1012, 'skip', 'English', 67, 'C'),  
  ('2020-12-03', 26, 1032, 'skip', 'Persian', 70, 'B'), 
  ('2020-12-03', 26, 1032, 'skip', 'Persian', 70, 'B'),
  ('2020-12-05', 25, 1033, 'skip', 'English', 15, 'D'),
  ('2020-12-05', 25, 1033, 'skip', 'English', 15, 'D'),
  ('2020-12-10', 26, 1014, 'skip', 'English', 63, 'A'),
  ('2020-12-10', 26, 1014, 'skip', 'English', 63, 'A'),
  ('2020-12-19', 30, 1035, 'skip', 'English', 52, 'D'), 
  ('2020-12-19', 30, 1035, 'skip', 'English', 52, 'D'),
  ('2020-12-25', 31, 1046, 'skip', 'English', 77, 'C'),
  ('2020-12-25', 31, 1046, 'skip', 'English', 77, 'C'),
  ('2020-12-29', 38, 1033, 'skip', 'Persian', 40, 'B'),
  ('2020-12-29', 38, 1033, 'skip', 'Persian', 40, 'B');
  
  
SELECT
    *,
    COUNT(*) AS no_of_records
FROM
    job_data
GROUP BY
    ds,
    job_id,
    actor_id,
    event,
    language,
    time_spent,
    org
HAVING
    COUNT(*) > 1
ORDER BY
    ds;
