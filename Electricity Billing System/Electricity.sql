create database ebs;

use ebs;

create table login(meter_no varchar(20), username varchar(30), name varchar(30), password varchar(20), user varchar(20)); 

create table customer(name varchar(20), meter_no varchar(20), address varchar(50), city varchar(30), state varchar(30), email varchar(40), phone varchar(20));

create table meter_info(meter_no varchar(20), meter_location varchar(20), meter_type varchar(20), phase_code varchar(20), bill_type varchar(20), days varchar(20));

create table tax(cost_per_unit varchar(20), meter_rent varchar(20), service_charge varchar(20), service_tax varchar(20), swacch_bharat_cess varchar(20), fixed_tax varchar(20));

CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    bill_amount DECIMAL(10, 2),
    bill_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO billing (customer_id, bill_amount)
VALUES 
(101, 250.75),
(102, 300.50);

select * from billing;

insert into tax values('9','47','22','57','6','18');

create table bill(meter_no varchar(20), month varchar(30), units varchar(20), totalbill varchar(20), status varchar(20));

select * from login;
select * from customer;
select * from tax;
select * from bill;
select * from meter_info;

select * from customer 
where meter_no=427850;

select meter_no, name from customer;

select meter_no,city from customer
where city='Mumbai';

create table customer_trigger(
login_id int AUTO_INCREMENT PRIMARY KEY,
meter_no int,
action VARCHAR(50),
login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_customer_insert
AFTER INSERT ON customer
FOR EACH ROW
BEGIN
INSERT INTO customer_trigger(login_id, action)
VALUES(NEW.meter_no,'Customer Login');
END $$
DELIMITER ;

ALTER table customer_trigger
ADD COLUMN meter_location POINT;

ALTER TABLE customer
DROP COLUMN meter_location;

DELIMITER $$
CREATE TRIGGER after_customer_update
AFTER UPDATE ON customer
FOR EACH ROW
BEGIN
INSERT INTO customer_trigger(login_id, action)
VALUES(OLD.meter_no,'Customer Account Updated');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER after_customer_delete
AFTER DELETE ON customer
FOR EACH ROW
BEGIN
INSERT INTO customer_trigger(login_id, action)
VALUES(OLD.meter_no,'Customer Account Delete');
END $$
DELIMITER ;

select login_id,action,login_time from customer_trigger;

UPDATE customer_trigger 
SET meter_location = ST_GeomFromText('POINT(34.0522-118.2437)') 
WHERE meter_no=849465;

SET SQL_SAFE_UPDATES = 0;

select address,city,state from customer;

drop database ebs;
