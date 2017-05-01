use image_management;

drop table tbl_attach;
drop table tbl_user;

create table tbl_user(
	uid varchar(50) not null,
	upw varchar(50) not null,
	uname varchar(50) not null,
	uemail varchar(50) not null,
	uphone varchar(50) not null,
	primary key(uid)
)

select * from tbl_user;

delete from tbl_user where uid = 'adf';

create table tbl_attach(
	fullname varchar(150) not null,
	uid varchar(50) not null,
	folder varchar(50),
	regdate timestamp default now(),
	primary key(fullname)
)

alter table tbl_attach add constraint fk_board_attach
foreign key (uid) references tbl_user(uid);

select * from tbl_attach;

select * from tbl_attach 
where folder='directory' and uid = 'test1'
order by folder asc;

select distinct folder from tbl_attach 
where folder is not null and uid = 'test1'
order by folder asc;

select * from tbl_attach where uid = 'test1';
delete from tbl_attach;

insert into tbl_attach(fullname, uid) values('abc', 'test1');