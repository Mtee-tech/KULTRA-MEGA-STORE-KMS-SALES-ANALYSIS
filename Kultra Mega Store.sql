create database KultraMegaStoredb

-------import flat file (csv) kultra mega storedb and order status.

select * from [Abuja division of Kms]


select COUNT(distinct Row_ID)
as total kultramegastore
from [Kultra Mega Store]

------Case Sceneroi 1(1)
------Product category with the highest sales

SELECT top 1 Product_Category, SUM(Sales) AS Total_Sales
FROM [Abuja division of Kms]
GROUP BY Product_Category
ORDER BY Total_Sales DESC

----(2)what are the top 3 and bottom 3regions in terms of sale
-----Top 3

 SELECT top 3 Region, sum(Sales) AS total_Sales
FROM [Abuja division of Kms]
group by Region
order by total_Sales asc

-----bottom 3
SELECT top 3 Region, sum(Sales) AS total_Sales
FROM [Abuja division of Kms]
group by Region
order by total_Sales desc

------(3)Total sales of appliances in ontario

SELECT Region, SUM(sales) AS total_sales
FROM [Abuja division of Kms]
WHERE 
    province = 'Ontario' 
	AND product_sub_category = 'Appliances'
	group by Region

	---(4) advice to KMS management over their bottom 10 customer
	------ Analyze Their Purchase Patterns
You can analyze their purchase frequency, average order value, and product preferences.
----Targeted Strategies ----Once you've identified the bottom 10 customers and their behavior, you can implement strategies like:

Personalized Offers: Provide discounts or promotions tailored to their preferences.
Upselling/Cross-Selling: Recommend complementary or higher-value products.
Engagement Campaigns: Send reminders, loyalty rewards, or exclusive deals to encourage repeat purchases.
4. Track Improvements
After implementing strategies, monitor the revenue changes for these customers using a similar query to track progress over time.

By combining SQL analysis with actionable business strategies, you can effectively work on increasing revenue from your bottom 10 customers.

----- customer with bottom 10 revenue

	SELECT TOP 10 Row_ID, Customer_Name, SUM(sales) AS Total_sales
FROM [Abuja division of Kms]
GROUP BY Row_ID, Customer_Name
ORDER BY Total_sales ASC;

----- (5)which KMS method incured the most shipping cost

SELECT top 1 Ship_Mode, SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM  [Abuja division of Kms]
GROUP BY Ship_Mode
ORDER BY Total_Shipping_Cost asc;

----- Case Scenario 2
-----(6) The Valuable Customer Kultra Mega Store and the Product / service they typically purchased----
----top 10 customer
select top 10 Customer_Name, Product_Name,
sum(Sales) as Total_Sales
from [Abuja division of Kms]
group by Customer_Name, Product_Name
order by Total_Sales asc

----(7)  Small Business Customer with the highest sales------
select top 1 customer_name,
sum(Sales) as Total_Sales
from [Abuja division of Kms]
where customer_segment = 'Small Business'
group by customer_name
order by total_sales asc

------(8) Corporate Customer that placed Order the most from 2009 - 2012
select top 1 customer_name,
count(distinct Order_ID) as number_of_orders
from [Abuja division of Kms]
where customer_segment = 'corporate'
and order_Date BETWEEN '2009-01-01' and '2012-12-31'
group by customer_name
order by number_of_orders desc

select top 1 customer_name,
count(distinct Order_ID) as number_of_orders
from [Abuja division of Kms]
where customer_segment = 'corporate'
and order_Date BETWEEN '2009-01-01' and '2012-12-31'
group by customer_name
order by number_of_orders asc

-----The Most Profitable customer of Kultra Mega Store
select top 1 customer_name,
sum(profit) as total_profit
from  [Abuja division of Kms]
where customer_segment = 'consumer'
group by customer_name
order by total_profit desc

------(10) Customers that Returned Item and their Segment
select distinct o.order_id,
o.customer_name,
o.customer_segment
from [Abuja division of Kms] o
Join Order_Status R
ON o.Order_ID = r.Order_ID
where R.status = 'Returned';

-----(11) Analysis on if the company appropriately spent shiping costs based on the order priority 
----( if high-priority orders use more expensive shipping (Express Air) and low-priority use economical (Delivery Truck))

select 
Order_Priority, Ship_Mode,
count (Order_ID) as Ordercount,
round(sum(Sales-Profit),2)as estimatedshipingcost,
avg (DATEdiff(day,Order_Date,Ship_Date)) as avgshipdays
from [Abuja division of Kms]
group by order_priority, ship_mode
order by order_priority, ship_mode desc

------Analysis:If "Critical" or "High" priority orders use Express Air most, and "Low" priority use Delivery Truck, shipping cost aligns with priority.
-----If not, the company may be overspending on shipping for low-priority orders.

