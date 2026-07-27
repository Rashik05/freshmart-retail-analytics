USE FreshMartRetailDB;

-- Product Performance

-- Which products generate the highest revenue?

-- Business Objective:
-- Identify the products that generate the highest revenue to support
-- inventory planning, pricing decisions, and marketing strategies.

SELECT
    PM.ProductID,
    PM.ProductName,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Product_Master AS PM
JOIN Sales_Fact AS SF
    ON PM.ProductID = SF.ProductID
GROUP BY
    PM.ProductID,
    PM.ProductName
ORDER BY
    TotalRevenue DESC
LIMIT 10;

-- Which product categories contribute the most revenue?
-- Business Objective:
-- Identify the product categories contributing the highest revenue to prioritize marketing investment and inventory allocation.
SELECT
    PM.Category,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
GROUP BY
    PM.Category
ORDER BY
    TotalRevenue DESC;
    
-- How has revenue changed month over month?
-- Business Objective:
-- Monitor monthly revenue trends to identify seasonality, forecast demand, and evaluate business performance over time.

SELECT
    DD.MonthYear,
    SUM(SF.LineTotal) AS MonthlyRevenue
FROM Sales_Fact AS SF
JOIN Date_Dimension AS DD
    ON SF.DateKey = DD.DateKey
GROUP BY
    DD.MonthYear
ORDER BY
    MIN(DD.Date);
    
-- Which payment methods contribute the most sales?
-- Business Objective:
-- Understand customer payment preferences to improve payment services and optimize checkout operations.

SELECT
    SF.PaymentMethod,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Sales_Fact AS SF
GROUP BY
    SF.PaymentMethod
ORDER BY
    TotalRevenue DESC;
    
-- Which invoices generate the highest sales value?
-- Business Objective:
-- Identify high-value customer transactions to understand purchasing behavior and monitor large sales.

SELECT
    SF.InvoiceID,
    SUM(SF.LineTotal) AS InvoiceRevenue
FROM Sales_Fact AS SF
GROUP BY
    SF.InvoiceID
ORDER BY
    InvoiceRevenue DESC
LIMIT 10;

-- Which products are our biggest profit drivers?
-- Business Objective:
-- Identify the products generating the highest gross profit to improve pricing strategies and maximize profitability.

SELECT
    PM.ProductID,
    PM.ProductName,
    SUM((SF.UnitSellingPrice - PM.CostPrice) * SF.QuantitySold) AS GrossProfit
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
GROUP BY
    PM.ProductID,
    PM.ProductName
ORDER BY
    GrossProfit DESC
LIMIT 10;

-- Which brands perform the best?
-- Business Objective:
-- Evaluate brand performance to support supplier negotiations and future marketing investments.

SELECT
    PM.Brand,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
GROUP BY
    PM.Brand
ORDER BY
    TotalRevenue DESC;
    
-- Which product categories deserve more marketing investment?
-- Business Objective:
-- Identify high-performing product categories that deserve increased marketing investment and promotional efforts.

SELECT
    PM.Category,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
GROUP BY
    PM.Category
ORDER BY
    TotalRevenue DESC
LIMIT 5;

-- Which products should be promoted based on sales performance?
-- Business Objective:
-- Identify products with strong sales demand that are suitable for promotional campaigns and featured placements.

SELECT
    PM.ProductID,
    PM.ProductName,
    SUM(SF.QuantitySold) AS UnitsSold
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
GROUP BY
    PM.ProductID,
    PM.ProductName
ORDER BY
    UnitsSold DESC
LIMIT 10;

-- Which products require business review due to poor performance?
-- Business Objective: 
-- Identify underperforming products that require pricing, marketing, or inventory review to improve business performance.

SELECT
    PM.ProductID,
    PM.ProductName,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
GROUP BY
    PM.ProductID,
    PM.ProductName
ORDER BY
    TotalRevenue ASC
LIMIT 10;

-- Inventory Analysis 

-- Which products require immediate restocking?
-- Business Objective:
-- Identify products with inventory below the reorder level to prevent stock shortages.

SELECT
    PM.ProductID,
    PM.ProductName,
    IFT.ClosingStock,
    IFT.ReorderLevel
FROM Inventory_Fact AS IFT
JOIN Product_Master AS PM
    ON IFT.ProductID = PM.ProductID
WHERE IFT.ClosingStock < IFT.ReorderLevel
ORDER BY
    IFT.ClosingStock ASC;
    
-- What is the current total inventory value?
-- Business Objective:
-- Calculate the total value of inventory currently held to support financial planning.

SELECT
    SUM(IFT.ClosingStock * PM.CostPrice) AS TotalInventoryValue
