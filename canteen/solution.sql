create database bill_mangement;

use bill_mangement;

create table Menu(
	Item_ID int primary key,
    Item_Name varchar(255),
    Item_Price int
);

create table Bill(
	Bill_ID int primary key,
    Customer_name varchar(255),
    Item_PID int ,
    count_Item int,
    dop date,
    total_price double,
    foreign key(Item_PID) references Menu(Item_ID)
);

insert into Menu values (1,'Tea',10),(2,'Coffee',12),(3,'Veg Meals',35),(4,'Fish Curry Meals',50),(5,'Snacks',10),(6,'Juice',20),
(7,'Ice Cream',10);

insert into Bill(Bill_ID,Customer_name,Item_PID,count_Item,dop)values
		(11,'Andrea',7,2,'2022-08-08'),(13,'Rayan',5,4,'2022-08-08'),(15,'Georgy',4,2,'2022-08-09'),
        (12,'Johan',6,3,'2022-08-08'),(14,'Irene',7,5,'2022-08-08'),(16,'Kenaz',7,1,'2022-08-09');
        
select * from Bill;
select * from Menu;
select Bill_ID,Item_Name,count_Item,Item_Price from Bill b,Menu m where b.Item_PID=m.Item_ID;

-- 1.
delimiter #
create procedure updateTotal()
begin
declare count_read int;
declare price_read int;
declare total double;
declare billid int;
declare is_done int default 0;
declare cur cursor for select Bill_ID,count_Item,Item_Price from Bill b,Menu m where b.Item_PID=m.Item_ID;
declare continue handler for not found set is_done = 1;
open cur;
get_data:loop
fetch cur into billid,count_read,price_read;
if is_done = 1 then leave get_data;
end if;
set total = count_read * price_read;
update Bill set total_price = total where Bill.Bill_ID=billid;
end loop get_data;
close cur;
end #
delimiter ;

call updateTotal();

-- 2
select Item_PID,Item_name,sum(count_Item) as total_count from Bill  b,Menu m where b.Item_PID=m.Item_ID and m.Item_Name = 'Ice Cream' and 
b.dop = date('2022-08-08');
-- 3
select sum(total_price) as total_collection from Bill where dop = date('2022-08-09') ;