# Online Book Store Analytics & Management System

A SQL-based web application that helps users manage and analyze bookstore operations using dashboard analytics, SQL queries, customer insights, and sales reporting. The project is deployed online with an interactive Flask dashboard.

---

# Live Demo

[https://online-bookstore-analytics-system.onrender.com/](https://online-bookstore-analytics-system.onrender.com/)

---

# Features

* Interactive analytics dashboard
* Books management system
* Customer records management
* Orders tracking system
* Revenue analytics
* Top selling books analysis
* Customer insights
* Search books by title or author
* SQL-based data analysis
* Responsive web interface
* Hosted online for public access

---

# Tech Stack

* Python
* Flask
* SQLite
* SQL
* Pandas
* HTML
* CSS
* Bootstrap
* Chart.js

---

# Analytics & SQL Approach

This project uses SQL analytics and dashboard reporting techniques:

* CSV data preprocessing
* SQLite database integration
* SQL query analysis
* Revenue tracking
* Customer insights generation
* Sales analytics
* Interactive dashboard visualization
* Search functionality using SQL filtering

---

# Project Structure

```text
Online-BookStore-Analytics-System/
│
├── app.py
├── requirements.txt
├── database.db
│
├── templates/
│   ├── index.html
│   ├── dashboard.html
│   ├── books.html
│   ├── customers.html
│   ├── orders.html
│   ├── analytics.html
│   └── search.html
│
├── static/
│   └── style.css
│
├── Books.csv
├── Customers.csv
├── Orders.csv
└── README.md
```

---

# Installation

## Clone the repository

```bash
git clone https://github.com/Pratik0781/online-bookstore-analytics-system.git
```

---

## Move to project directory

```bash
cd online-bookstore-analytics-system
```

---

## Install required packages

```bash
pip install -r requirements.txt
```

---

## Run the application

```bash
python app.py
```

---

# Open in Browser

```text
http://127.0.0.1:5000
```

---

# Deployment

Hosted on Render:

[https://online-bookstore-analytics-system.onrender.com/](https://online-bookstore-analytics-system.onrender.com/)

---

# SQL Queries Used

## Total Revenue

```sql
SELECT SUM(Total_Amount)
FROM orders;
```

---

## Top Selling Books

```sql
SELECT Book_ID, SUM(Quantity) AS Total_Sold
FROM orders
GROUP BY Book_ID
ORDER BY Total_Sold DESC
LIMIT 5;
```

---

## Most Active Customers

```sql
SELECT Customer_ID, COUNT(Order_ID) AS Total_Orders
FROM orders
GROUP BY Customer_ID
ORDER BY Total_Orders DESC;
```

---

# Future Enhancements

* Login Authentication
* Admin Dashboard
* Dark Mode
* AI Book Recommendation System
* Export Reports
* Advanced Analytics
* Mobile Responsive Improvements

---

# Author

## Pratik Shere

* BSc Data Science Student
* Python | SQL | Flask | Data Analytics

