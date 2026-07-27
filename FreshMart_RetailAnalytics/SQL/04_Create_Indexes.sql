USE FreshMartRetailDB;

-- Product indexes
CREATE INDEX IDX_Product_Category
ON Product_Master(CategoryID);

CREATE INDEX IDX_Product_Supplier
ON Product_Master(SupplierID);

-- Sales indexes
CREATE INDEX IDX_Sales_Product
ON Sales_Fact(ProductID);

CREATE INDEX IDX_Sales_Date
ON Sales_Fact(DateKey);

-- Purchase indexes
CREATE INDEX IDX_Purchase_Product
ON Purchase_Fact(ProductID);

CREATE INDEX IDX_Purchase_Supplier
ON Purchase_Fact(SupplierID);

CREATE INDEX IDX_Purchase_Date
ON Purchase_Fact(DateKey);

-- Inventory indexes
CREATE INDEX IDX_Inventory_Product
ON Inventory_Fact(ProductID);

CREATE INDEX IDX_Inventory_Date
ON Inventory_Fact(DateKey);