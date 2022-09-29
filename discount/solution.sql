create database discounts;
use discounts;

create table discountTable(
	category varchar(255) primary key,
    discount int
);

create table customerTable(
	CID int primary key,
    customerName varchar(255),
    dop date,
    cust_category varchar(255),
    price double,
    p_afdis double,    
    foreign key(cust_category) references discountTable(category)    
);

insert into discountTable values
	('Men',25),('Ladies',30),('Kids',35);
    
insert into customerTable(CID,customerName,dop,cust_category,price) values
	(121,'Avanthika','2022-12-12','Kids',1200),
    (122,'Gregory','2020-09-11','Men',2500),
    (123,'Sara','2021-04-12','Ladies',3000),(124,'Ajay','2021-07-09','Men',1000);
    
select * from customerTable;
select * from discountTable;

-- 1.
delimiter #
create procedure updatePrice()
begin
declare is_done int default 0;
declare dis int;
declare price_read double;
declare cid_read int;
declare dis_price double;
declare final_price double;
declare cur1 cursor for select CID,price,discount from customerTable, discountTable 
where (customerTable.cust_category=discountTable.category) ;
declare continue handler for not found set is_done = 1;
open cur1;
get_data:loop
fetch cur1 into cid_read,price_read,dis;
if is_done = 1 then leave get_data;
end if;
set dis_price = (price_read * dis)/100;
set final_price = price_read - dis_price;
if final_price<800 then set final_price = 800 ;
end if;
update customerTable set p_afdis = final_price where customerTable.CID=cid_read;
end loop get_data;
close cur1;
end #

delimiter ;

call updatePrice();

-- 2.
select CID,customerName,discount from 
customerTable,discountTable where (customerTable.cust_category=discountTable.category and customerTable.price > 2000);

-- 3.
select * from customerTable where (year(dop)=2021 and price < 2000);