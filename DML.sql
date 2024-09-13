/*Customer Table Data*/
insert all 
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('hithesh','nayak','hnayak@gmail.com',9874568908,'4567 Renneer rd','FL','Oakland',34760)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('john','doe','johndoe@gmail.com',9873456908,'4563 West rd','FL','Sanford',32771)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('mayank','mishra','mayankm@gmail.com',9873123908,'4561 West rd','TX','Richardson',75080)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('amit','kulkarni','amitk@gmail.com',9873345908,'4562 East rd','TX','Dallas',75088)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('glen','smith','gsmith@gmail.com',9873678908,'4564 South rd','TX','Plano',75325)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('michael','john','michaelj@gmail.com',9123345908,'4565 North rd','TX','Frisco',75034)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('aarti','singh','asingh@gmail.com',9345345908,'4566 West rd','TX','Dallas',75252)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('lesley','moore','lmoore@gmail.com',9678345908,'4567 South rd','NY','Richardson',10025)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('mary','keller','maryk@gmail.com',9890345908,'4568 Coit rd','NY','New York',10035)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('kruthi','jaishwal','kjaishwal@gmail.com',9873345123,'4569 East rd','NY','Albany',10045)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('andrea','josh','ajosh@gmail.com',9873345345,'4531 West rd','NY','New York',10025)
into customer(first_name,last_name,email,phone_number, address, state, city, zipcode) values ('kevin','paul','kpaul@gmail.com',9873345678,'4532 North rd','NY','Yonkers',11005)
SELECT 1 FROM dual;


/*Purchase Order Table Data*/
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(1,1000,25,'Submitted','05-MAY-2023','15-MAY-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(4,1001,56,'Returned','03-MAY-2023','08-MAY-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(2,1002,45,'Shipped','04-MAY-2023','09-MAY-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(5,1003,40,'In-Transit','01-MAY-2023','03-MAY-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(8,1004,800,'Delivered','24-APR-2023','27-APR-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(6,1005,500,'Cancelled','25-APR-2023','27-APR-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(9,1006,12,'On-Hold','25-APR-2023','29-APR-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(3,1007,50,'Out-for-Delivery','25-APR-2023','28-APR-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(7,1008,35,'Closed','25-APR-2023','28-APR-2023');
insert into purchase_order(customer_id,order_id,total_price,order_status,order_date,delivery_date) values(10,1009,115,'Rejected','25-APR-2023','28-APR-2023');



/*Product Table- Data*/
insert into product(name,price, description, order_id,category) values ('Sketcher Shoes',50,'Shoes with Memory Foam',1007,'Footwear');
insert into product(name,price, description, order_id,category) values ('Google Pixel 7 Pro',800,'16GB RAM with 512GB Storage',1004,'Mobiles');
insert into product(name,price, description, order_id,category) values ('Comforter',115,'Ultra Soft=Reversible',1009,'Household');
insert into product(name,price, description, order_id,category) values ('Universal Travel Adapter',12,'All-In-One',1006,'Accessories');
insert into product(name,price, description, order_id,category) values ('Vacuum Cleaner',35,'Multipurpose',1008,'Home and Kitchen');
insert into product(name,price, description, order_id,category) values ('ASUS Laptop',500,'32GB RAM with 1.5TB Storage',1005,'Electronics');
insert into product(name,price, description, order_id,category) values ('Amazon Gift Card',25,'Multipurpose',1000,'Gift Cards');
insert into product(name,price, description, order_id,category) values ('Trimmer',40,'Multipurpose Trimmer',1003,'Personal');
insert into product(name,price, description, order_id,category) values ('Similac',45,'Infant Formula',1002,'Toys, Kids and Baby');
insert into product(name,price, description, order_id,category) values ('Brake Pads',56,'Ceramic Brake Pads for Automobiles',1001,'Automotive and Industrial');



/*Shipping-Table*/
insert all 
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1000,'ABCDE10001','07-MAY-2023',4,'Express','4567 Renneer rd FL Oakland 34760')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1001,'EFGHI10002','04-MAY-2023',2,'Standard','4562 East rd TX Dallas 75088')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1002,'AABBC10003','04-MAY-2023',0,'Free','4563 West rd FL Sanford 32771')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1003,'XXYYZ10004','03-MAY-2023',4,'Express','4564 South rd TX Plano 75325')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1004,'MMNNO10005','25-APR-2023',0,'Free','4567 South rd NY Richardson 10025')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1005,'JKLMN10006','26-APR-2023',2,'Standard','4565 North rd TX Frisco 75034')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1006,'OPQRS10007','25-APR-2023',4,'Express','4568 Coit rd NY New York 10035')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1007,'TUVWX10008','26-APR-2023',2,'Standard','4561 West rd TX Richardson 75080')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1008,'YZABC10009','26-APR-2023',0,'Free','4566 West rd TX Dallas 75252')
 into shipping(order_id,tracking_number,shipping_date,shipping_cost,shipping_type,shipping_address) values(1009,'RRSST10010','25-APR-2023',4,'Express','4569 East rd NY Albany 10045')
select 1 from dual;

/*Payment Table Data*/
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (100,1000,29,'Credit Card','Paid','05-MAY-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (101,1001,58,'Debit Card','Refunded','03-MAY-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (102,1002,45,'Gift Card','Paid','04-MAY-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (103,1003,44,'Electronic Check','Paid','01-MAY-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (104,1004,800,'Credit Card','Paid','24-APR-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (105,1005,502,'Debit Card','Refunded','26-APR-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (106,1006,16,'Electronic Check','Paid','25-APR-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (107,1007,52,'Gift Card','Paid','25-APR-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (108,1008,35,'Debit Card','Paid','25-APR-2023');
insert into payment(payment_id,order_id,payment_amount,payment_method,payment_status,payment_date) values (109,1009,119,'Credit Card','Refunded','26-APR-2023');
commit;
