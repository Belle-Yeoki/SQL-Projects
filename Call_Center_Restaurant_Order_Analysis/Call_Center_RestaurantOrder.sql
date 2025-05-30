SELECT TOP (1000) [Serial_No]
      ,[Date]
      ,[Time_customer_placed_order]
      ,[Time_order_placed_at_restaurant]
      ,[Time_driver_arrived_at_restaurant]
      ,[Delivery_time]
      ,[Driver_ID]
      ,[Driver_Name]
      ,[Restaurant_ID]
      ,[Customer_ID]
      ,[Delivery_Area]
      ,[ASAP]
      ,[Sub_Total]
      ,[Delivery_fee]
      ,[Service_fee]
      ,[Discount]
      ,[Tip]
      ,[Refunded_amount]
  FROM [Call_Center_DeliveryAnalysis].[dbo].[Call-Center_Restaurant-Orders_Challenge]
  --Total Orders
  SELECT 
       COUNT(*) AS Total_Orders
  FROM [Call-Center_Restaurant-Orders_Challenge]
  --No of Customers--
  SELECT 
    COUNT(DISTINCT [Customer_ID]) AS Unique_Customers
   FROM 
    [Call-Center_Restaurant-Orders_Challenge]
  --No of restaurants--
  SELECT 
    COUNT(DISTINCT [Restaurant_ID]) AS Unique_Restaurants
   FROM 
    [Call-Center_Restaurant-Orders_Challenge]
	--Orders per Restaurant
	SELECT 
    [Restaurant_ID], 
    COUNT(*) AS Total_Orders
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    [Restaurant_ID]
ORDER BY 
    Total_Orders DESC;  -- optional: shows top restaurants by order count
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
--No Delivery Drivers
  SELECT 
    COUNT(DISTINCT  Driver_ID) AS Total_Delivery_Drivers
   FROM 
    [Call-Center_Restaurant-Orders_Challenge];

--No of Delivery Per Driver
SELECT 
    [Driver_Name], 
    COUNT(*) AS Total_Deliveries
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    [Driver_Name]
ORDER BY 
    Total_Deliveries DESC;

--Sum revenues
  SELECT 
    SUM(Tip) AS Total_Tips,
    SUM(Delivery_fee) AS Total_Delivery_Fee,
	SUM(Sub_Total) AS Total_SubTotal,
	SUM(Service_fee) AS Total_Service_Fee,
	SUM(Discount) AS Total_Discount,
	SUM(Refunded_amount) AS Total_Refunded_amount
FROM 
    [Call-Center_Restaurant-Orders_Challenge];

--Which Month had the highest delivery revenue?
	SELECT 
    FORMAT([Date], 'yyyy-MM') AS Month,
    SUM(Delivery_fee) AS Total_Delivery_Revenue
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    FORMAT([Date], 'yyyy-MM')
ORDER BY 
    Total_Delivery_Revenue DESC;
-- Total_Tips collected by Driver
SELECT TOP 5
    [Driver_Name], 
    SUM(Tip) AS Total_Tips
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    [Driver_Name]
ORDER BY 
    Total_Tips DESC;
--Average Tips
SELECT AVG(Tip) AS Avg_Tip_Per_Order
FROM [Call-Center_Restaurant-Orders_Challenge]
--Monthly Total Tips and Delivery fees
SELECT 
    FORMAT([Date], 'yyyy-MM') AS Month,
    SUM(Tip) AS Total_Tips,
    SUM(Delivery_fee) AS Total_Delivery_Fee
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
WHERE 
    [Date] BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    FORMAT([Date], 'yyyy-MM')
ORDER BY 
    Month;
--Average Delivery from restaurant to drivers arrival
SELECT 
    FORMAT([Date], 'yyyy-MM') AS Month,
    AVG(DATEDIFF(MINUTE, Time_order_placed_at_restaurant, Time_driver_arrived_at_restaurant)) AS Avg_Delivery_Time_Minutes
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
WHERE 
    Time_order_placed_at_restaurant IS NOT NULL
    AND Time_driver_arrived_at_restaurant IS NOT NULL
GROUP BY 
    FORMAT([Date], 'yyyy-MM')
ORDER BY 
    Month;
--Peak order time
SELECT 
    DATEPART(HOUR, [Time_customer_placed_order]) AS Order_Hour,
    COUNT(*) AS Total_Orders
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    DATEPART(HOUR, [Time_customer_placed_order])
ORDER BY 
    Total_Orders DESC;
--Driver Wait time at restaurant
SELECT 
    DATEDIFF(MINUTE, [Time_order_placed_at_restaurant], [Time_driver_arrived_at_restaurant]) AS Driver_Arrival_Lag_Minutes
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
--Order placement Lag
SELECT 
    DATEDIFF(MINUTE, [Time_customer_placed_order], [Time_order_placed_at_restaurant]) AS Call_Center_Lag_Minutes
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
--Restaurant that place orders quickly
SELECT 
    Restaurant_ID,
    COUNT(*) AS Total_Orders,
    AVG(DATEDIFF(MINUTE, Time_customer_placed_order, Time_order_placed_at_restaurant)) AS Avg_Order_Placement_Time_Minutes
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
WHERE 
    Time_customer_placed_order IS NOT NULL AND
    Time_order_placed_at_restaurant IS NOT NULL
GROUP BY 
    Restaurant_ID
ORDER BY 
    Avg_Order_Placement_Time_Minutes ASC; -- Most efficient restaurants at top
--Drivers that deliver food on time
SELECT 
    Driver_ID,
    Driver_Name,
    COUNT(*) AS Total_Deliveries,
    AVG(DATEDIFF(MINUTE, Time_order_placed_at_restaurant, Time_driver_arrived_at_restaurant)) AS Avg_Delivery_Time_Minutes
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
WHERE 
    Time_order_placed_at_restaurant IS NOT NULL AND
    Time_driver_arrived_at_restaurant IS NOT NULL
GROUP BY 
    Driver_ID, Driver_Name
ORDER BY 
    Avg_Delivery_Time_Minutes ASC; -- Fastest drivers at top
--Average delivery time by Area
SELECT 
    Delivery_Area,
    COUNT(*) AS Total_Deliveries,
    AVG(DATEDIFF(MINUTE, Time_order_placed_at_restaurant, Time_driver_arrived_at_restaurant)) AS Avg_Delivery_Time_Minutes
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
WHERE 
    Time_order_placed_at_restaurant IS NOT NULL AND
    Time_driver_arrived_at_restaurant IS NOT NULL
GROUP BY 
    Delivery_Area
ORDER BY 
    Avg_Delivery_Time_Minutes ASC;

--Areas with more customers
SELECT 
    [Delivery_Area],
    COUNT(DISTINCT [Customer_ID]) AS Unique_Customers
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    [Delivery_Area]
ORDER BY 
    Unique_Customers DESC;
	--Which Area has more deliveries
SELECT 
    [Delivery_Area],
    COUNT(*) AS Total_Deliveries
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    [Delivery_Area]
ORDER BY 
    Total_Deliveries DESC;

--Customers who wants there goods ASAP
SELECT 
    [ASAP],
    COUNT(*) AS Total_Orders
FROM 
    [Call-Center_Restaurant-Orders_Challenge]
GROUP BY 
    [ASAP]
ORDER BY 
    Total_Orders DESC;







