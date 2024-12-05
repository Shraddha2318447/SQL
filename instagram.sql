create database instagram;
use instagram;
create table user (
username varchar (100) primary key,
name varchar(100) not null, 
profile_pictur varchar(100),
email varchar(100) not null,
password varchar(100) not null, 
bio varchar(100) not null, 
gender enum('male' , 'female', 'others'),
joined timestamp default current_timestamp);

insert into user(username, name, profile_pictur, email, password, bio, gender)
values
('a1', 'varunshrama', 'link1', 'var.123@com', 'var@123', 'java developer', 'male'),
('a2', 'shraddhachaudhari', 'link2', 'shr.23@com', 'shr@23', 'python developer', 'female'),
('a3', 'shivanidubby', 'link3', 'shiv.123@com', 'shiv@123', 'software developer', 'female');

select * from user;

create table post (
id int primary key auto_increment,
posted_by varchar(100) not null,
post_pictur varchar(100) not null,
post_caption text not null,
location varchar(100),
foreign key (posted_by) references user(username),
posted_at timestamp default current_timestamp);

insert into post(id, posted_by, post_pictur, post_caption, location)
values
('1', 'a1', 'pic1','Happy Diwali','Delhi'),
('2', 'a2', 'pic2','Very Good','Bengaluru'),
('3', 'a2', 'pic3','Happy Birthday','Pune'),
('4', 'a3', 'pic4','Feeling bad','Chennai'),
('5', 'a3', 'pic5','Happy Dashera','Bengaluru');

select * from post;

create table followers(
follower_id varchar(100) not null,
following_id varchar(100) not null,
followed_at timestamp default current_timestamp,
primary key (follower_id, following_id),
foreign key (follower_id) references user(username),
foreign key (following_id) references user(username));

insert into followers(follower_id, following_id)
values
('a1','a2'),
('a1', 'a3'),
('a2', 'a1'),
('a2', 'a3'),
('a3', 'a1'),
('a3', 'a2');

select * from followers;

create table comments(
id int primary key auto_increment,
post_id int not null,
user_id varchar(100) not null,
reply_to int,
comment_message varchar(100) not null,
comment_at timestamp default current_timestamp,
foreign key (user_id) references user(username),
foreign key (reply_to) references comments(id),
foreign key (post_id) references post(id));

insert into comments(post_id, user_id, comment_message)
values
('1','a1','Same to You'),
('2','a2','Nice'),
('2','a1','awsom'),
('3','a2','Thanks'),
('4','a3','so sad'),
('5','a3','same as happy dashera');

select * from comments;

create table likes (
id int primary key auto_increment,
post_id int not null,
like_at timestamp default current_timestamp,
foreign key (post_id) references post(id));

-- DQL--
desc user;  
select * from user;

select * 
from user
where username='a2';

-- retrive all recordes shoted by column name in decending order--

select * from user order by username desc; -- IT WILL COME IN DECENDING ORDER--

-- Group data with group by--
-- count the number of user in each department--
select username, count(*) AS user_count
from user
group by username;

-- Filter grouped data with having
-- Retrive column name with more than 3 user--
select username, count(*) AS user_count
from user
group by username
having user_count > 3; -- cont come any column count bcz in user there are one user individual id and information--

 






















