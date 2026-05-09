from flask import Flask, render_template, request
import sqlite3
import pandas as pd

app = Flask(__name__)

# Database connection
conn = sqlite3.connect('database.db', check_same_thread=False)

# Load CSV files
books = pd.read_csv('Books.csv')
customers = pd.read_csv('Customers.csv')
orders = pd.read_csv('Orders.csv')

# Store data into SQLite
books.to_sql('books', conn, if_exists='replace', index=False)
customers.to_sql('customers', conn, if_exists='replace', index=False)
orders.to_sql('orders', conn, if_exists='replace', index=False)

# Home Page
@app.route('/')
def home():
    return render_template('index.html')

# Dashboard Page
@app.route('/dashboard')
def dashboard():

    total_books = pd.read_sql('SELECT COUNT(*) as count FROM books', conn)['count'][0]

    total_customers = pd.read_sql('SELECT COUNT(*) as count FROM customers', conn)['count'][0]

    total_orders = pd.read_sql('SELECT COUNT(*) as count FROM orders', conn)['count'][0]

    total_revenue = pd.read_sql('SELECT SUM(Total_Amount) as revenue FROM orders', conn)['revenue'][0]

    return render_template(
        'dashboard.html',
        total_books=total_books,
        total_customers=total_customers,
        total_orders=total_orders,
        total_revenue=total_revenue
    )

# Books Page
@app.route('/books')
def books_page():
    data = pd.read_sql('SELECT * FROM books', conn)
    return render_template('books.html', tables=data.to_html(classes='table table-bordered', index=False))

# Customers Page
@app.route('/customers')
def customers_page():
    data = pd.read_sql('SELECT * FROM customers', conn)
    return render_template('customers.html', tables=data.to_html(classes='table table-bordered', index=False))

# Orders Page
@app.route('/orders')
def orders_page():
    data = pd.read_sql('SELECT * FROM orders', conn)
    return render_template('orders.html', tables=data.to_html(classes='table table-bordered', index=False))

# Search Feature
@app.route('/search', methods=['GET', 'POST'])
def search():

    result = None

    if request.method == 'POST':
        keyword = request.form.get('keyword')

        query = f"SELECT * FROM books WHERE Title LIKE '%{keyword}%' OR Author LIKE '%{keyword}%'"

        result = pd.read_sql(query, conn)

        result = result.to_html(classes='table table-bordered', index=False)

    return render_template('search.html', result=result)

# Analytics Page
@app.route('/analytics')
def analytics():

    top_books = pd.read_sql('''
    SELECT Book_ID, SUM(Quantity) AS Total_Sold
    FROM orders
    GROUP BY Book_ID
    ORDER BY Total_Sold DESC
    LIMIT 5
    ''', conn)

    active_customers = pd.read_sql('''
    SELECT Customer_ID, COUNT(Order_ID) AS Total_Orders
    FROM orders
    GROUP BY Customer_ID
    ORDER BY Total_Orders DESC
    LIMIT 5
    ''', conn)

    return render_template(
        'analytics.html',
        top_books=top_books.to_html(classes='table table-striped table-hover shadow', index=False),
        active_customers=active_customers.to_html(classes='table table-bordered', index=False)
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=10000)