CREATE DATABASE subjects;
use subjects;

create table studentTable(
	StudentID INT primary key,
    StudentName VARCHAR(255),
    ElectiveID INT,
    Branch VARCHAR(255)
);

create table subjectTable(
	SubjectID INT primary key,
    SubjectName varchar(255),
    TeachersName varchar(255),
    nRS int
);

insert into studentTable values 
			(3001,'Archana',11,'Botany'),(3002,'Bobby',12,'Physics'),(3003,'Allen',11,'Zoology'),(3004,'Gauri',11,'Mathematics'),
            (3005,'Hannah',12,'Botany'),(3006,'Laya',14,'Botany'),(3007,'George',13,'Mathematics'),(3008,'Priya',13,'Chemistry'),
            (3009,'Mathew',14,'Chemistry'),(3010,'Nazreen',12,'Zoology'),(3011,'Sunina',11,'Botany'),(3012,'Rahul',12,'Physics');
            
select * from studentTable;

insert into subjectTable(SubjectID,SubjectName,TeachersName) values (11,'Fungi and Plant Viruses','Priyanga'),(12,'Bisphere','Sreya'),
(13,'Probability and Statistics','Bhasker'),(14,'Electromagnetism and Photonics','Akhil');

select * from subjectTable;

-- 1.Create a stored procedure to update the subject table
delimiter #
select * from studentTable #
create procedure updatesT()
begin
	declare coutid11 int default 0;
    declare coutid12 int default 0;
    declare coutid13 int default 0;
    declare coutid14 int default 0;
    declare eid int;
    declare is_done int default 0;
    declare cur cursor for select ElectiveID from studentTable;
    declare continue handler for not found set is_done = 1;
    open cur;
    get_data:loop
    fetch cur into eid;
    if is_done = 1 then leave get_data;
    end if;
    if eid = 11 then set countid11 = countid11+1;
	end if;
    if eid = 12 then set countid12 = countid12+1;
	end if;
    if eid = 13 then set countid13 = countid13+1;
	end if;
    if eid = 14 then set countid14 = countid14+1;
	end if;
    end loop get_data;
    update subjectTable set nRS=countid11 where subjectTable.SubjectID = 11;
     update subjectTable set nRS=countid12 where subjectTable.SubjectID = 12;
      update subjectTable set nRS=countid13 where subjectTable.SubjectID = 13;
       update subjectTable set nRS=countid14 where subjectTable.SubjectID = 14;
end #

delimiter ;


-- 2. display details of Botany students who have opted 'Fungi and Plant viruses' as elective
select StudentID,StudentName,Branch from studentTable where ElectiveID IN (SELECT SubjectID from subjectTable where SubjectName='Fungi and Plant Viruses');

-- 3.
select * from subjectTable where nRS in (select max(nRS) from subjectTable);