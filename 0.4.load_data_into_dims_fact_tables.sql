---------------------------------------------------------
-- LOAD DATA INTO DIMENSION TABLES
---------------------------------------------------------

-- dim date

INSERT INTO dwh_retail_sales.dbo.dim_date (
	Purchase_Date, 
	Ship_Date, 
	Return_Date
)
SELECT DISTINCT 
	Purchase_Date, 
	Ship_Date, 
	Return_Date
FROM stg_retail_sales.dbo.retail_sales_raw_data;


-- dim location

INSERT INTO dwh_retail_sales.dbo.dim_location (
    Continent, 
    Country, 
    City
)
SELECT DISTINCT 
    Continent, 
    Country, 
    City
FROM stg_retail_sales.dbo.retail_sales_raw_data;


-- dim_store

INSERT INTO dwh_retail_sales.dbo.dim_store (
    Store_Name, 
    Store_Type
)
SELECT DISTINCT 
    Store_Name, 
    Store_Type
FROM stg_retail_sales.dbo.retail_sales_raw_data;


-- dim_promotion

INSERT INTO dwh_retail_sales.dbo.dim_promotion (
    Promotion_Name
)
SELECT DISTINCT 
    Promotion_Name
FROM stg_retail_sales.dbo.retail_sales_raw_data;


-- dim_customer

INSERT INTO dwh_retail_sales.dbo.dim_customer (
    Customer_ID, 
    Customer_Segment, 
    Loyalty_Tier
)
SELECT DISTINCT 
    Customer_ID, 
    Customer_Segment, 
    Loyalty_Tier
FROM stg_retail_sales.dbo.retail_sales_raw_data
WHERE Customer_ID IS NOT NULL;


-- dim_salesperson

INSERT INTO dwh_retail_sales.dbo.dim_salesperson (
    Salesperson_ID, 
    Salesperson_Department
)
SELECT DISTINCT 
    Salesperson_ID, 
    Salesperson_Department
FROM stg_retail_sales.dbo.retail_sales_raw_data
WHERE Salesperson_ID IS NOT NULL;


-- dim_product

INSERT INTO dwh_retail_sales.dbo.dim_product (
    Product_ID, 
    SKU, 
    Product_Name, 
    Category, 
    Subcategory, 
    Brand
)
SELECT DISTINCT 
    Product_ID, 
    SKU, 
    Product_Name, 
    Category, 
    Subcategory, 
    Brand
FROM stg_retail_sales.dbo.retail_sales_raw_data
WHERE Product_ID IS NOT NULL;


---------------------------------------------------------
-- LOAD DATA INTO FACT TABLE
---------------------------------------------------------

-- retail_fact
INSERT INTO dwh_retail_sales.dbo.retail_fact (
    Date_ID, 
    Location_ID, 
    Store_ID, 
    Promotion_ID, 
    Customer_ID, 
    Salesperson_ID, 
    Product_ID,
    Channel, 
    Priority, 
    Payment_Method,
    Quantity, 
    Unit_Cost, 
    Unit_Price, 
    Discount_Amount, 
    Tax_Amount, 
    Shipping_Cost,
    Gross_Sales, 
    Net_Sales, 
    COGS, 
    Gross_Profit
)
SELECT 
    d.Date_ID,
    l.Location_ID,
    s.Store_ID,
    p.Promotion_ID,
    c.Customer_ID,
    sp.Salesperson_ID,
    pr.Product_ID,
    rs.Channel,
    rs.Priority,
    rs.Payment_Method,
    rs.Quantity,
    rs.Unit_Cost,
    rs.Unit_Price,
    rs.Discount_Amount,
    rs.Tax_Amount,
    rs.Shipping_Cost,
    rs.Gross_Sales,
    rs.Net_Sales,
    rs.COGS,
    rs.Gross_Profit
FROM stg_retail_sales.dbo.retail_sales_raw_data rs
JOIN dwh_retail_sales.dbo.dim_date d 
    ON rs.Purchase_Date = d.Purchase_Date 
   AND rs.Ship_Date = d.Ship_Date 
   AND rs.Return_Date = d.Return_Date
JOIN dwh_retail_sales.dbo.dim_location l 
    ON rs.City = l.City AND rs.Country = l.Country
JOIN dwh_retail_sales.dbo.dim_store s 
    ON rs.Store_Name = s.Store_Name
JOIN dwh_retail_sales.dbo.dim_promotion p 
    ON rs.Promotion_Name = p.Promotion_Name
JOIN dwh_retail_sales.dbo.dim_customer c 
    ON rs.Customer_ID = c.Customer_ID
JOIN dwh_retail_sales.dbo.dim_salesperson sp 
    ON rs.Salesperson_ID = sp.Salesperson_ID
JOIN dwh_retail_sales.dbo.dim_product pr 
    ON rs.Product_ID = pr.Product_ID;
