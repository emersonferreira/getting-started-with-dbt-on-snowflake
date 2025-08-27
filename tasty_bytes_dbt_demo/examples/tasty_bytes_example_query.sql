-- What tables exist?
SHOW TABLES IN SCHEMA emerson_bytes_dbt_db.raw;

SHOW VIEWS IN DATABASE emerson_bytes_dbt_db;

-- What is the scale of data? 
SELECT COUNT(*) FROM emerson_bytes_dbt_db.raw.order_header;

-- Understand a query that might be used in a mart
SELECT 
    cl.customer_id,
    cl.city,
    cl.country,
    cl.first_name,
    cl.last_name,
    cl.phone_number,
    cl.e_mail,
    SUM(oh.order_total) AS total_sales,
    ARRAY_AGG(DISTINCT oh.location_id) AS visited_location_ids_array
FROM emerson_bytes_dbt_db.raw.customer_loyalty cl
JOIN emerson_bytes_dbt_db.raw.order_header oh
ON cl.customer_id = oh.customer_id
GROUP BY cl.customer_id, cl.city, cl.country, cl.first_name,
cl.last_name, cl.phone_number, cl.e_mail;