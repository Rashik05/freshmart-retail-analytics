
DROP TABLE IF EXISTS Category_Master;
DROP TABLE IF EXISTS Supplier_Master;
DROP TABLE IF EXISTS Date_Dimension;
DROP TABLE IF EXISTS Product_Master;
DROP TABLE IF EXISTS Sales_Fact;
DROP TABLE IF EXISTS Inventory_Fact;
DROP TABLE IF EXISTS Purchase_Fact;
DROP TABLE IF EXISTS Sales_Fact;

CREATE TABLE Category_Master (
    CategoryID VARCHAR(10) NOT NULL,
    CategoryName VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    PRIMARY KEY (CategoryID)
);

CREATE TABLE Supplier_Master (
    SupplierID VARCHAR(10) NOT NULL,
    SupplierName VARCHAR(100) NOT NULL,
    PrimaryCategoryID VARCHAR(10) NOT NULL,
    PrimaryCategory VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Province VARCHAR(50) NOT NULL,
    PaymentTerms VARCHAR(30) NOT NULL,
    LeadTimeDays INT NOT NULL,
    ContactName VARCHAR(100) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    PRIMARY KEY (SupplierID)
);
CREATE TABLE Date_Dimension (
    DateKey INT NOT NULL,
    Date DATE NOT NULL,
    Day TINYINT NOT NULL,
    Month TINYINT NOT NULL,
    MonthName VARCHAR(15) NOT NULL,
    Quarter VARCHAR(5) NOT NULL,
    Year SMALLINT NOT NULL,
    Weekday VARCHAR(15) NOT NULL,
    DayOfWeekNumber TINYINT NOT NULL,
    WeekOfYear TINYINT NOT NULL,
    MonthYear VARCHAR(10) NOT NULL,
    IsWeekend BOOLEAN NOT NULL,
    Season VARCHAR(15) NOT NULL,

    PRIMARY KEY (DateKey)
);

CREATE TABLE Product_Master (
    ProductID VARCHAR(10) NOT NULL,
    SKU VARCHAR(30) NOT NULL,
    Barcode VARCHAR(20) NOT NULL,
    ProductName VARCHAR(150) NOT NULL,
    Brand VARCHAR(100) NOT NULL,
    CategoryID VARCHAR(10) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    SubCategory VARCHAR(100) NOT NULL,
    SupplierID VARCHAR(10) NOT NULL,
    SupplierName VARCHAR(100) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    CostPrice DECIMAL(10,2) NOT NULL,
    SellingPrice DECIMAL(10,2) NOT NULL,
    MarginPercent DECIMAL(5,2) NOT NULL,
    Taxable BOOLEAN NOT NULL,
    ReorderLevel INT NOT NULL,
    Status VARCHAR(20) NOT NULL,

    PRIMARY KEY (ProductID)
);
CREATE TABLE Sales_Fact (
    SaleLineID VARCHAR(15) NOT NULL,
    InvoiceID VARCHAR(20) NOT NULL,
    DateKey INT NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    QuantitySold INT NOT NULL,
    UnitSellingPrice DECIMAL(10,2) NOT NULL,
    DiscountAmount DECIMAL(10,2) NOT NULL,
    TaxAmount DECIMAL(10,2) NOT NULL,
    LineTotal DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,

    PRIMARY KEY (SaleLineID)
);
CREATE TABLE Purchase_Fact (
    PurchaseLineID VARCHAR(15) NOT NULL,
    PurchaseOrderID VARCHAR(20) NOT NULL,
    DateKey INT NOT NULL,
    SupplierID VARCHAR(10) NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    QuantityPurchased INT NOT NULL,
    UnitCost DECIMAL(10,2) NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL,
    PurchaseStatus VARCHAR(20) NOT NULL,

    PRIMARY KEY (PurchaseLineID)
);

CREATE TABLE Inventory_Fact (
    InventoryID VARCHAR(15) NOT NULL,
    DateKey INT NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    OpeningStock INT NOT NULL,
    PurchasedQty INT NOT NULL,
    SoldQty INT NOT NULL,
    ClosingStock INT NOT NULL,
    ReorderLevel INT NOT NULL,
    StockStatus VARCHAR(20) NOT NULL,

    PRIMARY KEY (InventoryID)
);