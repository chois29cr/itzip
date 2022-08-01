  
create table userinfo
(
	uno int not null auto_increment primary key,
	name varchar(20),
	email varchar(100),
	pw varchar(100),
	phone varchar(20),
	texture varchar(20),
	file varchar(256),
	isadmin varchar(2) default 'N'
) default charset="utf8";

insert into userinfo (name, email, pw, phone, texture, file, isadmin) values ('잠코딩', 'onyu0918@naver.com', md5('12345678'), '01000000000', 'vin', 'blue.png', 'N');

create table myroom
(
	no int not null auto_increment primary key,
	uno int,
	title varchar(100),
	body text,
	name varchar(20),
	date datetime,
	hit int,
	foreign key (uno) references userinfo(uno) on delete cascade
) default charset="utf8";

create table qna
(
	qno int not null auto_increment primary key,
	uno int,
	title varchar(100),
	body text,
	name varchar(20),
	date datetime,
	hit int,
	ncheck varchar(2) default 'N',
	foreign key (uno) references userinfo(uno) on delete cascade
) default charset="utf8";

create table classboard
(
	cno int not null auto_increment primary key,
	uno int,
	title varchar(100),
	body text,
	name varchar(20),
	date datetime,
	hit int,
	feed varchar(200),
	foreign key (uno) references userinfo(uno) on delete cascade	
) default charset="utf8";

create table mattach
(
	mno int not null auto_increment primary key,
	uno int,
	no int,
	mattach varchar(256),
	foreign key (uno) references userinfo(uno) on delete cascade,
	foreign key (no) references myroom(no) on delete cascade
) default charset="utf8";

create table mrelike
(
	lno int not null auto_increment primary key,
	uno int,
	no int,
	likecheck varchar(2) default 'N',
	foreign key (uno) references userinfo(uno) on delete cascade,
	foreign key (no) references myroom(no) on delete cascade	
)  default charset="utf8";

create table mreply
(
	mreno int not null auto_increment primary key,
	uno int,
	no int,
	mre text,
	mrename varchar(20),
	mredate datetime,
	foreign key (uno) references userinfo(uno) on delete cascade,
	foreign key (no) references myroom(no) on delete cascade
) default charset="utf8";


create table qreply
(
	qreno int not null auto_increment primary key,
	uno int,
	qno int,
	qre text,
	qrename varchar(20),
	qredate datetime,
	foreign key (uno) references userinfo(uno) on delete cascade,
	foreign key (qno) references qna(qno) on delete cascade	
) default charset="utf8";


create table dcattach
(
	dcno int not null auto_increment primary key,
	uno int,
	cno int,
	dcattach varchar(256),
	foreign key (uno) references userinfo(uno) on delete cascade,
	foreign key (cno) references classboard(cno) on delete cascade
) default charset="utf8";


create table creply
(
	creno int not null auto_increment primary key,
	uno int,
	cno int,
	cre text,
	crename varchar(20),
	credate datetime,
	foreign key (uno) references userinfo(uno) on delete cascade,	
	foreign key (cno) references classboard(cno) on delete cascade
) default charset="utf8";

create table student
(
	sno int not null auto_increment primary key,
	uno int,
	cno int,
	name varchar(20),
	phone varchar(20),
	date datetime,
	title varchar(100),
	image varchar(256),
	email varchar(100),
	foreign key (uno) references userinfo(uno) on delete cascade,
	foreign key (cno) references classboard(cno) on delete cascade
) default charset="utf8";


create table classpick
(
	pno int not null auto_increment primary key,
	uno int,
	cno int,
	pickcheck varchar(2) default 'N',
	foreign key (uno) references userinfo(uno) on delete cascade,
	foreign key (cno) references classboard(cno) on delete cascade
) default charset="utf8";