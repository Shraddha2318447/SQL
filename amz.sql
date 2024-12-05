create database amz;
use amz;
create table seller(
store_name int,
location int,
date_joined date,
estd date,
rating int
);
-- want to modify store datatype int to varchar
alter table seller
  modify store_name varchar(100);
  
  -- want to add id in table
alter table seller
  add id int;
  
-- forgot to add primary key in above added id then now should add  
alter table seller
  add primary key(id);
  
-- delete primary key from table
alter table seller
  drop primary key;
  
-- another format to add primary key with constraint name
alter table seller
  add constraint seller_pk primary key(id);
-- can give name(seller_pk) for contraint also 

 -- describe table
desc seller;

-- its show the table info in one line not a format table(waht was run to create a table)
show create table seller;
  
  
-- id is commin in last row want in first row or top row
alter table seller
  drop column id;
  
-- then again add id for commining in first row
alter table seller
add id int primary key first;

-- want to change seller name
alter table seller rename to sell;

desc sell; 

-- agin change name
alter table sell rename to seller;

-- want to change column name location to address
alter  table seller
  rename column location to office_address;

desc seller;

 -- another way to change colunm name, again i want address to location
alter table seller
  change column office_address lpcation int;  -- change column <old_col_name> <new_col_name> <dt_type>
  alter table seller
  change column lpcation location int;
  
  
desc seller;

-- want to give forien key in location that y create constraint name(address_link)
alter table seller
add constraint address_link foreign key(location) references address(id);

desc seller;

-- add data in seller in that not now adding loction and rating should give the costomer not seller
insert into seller (id, store_name, date_joined, estd)
values ('1','internatinal electronics','2001-02-17','1997-07-14'), ('2','in electronics','1981-11-23','1980-12-31'), ('3','keishna electronics','2010-04-02','2005-09-01');

select * from seller;

-- next table is the seller's different warehouse which is linked to each seller.
-- afterwards, we indroduce the products entity which has space and retail price.
-- product_isting is an entity which ahows which product are available form which warehouse or putlets and for waht selling price.

-- create address table
create table address(
 id int primary key auto_increment,
 pincode int not null,
 building_no varchar(50),
 street_address varchar(100),
 landmark varchar(100));
 
insert into address (pincode, building_no, street_address, landmark)
values ('413004','306','vaman nagar road','govindshree mangalkaryalay'), ('540023','63F','12th main street','nandana hotel'), 
('560078','GB','23rd street road','raggiguda temple'), ('42314','C1','wakad main road','near D-mart');

select * from address;
-- create outlets table
create table outlets(
id int auto_increment ,
seller_id int not null,
address_id int,
phno varchar(20),
primary key(id), -- it show above in id column also
constraint fk_seller_id foreign key(seller_id) references seller(id), -- when were we are given constraint should give name of constraint
constraint outlet_address foreign key (address_id) references address(id));

desc outlets;
insert into outlets (seller_id, address_id, phno)
values ('1','3','8756201496'), ('3','1','6345102374'), ('2', '4','9822456120'), ('1','2','7350041532');

 -- truncate outlets;
select * from outlets;


-- cant possible to drop primary key bcz foreign key is depend on primary key then 1st drop foreign key then primary key

-- want to remove oulet_address(means mull) from outlets table
alter table outlets
drop foreign key outlet_address;
-- not happen or not remove MUL in key column 

desc outlets;

-- above step not working that y now doing this
-- want to remove MUL in key column then drop foreign key aswell as only key
alter table outlets drop foreign key outlet_address;
alter table outlets drop key outlet_address;

desc outlets;
  
-- again want to MUL in key column means add foreign key in address_id
alter table outlets
add constraint outlet_address foreign key(address_id) references address(id);

desc outlets;
  
-- create products entity
create table products(
  id varchar(100) primary key,
  title varchar(100) not null,
  prod_desc varchar(255),
  retail_price float,
  category enum('electronic', 'utensils','hardware','software','stationary'));

desc products;
insert into products (id, title, prod_desc, retail_price, category)
values ('P001', 'Smartphone', 'Latest model with 128GB storage', 699.99, 'electronic'),
('P002', 'Hammer', 'Durable steel hammer with rubber grip', 15.49, 'hardware'),
('P003', 'Notebook', '200 pages spiral-bound notebook', 2.99, 'stationary'),
('P004', 'Antivirus Software', '1-year subscription for PC protection', 39.99, 'software');
select * from products;

-- create product_list
create table product_list(
  id varchar(100) primary key,
  product_id varchar(100) not null,
  outlet_id int not null,
  rate float not null,
  stock int not null, -- quntity
  constraint prod_link foreign key(product_id) references products(id),
  constraint outlet_link foreign key(outlet_id) references outlets(id),
  constraint stock_check check(stock >= 0)); -- how to add check, then oly next process will done- quntity should be more than or equal to 0 then only process happen

