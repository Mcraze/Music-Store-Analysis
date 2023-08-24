/* Who is the senior most employee based on their level? */

select * from employee order by levels desc limit 1;

/* Which country has the most Invoices? */

select billing_country, count(billing_country) from invoice 
group by billing_country order by count(billing_country) desc;

/* What are the top 3 values of total invoices? */

select billing_country, total from invoice order by total desc limit 3;

/* Which city has the best customers? 
We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select billing_city as City_Name, sum(total) as Total_Invoices 
from invoice group by billing_city order by sum(total) desc;

/* Who is the best customer? 
The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select c.customer_id, c.first_name, c.last_name, sum(i.total) from customer as c 
inner join invoice as i on c.customer_id = i.customer_id 
group by c.customer_id 
order by sum(i.total) 
desc limit 1;

/* Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select distinct customer.email, customer.first_name, customer.last_name, genre.name 
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
where genre.name = 'Rock'
order by email;

/* Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select artist.name, count(track.track_id) from track
join album on track.album_id = album.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name = 'Rock'
group by artist.artist_id
order by count(track.track_id) 
desc limit 10;

/* Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. 
Order by the song length with the longest songs listed first. */

select name from track 
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;

/* Return the number of tracks present for each genre.
Order them according to the most number of tracks present */

select count(t.genre_id), g.name from genre as g
inner join track as t
on t.genre_id = g.genre_id
group by g.name
order by count(t.genre_id) desc;

/* Return the total number of customers which belong to the country of India, USA and Canada
And who have made an invoice using the invoice table */

select billing_country as Country, count(customer_id) as Total_Customers 
from invoice
where billing_country in ('India', 'USA', 'Canada')
group by billing_country
order by count(customer_id) desc;

/* Return the total number of tracks present with the media type of MPEG audio file and AAC Audio File*/

select m.name, count(t.track_id) 
from track as t
inner join media_type as m
on t.media_type_id = m.media_type_id
where t.media_type_id in ('1','5')
group by m.name;

/* Return the Artist names which start with the letter S or letter M*/

select name from artist
where name like 'S%' or name like 'M%';

/* Return the name of the top 5 artists according to the number of tracks published */

select art.name, count(t.track_id) as total_tracks 
from track as t
inner join album as alb
on alb.album_id = t.album_id
inner join artist as art
on art.artist_id = alb.artist_id
group by art.name
order by total_tracks desc
limit 5;