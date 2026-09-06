------------------------------------------------------ 
-- CREATE DATABASES
------------------------------------------------------ 
create database stg_retail_sales 
create database dwh_retail_sales

---------------------------------------------------------
-- CREATE DIM TABLES
---------------------------------------------------------
-- dim_date

CREATE TABLE dwh_retail_sales.dbo.dim_date
(
    Date_ID INT IDENTITY(1,1) PRIMARY KEY,
    Purchase_Date DATE,
    Ship_Date DATE,
    Return_Date DATE
);


-- dim_location

CREATE TABLE dwh_retail_sales.dbo.dim_location
(
    Location_ID INT IDENTITY(1,1) PRIMARY KEY,
    Continent VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(50)
);


-- dim_store

CREATE TABLE dwh_retail_sales.dbo.dim_store
(
    Store_ID INT IDENTITY(1,1) PRIMARY KEY,
    Store_Name VARCHAR(100),
    Store_Type VARCHAR(50)
);


-- dim_promotion

CREATE TABLE dwh_retail_sales.dbo.dim_promotion
(
    Promotion_ID INT IDENTITY(1,1) PRIMARY KEY,
    Promotion_Name VARCHAR(100)
);


-- dim_customer

CREATE TABLE dwh_retail_sales.dbo.dim_customer
(
    Customer_ID VARCHAR(50) PRIMARY KEY,  
    Customer_Segment VARCHAR(50),
    Loyalty_Tier VARCHAR(100)
);


-- dim_salesperson

CREATE TABLE dwh_retail_sales.dbo.dim_salesperson
(
    Salesperson_ID VARCHAR(50) PRIMARY KEY,   
    Salesperson_Department VARCHAR(100)
);

-- dim_product

CREATE TABLE dwh_retail_sales.dbo.dim_product
(
    Product_ID VARCHAR(50) PRIMARY KEY,   -- FIXED (if IDs are like 'P0001')
    SKU VARCHAR(50),
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Subcategory VARCHAR(50),
    Brand VARCHAR(50)
);

---------------------------------------------------------
-- CREATE FACT TABLE
---------------------------------------------------------

-- retail_fact

CREATE TABLE dwh_retail_sales.dbo.retail_fact
(
    Retail_ID INT IDENTITY(1,1) PRIMARY KEY,

    Date_ID INT FOREIGN KEY REFERENCES dwh_retail_sales.dbo.dim_date(Date_ID),
    Location_ID INT FOREIGN KEY REFERENCES dwh_retail_sales.dbo.dim_location(Location_ID),
    Store_ID INT FOREIGN KEY REFERENCES dwh_retail_sales.dbo.dim_store(Store_ID),
    Promotion_ID INT FOREIGN KEY REFERENCES dwh_retail_sales.dbo.dim_promotion(Promotion_ID),
    Customer_ID VARCHAR(50) FOREIGN KEY REFERENCES dwh_retail_sales.dbo.dim_customer(Customer_ID),
    Salesperson_ID VARCHAR(50) FOREIGN KEY REFERENCES dwh_retail_sales.dbo.dim_salesperson(Salesperson_ID),
    Product_ID VARCHAR(50) FOREIGN KEY REFERENCES dwh_retail_sales.dbo.dim_product(Product_ID),

    Channel VARCHAR(50),
    Priority VARCHAR(50),
    Payment_Method VARCHAR(50),

    Quantity INT,
    Unit_Cost INT,
    Unit_Price INT,
    Discount_Amount INT,
    Tax_Amount INT,
    Shipping_Cost INT,
    Gross_Sales INT,
    Net_Sales INT,
    COGS INT,
    Gross_Profit INT
);