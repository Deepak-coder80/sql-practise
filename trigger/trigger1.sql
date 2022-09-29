-- trigger

create database trigger_mark;
use trigger_mark;

create table students_mark(
	s_id int primary key,
    s_name varchar(255),
    mark1 int,
    mark2 int,
    mark3 int,
    total int
);

delimiter #
create trigger update_auto  before insert on students_mark for each row
begin
	set new.total = new.mark1+new.mark2+new.mark3;
end #

delimiter ;


insert into students_mark(s_id,s_name,mark1,mark2,mark3) values (2,'armin',22,85,228);


select * from students_mark;