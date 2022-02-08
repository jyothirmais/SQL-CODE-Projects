
SAMPLE DATE:
+-------------------------------+---------------+---------------+---------------+
| Process_Title         | Start_Date| End_Date  | Effort_Hrs|
+-------------------------------+---------------+---------------+---------------+
| Requirements Gathering| 09/22/2020| 09/24/2020| 20        |
| Scoping Build         | 09/22/2020| 09/30/2020| 15        |
| BRD Writing           | 09/23/2020| 09/30/2020| 20        |
| Datamart Build        | 10/03/2020| 10/07/2020| 80        |
| Datamart Backfill     | 10/10/2020| 10/12/2020| 10        |
| UAT                   | 10/22/2020| 10/25/2020| 20        |
| Support               | 10/22/2020| 10/31/2020| 20        |
+-------------------------------+---------------+---------------+---------------+


cycle_start_date | cycle_end_date | total hours


with sub as (SELECT ROW_NUMBER() OVER (ORDER BY pp.start_date,pp.end_date) AS rn,
                   process_title process_title,start_date start_date,end_date end_date,effort_hrs effort_hrs,
                   LAG(pp.end_date,1) OVER (ORDER BY pp.start_date,pp.end_date) AS previous_end_date
            FROM project_planning pp),

sub1 as (SELECT start_date start_date,end_date end_date,effort_hrs effort_hrs,
             CASE
               WHEN previous_end_date >= start_date THEN 0
               ELSE 1
             END AS island_start,
             SUM(CASE WHEN previous_end_date >= start_date THEN 0 ELSE 1 END) OVER (ORDER BY RN ROWS UNBOUNDED PRECEDING) AS island_ID
      FROM sub)

SELECT MIN(start_date) AS Cycle_Start_Date,
       MAX(end_date) AS Cycle_End_Date,
       SUM(effort_hrs) AS Cycle_Effort_Hrs
FROM sub1
GROUP BY island_ID
ORDER BY 1 ASC;
