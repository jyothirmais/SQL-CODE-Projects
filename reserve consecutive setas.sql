Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?

seat_id free
1   1
2   0
3   1
4   1
5   1
Your query should return the following result for the sample case above.

seat_id
3
4
5
Note:
The seat_id is an auto-increment int, and free is bool (‘1’ means free, and ‘0’ means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.


Create table "cinema" (
    "seat_id" SERIAL primary key ,
    "free" bool);


WITH sub
AS (
    SELECT seat_id seat_id
        ,free free
        ,lead(free, 1) OVER (
            ORDER BY seat_id
            ) AS lead
        ,lag(free, 1) OVER (
            ORDER BY seat_id
            ) lag
    FROM cinema
    )
    ,sub1
AS (
    SELECT seat_id
        ,free free
        ,CASE WHEN lead = true AND free = true THEN 'consecutive_seat' WHEN lead IS NULL AND lag = true THEN 'consecutive_seat' WHEN lead = false AND lag = true AND free = true THEN 'consecutive_seat' ELSE 'not a _consecutive_seat' END AS seat_availabiltiy
    FROM sub
    )
SELECT seat_id
FROM sub1
WHERE seat_availabiltiy = 'consecutive_seat';





select seat_id,free,case when seat_id = true and seat_id + 1 = false  or seat_id = false then                    'not_consecutive_seat' when seat_id = true and seat_id + 1 = true then'consecutive_seat' when seat_id + 1 = true and seat_id-1 = false and seat_id = true then 'consecutive_seat' when seat_id + 1 is null and seat_id-1 = true and seat_id = true then 'consecutive_seat' else'not_consecutive_seat' end as seat_availability
from cinema

