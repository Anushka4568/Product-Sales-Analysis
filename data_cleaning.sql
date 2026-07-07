
CREATE TABLE superstore (
    order_id VARCHAR(30),
    order_date TEXT,
    ship_date TEXT,
    ship_mode VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    state VARCHAR(100),
    country VARCHAR(100),
    market VARCHAR(50),youtu
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales TEXT,
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(12,2),
    shipping_cost NUMERIC(12,2),
    order_priority VARCHAR(20),
    year INT
);


UPDATE superstore
SET sales = REPLACE(sales, ',', '');
ALTER TABLE superstore
ALTER COLUMN sales TYPE NUMERIC
USING sales::NUMERIC;
