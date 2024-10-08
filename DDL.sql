


/* DROP statements to clean up objects from previous run */
-- Triggers
DROP TRIGGER TRG_PAYMENT;
DROP TRIGGER TRG_SHIPPING;
DROP TRIGGER TRG_PURCHASE_ORDER;
DROP TRIGGER TRG_Product;
DROP TRIGGER TRG_Customer;

--Sequences
DROP SEQUENCE SEQ_Customer_customer_id;
DROP SEQUENCE SEQ_Product_Product_id;
DROP SEQUENCE SEQ_Shipping_shipping_id;

--VIEWS
DROP VIEW CustomerInfo;
DROP VIEW OrderInfo;
DROP VIEW OrderOver50;
DROP VIEW ShippingInfo;

--Indices
DROP INDEX IDX_Payment_Payment_Status;
DROP INDEX IDX_Payment_order_id_FK;
DROP INDEX IDX_Shipping_Tracking_No;
DROP INDEX IDX_Shipping_order_id_FK;
DROP INDEX IDX_Product_order_id_FK;
DROP INDEX IDX_Product_Name;
DROP INDEX IDX_Purchase_Order_customer_id_FK;
DROP INDEX IDX_Customer_First_Name;

/* Drop table */

DROP TABLE Payment;
DROP TABLE Shipping;
DROP TABLE Product;
DROP TABLE Purchase_order;
DROP TABLE Customer;

/* Create tables based on entities */

CREATE TABLE customer (
    customer_id  VARCHAR(20)    NOT NULL,
    first_name   VARCHAR(30)    NOT NULL,
    last_name    VARCHAR(30)    NOT NULL,
    email        VARCHAR(50)    NOT NULL,
    phone_number VARCHAR(15)    NOT NULL,
    address      VARCHAR(50)    NOT NULL,
    city         VARCHAR(20)    NOT NULL,
    state        VARCHAR(20)    NOT NULL,
    zipcode      INTEGER        NOT NULL,
    CONSTRAINT pk_customer PRIMARY KEY ( customer_id )
);

CREATE TABLE Purchase_Order (
    order_id        VARCHAR(20)  NOT NULL,
    customer_id     VARCHAR(20)  NOT NULL,
    order_status    VARCHAR(20)  NOT NULL,
    total_price     INTEGER      NOT NULL,
    order_date      DATE         NOT NULL,
    delivery_date   DATE	     NOT NULL,    
     
    CONSTRAINT PK_Purchase_Order         PRIMARY KEY (order_id),  
    CONSTRAINT FK_Purchase_Order_customer_id FOREIGN KEY (customer_id) REFERENCES Customer
);


CREATE TABLE Product (
    product_id  VARCHAR(20) NOT NULL,
    name        VARCHAR(30) NOT NULL,
    price       INTEGER NOT NULL,
    description VARCHAR(50) NOT NULL,
    category    VARCHAR(30) NOT NULL,
    order_id    VARCHAR(20) NOT NULL,
    
    CONSTRAINT pk_product PRIMARY KEY ( product_id ),
CONSTRAINT FK_PRODUCT_ORDER_ID FOREIGN KEY ( ORDER_ID ) REFERENCES PURCHASE_ORDER

);


CREATE TABLE shipping (
    shipping_id      VARCHAR(20) NOT NULL,
    shipping_date    DATE        NOT NULL,
    tracking_number  VARCHAR(20) NOT NULL,
    shipping_cost    INTEGER     NOT NULL,
    order_id         VARCHAR(20) NOT NULL,
    shipping_type    VARCHAR(20) NOT NULL,
    shipping_address VARCHAR(50) NOT NULL,

    CONSTRAINT pk_shipping PRIMARY KEY (shipping_id),
    CONSTRAINT fk_shipping_order_id FOREIGN KEY (order_id)
        REFERENCES purchase_order
);


CREATE TABLE Payment (
    payment_id     VARCHAR(20) NOT NULL,
    payment_date   DATE        NOT NULL,
    payment_amount INTEGER     NOT NULL,
    order_id       VARCHAR(20) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    
    CONSTRAINT PK_Payment       PRIMARY KEY (payment_id),  
    CONSTRAINT FK_Payment_order_id FOREIGN KEY (order_id) REFERENCES Purchase_Order
);


