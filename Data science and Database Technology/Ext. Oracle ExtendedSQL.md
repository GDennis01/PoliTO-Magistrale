#### Physical aggregation example
Example table:
SALES(**City**, **Date**, Amount) 
Select, separately for each city, for each date the amount and the average amount over the current and the previous two rows.
Query:
SELECT Date, Amount,
AVG(Amount) OVER ( 
	PARTITION BY City ORDER BY Date ROWS 2 PRECEDING 
	) 
	AS MovingAverage FROM Sales ORDER BY Date;
#### Logical aggregation example
Select, separately for each city, for each date the amount and the average amount over the current row and the sales of the two previous days.
Query:
SELECT Date, Amount, AVG(Amount) OVER 
( PARTITION BY City ORDER BY **Date** RANGE BETWEEN INTERVAL ‘2’ DAY PRECEDING AND CURRENT ROW )
AS Last3DaysAverage FROM Sales ORDER BY Date;

#### Ranking example
Schema :
SUPPLIERS(Cod_S, Name, SLocation ) 
ITEM(Cod_I, Type, Color, Weight) 
PROJECTS(Cod_P, Name, PLocation) 
FACTS(Cod_S, Cod_I, Cod_P, SoldAmount)

Select for each item the total amount sold and the ranking according to the total amount sold

Query:
SELECT COD_I, SUM(SoldAmount), RANK() 
OVER ( ORDER BY SUM(SoldAmount) ) AS SalesRank 
FROM Facts GROUP BY COD_I;

**DENSE_RANK()** doesnt leave missing positions.


#### Row Number
Assigning a progressive number to each row in a partition.

#### CUME_DIST
Similar to ROW_NUMBER but assigns a number between 0 and 1 based on how many records there are

#### NTITLES(n)
Splits each partition in $n$ subgroups containing the same number of records


### Materialized View
A standard view that it's actually stored in the database.
DBMS can rewrite a query by using a materialized view to improve the performance.
![[define_mat_view.png]]
*Syntax to define a materialized view*

##### Name
Name of the view
##### Query
Actual query that creates the materialized view, written in Standard SQL
##### Build
Optional parameter. Whether to build(create and load) the view immediately as soon as the create query is executed(**immediate**) or just creating the view.

##### Refresh
When to refresh data
**Complete:** recomputes the query result by executing the query on all data.
**Fast:** updates the content of the materialized view using the changes since the last refresh
**Force:** when possiboe, use the **fast** approach, otherwise the **complete** approach
**Never:** the content of the materialized view is not updated  using Oracle standard procedures.

#### On commit
An automatic refresh is performed when SQL operations affect the materialized view content

#### On demand
The refresh is performed only upon explicit request of the user issuing the command
(DBMS_MVIEW.REFRESH)

#### Enable query rewrite
Enables the DBMS to automatically use the materialized view to speed up execution.
Available only in **paid** oracle.

#### Fast refresh
It requires  a proper structures to log changes.
**MATERIALIZED VIEW LOG:** A log table for each materialize view which stores changes.
Can be upsed only if:
- materialized view **logs** for tables and attributes exist
- when the GROUP BY clause is used, in the SELECT statement an aggregation function must be specified (e.g., COUNT, SUM, …)
![[mview_log_creation.png]]
*Standard syntax for creating a materialized view log. Sequence and ROWID are options that tracks the sequence and ID of new records*

By issuing the following command![[refresh_ondemand.png]]
, the user can request  an update on a materialized view

![[dml_view.png]]
*DML for views*



##### Esercizi
select c.categoryname,sum(totamount),count(numsolditems) as numbersold, rank() over(
order by sum(totamount) DESC
) as ranktotal,
rank() over (
order by count(numsolditems) DESC
) as ranknumber
from sales s,category c
where s.itemcategoryID = c.categoryID
group by CategoryID
order by ranknumber

--------------------
select c.province,c.region,sum(s.totamount),
rank over(
partition by c.region
order by sum(totamount)
) as saleprovince

from sales s,customer c
where s.customerid=c.customerid
group by c.province,c.region

------------------------------
select c.province,c.region,t.month,sum(s.totalamount),
rank() over(
	partition by month order by sum(s.totalamount)
)
from sales s,customer c,time t
where s.customerid=c.customerid and s.timeid=t.timeid
group by province,region,month

---------------------------------
select c.region,c.province, sum(s.totamount)
sum(sum(totamount)) over(
	partition by region order by month
	ROWS UNBOUNDED PRECEDING
	)
from sales s,customer c
where s.customerid=c.customerid
group by province,region,month

**2 AGGREGATION FUNCTIONS ARE NEEDED WHEN I HAVE PARTITION WITH GROUP BY(THUS WHEN I HAVE SUBGROUPS)**

