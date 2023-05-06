--Que. 1: Find how much amount spent by each customer on artists?
--Write a query to return customer name, artist name and total spent.
select concat(c.first_name,c.last_name) as Customer_Name, a.name as Artist_Name, 
sum(il.unit_price*il.quantity) as Total_Spent
from customer c
inner join invoice i
on c.customer_id=i.customer_id
inner join invoice_line il
on i.invoice_id=il.invoice_id
inner join track t
on il.track_id=t.track_id
inner join album al
on t.album_id=al.album_id
inner join artist a
on al.artist_id=a.artist_id
group by 1,2
order by 3 desc;

--Que. 2:We want to find the most popular music genre for each country.
--We determine the most popular genre as the genre with the highest amount of purchases.
--Write a query that returns each country along with the top genre for countries where the maximum number of purchases is shared return all genre.
select *
from(
	select *, row_number() over (partition by Country order by Purchase desc) as row_num
	from(
		select i.billing_country as Country, g.name as Genre_Name, ceil(sum(il.unit_price*il.quantity)) as Purchase
		from invoice i
		inner join invoice_line il
		on i.invoice_id=il.invoice_id
		inner join track t
		on il.track_id=t.track_id
		inner join genre g
		on t.genre_id=g.genre_id
		group by 1,2
		order by 3 desc) as a) as b
where row_num=1
order by Purchase desc;

--Que. 3: Write a query that determines the customer that has spent the most on music for each country.
--Write a query that returns the country along with the top customer and how much they spent.
--For countries where the top amount spent is shared, provide all customers who spent this amount.
select *
from(
	select *, row_number() over (partition by country order by Total_spent desc) as row_num
	from(
		select concat(c.first_name, c.last_name) as Customer_Name, i.billing_country as Country, 
		ceil(sum(il.unit_price*il.quantity)) as Total_spent
		from customer c
		inner join invoice i
		on c.customer_id=i.customer_id
		inner join invoice_line il
		on i.invoice_id=il.invoice_id
		group by 1,2) as a) as b
where row_num=1
order by Total_spent desc;