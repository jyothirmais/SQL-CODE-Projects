SAMPLE DATE:
+---------------+---------------+---------------+---------------+-------+
| Flight_Date   | Flight_Number | Departure | Arrival   | Cost  |
+---------------+---------------+---------------+---------------+-------+
| 11/10/2021    | 1     | SEA       | LAX       | 395   |
| 11/10/2021    | 2     | PDX       | LAX       | 161   |
| 11/10/2021    | 3     | SFO       | LAX       | 319   |
| 11/10/2021    | 4     | PHX       | SEA       | 146   |
| 11/10/2021    | 5     | LAX       | SFO       | 486   |
| 11/10/2021    | 6     | SEA       | MCO       | 406   |
| 11/10/2021    | 7     | PDX       | DEN       | 391   |
| 11/10/2021    | 8     | DEN       | MCO       | 331   |
| 11/10/2021    | 9     | MCO       | DEN       | 317   |
| 11/10/2021    | 10    | SEA       | LAX       | 500   |
+---------------+---------------+---------------+---------------+-------+

Print the list of distinct airports that have flights between them.
                        Ex. SFO --> LAX and LAX --> SFO counts once.

select *
from flights f1,flights f2
where f1.arrival=f2.departure and f1.departure=f2.arrival
;
