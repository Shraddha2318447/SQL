CREATE DATABASE WomanClothingShop;
USE WomanClothingShop;
 -- categories(topes, dress, one_piece)
 -- products (Pid, product name, price, size, color, description, image, manufacturer)
 -- customer (customerid, firstname, last_name, phone no, email id, address)
 -- orders ( order id, order date, total amounr, status)
 -- orderdetails (orderdetail id, quntity, totalprice)
-- Create Departments table
CREATE TABLE Categories (
    Categoryid INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- Step 4: Create the products table
CREATE TABLE Products (
    Productid INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Categoryid INT,
    Price DECIMAL(10, 2) NOT NULL,
    Size ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL') NOT NULL,
    Color VARCHAR(25),
    Description TEXT,
    ImageURL VARCHAR(200),
    manufacturer TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Categoryid) REFERENCES Categories(Categoryid)
);

-- Step 5: Create the customers table
CREATE TABLE Customers (
    Customerid INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(25),
    Address TEXT,
    City VARCHAR(100),
    State VARCHAR(100),
    PinCode VARCHAR(100),
    Country VARCHAR(25)
);

-- Step 6: Create the orders table
CREATE TABLE Orders (
    Orderid INT AUTO_INCREMENT PRIMARY KEY,
    Customerid INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (Customerid) REFERENCES Customers(Customerid)
);

-- Step 7: Create the order details table
CREATE TABLE OrderDetails (
    OrderDetailid INT AUTO_INCREMENT PRIMARY KEY,
    Orderid INT,
    Productid INT,
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Orderid) REFERENCES Orders(Orderid),
    FOREIGN KEY (Productid) REFERENCES Products(Productid)
);

