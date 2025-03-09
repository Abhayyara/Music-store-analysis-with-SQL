-- Q1. Who is the senior most employee based on the job title
SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;


-- Q2. Which countries have most invoices?

SELECT billing_country, count(invoice_id) FROM invoice
Group BY billing_country
ORDER BY count(invoice_id) DESC;

--Q3. What are top 3 values of total invoices?
Select * from invoice
ORDER BY total DESC
LIMIT 3


-- Q4: Which city has the best customers? We would like to throw a 
--promotional Music Festival in the city we made the most money. 
--Write a query that returns one city that has the highest sum 
--of invoice totals. 
--Return both the city name & sum of all invoice totals

SELECT billing_city, sum(total)
FROM invoice
Group BY billing_city
Order By sum(total) DESC
Limit 1;

--Q5: Who is the best customer? The customer who has spent
--the most money will be declared the best customer. 
--Write a query that returns the person who has spent 
--the most money.

SELECT first_name, last_name, sum(total) FROM customer
join invoice on
invoice.customer_id = customer.customer_id
group by first_name, last_name
order by sum(total) DESC
LIMIT 1;


--Q6: Write query to return the email, first name, 
--last name, & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by 
--email starting with A.

SELECT email,first_name,last_name , genre.name
FROM customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock'
Order by email ASC;



--Q7: Let's invite the artists who have written 
--the most rock music in our dataset. 
--Write a query that returns the Artist name
--and total track count of the top 10 rock bands. 
SELECT artist.name, genre.name, count(track.track_id) FROM artist
JOIN album on album.artist_id = artist.artist_id
JOIN track on track.album_id = album.album_id
Join genre on track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock'
Group by artist.name, genre.name
order by count(track.track_id) DESC
LIMIT 10;



--Q8: Return all the track names that have a 
--song length longer than the average song length. 
--Return the Name and Milliseconds for each track. 
--Order by the song length with the longest songs listed first.
SELECT name, milliseconds 
FROM track
WHERE milliseconds > (SELECT avg(milliseconds) FROM track)
ORDER BY milliseconds DESC;