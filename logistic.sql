CREATE DATABASE logistics_db;
USE logistics_db;

CREATE TABLE shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_date DATE NOT NULL,
    origin VARCHAR(50),
    destination VARCHAR(50),
    vehicle_type VARCHAR(30),
    distance_km INT,
    shipping_cost DECIMAL(10,2),
    delivery_status VARCHAR(20),
    delivery_days INT,
    customer_type VARCHAR(30)
);

DESCRIBE shipments;
USE logistics_db;

INSERT INTO shipments
(shipment_date, origin, destination, vehicle_type, distance_km, shipping_cost, delivery_status, delivery_days, customer_type)
VALUES
('2026-09-01','Chennai','Bangalore','Truck',350,8500,'Delivered',2,'Business'),
('2026-09-01','Coimbatore','Chennai','Van',510,6200,'Delivered',3,'Business'),
('2026-09-01','Madurai','Chennai','Truck',460,7800,'Delayed',5,'Business'),
('2026-09-02','Chennai','Hyderabad','Truck',630,10500,'Delivered',3,'Business'),
('2026-09-02','Salem','Coimbatore','Van',160,3200,'Delivered',1,'Individual'),
('2026-09-02','Bangalore','Chennai','Truck',350,8200,'Delayed',4,'Business'),
('2026-09-03','Coimbatore','Bangalore','Van',365,4800,'Delivered',2,'Individual'),
('2026-09-03','Chennai','Madurai','Truck',460,7600,'Delivered',2,'Business'),
('2026-09-03','Trichy','Chennai','Van',320,4500,'Delivered',2,'Individual'),
('2026-09-04','Bangalore','Hyderabad','Truck',570,9800,'Delayed',5,'Business'),
('2026-09-04','Chennai','Coimbatore','Truck',510,8000,'Delivered',3,'Business'),
('2026-09-04','Madurai','Coimbatore','Van',220,3800,'Delivered',1,'Individual'),
('2026-09-05','Coimbatore','Chennai','Truck',510,8100,'Delayed',4,'Business'),
('2026-09-05','Chennai','Bangalore','Van',350,5000,'Delivered',2,'Individual'),
('2026-09-05','Salem','Chennai','Truck',340,6500,'Delivered',2,'Business'),
('2026-09-06','Chennai','Trichy','Van',320,4400,'Delivered',2,'Individual'),
('2026-09-06','Bangalore','Coimbatore','Truck',365,7200,'Delayed',4,'Business'),
('2026-09-06','Madurai','Bangalore','Truck',430,7500,'Delivered',3,'Business'),
('2026-09-07','Coimbatore','Madurai','Van',220,3700,'Delivered',1,'Individual'),
('2026-09-07','Chennai','Salem','Van',340,4600,'Delivered',2,'Individual');

SELECT COUNT(*) AS total_shipments
FROM shipments;
SELECT * FROM shipments;

USE logistics_db;

-- 1. Total shipments
SELECT COUNT(*) AS total_shipments
FROM shipments;

-- 2. Total shipping cost
SELECT SUM(shipping_cost) AS total_shipping_cost
FROM shipments;

-- 3. Average delivery days
SELECT AVG(delivery_days) AS average_delivery_days
FROM shipments;

-- 4. Delivered vs Delayed
SELECT delivery_status, COUNT(*) AS shipment_count
FROM shipments
GROUP BY delivery_status;

-- 5. Vehicle-wise shipments
SELECT vehicle_type, COUNT(*) AS shipment_count
FROM shipments
GROUP BY vehicle_type;

-- 6. Destination-wise shipments
SELECT destination, COUNT(*) AS shipment_count
FROM shipments
GROUP BY destination;