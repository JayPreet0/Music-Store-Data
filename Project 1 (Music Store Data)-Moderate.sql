--Que. 1: Write a query to return the email, first name, last name and genre of all rock music listeners.
--Return your list ordered alphabetically by email starting with "A".
select distinct(email), first_name, last_name, g.name
from customer c
inner join invoice i
on c.customer_id=i.customer_id
inner join invoice_line il
on i.invoice_id=il.invoice_id
inner join track t
on il.track_id=t.track_id
inner join genre g
on t.genre_id=g.genre_id
where g.name= 'Rock'
order by 1;

--Que. 2: Lets invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the artist name and total track count of the top 100 rock bands.
select a.name, count(t.track_id) as Total_Track_Count, g.name
from artist a
inner join album al
on a.artist_id=al.artist_id
inner join track t
on al.album_id=t.album_id
inner join genre g
on t.genre_id=g.genre_id
where g.name='Rock'
group by 1,3
order by 2 desc;

--Que. 3: Return all the track names that have a song length londer than the average song length.
--Return the name and miliseconds for each track. 
--Order by the song length with the longest song listed first.
select name, milliseconds
from track t
where milliseconds> (select avg(milliseconds)
						from track)
order by 2 desc;