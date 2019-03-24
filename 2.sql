DROP DATABASE IF EXISTS school_sport_clubs;
CREATE DATABASE school_sport_clubs;
USE school_sport_clubs;

CREATE TABLE school_sport_clubs.sports(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE school_sport_clubs.coaches(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL ,
	egn VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE school_sport_clubs.students(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL ,
	egn VARCHAR(10) NOT NULL UNIQUE ,
	address VARCHAR(255) NOT NULL ,
	phone VARCHAR(20) NULL DEFAULT NULL ,
	class VARCHAR(10) NULL DEFAULT NULL   
);

CREATE TABLE school_sport_clubs.sportGroups(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	location VARCHAR(255) NOT NULL ,
	dayOfWeek ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') ,
	hourOfTraining TIME NOT NULL ,
	sport_id INT NOT NULL ,
	coach_id INT NOT NULL ,
	UNIQUE KEY(location,dayOfWeek,hourOfTraining)  ,
	CONSTRAINT FOREIGN KEY(sport_id) 
		REFERENCES sports(id) ,
	CONSTRAINT FOREIGN KEY (coach_id) 
		REFERENCES coaches(id)
);

CREATE TABLE school_sport_clubs.student_sport(
	student_id INT NOT NULL , 
	sportGroup_id INT NOT NULL ,  
	CONSTRAINT FOREIGN KEY (student_id) 
		REFERENCES students(id) ,	
	CONSTRAINT FOREIGN KEY (sportGroup_id) 
		REFERENCES sportGroups(id) ,
	PRIMARY KEY(student_id,sportGroup_id)
);

CREATE TABLE taxesPayments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	student_id INT NOT NULL,
	group_id INT NOT NULL,
	paymentAmount DOUBLE NOT NULL,
	month TINYINT,
	year YEAR,
	dateOfPayment DATETIME NOT NULL ,
	CONSTRAINT FOREIGN KEY (student_id) 
		REFERENCES students(id),
	CONSTRAINT FOREIGN KEY (group_id) 
		REFERENCES sportgroups(id)
);

CREATE TABLE salaryPayments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	coach_id INT NOT NULL,
	month TINYINT,
	year YEAR,
	salaryAmount double,
	dateOfPayment datetime not null,
	CONSTRAINT FOREIGN KEY (coach_id) 
		REFERENCES coaches(id),
	UNIQUE KEY(`coach_id`,`month`,`year`)
);

INSERT INTO sports
VALUES 	(NULL, 'Football') ,
		(NULL, 'Volleyball'),
		(NULL, 'Tennis');
		
INSERT INTO coaches  
VALUES 	(NULL, 'Ivan Todorov Petkov', '7509041245') ,
		(NULL, 'georgi Ivanov Todorov', '8010091245') ,
		(NULL, 'Ilian Todorov Georgiev', '8407106352') ,
		(NULL, 'Petar Slavkov Yordanov', '7010102045') ,
		(NULL, 'Todor Ivanov Ivanov', '8302160980') , 
		(NULL, 'Slavi Petkov Petkov', '7106041278');
		
INSERT INTO students (name, egn, address, phone, class) 
VALUES 	('Iliyan Ivanov', '9401150045', 'Sofia-Mladost 1', '0893452120', '10') ,
		('Ivan Iliev Georgiev', '9510104512', 'Sofia-Liylin', '0894123456', '11') ,
		('Elena Petrova Petrova', '9505052154', 'Sofia-Mladost 3', '0897852412', '11') ,
		('Ivan Iliev Iliev', '9510104542', 'Sofia-Mladost 3', '0894123457', '11') ,
		('Maria Hristova Dimova', '9510104547', 'Sofia-Mladost 4', '0894123442', '11') ,
		('Antoaneta Ivanova Georgieva', '9411104547', 'Sofia-Krasno selo', '0874526235', '10');
		
INSERT INTO sportGroups
VALUES 	(NULL, 'Sofia-Mladost 1', 'Monday', '08:00:00', 1, 1 ) ,
		(NULL, 'Sofia-Mladost 1', 'Monday', '09:30:00', 1, 2 ) ,
		(NULL, 'Sofia-Liylin 7', 'Sunday', '08:00:00', 2, 1) ,
		(NULL, 'Sofia-Liylin 7', 'Sunday', '09:30:00', 2, 2) ,		
		(NULL, 'Plovdiv', 'Monday', '12:00:00', '1', '1');
		
INSERT INTO student_sport 
VALUES 	(1, 1),
		(2, 1),
		(3, 1),
		(4, 2),
		(5, 2),
		(6, 2),
		(1, 3),
		(2, 3),
		(3, 3);
		
