USE FreshMartRetailDB;

-- Product_Master Relationships

ALTER TABLE Product_Master
ADD CONSTRAINT FK_Product_Category
FOREIGN KEY (CategoryID)
REFERENCES Category_Master(CategoryID);

ALTER TABLE Product_Master
ADD CONSTRAINT FK_Product_Supplier
FOREIGN KEY (SupplierID)
REFERENCES Supplier_Master(SupplierID);

-- Sales_Fact Relationships

ALTER TABLE Sales_Fact
ADD CONSTRAINT FK_Sales_Product
FOREIGN KEY (ProductID)
REFERENCES Product_Master(ProductID);

ALTER TABLE Sales_Fact
ADD CONSTRAINT FK_Sales_Date
FOREIGN KEY (DateKey)
REFERENCES Date_Dimension(DateKey);

-- Purchase_Fact Relationships

ALTER TABLE Purchase_Fact
ADD CONSTRAINT FK_Purchase_Product
FOREIGN KEY (ProductID)
REFERENCES Product_Master(ProductID);

ALTER TABLE Purchase_Fact
ADD CONSTRAINT FK_Purchase_Supplier
FOREIGN KEY (SupplierID)
REFERENCES Supplier_Master(SupplierID);

ALTER TABLE Purchase_Fact
ADD CONSTRAINT FK_Purchase_Date
FOREIGN KEY (DateKey)
REFERENCES Date_Dimension(DateKey);

-- Inventory_Fact Relationships

ALTER TABLE Inventory_Fact
ADD CONSTRAINT FK_Inventory_Product
FOREIGN KEY (ProductID)
REFERENCES Product_Master(ProductID);

ALTER TABLE Inventory_Fact
ADD CONSTRAINT FK_Inventory_Date
FOREIGN KEY (DateKey)
REFERENCES Date_Dimension(DateKey);