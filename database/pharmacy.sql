

-- Create new database
CREATE DATABASE online_pharmacy;
USE online_pharmacy;


CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL, -- customer | pharmacist | admin
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE Medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    category VARCHAR(80),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    prescription_needed BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL, -- Pending | Approved | Rejected | Completed | Cancelled
    order_type VARCHAR(10) NOT NULL, -- Pickup | Delivery
    total_price DECIMAL(10,2),
    phone VARCHAR(20),
    address TEXT,
    prescription_file VARCHAR(255),
    approved_by INT,
    approved_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (approved_by) REFERENCES Users(user_id)
);


CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);


CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    method VARCHAR(20) NOT NULL, -- Online | COD | OnPickup
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL, -- Pending | Paid | Failed | Refunded
    paid_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


CREATE TABLE Refunds (
    refund_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(20) NOT NULL, -- Requested | Approved | Rejected | Processed
    requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    processed_at DATETIME,
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);


CREATE TABLE Logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT, -- nullable for anonymous events
    action VARCHAR(100) NOT NULL,
    details TEXT,
    ip_address VARCHAR(45),
    status VARCHAR(20) NOT NULL, -- success | failure
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Notifications (
    notif_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_id INT,
    type VARCHAR(20) NOT NULL, -- email | sms
    message TEXT,
    status VARCHAR(20) NOT NULL, -- queued | sent | failed
    sent_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert sample users (customers, pharmacist, admin)
INSERT INTO Users (name, email, password, phone, role, created_at, updated_at)
VALUES
('Alice Doe', 'alice@example.com', 'hashed_password1', '5251234', 'customer', NOW(), NOW()),
('Bob Smith', 'bob@example.com', 'hashed_password2', '5255678', 'customer', NOW(), NOW()),
('Dr. Jane Pharma', 'jane@pharmacy.com', 'hashed_password3', '5258765', 'pharmacist', NOW(), NOW()),
('Admin User', 'admin@system.com', 'hashed_password4', '5259999', 'admin', NOW(), NOW());

-- Insert sample medicines
INSERT INTO Medicines (name, description, category, price, stock, prescription_needed, created_at, updated_at)
VALUES
('Paracetamol', 'Pain reliever and fever reducer', 'Analgesic', 2.50, 100, FALSE, NOW(), NOW()),
('Amoxicillin', 'Antibiotic for bacterial infections', 'Antibiotic', 8.75, 50, TRUE, NOW(), NOW()),
('Cough Syrup', 'Relieves cough and sore throat', 'Cold & Flu', 5.20, 75, FALSE, NOW(), NOW()),
('Insulin', 'Used for diabetes treatment', 'Endocrine', 20.00, 30, TRUE, NOW(), NOW());

-- Insert sample orders
INSERT INTO Orders (user_id, order_date, status, order_type, total_price, phone, address, prescription_file, approved_by, approved_at)
VALUES
(1, NOW(), 'Pending', 'Delivery', 11.25, '5251234', '123 Main St', NULL, NULL, NULL),
(2, NOW(), 'Approved', 'Pickup', 8.75, '5255678', NULL, 'prescriptions/rx1.pdf', 3, NOW());

-- Insert order items
INSERT INTO OrderItems (order_id, medicine_id, quantity, subtotal)
VALUES
(1, 1, 2, 5.00),   -- Alice ordered 2 Paracetamol
(1, 3, 1, 5.20),   -- Alice ordered 1 Cough Syrup
(2, 2, 1, 8.75);   -- Bob ordered 1 Amoxicillin (prescription)

-- Insert payments
INSERT INTO Payments (order_id, method, amount, status, paid_at, created_at)
VALUES
(1, 'COD', 11.25, 'Pending', NULL, NOW()),
(2, 'Online', 8.75, 'Paid', NOW(), NOW());

-- Insert refunds (example, Bob requested refund)
INSERT INTO Refunds (payment_id, amount, reason, status, requested_at, processed_at)
VALUES
(2, 8.75, 'Wrong medicine delivered', 'Requested', NOW(), NULL);

-- Insert logs
INSERT INTO Logs (user_id, action, details, ip_address, status, created_at)
VALUES
(1, 'login_success', 'User Alice logged in', '127.0.0.1', 'success', NOW()),
(3, 'rx_approved', 'Prescription rx1.pdf approved', '127.0.0.1', 'success', NOW());

-- Insert notifications
INSERT INTO Notifications (user_id, order_id, type, message, status, sent_at, created_at)
VALUES
(1, 1, 'email', 'Your order #1 has been placed.', 'sent', NOW(), NOW()),
(2, 2, 'sms', 'Your order #2 is ready for pickup.', 'queued', NULL, NOW());

SELECT * FROM Users;
SELECT * FROM Orders;
SELECT * FROM OrderItems;
