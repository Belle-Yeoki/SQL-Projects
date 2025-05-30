# Unwrapping Food Delivery Insights: A Call Center Restaurant Orders Analysis
![](Ccoverpage.png)
## Introduction
Over the past few weeks, I took a deep dive into a food delivery dataset with 72,314 orders, involving 6,262 unique customers, 408 restaurants, and a fleet of delivery drivers. As a data analyst, my goal was to help uncover the operational strengths, challenges, and untapped opportunities in this delivery business.

Food delivery is a fast-paced game — and behind every hot meal delivered is a chain of processes that either delight customers or lead to delays and lost revenue. This project is about making sense of that.

## Problem Statement
Despite receiving thousands of orders, the business wasn’t sure where inefficiencies were creeping in:

Which drivers deliver on time and which delay orders?

Do certain areas take longer to serve than others?

Which restaurants drive the most revenue?

What’s the customer tipping behavior like?

Are customers requesting ASAP orders more often?

The business needed answers, and I was determined to find them.

## Objective
The key objectives of this project were:

Identify top-performing restaurants based on order volume and revenue.

Measure average delivery times and what influences them.

Analyze driver performance, particularly around tip amounts and delivery efficiency.

Analyze driver performance, particularly around tip amounts and delivery efficiency.

Discover customer preferences, including ASAP requests and popular delivery areas.

Provide actionable recommendations to improve customer experience and delivery operations.

## Data Source
The dataset was provided in Excel and uploaded to SQL Server Management Studio for querying. It contains timestamped order records, delivery details, financial figures (tips, discounts, fees), and driver/customer IDs.

Key columns included:

Date, Time_order_placed_at_restaurant, Time_driver_arrived_at_restaurant,Delivery_time

Driver_ID, Driver_Name, Customer_ID, Restaurant_ID, Delivery_Area

Sub_Total, Tip, Delivery_fee, ASAP (order urgency)

## Skills Demonstrated
SQL Querying (JOINs, GROUP BY, DATEDIFF, Aggregation)

Exploratory Data Analysis (EDA) using SQL

Data Cleaning (handling NULLs, formatting issues)

KPI Reporting (revenue, tips, delivery time, customer behavior)

Storytelling with Data (insightful narrative presentation)

Problem-Solving (translating business challenges into queries)

## Insights Drawn
Here are some of the most eye-opening discoveries:

### Key Metrics(KPIs)
Total Orders 72314
Total Customers 6262
Total Drivers 432
Unique Restaurants 408

 Top Performing Restaurants
Based on total orders, Restaurant ID 7320 leads with 256 orders, showing high demand and customer preference. A total of 9 restaurants had over 230 orders, indicating they are consistent performers. These restaurants may be driving a significant portion of revenue and should be prioritized in operational planning and partnerships.However, high volume didn’t always equal high revenue.

```
SELECT 
    Restaurant_ID, 
    COUNT(*) AS Total_Orders
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    Restaurant_ID
ORDER BY 
    Total_Orders DESC;
```

 Top Revenue Contributors
While total order count is important, total revenue is more valuable to the business. Here, Restaurant ID 7062 leads in delivery revenue at $1423.40 and subtotal at $21,994. This highlights it as a high-value partner. Others like 7208 revenue $1412.94 and subtotal $19988.50, 7123,7113,7240 also contribute significantly despite fewer total orders, suggesting larger average order values.
```
--Restaurant that generate more delivery Revenue fee and Sub total
	SELECT 
    [Restaurant_ID], 
    SUM(Delivery_fee) AS Delivery_Revenue,
	SUM(Sub_Total) AS Total_Subtotal
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    [Restaurant_ID]
ORDER BY 
    Delivery_Revenue DESC;
```

1. Top 5 Restaurants by Revenue
Certain restaurants consistently outperformed others. These top spots not only had the most orders but also generated significantly higher delivery fees and tips.

2.  Driver Performance
Some drivers consistently received more tips than others. Drivers with quicker delivery times were often rewarded more — highlighting the link between speed and customer satisfaction.

3.  Average Delivery Time by Area
Delivery times varied significantly by area. Densely populated or hard-to-reach neighborhoods had higher delivery time averages.

4.  ASAP Orders Dominate
Many customers chose the “ASAP” option, emphasizing their need for speed. This urgency could be used to prioritize dispatching strategies.

5.  Delivery Area Patterns
Some areas received far more deliveries than others — identifying key zones that should have more dedicated drivers for efficiency.

## Recommendations
Reward high-performing drivers (by tips or delivery time) to maintain quality.

Collaborate more with high-revenue restaurants, even if their order counts are lower.

Optimize driver routes for areas with longer delivery times.

Consider pre-positioning drivers during peak "ASAP" request times.

Perform monthly reviews of performance metrics to identify seasonal patterns.

## Conclusion
This project was more than just running SQL queries — it was about telling a story with data, listening to what the numbers were saying, and helping the business serve its customers better. With insights in hand, the business can now optimize delivery operations, boost revenue, and increase customer satisfaction.

For me, this was a rewarding journey that sharpened my analytical thinking and SQL skills. And I’m excited for the next problem to solve.

