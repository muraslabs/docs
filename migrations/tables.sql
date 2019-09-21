create schema if not exists instagram collate utf8_general_ci;

create table if not exists users
(
	id int auto_increment
		primary key,
	fullname varchar(50) not null,
	username varchar(5) not null,
	password char(40) not null,
	phone_number varchar(10) null,
	email varchar(250) not null,
	description text null,
	profile_picture varchar(250) null,
	timestamp timestamp null,
	constraint email
		unique (email),
	constraint email_2
		unique (email),
	constraint email_3
		unique (email)
);

create table if not exists followers
(
	id int auto_increment
		primary key,
	follower_id int not null,
	followee_id int not null,
	constraint followers_ibfk_1
		foreign key (follower_id) references users (id),
	constraint followers_ibfk_2
		foreign key (followee_id) references users (id)
);

create index followee_id
	on followers (followee_id);

create index follower_id
	on followers (follower_id);

create table if not exists likes
(
	id int auto_increment
		primary key,
	like_type varchar(10) not null,
	commment_or_post_id int not null,
	user_id int not null,
	constraint likes_ibfk_1
		foreign key (user_id) references users (id)
			on delete cascade
);

create index user_id
	on likes (user_id);

create table if not exists posts
(
	id int auto_increment
		primary key,
	author_id int not null,
	media varchar(250) not null,
	description text null,
	location varchar(250) null,
	timestamp timestamp default CURRENT_TIMESTAMP null,
	constraint posts_ibfk_1
		foreign key (author_id) references users (id)
);

create index author_id
	on posts (author_id);

-- Cyclic dependencies found

create table if not exists comments
(
	id int auto_increment,
	text text not null,
	author_id int not null,
	parent_comment_id int not null,
	post_id int null,
	constraint id
		unique (id),
	constraint comments_ibfk_1
		foreign key (author_id) references users (id),
	constraint comments_ibfk_2
		foreign key (parent_comment_id) references comments (id)
			on delete cascade
);

create index author_id
	on comments (author_id);

create index parent_comment_id
	on comments (parent_comment_id);

alter table comments
	add primary key (id);

