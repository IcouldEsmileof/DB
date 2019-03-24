create database newssite;
use newssite;

create table person(
	id int auto_increment primary key,
    name varchar(255),
    userName varchar(255) not null unique,
    pass varchar(255) not null
);

create table auters(
	id int auto_increment primary key,
    person_id int not null unique,
    constraint foreign key(person_id) references person(id)
);

create table clients(
	id int auto_increment primary key,
    person_id int not null unique,
    constraint foreign key(person_id) references person(id)
);

create table statia(
	id int auto_increment primary key,
    header varchar(255),
    auter_id int not null unique,
    publishedOn datetime not null,
    text text not null,
    typeOfStatia enum('Crime','Sport','International','Other'),
    
    constraint foreign key (auter_id) references auters(id)
);

create table coments(
	id int auto_increment primary key,
    text text not null,
    client_id int not null,
    publishedOn datetime not null,
	statia_id int not null,
    
    constraint foreign key(statia_id) references statia(id),
    constraint foreign key(client_id) references clinets(id)
);

create table images(
	id int auto_increment primary key,
    imageAdress varChar(255),
    statia_id int not null,
    
    constraint foreign key (statia_id) references statia(id)
);
create table managers(
	id int auto_increment primary key,
    person_id int not null unique,
    constraint foreign key(person_id) references person(id)
);

create table admins(
	id int primary key,
    person_id int not null unique,
    constraint foreign key(person_id) references person(id)
);