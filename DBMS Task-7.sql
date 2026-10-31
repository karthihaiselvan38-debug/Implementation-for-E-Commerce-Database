
create database  ecommerce_db;
use ecommerce_db;

create table customers (
    customer_id int primary key,
    customer_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(15),
    city varchar(50),
    registration_date date
);

create table categories (
    category_id int primary key,
    category_name varchar(100) not null
);

create table products (
    product_id int primary key,
    product_name varchar(100) not null,
    category_id int,
    price decimal(10,2) not null,
    stock_quantity int not null,
    foreign key (category_id) references categories(category_id),
    check (price > 0),
    check (stock_quantity >= 0)
);

create table orders (
    order_id int primary key,
    customer_id int not null,
    order_date date not null,
    total_amount decimal(10,2),
    order_status varchar(30),
    foreign key (customer_id) references customers(customer_id)
);

create table order_details (
    order_detail_id int primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    price decimal(10,2) not null,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id),
    check (quantity > 0)
);

create table payment (
    payment_id int primary key,
    order_id int not null unique,
    payment_mode varchar(30),
    payment_status varchar(30),
    transaction_amount decimal(10,2),
    foreign key (order_id) references orders(order_id)
);

create table review (
    review_id int primary key,
    customer_id int not null,
    product_id int not null,
    rating int not null,
    review_text varchar(500),
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id),
    check (rating between 1 and 5)
);

insert into customers values
(1, 'arun', 'arun@gmail.com', '9876543210', 'chennai', '2026-01-10'),
(2, 'bala', 'bala@gmail.com', '9876543211', 'bangalore', '2026-02-15'),
(3, 'divya', 'divya@gmail.com', '9876543212', 'madurai', '2026-03-20'),
(4, 'kumar', 'kumar@gmail.com', '9876543213', 'chennai', '2026-04-12'),
(5, 'priya', 'priya@gmail.com', '9876543214', 'coimbatore', '2026-05-18');

insert into categories values
(1, 'electronics'),
(2, 'fashion'),
(3, 'home appliances'),
(4, 'accessories');

insert into products values
(101, 'samsung mobile', 1, 25000, 20),
(102, 'iphone mobile', 1, 60000, 15),
(103, 'headphone', 4, 1500, 30),
(104, 'laptop', 1, 45000, 10),
(105, 't-shirt', 2, 800, 50),
(106, 'smart watch', 4, 3000, 25),
(107, 'washing machine', 3, 30000, 5),
(108, 'mouse', 4, 500, 0);

insert into orders values
(201, 1, '2026-10-20', 25000, 'completed'),
(202, 2, '2026-10-21', 60000, 'completed'),
(203, 3, '2026-10-22', 1500, 'pending'),
(204, 4, '2026-10-23', 45000, 'cancelled'),
(205, 5, '2026-10-24', 3000, 'completed'),
(206, 1, '2026-10-25', 800, 'pending');

insert into order_details values
(1, 201, 101, 1, 25000),
(2, 202, 102, 1, 60000),
(3, 203, 103, 1, 1500),
(4, 204, 104, 1, 45000),
(5, 205, 106, 1, 3000),
(6, 206, 105, 1, 800);

insert into payment values
(1, 201, 'upi', 'success', 25000),
(2, 202, 'credit card', 'success', 60000),
(3, 203, 'debit card', 'pending', 1500),
(4, 204, 'net banking', 'failed', 45000),
(5, 205, 'cash on delivery', 'success', 3000),
(6, 206, 'upi', 'pending', 800);

insert into review values
(1, 1, 101, 5, 'excellent mobile'),
(2, 2, 102, 4, 'good quality'),
(3, 3, 103, 3, 'average sound'),
(4, 4, 104, 5, 'very good laptop'),
(5, 5, 106, 4, 'nice smartwatch'),
(6, 1, 101, 5, 'excellent performance');

select * from customers;

select * from products
where stock_quantity > 0;

select product_name, price
from products;

select * from orders;



select * from payment;

select * from products
where price > 5000;

select * from products
where stock_quantity > 0;

select * from customers
where city = 'chennai';

select * from orders
where order_status = 'completed';

select p.product_name, r.rating
from products p
join review r
on p.product_id = r.product_id
where r.rating > 4;

select * from products
order by price asc;

select * from customers
order by customer_name asc;

select * from products
order by price desc;

select * from orders
order by order_date desc;

select distinct category_name
from categories;

select distinct payment_mode
from payment;
select distinct city
from customers;

select * from products
where price between 1000 and 5000;

select p.product_name, p.price, c.category_name
from products p
join categories c
on p.category_id = c.category_id
where c.category_name = 'electronics';

select product_name, stock_quantity
from products
where stock_quantity > 0;

select * from products
where product_name like '%mobile%';

select * from products
where stock_quantity < 10;

select
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
from customers c
join orders o
on c.customer_id = o.customer_id;

select
    p.product_id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
from products p
join categories c
on p.category_id = c.category_id;

select distinct
    c.customer_name,
    p.product_name
from customers c
join orders o
on c.customer_id = o.customer_id
join order_details od
on o.order_id = od.order_id
join products p
on od.product_id = p.product_id
where p.product_id = 101;

select
    c.customer_name,
    p.product_name,
    od.quantity,
    od.price
from customers c
join orders o
on c.customer_id = o.customer_id
join order_details od
on o.order_id = od.order_id
join products p
on od.product_id = p.product_id;

select * from products
where category_id = 1
and price > 10000;

select * from customers
where city = 'chennai'
or city = 'bangalore';

select * from orders
where order_date between '2026-10-20'
and '2026-10-25';

select * from products
where product_name like '%mobile%';

select * from customers
where city in ('chennai', 'bangalore');

select p.product_name, p.price
from products p
join categories c
on p.category_id = c.category_id
where c.category_name = 'electronics'
and p.price > 10000;

select * from orders
where order_date between '2026-10-20'
and '2026-10-25';

select
    product_name,
    price,
    stock_quantity,
    case
        when stock_quantity > 0 then 'available'
        else 'out of stock'
    end as availability_status
from products;

select count(*) as total_customers
from customers;

select city, count(*) as total_customers
from customers
group by city;

select *
from customers
order by registration_date desc;

select count(*) as total_orders
from orders;

select count(*) as completed_orders
from orders
where order_status = 'completed';

select count(*) as pending_orders
from orders
where order_status = 'pending';

select count(*) as cancelled_orders
from orders
where order_status = 'cancelled';

select order_status, count(*) as total_orders
from orders
group by order_status;

select *
from products
order by price desc
limit 5;

select
    p.product_name,
    count(r.review_id) as total_reviews
from products p
left join review r
on p.product_id = r.product_id
group by p.product_id, p.product_name
order by total_reviews desc;

select *
from products
where stock_quantity > 0;

select
    p.product_name,
    round(avg(r.rating), 2) as average_rating
from products p
left join review r
on p.product_id = r.product_id
group by p.product_id, p.product_name;


select sum(total_amount) as total_sales
from orders
where order_status = 'completed';



select
    payment_mode,
    sum(transaction_amount) as total_revenue
from payment
where payment_status = 'success'
group by payment_mode;


select product_name, stock_quantity
from products
where stock_quantity < 10;

select * from customers;
select * from categories;
select * from products;
select * from orders;
select * from order_details;
select * from payment;
select * from review;
