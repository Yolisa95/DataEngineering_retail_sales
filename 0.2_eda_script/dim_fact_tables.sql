--dim_date

CREATE TABLE dim_date(
    date_id INT PRIMARY KEY,
    purchase_date DATE,
    ship_date DATE,
    return_date DATE,   
);


--dim_location

CREATE TABLE dim_location (
    location_id INT PRIMARY KEY,
    continent VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(50)
);

--dim_store

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    store_type VARCHAR(50)
);

--dim_promotion

CREATE TABLE dim_promotion (
    promotion_id INT PRIMARY KEY,
    promotion_name VARCHAR(100)
) ;

--dim_customer

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    cusomer_segment VARCHAR(50),
    loyalty_tier VARCHAR(100)
);

--dim_salesperson

CREATE TABLE dim_salesperson (
    salesperson_id INT PRIMARY KEY,
    salesperson_dept VARCHAR(50)
);

--dim_product

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    brand VARCHAR(50),
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    sku VARCHAR(50)
);

--retail_fact

CREATE TABLE retail_fact (
    retail_id INT PRIMARY KEY,
    date_id INT,
    location_id INT,
    store_id INT,
    promotion_id INT,
    customer_id INT,
    salesperson_id INT,
    product_id INT,
    quantity INT,
    unit_cost INT,
    unit_price INT,
    discount_amount INT,
    tax_amount INT,
    shipping_cost INT,
    gross_sales INT,
    net_sales INT,
    cogs INT,
    gross_profit INT   
);
