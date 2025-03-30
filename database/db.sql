CREATE DATABASE IF NOT EXISTS shaday_db;
USE shaday_db;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    state ENUM('active', 'inactive') DEFAULT 'active',
    role ENUM('admin', 'user') NOT NULL
);

CREATE TABLE Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Persons (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE SET NULL
);

CREATE TABLE Companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    ruc VARCHAR(20) UNIQUE NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE SET NULL
);

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    short_name VARCHAR(50) NOT NULL,
    state ENUM('active', 'inactive') DEFAULT 'active'
);

CREATE TABLE Subcategories (
    subcategory_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    short_name VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mark VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    subcategory_id INT NOT NULL,
    FOREIGN KEY (subcategory_id) REFERENCES Subcategories(subcategory_id) ON DELETE CASCADE
);

CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    client_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE
);

CREATE TABLE Products_Sales (
    product_id INT NOT NULL,
    sale_id INT NOT NULL,
    quantity INT NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_id, sale_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id) ON DELETE CASCADE
);

CREATE TABLE Debts (
    debt_id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'paid') DEFAULT 'pending',
    client_id INT NOT NULL,
    sale_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id) ON DELETE CASCADE
);
