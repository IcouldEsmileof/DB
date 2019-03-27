/*http://javac.bg/?p=570*/

drop database if exists gallery;
create database gallery;
use gallery;
create table goods(
good_no int primary key auto_increment,
name varchar(100),
price decimal null default null,
size varchar(100) null default null,
type ENUM('1','2','3') not null,
year year null default null,
artist_id int null default null
)Engine = InnoDb;

create table person(
id int primary key auto_increment,
name varchar(255) not null,
address varchar(255),
phone varchar(15),
isArtist boolean default 0
)Engine = InnoDb;

ALTER table goods
add constraint foreign key (artist_id) references person(id);

create table services(
id int primary key auto_increment,
finalPrice decimal not null default 0,
type ENUM('1','2','3') not null default 3,
dateCreated datetime not null,
endDate datetime null default null,
comment varchar(255) null default null,
size varchar(200) null default null,
empl_name varchar(200) not null,
isReady boolean default 0,
isReceived boolean default 0,
good_id int null default null,
constraint foreign key (good_id) references goods(good_no),
customer_id int not null,
constraint foreign key (customer_id) references person(id),
artist_id int null default null,
constraint foreign key (artist_id) references person(id)
)Engine = InnoDb;
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`) 
VALUES ('Ivan Ivanov', 'Sofia', '0894512', 0);
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`) 
VALUES ('Georgi Martinov', 'Sofia', '087452', 1);
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`)
VALUES ('Stefan Dimov', 'Sofia', '0785421', 1);
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`)
VALUES ('Iordan Metodioev', 'Sofia', '0874512', 0);


INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`)
 VALUES ('Mona Liza', '4500', '77 ? 53 cm', '1',null);
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`, `artist_id`) 
VALUES ('Kone na vodopoi', '250', '40X80', '1', 2000, '2');
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`) 
VALUES ('Ramka ot dyb', '100', '20X22', '2', 2015);
INSERT INTO `gallery`.`goods` (`name`, `price`,`type`, `year`) 
VALUES ('Vaza - monblan', '100','3', 2015);
INSERT INTO `gallery`.`goods` ( `name`, `price`, `size`,`type`, `year`) 
VALUES ('Ramka ot bor', '80', 'y X y cm' ,'2', 2016);
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`,`type`, `year`) 
VALUES ('Ramka ot qsen', '90', 'y X y cm','2', 2016);


INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `comment`, `empl_name`, `isReceived`, `good_id`, `customer_id`) 
VALUES ('250', '3', '2016-04-08 17:10:22', 'Vaza-1br', 'Ivan', '1', '4', '1');
INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`) 
VALUES ('115', '1', '2016-04-08 17:10:22', '2016-05-08 17:10:22', 'RIsunkata e v profil', '200X150', 'Ivan', '0', '0', '5', '1');
UPDATE `gallery`.`services` SET `endDate`='2016-04-08 17:10:22' WHERE `id`='1';

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('200', '2', '2016-04-08 17:10:22', '2016-05-08 17:10:22', 'risuwane w profil', '200x200', 'Ivan', '0', '0', '6', '1', '2');
UPDATE `gallery`.`services` SET `comment`='ramkata e staral' WHERE `id`='2';

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('300', '2', '2016-04-08 17:10:22', '2016-06-08 17:10:22', 'sds', '200X300', 'Ivan', '0', '0', '6', '1', '3');

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('280', '2', '2016-04-08 17:10:22', '2016-04-11 17:10:22', 'nqma', '80X200 cm', 'Petyr', '1', '1', '3', '1', '2');
INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('300', '2', '2016-04-01 17:10:22', '2016-04-11 17:10:22', 'profil', '180X250', 'Petyr', '1', '1', '3', '4', '3');


INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('310', '2', '2016-04-01 17:10:22', '2016-04-10 17:10:22', 'portret', '200X250', 'Petyr', '1', '1', '3', '1', '3');




select s.*, artist.name 
from services as s
join person as customer on s.customer_id=customer.id
join person as artist on s.artist_id=artist.id
where s.type=2 and s.isReady=1 and s.isReceived=1 and customer.name='Ivan Ivanov';

select customer.name as Customer, sum(finalPrice) as TotalSum
from person as customer
join services as s on s.customer_id=customer.id
where s.isReady=1 and s.isReceived=1
group by customer.name
having TotalSum>(select avg(finalPrice) from services)
order by customer.name
limit 6;