desc product_list;
  
insert into product_list (id, product_id, outlet_id, rate, stock)
values('PL1', 'P001', '4', 23000, 25),
('PL2', 'P002', '2', '1200', '50'),
('PL3', 'P003', '3', '30', '200'),
('PL4', 'P004', '1', '3400', '30'),
('PL5', 'P002', '4', '1180', '40'),
('PL6', 'P001', '1', '24500', '10'),
('PL7', 'P003', '1', '27', '500'),
('PL8', 'P004', '2', '5000', '15'),
('PL9', 'P002', '3', '1360', '60');
select * from product_list;


-- DQL - Filter grouped data with having--
select product_id, count(*) AS user_count
from product_list
group by product_id
having user_count > 1;

-- Limit Results in DQL-- it is taking decending order values of column name--
select * from product_list order by rate desc limit 7;

-- offset means if we dont want above some rows cant come for limit then use offset-- offset with limit
select * from product_list LIMIT 5 OFFSET 2; -- it will cont take above 2 values then from 3rd to 7th (5 values) will take--


create table customer(
  id varchar(100) primary key,
  fname varchar(100) not null,
  lname varchar(100),
  email varchar(100) not null,
  dob date not null,
  phnno varchar(20),
  pwd varchar(100));
  
desc customer;

insert into customer (id, fname, lname, email, dob, phnno, pwd) values
('C001', 'Arpitha', 'Agarwal', 'Arp@523.com', '1990-05-15', '123-456-7890', 'password123'),
('C002', 'Dilip', 'Shetty', 'dilip@2310.com', '1985-10-20', '234-567-8901', 'securepass456'),
('C003', 'Mayur', 'Patil', 'mayur@0204.com', '1995-03-08', '345-678-9012', 'alice@brown99'),
('C004', 'Kanha', 'Kalyan', 'kah@cool.com', '1988-07-12', '456-789-0123', 'bobby_john!88'),
('C005', 'Shweta', 'Sharma', 'shwet@56.com', '2000-01-25', '567-890-1234', 'shfshrma_2020');

select * from customer;
  
 -- craete cart table , its tempory table bcz after orders product_list remove from cart table 
create table Cart_Item(
  id int primary key,
  product_list_id varchar(100) not null,
  customer_id varchar(100) not null,
  quntity int not null,
  foreign key(product_list_id) references product_list(id), -- not products table its product_list table, in product_list item are available but info can take from products table
  foreign key(customer_id) references customer(id));  -- can use constraint for foreign key or this way also
  
desc Cart_Item;
  
insert into Cart_Item (id, product_list_id, customer_id, quntity) values
(11, 'PL1', 'C001', 2),
(22, 'PL2', 'C002', 7),
(33, 'PL3', 'C003', 5),
(44, 'PL4', 'C001', 1),
(55, 'PL5', 'C004', 3),
(66, 'PL6', 'C005', 1),
(77, 'PL7', 'C002', 10);

select * from Cart_Item;

  
create table orders(
  id varchar(100) not null,
  customer_id varchar(100) not null,
  orderd_at timestamp default current_timestamp,
  order_status enum("pending","waiting-to-dispatch","dispatched","shipped","delivered") default "pending", 
  foreign key(customer_id) references customer(id));
  
desc orders;

alter table orders
  add primary key(id);

INSERT INTO orders (id, customer_id, order_status) VALUES
('OR1','C001', 'pending'),
('OR2','C002', 'waiting-to-dispatch'),
('OR3','C003', 'dispatched'),
('OR4','C001', 'shipped'),
('OR5','C005', 'delivered'),
('OR6','C003', 'pending');
select * from orders;
  
-- can for cart recored, cart is tempary things, orders detail with quntity, similar like a cart but after orders it will stay in record
-- craete order_details
-- cart item is not connect to orders
create table order_details(
  id int primary key not null, 
  order_id varchar(100) not null,
  product_l_id varchar(100) not null,
  quantity INT NOT NULL,
  foreign key(order_id) references orders(id), 
  foreign key(product_l_id) references product_list(id)
);
  
desc order_details;

INSERT INTO order_details (id, order_id, product_l_id, quantity) VALUES
(1, 'OR1', 'PL1', 2),
(2, 'OR1', 'PL4', 1),
(3, 'OR2', 'PL2', 7),
(4, 'OR2', 'PL5', 3),
(5, 'OR3', 'PL3', 5),
(6, 'OR4', 'PL4', 1);
  
select * from order_details;



  
  
  



  
  
  
  