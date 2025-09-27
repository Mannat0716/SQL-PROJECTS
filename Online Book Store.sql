-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Orders.csv' 
CSV HEADER;


-- 1) Retrieve all books in the "Fiction" genre:

SELECT Genre
FROM BOOKS 
WHERE Genre = "fiction";


-- 2) Find books published after the year 1950:
SELECT Published_Year
FROM BOOKS 
WHERE Published_Year > 1950;

-- 3) List all customers from the Canada:
SELECT *
FROM customers 
WHERE country = "Canada";


-- 4) Show orders placed in November 2023:
SELECT *
FROM orders
WHERE Order_Date Between '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) as TOTAL_STOCK_BOOKs
FROM books;


-- 6) Find the details of the most expensive book:
SELECT * 
FROM books
Order by Price
DESC
limit 1
;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT Customer_ID, Quantity 
FROM orders
WHERE Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * 
FROM orders
WHERE Total_Amount > 20
;

-- 9) List all genres available in the Books table:
Select DISTINCT Genre From books;

-- 10) Find the book with the lowest stock:
SELECT * 
FROM books
order by Stock
limit 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) 
FROM orders;




-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

SELECT b.Genre,SUM(o.Quantity) as Total_BOOKS_SOLD
From books as b 
join orders as o
On o.Book_ID = b.Book_ID
Group by b.Genre;


-- 2 Find the average price of books in the "Fantasy" genre:

SELECT AVG(Price)
From books
Where  Genre = "Fantasy"
;





-- 3) List customers who have placed at least 2 orders:

Select Distinct c.Customer_ID, c. name,o.quantity
From customers as c
join orders as o
ON c.Customer_ID = o.Customer_ID
WHERE Quantity >= 2 
;




-- 4) Find the most frequently ordered book:

SELECT Book_ID, Count(Order_ID) AS FREQUENT_ORDER
From orders
Group by Book_Id
Order by FREQUENT_ORDER 
desc
limit 1
;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT Book_ID,Genre, Price
From books
Where Genre = "Fantasy"
order by price 
desc
limit 3;


-- 6) Retrieve the total quantity of books sold by each author:

SElECT b.Author ,SUM(o.Quantity) AS TOTAL_
From books as b
Join orders as o
On b.Book_ID = o.Book_ID
Group by b.Author
;





-- 7) List the cities where customers who spent over $30 are located:

Select DISTINCT c.city , Total_Amount
FROm customers as c
join orders as o
ON c.Customer_ID = o.Customer_ID
WHERE Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:

Select c.name, sum(o.Total_amount) as MAX_SPENT
FROm customers as c
join orders as o
ON c.Customer_ID = o.Customer_ID
group by c.name, c.Customer_ID
order by MAX_SPENT
DESC
limit 1
;


-- 9) Calculate the stock remaining_after fulfilling_all orders:


SELECT b.Book_ID,b.title,b.stock,
coalesce((o.Quantity),0) as order_quantity,
b.stock - coalesce((o.Quantity),0) as remaining_quantity
FROM books as b
Left Join orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID
Order by b.Book_ID; 