FROM Inventory_Fact AS IFT
JOIN Product_Master AS PM
    ON IFT.ProductID = PM.ProductID;
    
-- Which products tie up the most inventory investment?
-- Business Objective:
-- Identify products with the highest inventory value to optimize working capital.

SELECT
    PM.ProductID,
    PM.ProductName,
    (IFT.ClosingStock * PM.CostPrice) AS InventoryValue
FROM Inventory_Fact AS IFT
JOIN Product_Master AS PM
    ON IFT.ProductID = PM.ProductID
ORDER BY
    InventoryValue DESC
LIMIT 10;

-- Which product categories hold the highest inventory value?
-- Business Objective:
-- Determine which product categories represent the largest inventory investment.

SELECT
    PM.Category,
    SUM(IFT.ClosingStock * PM.CostPrice) AS InventoryValue
FROM Inventory_Fact AS IFT
JOIN Product_Master AS PM
    ON IFT.ProductID = PM.ProductID
GROUP BY
    PM.Category
ORDER BY
    InventoryValue DESC;
    
-- Which products are moving slowly through inventory?
-- Business Objective:
-- Identify slow-moving products to improve inventory turnover and reduce carrying costs.

SELECT
    PM.ProductID,
    PM.ProductName,
    SUM(IFT.SoldQty) AS TotalUnitsSold
FROM Inventory_Fact AS IFT
JOIN Product_Master AS PM
    ON IFT.ProductID = PM.ProductID
GROUP BY
    PM.ProductID,
    PM.ProductName
ORDER BY
    TotalUnitsSold ASC
LIMIT 10;

-- Business Question:
-- Which categories require inventory optimization?

-- Business Objective:
-- Identify product categories with high inventory levels to improve inventory allocation and reduce holding costs.

SELECT
    PM.Category,
    SUM(IFT.ClosingStock * PM.CostPrice) AS InventoryValue
FROM Inventory_Fact AS IFT
JOIN Product_Master AS PM
    ON IFT.ProductID = PM.ProductID
GROUP BY
    PM.Category
ORDER BY
    InventoryValue DESC;
    
-- Business Question:
-- Which products have the highest inventory turnover?

-- Business Objective:
-- Identify products that sell quickly to improve replenishment planning and inventory management.

SELECT
    PM.ProductID,
    PM.ProductName,
    SUM(IFT.SoldQty) AS UnitsSold
FROM Inventory_Fact AS IFT
JOIN Product_Master AS PM
    ON IFT.ProductID = PM.ProductID
GROUP BY
    PM.ProductID,
    PM.ProductName
ORDER BY
    UnitsSold DESC
LIMIT 10;

-- SUPPLIER ANALYSIS

-- Business Question:
-- Which suppliers account for the highest purchasing costs?

-- Business Objective:
-- Identify suppliers with the highest procurement costs to support supplier negotiations and purchasing decisions.

SELECT
    SM.SupplierName,
    SUM(PF.TotalCost) AS TotalPurchaseCost
FROM Purchase_Fact AS PF
JOIN Supplier_Master AS SM
    ON PF.SupplierID = SM.SupplierID
GROUP BY
    SM.SupplierName
ORDER BY
    TotalPurchaseCost DESC;
    
-- Business Question:
-- Which suppliers provide the widest product range?

-- Business Objective:
-- Identify suppliers offering the largest product variety to support supplier relationship management.

SELECT
    SM.SupplierName,
    COUNT(PM.ProductID) AS TotalProducts
FROM Supplier_Master AS SM
JOIN Product_Master AS PM
    ON SM.SupplierID = PM.SupplierID
GROUP BY
    SM.SupplierName
ORDER BY
    TotalProducts DESC;
    
-- Business Question:
-- Which suppliers contribute the most revenue?

-- Business Objective:
-- Identify suppliers whose products generate the highest sales revenue.

SELECT
    SM.SupplierName,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
JOIN Supplier_Master AS SM
    ON PM.SupplierID = SM.SupplierID
GROUP BY
    SM.SupplierName
ORDER BY
    TotalRevenue DESC;
    
-- Business Question:
-- Which supplier relationships are the most valuable?

-- Business Objective:
-- Evaluate supplier performance based on combined revenue generated by their supplied products.

SELECT
    SM.SupplierName,
    COUNT(DISTINCT PM.ProductID) AS ProductsSupplied,
    SUM(SF.LineTotal) AS TotalRevenue
FROM Supplier_Master AS SM
JOIN Product_Master AS PM
    ON SM.SupplierID = PM.SupplierID
JOIN Sales_Fact AS SF
    ON PM.ProductID = SF.ProductID
GROUP BY
    SM.SupplierName
