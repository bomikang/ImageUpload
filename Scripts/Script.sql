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
	uno int not null,
	regdate timestamp default now(),
	primary key(fullname)
)

alter table tbl_attach add constraint fk_board_attach
foreign key (uno) references tbl_user(uno);