/* Create indices for natural keys, foreign keys, and frequently-queried columns */

-- Customer
-- Natural Keys
CREATE INDEX IDX_Customer_First_Name ON Customer (First_Name);

-- Pruchase_Order
--  Foreign Keys
CREATE INDEX IDX_Purchase_Order_customer_id_FK ON Purchase_Order (customer_id);

-- Product
-- Frequently-queried columns
CREATE INDEX IDX_Product_Name  ON Product (Name);
--  Foreign Keys
CREATE INDEX IDX_Product_order_id_FK  ON Product (order_id);


-- Shipping
--  Foreign Keys
CREATE INDEX IDX_Shipping_order_id_FK   ON Shipping (order_id);

--  Frequently-queried columns
CREATE INDEX IDX_Shipping_Tracking_No ON Shipping (Tracking_Number);


-- Payment
--  Foreign Keys
CREATE INDEX IDX_Payment_order_id_FK  ON Payment (order_id);

--  Frequently-queried columns
CREATE INDEX IDX_Payment_Payment_Status   ON Payment (Payment_Status);



/* Alter Tables by adding Audit Columns */
ALTER TABLE CUSTOMER ADD (
    created_by    VARCHAR2(30),
    date_created  DATE,
    modified_by   VARCHAR2(30),
    date_modified DATE
);

ALTER TABLE Purchase_Order ADD (
    created_by    VARCHAR2(30),
    date_created  DATE,
    modified_by   VARCHAR2(30),
    date_modified DATE
);

ALTER TABLE Product ADD (
    created_by    VARCHAR2(30),
    date_created  DATE,
    modified_by   VARCHAR2(30),
    date_modified DATE
);

ALTER TABLE Shipping ADD (
    created_by    VARCHAR2(30),
    date_created  DATE,
    modified_by   VARCHAR2(30),
    date_modified DATE
);

ALTER TABLE Payment ADD (
    created_by    VARCHAR2(30),
    date_created  DATE,
    modified_by   VARCHAR2(30),
    date_modified DATE
);

/* Create Views */
-- Business purpose: The CustomerInfo view will be used primarily for rapidly fetching information about customers.
CREATE OR REPLACE VIEW CustomerInfo AS
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone_number,
    address
FROM
    Customer;

-- Business purpose: The OrderInfo view will be used to fetch information about an Order for a Customer.
CREATE OR REPLACE VIEW OrderInfo AS
SELECT
    p.order_id,
    p.customer_id,
    c.first_name,
    c.last_name,
    p.order_status,
    p.total_price,
    p.order_date
FROM
         Purchase_Order p
    JOIN Customer c ON p.customer_id = c.customer_id;

-- Business purpose: The OrderOver50 view will be used to fetch information of all orders from customer that are over $50.
CREATE OR REPLACE VIEW OrderOver50 AS
SELECT
    p.product_id,
    p.name,
    p.price,
    p.category,
    o.order_id,
    o.total_price,
    c.first_name,
    c.last_name
FROM
         product p
    JOIN purchase_order o ON p.order_id = o.order_id
    JOIN customer       c ON o.customer_id = c.customer_id
WHERE
    o.total_price > 50;

-- Business purpose: The ShippingInfo view will be used to populate a list of all Shipping information for an order.
CREATE OR REPLACE VIEW ShippingInfo AS
SELECT
    shipping_id,
    shipping_date,
    tracking_number,
    shipping_type,
    order_id
FROM
    Shipping;

/* Create Sequences */
CREATE SEQUENCE SEQ_Customer_customer_id
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 1
    NOCACHE;

CREATE SEQUENCE SEQ_Product_Product_id
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 1
    NOCACHE;

CREATE SEQUENCE SEQ_Shipping_shipping_id
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 1
    NOCACHE;
    
