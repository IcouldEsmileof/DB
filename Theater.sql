/*http://javac.bg/?p=537*/

drop database if exists Theater;

create database Theater;
use Theater;

/*zad 1*/
create table producers(
	id int auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    bulstat varchar(255) not null unique
);

create table Studios(
	id int auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null unique,
    bulstat varchar(255) unique
);

create table Actors(
	id int auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    gender varchar(50) not null,
    dateOfBirth date not null
);

create table Films(
	id int auto_increment primary key,
    name varchar(255) not null unique,
    madeIn year not null,
    lenght double not null,
    budget double not null,
    studio_id int not null,
    producer_id int not null,
    
    constraint foreign key(studio_id) references Studios(id),
    constraint foreign key(producer_id) references Producers(id)
);

create table Film_Actors(
	film_id int not null,
    actor_id int not null,
    
    constraint foreign key(film_id) references Films(id),
    constraint foreign key(actor_id) references Actors(id),
    constraint primary key(film_id,actor_id)
);
INSERT INTO `studios` (`address`, `name`, `bulstat`)
VALUES ('Sofia, Boris str. 56', 'Studio Diana', '1112221'),
('London, Everest str. 355', 'Studio Express', '1457458'),
('Berlin, Kernigan str. 455', 'Studio Europa', '1114452');

INSERT INTO producers(address, bulstat, name)
VALUES("London, Safary str. 477", "12124545", "John Smith"),
("Sofia, Opalchenska str. 78", '12541250',"Erna & Dina EOOD"),
("Paris, Earoh str. 626", '14514520',"Exctravaganzza Trading");

INSERT INTO actors(name, address, gender, dateOfBirth)
VALUES("Robert de Niro", "London, JMS str. 346", 'M','1943-08-17'),
("Arnold Schwarzenegger", "London, Monacco str. 478", 'M','1947-07-30'),
("Stoyanka Mutafova", "Sofia, Tsar Boris str. 45", 'F','1922-02-02');

INSERT INTO Films(name, madeIn, budget, lenght, studio_id, producer_id)
VALUES("Greetings",1968,5000000,120.0,2,3),
("Juniour",1994,50000000,115.0,3,1),
("If somebody loves you",2010,500000,90.0,1,2);

INSERT INTO Film_actors(actor_id,film_id)
VALUES(1,1),
(2,2),
(1,2),
(3,3);
/*zad 2*/

select * from Actors
where lower(gender)='m' or address like '%Sofia%';

select * from Films 
where madeIn between 1990 and 2000
order by budget desc 
limit 3;

/*zad 3*/
select film.name ,actor.name
from Films as film
join Film_Actors on Film_Actors.film_id=film.id
join Actors as actor on Film_Actors.actor_id=actor.id
join Studios on film.studio_id=Studios.id
where Studios.name='IFS-200';

select film.name, studio.name, producer.name
from Films as film
join Studios as studio on film.studio_id=studio.id
join Producers as producer on film.producer_id=producer.id;

/*zad 4*/

select actor.name as Actor, film.name as Film, min(film.budget) as budget 
from Actors as actor
join Film_Actors on Film_Actors.actor_id=actor.id
join Films as film on Film_Actors.film_id=film.id
group by actor.id, film.id, Actor, Film, film.budget
having film.budget=budget
order by film.budget;

select actor.name as Actor, avg(film.lenght) as AvrageLen
from Actors as actor
join Film_Actors on Film_Actors.actor_id=actor.id
join Films as film on Film_Actors.film_id=film.id
where film.id in (
					select Films.id 
					from Films 
					where Films.lenght>(select avg(Films.lenght) 
										from Films 
										where Films.madeIn>2000)
					)
group by actor.id, Actor;
                    
                    
/*dop zad*/

select actor.name as Actor 
from Actors as actor
join Film_Actors on Film_Actors.actor_id=actor.id
join Films as film on Film_Actors.film_id=film.id
where film.name='MGM';

select producer.name as Producer, film.name as Film
from Films as film
join Producers as producer on film.producer_id=producer.id
where producer.id in (select Films.producer_id 
					from Films
                    where Films.name='Star Wars');
                    
select actor.name as Actor
from Actors as actor
where actor.id not in (select actor_id from Film_Actors);

select actor.name as Actor, count(film_id) as Films
from Actors as actor
join Film_Actors on Film_Actors.actor_id=actor.id
order by Films
limit 1;

select actor.name as Actor, count(film_id) as Films
from Actors as actor
join Film_Actors on Film_Actors.actor_id=actor.id
order by Films desc ,actor.dateOfBirth
limit 1;


/*zad 3 ot primerna kursova rabota*/
select film.*
from Films as film
join Producers as producer on film.producer_id=producer.id
where producer.name='John Smith';