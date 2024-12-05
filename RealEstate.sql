-- Entities;
  -- Broker (id, name, age, phno, joined)
  -- Plots (id, cost_price, broker_id,survey_no, type)
  -- Customer (id, first_name, last_name, age, gender, refrral_id, pwd)
  -- Sales (id, plot_id, customer_id, broker_id, price, date)
create database RealEstate;
use RealEstate;
Create table broker(
id int primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
age int,
phno varchar(100) not null,
joined timestamp default current_timestamp);

create table plots(
id int primary key auto_increment,
cost_price double not null,
broker_id int,
area float,
survey_no int not null,
plot_type varchar(100),
foreign key(broker_id) references broker(id));

create table customer(
username varchar(100) primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
email varchar(100) not null,
phno varchar(100) not null,
pwd varchar(100) not null,
age int,
gender enum('Male' , 'Female', 'Others'),
referral_id varchar(100),
foreign key (referral_id) references customer(username));

create table sales(
id int primary key auto_increment,
plot_id int not null,
customer_id varchar(100) not null,
broker_id int,
price float not null,
sold_at timestamp default current_timestamp,
foreign key(plot_id) references plots(id),
foreign key(customer_id) references customer(username),
foreign key(broker_id) references broker(id));
desc sales;
insert into broker (id, first_name, last_name, age, phno)
values (1, 'Raju', 'Sharma', 25, 364),(2, 'Sonu', 'Shon', 30, 142),
(3, 'Monu', 'Agarwal', 20, 3674),(4, 'Golu', 'Han', 41, 874);
select * from broker;



 


