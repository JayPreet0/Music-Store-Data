--Que. 1: Who is the senior most employee based on job title?
select employee_id, concat(first_name,last_name) as full_name, title, levels
from employee
order by levels desc
limit 1;

--Que. 2: Which Countries have the most invoices?
select billing_country,count(*)
from invoice
group by 1
order by 2 desc
limit 1;

--Que. 3: What are top 3 values of total invoices?
select invoice_id, total
from invoice
order by total desc
limit 3;

--Que. 4: Which city has the best customers? 
--We would like to throw a promotional Music Festival in the city we made the most money.
--Write a query that returns one city that has the highest sum of invoices totals. 
--Return both the city name and sum of invoice totals.
select billing_city, sum(total)
from invoice
group by 1
order by 2 desc
limit 1;

--Que. 5: Who is the best customer? The customer who has spent the most money will be declared the best customer.
--Write a query that returns the person who has spent the most money.
select c.customer_id, concat(c.first_name, c.last_name), sum(unit_price*quantity) as spending
from invoice i
inner join customer c
on i.customer_id=c.customer_id
inner join invoice_line il
on i.invoice_id=il.invoice_id
group by 1
order by 3 desc
limit 1;