-- Question 1 🛠️ Achieving 1NF (First Normal Form)
-- The original table contains multi-valued attributes in the 'Products' column
-- We need to split those values so that each row contains only a single product per order

-- Step 1: Create a new normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert the decomposed data (manually splitting comma-separated products into individual rows)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- The new table is now in 1NF: atomic values and no repeating groups

--------------------------------------------------

-- Question 2 🧩 Achieving 2NF (Second Normal Form)
-- The original table is in 1NF but has a partial dependency:
-- CustomerName depends only on OrderID, not the full (OrderID, Product) key
-- To achieve 2NF, we split the table into two: one for orders, one for order items

-- Step 1: Create the 'Orders' table with CustomerName dependent only on OrderID
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create the 'OrderItems' table where each product and quantity is linked to an OrderID
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into the 'Orders' table (one entry per order)
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 4: Insert data into the 'OrderItems' table (normalized, product-level info)
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES 
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- The data is now fully normalized to 2NF:
-- No partial dependencies, and each table stores information based on the proper keys
