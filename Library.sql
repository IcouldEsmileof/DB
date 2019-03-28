/*kontrolno 1 31.03.2018*/
/*not tested*/

drop database if exists Library;

create database Library;
use Library;

create table roles(
	id int auto_increment primary key,
    roleName varchar(255) not null
);

create table users(
	id int auto_increment primary key,
    name varchar(255) not null,
    egn varchar(10) not null unique,
    pass varchar(255) not null unique,
    phone varchar(15),
    email varchar(255),
    role_id int not null,
    
    constraint foreign key(role_id) references roles(id)
);

create table publishers(
	id int auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null
);

create table auters(
	id int auto_increment primary key,
    name varchar(255) not null,
    info blob
);

create table genres(
	id int auto_increment primary key,
    name varchar(255) not null
);

create table books(
	id int auto_increment primary key,
    title varchar(255) not null,
    description blob,
    publisher_id int not null,
    
    constraint foreign key(publisher_id) references publishers(id)
);

create table book_auters(
	book_id int not null,
    auter_id int not null,
    
    constraint foreign key(book_id) references books(id),
    constraint foreign key(auter_id) references auters(id),
    constraint primary key(book_id,auter_id)
);

create table book_genres(
	book_id int not null,
    genre_id int not null,
    
    constraint foreign key(book_id) references books(id),
    constraint foreign key(genre_id) references genres(id),
    constraint primary key(book_id,genre_id)
);

create table user_book(
	id int auto_increment primary key,
    date datetime not null,
    user_id int not null,
    book_id int not null,
    
    constraint foreign key(user_id) references users(id),
    constraint foreign key(book_id) references books(id)
);

select book.title as Book, book.description as Description, publisher.name as Publisher, auter.name as Auter, genre.name as Genre
from Books as book
join Publishers as publisher on publisher.id=book.publisher_id
join book_auters on book.id=book_auters.book_id
join auters as auter on book_auters.auter_id=auter.id
join book_genres on book_genres.book_id=book.id
join genres as genre on book_genres.genre_id=genre.id;

select count(book.id) as Count, user.name as User, user.phone as Phone, user.email as Email
from Books as book
join Publishers as publisher on book.publisher_id=publisher.id
join user_book on user_book.book_id=book.id
join users as user on user.id=user_book.user_id
where publisher.name='TU-Sofia'
group by user.id,user.name,user.phone,user.email
having Count>2;