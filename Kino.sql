/*https://www.cphpvb.net/db/9666-18-04-2015-1/*/

drop database if exists Theaters;

create database Theaters;
use Theaters;

create table Theater(
	id int auto_increment primary key,
    name varchar(255) not null unique,
    city varchar(255) not null,
    
    constraint unique(name,city)
);

create table Movies(
	id int auto_increment primary key,
    name varchar(255) not null unique,
    year year not null,
    country varchar(255) not null
);

create table Screens(
	num int not null,
    type enum('normal','deluxe','VIP') not null,
    theater_id int not null,
    
    constraint foreign key(theater_id) references Theater(id),
    constraint primary key(num,theater_id)
);

create table Shows(
	time datetime not null,
    visitors int not null,
    movie_id int not null,
    screen_num int not null,
    screen_theater_id int not null,
    
    constraint foreign key(movie_id) references Movies(id),
    constraint foreign key(screen_num,screen_theater_id) references Screens(num,theater_id),
    constraint primary key(time,screen_num,screen_theater_id)
);

select kino.name as Kino, zala.num as Zala, shows.time as Chas
from Theater as kino
join Screens as zala on zala.theater_id=kino.id
join Shows as shows on shows.screen_num=zala.num and shows.screen_theater_id=zala.theater_id
join Movies as film on shows.movie_id=film.id
where film.name='Fast and furious 7' and (zala.type='deluxe' or zala.type='VIP')
order by kino.name,zala.num;

select sum(shows.visitors) as Posetiteli
from Shows as shows
join Movies as film on shows.movie_id=film.id
join Screens as zala on shows.screen_num=zala.num and shows.screen_theater_id=zala.theater_id
join Theater as kino on kino.id=zala.theater_id
where film.name = 'Fast and furious 7' and kino.name='Arena Mladost' and zala.type='VIP';

