create database vechicle;
use vechicle;

create table customerTable(
	CustomerID int primary key,
    park_date date,
    CustomerName varchar(255),
    vechicleNo varchar(255),
    hours int,
    parkingFee int
);

create table feeTable(
	Hours int primary key,
    amount int 
);

insert into feeTable values (2,30),(3,50),
					(4,100),(5,150),(6,200);
                    
insert into customerTable(CustomerID,park_date,CustomerName,vechicleNo) values 
			(121,'2022-07-09','Priya','KL39N6382'),
            (122,'2022-07-13','John','KL44F5036'),
            (123,'2022-07-24','Meenakshi','KL25D1744'),
            (124,'2022-07-30','Suhani','KL24C9334'),
            (125,'2022-08-04','Arman','KL39F3999'),
            (126,'2022-08-17','Anjali','KL39G1076'),
            (127,'2022-08-21','Poppy','KL34F9408');
            
 
  delimiter #
create procedure updateCT(hinput int,cid int)
     begin
     declare is_done int default 0;
     declare amount_read int default 0;
     declare amount_pay int default 0;
	 declare cur cursor for select amount from feeTable where Hours=hinput;
     declare continue handler for not found set is_done = 1;
    if hinput <= 1 then
     update customerTable set hours=hinput where customerTable.CustomerID=cid;
	 update customerTable set parkingFee=0 where customerTable.CustomerID=cid;
    end if;
    if hinput > 1 then   
    open cur;
    get_paid:loop
    fetch cur into amount_read;
    if is_done = 1 then leave get_paid;
    end if;
    set amount_pay = amount_read;
     update customerTable set parkingFee=amount_pay where customerTable.CustomerID=cid;
    update customerTable set hours=hinput where customerTable.CustomerID=cid;
    end loop;
    end if;
    close cur;
    end #
    
delimiter ;

call  updateCT(2,127);

-- 2.
select * from customerTable where parkingFee in 
	(select max(parkingFee) from customerTable);
  

-- 3. 
select * from customerTable where monthname(park_date)='july';