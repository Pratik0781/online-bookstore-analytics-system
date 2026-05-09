-- CREATE TABLE BOOKS
CREATE TABLE Books(
	Book_id SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	published_Year INT,
	Price NUMERIC(10,2),
	Stock INT
);

--CREATE TABLE CUSTOMERS
CREATE TABLE Customers(
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

-- CREATE TABLE ORDERS
CREATE TABLE Orders(
	Order_id SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- BASIC QUESTIONS

-- 1) Retrive all books in the "Fiction" Genre:

SELECT * FROM Books
WHERE Genre= 'Fiction';

-- 2) Find Books Published after the year 1950:

SELECT * FROM Books
WHERE published_year>1950;

-- 3) List All Customers From The Canada:

SELECT * FROM Customers
WHERE Country='Canada'

-- 4) Show Orders Placed in November 2023:

SELECT * FROM Orders
WHERE Order_Date>='2023-11-01' AND Order_Date<='2023-11-30';

-- 5) Retrive THe Total Stocks Of Books Available:
SELECT 
	SUM(Stock) AS Total_Stock
FROM Books;

-- 6) Find The Details Of Most Expensive Book:

SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

-- 7) Show All Customers who ordered more than 1 quantity of a book:
 
 SELECT * FROM Orders
 WHERE Quantity>1;

-- 8) Retrivr The All Orders Where The Totall amount exceeds $20:

SELECT * FROM Orders
WHERE Total_Amount>20

-- 9) List All The Genres Available in the table

SELECT DISTINCT genre FROM Books;

-- 10) Find The Book With Lowest Stock

SELECT * FROM Books ORDER BY Stock ASC LIMIT 1;

-- 11) Calculate The Total Revenue Generated From Orders
SELECT SUM(Total_Amount) As Revenue
FROM Orders;

-- ADVANCED QUESTIONS

-- 1) Retrive the total number of books sold for each genre:
SELECT b.Genre,SUM(o.Quantity) As Total_Books_Sold
FROM Orders o
JOIN
Books b On o.Book_Id=b.Book_Id
GROUP By b.Genre;

-- 2) Find The Average Price Of Books In The "Fantasy" Genera
SELECT AVG(price) As Average_Price
FROM Books
WHERE genre='Fantasy';

-- 3) List Customers Who Have Placed At Least tto Orders

SELECT o.Customer_ID,c.Name, COUNT(o.Order_ID) As Order_Count
FROM Orders o
JOIN 
Customers c ON o.Customer_ID=c.Customer_ID
GROUP BY o.Customer_ID,c.Name
HAVING COUNT(o.Order_ID)>=2;

-- 4) Find Most Frequently Ordered Book:

SELECT o.Book_ID,b.Title,COUNT(o.Order_ID) As order_Count
FROM Orders o
JOIN Books b ON o.Book_ID=b.Book_ID 
GROUP BY o.Book_ID,b.Title
ORDER BY (order_Count)DESC LIMIT 1;

-- 5) Show The Top 3 Most Expensive Books Of "Fantasy" Genre

SELECT Title,genre,Price
FROM Books
WHERE genre='Fantasy'
ORDER BY Price DESC 
LIMIT 3;

-- 6) Retrive the Total Quantity Of Books Sold By Each Author:

SELECT b.Author,COUNT(o.Quantity) AS Total_Sold_Books
FROM Orders o
JOIN Books b ON o.Book_Id=b.Book_ID
GROUP BY b. Author;

-- 7) List The Cities Where Customeras Who Spent Over $30 Are Located:

SELECT DISTINCT c.City,o.Total_Amount
FROM Orders o
JOIN Customers c ON o.Customer_ID=c.Customer_ID
WHERE o.Total_Amount>30;

-- 8) Find The Customer Who Spent the Most On Orders:

SELECT DISTINCT c.Name,SUM(o.Total_Amount) AS Total_Spend
FROM Orders o
JOIN Customers c ON c.Customer_ID=o.Customer_ID
GROUP BY c.Name
ORDER BY Total_Spend DESC LIMIT 1;

-- 9) Calculate The Stock Remaining After Fulfilling All Orders:

SELECT b.Book_ID,b.Title,b.Stock,COALESCE(SUM(o.Quantity),0) AS Order_Quantity,
	b.stock - COALESCE(SUM(o.Quantity),0) AS Remaining_Quantity
FROM Books b
JOIN Orders o ON o.Book_ID=b.Book_ID
GROUP BY b.Book_ID;