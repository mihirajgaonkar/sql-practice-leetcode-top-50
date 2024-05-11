Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation: 
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33


my solution:
-- Write your PostgreSQL query statement below
-- Write your PostgreSQL query statement below
with temp as (
    select query_name,
    result,
    position,
    rating,
    (rating::numeric/position) as quality_metric,
    (case when (rating < 3) then 1 else 0 end) as poor_rating
    from Queries
)

select
    query_name,
    round(avg(quality_metric),2) as quality,
    round(avg(poor_rating*100),2) as poor_query_percentage
from
    temp
where query_name is not null
group by
    query_name

fastest solution
SELECT query_name, ROUND(SUM(rating :: NUMERIC/ position)/COUNT(*), 2) AS quality, ROUND(AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100, 2)  AS poor_query_percentage FROM Queries WHERE query_name IS NOT NULL GROUP BY query_name; 



fastest solution:
select r.contest_id, round(round(count(r.user_id), 2)  * 100/(select count(user_id) from users), 2) as percentage
from users as u
join register as r
on u.user_id = r.user_id
group by r.contest_id 
order by percentage desc, r.contest_id asc