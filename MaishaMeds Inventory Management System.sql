-- Create the database
CREATE DATABASE maishameds_db;
SHOW databases;
USE maishameds_db;

-- Create tables
CREATE TABLE Supplies (
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    supply_name VARCHAR(100) NOT NULL,
    category ENUM('PPE', 'Medication', 'Tools', 'Vaccines') NOT NULL,
    unit_cost DECIMAL(10, 2) NOT NULL,
    min_stock INT DEFAULT 20,
    max_stock INT DEFAULT 500
);

CREATE TABLE Clinics (
    clinic_id INT PRIMARY KEY AUTO_INCREMENT,
    clinic_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL
);


CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    supply_id INT,
    clinic_id INT,
    quantity INT NOT NULL CHECK (quantity >= 0),
    expiration_date DATE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supply_id) REFERENCES Supplies(supply_id),
    FOREIGN KEY (clinic_id) REFERENCES Clinics(clinic_id)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    supply_id INT,
    clinic_id INT,
    quantity_ordered INT NOT NULL CHECK (quantity_ordered > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Shipped', 'Delivered') DEFAULT 'Pending',
    FOREIGN KEY (supply_id) REFERENCES Supplies(supply_id),
    FOREIGN KEY (clinic_id) REFERENCES Clinics(clinic_id)
);

-- Create indexes for performance
CREATE INDEX idx_inventory_supply ON Inventory(supply_id);
CREATE INDEX idx_orders_date ON Orders(order_date); 

-- Query the data
-- 1. Low stock alert
SELECT s.supply_name, s.category, i.clinic_id, i.quantity, s.min_stock, c.region
FROM inventory i
JOIN supplies s
ON i.supply_id = s.supply_id
JOIN clinics c
ON c.clinic_id = i.clinic_id
WHERE i.quantity < s.min_stock
ORDER BY i.quantity DESC;

-- 2. Expiring Supplies in the next 60 days
SELECT s.supply_name,c.clinic_name,i.quantity,i.expiration_date,
    DATEDIFF(i.expiration_date, CURDATE()) AS days_until_expiry
FROM Inventory i
JOIN Supplies s ON i.supply_id = s.supply_id
JOIN Clinics c ON i.clinic_id = c.clinic_id
WHERE i.expiration_date IS NOT NULL
AND i.expiration_date <= DATE_ADD(CURDATE(), INTERVAL 60 DAY)
AND i.quantity > 0
ORDER BY days_until_expiry ASC;

-- 3. Inventory Value by Region
SELECT c.region, s.category, ROUND(SUM(i.quantity * s.unit_cost),2) AS Total_value
FROM inventory i
JOIN supplies s
ON i.supply_id = s.supply_id
JOIN clinics c
ON i.clinic_id = c.clinic_id
GROUP BY region,category
ORDER BY Total_value DESC;

-- 4.Top Ordered Supplies (Last 90 Days)
SELECT s.supply_name,s.category,
    SUM(o.quantity_ordered) AS Ordered_quantity,
    COUNT(o.order_id) AS Count_order
FROM Orders o
JOIN Supplies s ON o.supply_id = s.supply_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
GROUP BY s.supply_name, s.category
ORDER BY Ordered_quantity DESC
LIMIT 5;

-- 5. Overtocked supplies
SELECT s.supply_name, c.clinic_name, i.quantity, s.max_stock
FROM Inventory i
JOIN Supplies s
ON i.supply_id = s.supply_id
JOIN Clinics c
ON i.clinic_id = c.clinic_id
WHERE i.quantity > s.max_stock
ORDER BY i.quantity DESC;

-- 6. Rank Top 3 Clinics by Inventory Value Within Each Region
WITH RankedClinics AS (
    SELECT c.clinic_name, c.region,     
        ROUND(SUM(i.quantity * s.unit_cost), 2) AS inventory_value,  
        RANK() OVER (PARTITION BY c.region ORDER BY SUM(i.quantity * s.unit_cost) DESC) AS value_rank  
    FROM Inventory i  
    JOIN Supplies s ON i.supply_id = s.supply_id  
    JOIN Clinics c ON i.clinic_id = c.clinic_id  
    GROUP BY c.clinic_name, c.region  
)  
SELECT *  
FROM RankedClinics  
WHERE value_rank < 4  
ORDER BY region, value_rank;

-- 7. Running Total of Orders by Supply Over Time
SELECT s.supply_name, o.order_date, o.quantity_ordered,
    SUM(o.quantity_ordered) OVER (PARTITION BY s.supply_name ORDER BY o.order_date ) AS running_total
FROM Orders o
JOIN Supplies s
ON o.supply_id = s.supply_id
ORDER BY s.supply_name, o.order_date;




