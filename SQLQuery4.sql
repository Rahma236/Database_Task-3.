-------------&[TASK_B]-----------

CREATE DATABASE OnlineShoppingSystem
USE OnlineShoppingSystem

CREATE TABLE Customers(
id INT IDENTITY PRIMARY KEY,
email VARCHAR(100) UNIQUE NOT NULL,
name NVARCHAR(50) NOT NULL,
phoneNumber NVARCHAR(50) NOT NULL,
address NVARCHAR(50) NOT NULL,
);
CREATE TABLE  Products(
productID INT IDENTITY PRIMARY KEY,
category NVARCHAR(50) NOT NULL ,
name NVARCHAR(50) UNIQUE NOT NULL,
description NVARCHAR(MAX) NOT NULL,
 price DECIMAL(8,2) CHECK (price > 0) NOT NULL
);
CREATE TABLE Orders(
orderID INT IDENTITY PRIMARY KEY,
totalAmount DECIMAL(8,2) NOT NULL ,
orderDate DATETIME DEFAULT GETUTCDATE(),
status NVARCHAR(50),
customerID INT NOT NULL,
FOREIGN KEY (customerID) REFERENCES Customers(id)
);
CREATE TABLE OrderDetails (
    orderDetailID INT IDENTITY PRIMARY KEY,
    price DECIMAL(8,2) CHECK (price > 0) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
  );
CREATE TABLE Suppliers(
id INT IDENTITY PRIMARY KEY,
contactInfo  NVARCHAR(200) NOT NULL,
name NVARCHAR(100) NOT NULL,
);
CREATE TABLE ProductSupplier(
productID INT NOT NULL,
supplierID INT NOT NULL,
 PRIMARY KEY (productID, supplierID),
FOREIGN KEY (productID) REFERENCES Products(productID),
FOREIGN KEY (supplierID) REFERENCES Suppliers(id)
);
CREATE TABLE Asosociative(

  productID INT NOT NULL,
      orderDetailID INT NOT NULL,
    orderID INT NOT NULL,
	 PRIMARY KEY (productID, orderDetailID,orderID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (productID) REFERENCES Products(productID),
	FOREIGN KEY (orderDetailID) REFERENCES OrderDetails(orderDetailID)
);

ALTER TABLE Products
ADD rating DECIMAL(3,2) DEFAULT 0 CHECK(rating>=0 AND rating<=5) ;
ALTER TABLE Products
ADD CONSTRAINT DE_category DEFAULT 'NEW' FOR category;

-- البحث عن جميع القيود على جدول Products
SELECT name, type_desc 
FROM sys.objects 
WHERE parent_object_id = OBJECT_ID('Products');

ALTER TABLE Products DROP CONSTRAINT DF__Products__rating__4CA06362;
ALTER TABLE Products DROP CONSTRAINT CK__Products__rating__4D94879B;
ALTER TABLE Products DROP COLUMN rating;


-----[update the order date]---
UPDATE Orders SET orderDate=GETUTCDATE() WHERE orderID>0 ;
----[Delete all rows from the Products table]----
DELETE FROM Products where name IS NOT NULL AND name <>'NULL';