ORDER BY
    TotalRevenue DESC;
    
-- Business Question:
-- Which suppliers support our highest-selling products?

-- Business Objective:
-- Identify suppliers responsible for products with the highest sales volume to strengthen strategic supplier partnerships.

SELECT
    SM.SupplierName,
    SUM(SF.QuantitySold) AS TotalUnitsSold
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
JOIN Supplier_Master AS SM
    ON PM.SupplierID = SM.SupplierID
GROUP BY
    SM.SupplierName
ORDER BY
    TotalUnitsSold DESC;
    
-- PROFITABILITY ANALYSIS

-- Business Question:
-- What is the company's total gross profit?


-- Business Objective:
-- Measure the overall profitability of the business after accounting for product costs.


SELECT
    SUM((SF.UnitSellingPrice - PM.CostPrice) * SF.QuantitySold) AS GrossProfit
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID;
    
-- Business Question:
-- Which categories generate the highest profit?

-- Business Objective:
-- Identify the most profitable product categories to guide inventory and marketing decisions.

SELECT
    PM.Category,
    SUM((SF.UnitSellingPrice - PM.CostPrice) * SF.QuantitySold) AS GrossProfit
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
GROUP BY
    PM.Category
ORDER BY
    GrossProfit DESC;
    
-- Business Question:
-- Are discounts reducing profitability?

-- Business Objective:
-- Evaluate the impact of discounts on overall business profitability.

SELECT
    SUM(SF.DiscountAmount) AS TotalDiscount,
    SUM((SF.UnitSellingPrice - PM.CostPrice) * SF.QuantitySold) AS GrossProfit
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID;
    
-- Business Question:
-- Which products produce the greatest return on investment?

-- Business Objective:
-- Identify products delivering the highest profit relative to their cost.

SELECT
    PM.ProductID,
    PM.ProductName,
    ROUND(
        ((PM.SellingPrice - PM.CostPrice) / PM.CostPrice) * 100,
        2
    ) AS ROI_Percentage
FROM Product_Master AS PM
ORDER BY
    ROI_Percentage DESC
LIMIT 10;

-- Business Question:
-- Which products are sold with the lowest profit margin?

-- Business Objective:
-- Identify products with low profitability that may require pricing
-- review or supplier negotiations.

SELECT
    ProductID,
    ProductName,
    MarginPercent
FROM Product_Master
ORDER BY
    MarginPercent ASC
LIMIT 10;

-- TIME-BASED ANALYSIS

-- Business Question:
-- Which months perform best?

-- Business Objective:
-- Identify the highest-performing months to support seasonal planning and demand forecasting.

SELECT
    DD.MonthYear,
    SUM(SF.LineTotal) AS MonthlyRevenue
FROM Sales_Fact AS SF
JOIN Date_Dimension AS DD
    ON SF.DateKey = DD.DateKey
GROUP BY
    DD.MonthYear
ORDER BY
    MonthlyRevenue DESC;
    
-- Business Question:
-- Which quarters perform best?

-- Business Objective:
-- Evaluate quarterly performance to support strategic planning.

SELECT
    DD.Quarter,
    SUM(SF.LineTotal) AS QuarterlyRevenue
FROM Sales_Fact AS SF
JOIN Date_Dimension AS DD
    ON SF.DateKey = DD.DateKey
GROUP BY
    DD.Quarter
ORDER BY
    QuarterlyRevenue DESC;
    
-- Business Question:
-- Are sales improving over time?

-- Business Objective:
-- Monitor long-term sales performance to identify growth or decline.

SELECT
    DD.MonthYear,
    SUM(SF.LineTotal) AS MonthlyRevenue
FROM Sales_Fact AS SF
JOIN Date_Dimension AS DD
    ON SF.DateKey = DD.DateKey
GROUP BY
    DD.MonthYear
ORDER BY
    MIN(DD.Date);
    
-- Business Question:
-- Which products show the strongest sales growth?

-- Business Objective:
-- Identify products with increasing customer demand over time.

SELECT
    PM.ProductName,
    DD.MonthYear,
    SUM(SF.QuantitySold) AS UnitsSold
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
JOIN Date_Dimension AS DD
    ON SF.DateKey = DD.DateKey
GROUP BY
    PM.ProductName,
    DD.MonthYear
ORDER BY
    PM.ProductName,
    DD.MonthYear;
    
-- Business Question:
-- Which categories are losing momentum?

-- Business Objective:
-- Identify declining product categories that may require marketing
-- or pricing intervention.

SELECT
    PM.Category,
    DD.MonthYear,
    SUM(SF.LineTotal) AS MonthlyRevenue
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
    ON SF.ProductID = PM.ProductID
