create database Ride;
use ride;
-- 1. Retrieve all successful bookings:
select *
from bookings
where booking_status = 'success';
-- 2. Find the average ride distance for each vehicle type:
select vehicle_type, avg(ride_distance) as avg_distance
from bookings
group by vehicle_type;

-- 3. Get the total number of cancelled rides by customers:
select count(*) as total_cancelled_rides
from bookings
where booking_status = 'cancelled by customer';

-- 4. List the top 5 customers who booked the highest number of rides:
select customer_id, count(booking_id) as total_rides
from bookings
group by customer_id
order by total_rides desc
limit 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
select count(*) as total_cancelled_rides
from bookings
where canceled_rides_by_driver = 'personal & car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
select max(driver_ratings) as max_rating,
       min(driver_ratings) as min_rating
from bookings
where vehicle_type = 'prime sedan';

-- 7. Retrieve all rides where payment was made using UPI:
select *
from bookings
where payment_method = 'upi';

-- 8. Find the average customer rating per vehicle type:
select vehicle_type, avg(customer_rating) as avg_customer_rating
from bookings
group by vehicle_type;

-- 9. Calculate the total booking value of rides completed successfully:
select sum(booking_value) as total_successful_value
from bookings
where booking_status = 'success';

-- 10. List all incomplete rides along with the reason:
select booking_id, incomplete_rides_reason
from bookings
where incomplete_rides = 'yes';

-- used the view method to analyze the data

-- 1. Retrieve all successful bookings:
create view successful_bookings as
select *
from bookings
where booking_status = 'success';


-- 2. Find the average ride distance for each vehicle type:
create view ride_distance_for_each_vehicle as
select vehicle_type, avg(ride_distance) as avg_distance
from bookings
group by vehicle_type;


-- 3. Get the total number of cancelled rides by customers:
create view cancelled_rides_by_customers as
select count(*) as total_cancelled_rides
from bookings
where booking_status = 'cancelled by customer';


-- 4. List the top 5 customers who booked the highest number of rides:
create view top_5_customers as
select customer_id, count(booking_id) as total_rides
from bookings
group by customer_id
order by total_rides desc
limit 5;


-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
create view rides_cancelled_by_drivers_p_c_issues as
select count(*) as total_cancelled_rides
from bookings
where canceled_rides_by_driver = 'personal & car related issue';


-- 6. Find the maximum and minimum driver ratings for prime sedan bookings:
create view max_min_driver_rating as
select max(driver_ratings) as max_rating,
       min(driver_ratings) as min_rating
from bookings
where vehicle_type = 'prime sedan';


-- 7. Retrieve all rides where payment was made using upi:
create view upi_payment as
select *
from bookings
where payment_method = 'upi';


-- 8. Find the average customer rating per vehicle type:
create view avg_cust_rating as
select vehicle_type, avg(customer_rating) as avg_customer_rating
from bookings
group by vehicle_type;


-- 9. Calculate the total booking value of rides completed successfully:
create view total_successful_ride_value as
select sum(booking_value) as total_successful_ride_value
from bookings
where booking_status = 'success';


-- 10. List all incomplete rides along with the reason:
create view incomplete_rides_reason as
select booking_id, incomplete_rides_reason
from bookings
where incomplete_rides = 'yes';


-- Retrieve All Answers Using Views


-- 1. Retrieve all successful bookings:
select * from successful_bookings;

-- 2. Find the average ride distance for each vehicle type:
select * from ride_distance_for_each_vehicle;

-- 3. Get the total number of cancelled rides by customers:
select * from cancelled_rides_by_customers;

-- 4. List the top 5 customers who booked the highest number of rides:
select * from top_5_customers;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
select * from rides_cancelled_by_drivers_p_c_issues;

-- 6. Find the maximum and minimum driver ratings for prime sedan bookings:
select * from max_min_driver_rating;

-- 7. Retrieve all rides where payment was made using upi:
select * from upi_payment;

-- 8. Find the average customer rating per vehicle type:
select * from avg_cust_rating;

-- 9. Calculate the total booking value of rides completed successfully:
select * from total_successful_ride_value;

-- 10. List all incomplete rides along with the reason:
select * from incomplete_rides_reason;

-- Additional Questions Suggested by the Trainer for the Project

-- Cancellation rate by vehicle type
select vehicle_type,
       round(100.0 * sum(booking_status like 'cancelled%') / count(*), 2) as cancel_rate_pct
from bookings
group by vehicle_type;

-- Revenue by payment method
select payment_method, sum(booking_value) as revenue
from bookings
where booking_status = 'success'
group by payment_method
order by revenue desc;

-- Rank vehicle types by revenue (window function)
select vehicle_type,
       sum(booking_value) as revenue,
       rank() over (order by sum(booking_value) desc) as revenue_rank
from bookings
where booking_status = 'success'
group by vehicle_type;

-- Total rides
select count(*) as total_rides from bookings;

-- Cancellation breakdown (gives you counts per status)
select booking_status, count(*) as cnt
from bookings
group by booking_status;
-- Top payment method by revenue
select payment_method, sum(booking_value) as revenue
from bookings
where booking_status = 'success'
group by payment_method
order by revenue desc;