/* Create Triggers */
-- Business purpose: The TRG_Customer trigger automatically assigns a sequential Customer ID to a newly-inserted row in the Customer table, 
-- as well as assigning appropriate values to the created_by and date_created fields. 
--If the record is being inserted or updated, appropriate values are assigned to the modified_by and modified_date fields.
CREATE OR REPLACE TRIGGER TRG_Customer
    BEFORE INSERT OR UPDATE ON Customer
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            IF :NEW.customer_id IS NULL THEN
                :NEW.customer_id := SEQ_Customer_customer_id.NEXTVAL;
            END IF;
            IF :NEW.created_by IS NULL THEN
                :NEW.created_by := USER;
            END IF;
            IF :NEW.date_created IS NULL THEN
                :NEW.date_created := SYSDATE;
            END IF;
        END IF;
        IF INSERTING OR UPDATING THEN
            :NEW.modified_by := USER;
            :NEW.date_modified := SYSDATE;
        END IF;
END;
/ 

-- Business purpose: The TRG_Product trigger automatically assigns a sequential Product ID to a newly-inserted row in the Product table,
--as well as assigning appropriate values to the created_by and date_created fields.  
--If the record is being inserted or updated, appropriate values are assigned to the modified_by and modified_date fields.
CREATE OR REPLACE TRIGGER TRG_Product
    BEFORE INSERT OR UPDATE ON Product
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            IF :NEW.Product_id IS NULL THEN
                :NEW.Product_id := SEQ_Product_Product_id.NEXTVAL;
            END IF;
            IF :NEW.created_by IS NULL THEN
                :NEW.created_by := USER;
            END IF;
            IF :NEW.date_created IS NULL THEN
                :NEW.date_created := SYSDATE;
            END IF;
        END IF;
        IF INSERTING OR UPDATING THEN
            :NEW.modified_by := USER;
            :NEW.date_modified := SYSDATE;
        END IF;
END;
/

-- Business purpose: The TRG_Pruchase_Order trigger sets the modified_by and date_modified fields to appropriate values in a newly inserted or updated record; 
--if the record is being inserted, then the created_by and date_created fields are set to appropriate values too.
CREATE OR REPLACE TRIGGER TRG_Purchase_Order
    BEFORE INSERT OR UPDATE ON Purchase_Order
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            IF :NEW.created_by IS NULL THEN
                :NEW.created_by := USER;
            END IF;
            IF :NEW.date_created IS NULL THEN
                :NEW.date_created := SYSDATE;
            END IF;
        END IF;
        IF INSERTING OR UPDATING THEN
            :NEW.modified_by := USER;
            :NEW.date_modified := SYSDATE;
        END IF;
END;
/

-- Business purpose: The TRG_Shipping trigger automatically assigns a sequential comment ID to a newly-inserted row
--in the Shipping table, as well as assigning appropriate values to the created_by and date_created fields.  If the record is being inserted or updated, 
--appropriate values are assigned to the modified_by and modified_date fields.
CREATE OR REPLACE TRIGGER TRG_Shipping
    BEFORE INSERT OR UPDATE ON Shipping
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            IF :NEW.Shipping_id IS NULL THEN
                :NEW.Shipping_id := SEQ_Shipping_shipping_id.NEXTVAL;
            END IF;
            IF :NEW.created_by IS NULL THEN
                :NEW.created_by := USER;
            END IF;
            IF :NEW.date_created IS NULL THEN
                :NEW.date_created := SYSDATE;
            END IF;
        END IF;
        IF INSERTING OR UPDATING THEN
            :NEW.modified_by := USER;
            :NEW.date_modified := SYSDATE;
        END IF;
END;
/

-- Business purpose: The TRG_Payment trigger sets the modified_by and date_modified fields to appropriate values in a newly inserted or updated record; 
--if the record is being inserted, then the created_by and date_created fields are set to appropriate values too.
CREATE OR REPLACE TRIGGER TRG_Payment
    BEFORE INSERT OR UPDATE ON Payment
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            IF :NEW.created_by IS NULL THEN
                :NEW.created_by := USER;
            END IF;
            IF :NEW.date_created IS NULL THEN
                :NEW.date_created := SYSDATE;
            END IF;
        END IF;
        IF INSERTING OR UPDATING THEN
            :NEW.modified_by := USER;
            :NEW.date_modified := SYSDATE;
        END IF;
END;
/

-- Check the DBMS data dictionary to make sure that all objects have been created successfully
--SELECT TABLE_NAME FROM USER_TABLES;

--SELECT OBJECT_NAME, STATUS, CREATED, LAST_DDL_TIME FROM USER_OBJECTS;