INSERT INTO `school_sport_clubs`.`taxespayments` 
VALUES	(NULL, '1', '1', '200', '1', 2015, now()),
		(NULL, '1', '1', '200', '2', 2015, now()),
		(NULL, '1', '1', '200', '3', 2015, now()),
		(NULL, '1', '1', '200', '4', 2015, now()),
		(NULL, '1', '1', '200', '5', 2015, now()),
		(NULL, '1', '1', '200', '6', 2015, now()),
		(NULL, '1', '1', '200', '7', 2015, now()),
		(NULL, '1', '1', '200', '8', 2015, now()),
		(NULL, '1', '1', '200', '9', 2015, now()),
		(NULL, '1', '1', '200', '10', 2015, now()),
		(NULL, '1', '1', '200', '11', 2015, now()),
		(NULL, '1', '1', '200', '12', 2015, now()),
		(NULL, '2', '1', '250', '1', 2015, now()),
		(NULL, '2', '1', '250', '2', 2015, now()),
		(NULL, '2', '1', '250', '3', 2015, now()),
		(NULL, '2', '1', '250', '4', 2015, now()),
		(NULL, '2', '1', '250', '5', 2015, now()),
		(NULL, '2', '1', '250', '6', 2015, now()),
		(NULL, '2', '1', '250', '7', 2015, now()),
		(NULL, '2', '1', '250', '8', 2015, now()),
		(NULL, '2', '1', '250', '9', 2015, now()),
		(NULL, '2', '1', '250', '10', 2015, now()),
		(NULL, '2', '1', '250', '11', 2015, now()),
		(NULL, '2', '1', '250', '12', 2015, now()),
		(NULL, '3', '1', '250', '1', 2015, now()),
		(NULL, '3', '1', '250', '2', 2015, now()),
		(NULL, '3', '1', '250', '3', 2015, now()),
		(NULL, '3', '1', '250', '4', 2015, now()),
		(NULL, '3', '1', '250', '5', 2015, now()),
		(NULL, '3', '1', '250', '6', 2015, now()),
		(NULL, '3', '1', '250', '7', 2015, now()),
		(NULL, '3', '1', '250', '8', 2015, now()),
		(NULL, '3', '1', '250', '9', 2015, now()),
		(NULL, '3', '1', '250', '10', 2015, now()),
		(NULL, '3', '1', '250', '11', 2015, now()),
		(NULL, '3', '1', '250', '12', 2015, now()),
		(NULL, '1', '2', '200', '1', 2015, now()),
		(NULL, '1', '2', '200', '2', 2015, now()),
		(NULL, '1', '2', '200', '3', 2015, now()),
		(NULL, '1', '2', '200', '4', 2015, now()),
		(NULL, '1', '2', '200', '5', 2015, now()),
		(NULL, '1', '2', '200', '6', 2015, now()),
		(NULL, '1', '2', '200', '7', 2015, now()),
		(NULL, '1', '2', '200', '8', 2015, now()),
		(NULL, '1', '2', '200', '9', 2015, now()),
		(NULL, '1', '2', '200', '10', 2015, now()),
		(NULL, '1', '2', '200', '11', 2015, now()),
		(NULL, '1', '2', '200', '12', 2015, now()),
		(NULL, '4', '2', '200', '1', 2015, now()),
		(NULL, '4', '2', '200', '2', 2015, now()),
		(NULL, '4', '2', '200', '3', 2015, now()),
		(NULL, '4', '2', '200', '4', 2015, now()),
		(NULL, '4', '2', '200', '5', 2015, now()),
		(NULL, '4', '2', '200', '6', 2015, now()),
		(NULL, '4', '2', '200', '7', 2015, now()),
		(NULL, '4', '2', '200', '8', 2015, now()),
		(NULL, '4', '2', '200', '9', 2015, now()),
		(NULL, '4', '2', '200', '10', 2015, now()),
		(NULL, '4', '2', '200', '11', 2015, now()),
		(NULL, '4', '2', '200', '12', 2015, now()),
		/**2014**/
		(NULL, '1', '1', '200', '1', 2014, now()),
		(NULL, '1', '1', '200', '2', 2014, now()),
		(NULL, '1', '1', '200', '3', 2014, now()),
		(NULL, '1', '1', '200', '4', 2014, now()),
		(NULL, '1', '1', '200', '5', 2014, now()),
		(NULL, '1', '1', '200', '6', 2014, now()),
		(NULL, '1', '1', '200', '7', 2014, now()),
		(NULL, '1', '1', '200', '8', 2014, now()),
		(NULL, '1', '1', '200', '9', 2014, now()),
		(NULL, '1', '1', '200', '10', 2014, now()),
		(NULL, '1', '1', '200', '11', 2014, now()),
		(NULL, '1', '1', '200', '12', 2014, now()),
		(NULL, '2', '1', '250', '1', 2014, now()),
		(NULL, '2', '1', '250', '2', 2014, now()),
		(NULL, '2', '1', '250', '3', 2014, now()),
		(NULL, '2', '1', '250', '4', 2014, now()),
		(NULL, '2', '1', '250', '5', 2014, now()),
		(NULL, '2', '1', '250', '6', 2014, now()),
		(NULL, '2', '1', '250', '7', 2014, now()),
		(NULL, '2', '1', '250', '8', 2014, now()),
		(NULL, '2', '1', '250', '9', 2014, now()),
		(NULL, '2', '1', '250', '10', 2014, now()),
		(NULL, '2', '1', '250', '11', 2014, now()),
		(NULL, '2', '1', '250', '12', 2014, now()),
		(NULL, '3', '1', '250', '1', 2014, now()),
		(NULL, '3', '1', '250', '2', 2014, now()),
		(NULL, '3', '1', '250', '3', 2014, now()),
		(NULL, '3', '1', '250', '4', 2014, now()),
		(NULL, '3', '1', '250', '5', 2014, now()),
		(NULL, '3', '1', '250', '6', 2014, now()),
		(NULL, '3', '1', '250', '7', 2014, now()),
		(NULL, '3', '1', '250', '8', 2014, now()),
		(NULL, '3', '1', '250', '9', 2014, now()),
		(NULL, '3', '1', '250', '10', 2014, now()),
		(NULL, '3', '1', '250', '11', 2014, now()),
		(NULL, '3', '1', '250', '12', 2014, now()),
		(NULL, '1', '2', '200', '1', 2014, now()),
		(NULL, '1', '2', '200', '2', 2014, now()),
		(NULL, '1', '2', '200', '3', 2014, now()),
		(NULL, '1', '2', '200', '4', 2014, now()),
		(NULL, '1', '2', '200', '5', 2014, now()),
		(NULL, '1', '2', '200', '6', 2014, now()),
		(NULL, '1', '2', '200', '7', 2014, now()),
		(NULL, '1', '2', '200', '8', 2014, now()),
		(NULL, '1', '2', '200', '9', 2014, now()),
		(NULL, '1', '2', '200', '10', 2014, now()),
		(NULL, '1', '2', '200', '11', 2014, now()),
		(NULL, '1', '2', '200', '12', 2014, now()),
		(NULL, '4', '2', '200', '1', 2014, now()),
		(NULL, '4', '2', '200', '2', 2014, now()),
		(NULL, '4', '2', '200', '3', 2014, now()),
		(NULL, '4', '2', '200', '4', 2014, now()),
		(NULL, '4', '2', '200', '5', 2014, now()),
		(NULL, '4', '2', '200', '6', 2014, now()),
		(NULL, '4', '2', '200', '7', 2014, now()),
		(NULL, '4', '2', '200', '8', 2014, now()),
		(NULL, '4', '2', '200', '9', 2014, now()),
		(NULL, '4', '2', '200', '10', 2014, now()),
		(NULL, '4', '2', '200', '11', 2014, now()),
		(NULL, '4', '2', '200', '12', 2014, now()),
		/**2016**/
		(NULL, '1', '1', '200', '1', 2016, now()),
		(NULL, '1', '1', '200', '2', 2016, now()),
		(NULL, '1', '1', '200', '3', 2016, now()),
		(NULL, '2', '1', '250', '1', 2016, now()),
		(NULL, '3', '1', '250', '1', 2016, now()),
		(NULL, '3', '1', '250', '2', 2016, now()),
		(NULL, '1', '2', '200', '1', 2016, now()),
		(NULL, '1', '2', '200', '2', 2016, now()),
		(NULL, '1', '2', '200', '3', 2016, now()),
		(NULL, '4', '2', '200', '1', 2016, now()),
		(NULL, '4', '2', '200', '2', 2016, now());
        
        
        
select sports.name,sportGroups.location from sports left join sportGroups on sport.id=sportGroup.sport_id
union 
select sports.name,sportGroups.location from sports right join sportGroups on sport.id=sportGroup.sport_id;

select s.name as Sport, sg.location as Place
from sports as s
join sportGroups as sg
on sport.id=sportGroups.sport_id;


select s1.name as Student1,s2.name as Student2, sports.name as Sport 
from students as s1 
join students as s2 
on s1.id<s2.id
join sports 
on (s1.id in 
	(select sport_id from student_sport 
    where sportGroup_id in
		(select id from sportGroups 
        where sportGroups.sport_id=sport.id)
	)
and 
	(s2.id  in 
    (select sport_id from student_sport 
    where sportGroup_id in 
		(select id from sportGroups 
        where sportGroups.sport_id=sport.id)
	)
where s1.id in
	(select student_id from student_sport 
    where sportGroup_id in
		(select sportGroup_id from student_sport 
        where student_id=s2.id)
	)
order by Sport;