JOIN Date_Dimension AS DD
    ON SF.DateKey = DD.DateKey
GROUP BY
    PM.Category,
    DD.MonthYear
ORDER BY
    PM.Category,
    DD.MonthYear;
    
-- Business Question:
-- What is the company's total revenue?

-- Business Objective:
-- Measure the total sales revenue generated by the business.

SELECT
    SUM(LineTotal) AS TotalRevenue
FROM Sales_Fact;

-- Business Question:
-- What is the company's total gross profit?

-- Business Objective:
-- Measure the overall profitability after accounting for product costs.

SELECT
    SUM((SF.UnitSellingPrice - PM.CostPrice) * SF.QuantitySold) AS GrossProfit
FROM Sales_Fact AS SF
JOIN Product_Master AS PM
ON SF.ProductID = PM.ProductID;

-- Business Question:
-- What is the average basket size?

-- Business Objective:
-- Calculate the average value of customer purchases per invoice.

SELECT
    ROUND(AVG(InvoiceTotal),2) AS AverageBasketSize
FROM
(
    SELECT
        InvoiceID,
        SUM(LineTotal) AS InvoiceTotal
    FROM Sales_Fact
    GROUP BY InvoiceID
) AS Basket;

-- Business Question:
-- How many units have been sold?

-- Business Objective:
-- Measure the total sales volume across all products.

SELECT
    SUM(QuantitySold) AS TotalUnitsSold
FROM Sales_Fact;

-- Business Question:
-- What is the company's gross margin percentage?

-- Business Objective:
-- Evaluate overall business profitability relative to revenue.

SELECT
ROUND(
(
SUM((SF.UnitSellingPrice-PM.CostPrice)*SF.QuantitySold)
/
SUM(SF.LineTotal)
)*100,2) AS GrossMarginPercentage
FROM Sales_Fact SF
JOIN Product_Master PM
ON SF.ProductID=PM.ProductID;

-- ADVANCED ANALYTICS

-- Business Question:
-- Rank products by total revenue.

-- Business Objective:
-- Identify the highest-performing products using ranking analysis.

SELECT
    PM.ProductName,
    SUM(SF.LineTotal) AS TotalRevenue,
    RANK() OVER(
        ORDER BY SUM(SF.LineTotal) DESC
    ) AS RevenueRank
FROM Sales_Fact SF
JOIN Product_Master PM
ON SF.ProductID=PM.ProductID
GROUP BY PM.ProductName;

-- Business Question:
-- Which products contribute to 80% of total revenue?

-- Business Objective:
-- Perform Pareto Analysis to identify the most valuable products.

WITH RevenueCTE AS
(
SELECT
PM.ProductName,
SUM(SF.LineTotal) AS Revenue
FROM Sales_Fact SF
JOIN Product_Master PM
ON SF.ProductID=PM.ProductID
GROUP BY PM.ProductName
)

SELECT *
FROM RevenueCTE
ORDER BY Revenue DESC;

-- Business Question:
-- What is the cumulative monthly revenue?

-- Business Objective:
-- Track cumulative revenue growth over time.

SELECT
DD.MonthYear,
SUM(SF.LineTotal) AS MonthlyRevenue,
SUM(SUM(SF.LineTotal))
OVER(
ORDER BY MIN(DD.Date)
) AS RunningRevenue
FROM Sales_Fact SF
JOIN Date_Dimension DD
ON SF.DateKey=DD.DateKey
GROUP BY DD.MonthYear;

-- Business Question:
-- How does each month's revenue compare with the previous month?

-- Business Objective:
-- Compare month-over-month revenue to identify growth trends.

SELECT
DD.MonthYear,
SUM(SF.LineTotal) AS MonthlyRevenue,

LAG(SUM(SF.LineTotal))
OVER(
ORDER BY MIN(DD.Date)
) AS PreviousMonthRevenue

FROM Sales_Fact SF
JOIN Date_Dimension DD
ON SF.DateKey=DD.DateKey
GROUP BY DD.MonthYear;

-- Business Question:
-- Which products consistently perform well over time?

-- Business Objective:
-- Identify consistently high-performing products using window functions.

SELECT
PM.ProductName,
DD.MonthYear,
SUM(SF.LineTotal) AS MonthlyRevenue,

ROW_NUMBER()
OVER(
PARTITION BY PM.ProductName
ORDER BY DD.MonthYear
) AS MonthNumber

FROM Sales_Fact SF
JOIN Product_Master PM
ON SF.ProductID=PM.ProductID

JOIN Date_Dimension DD
ON SF.DateKey=DD.DateKey

GROUP BY
PM.ProductName,
DD.MonthYear;