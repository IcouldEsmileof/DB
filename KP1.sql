drop database if exists DB1;

create database DB1;
use DB1;


create table Degrees(
	id int primary key,
    name varchar(20)
);

create table Faculties(
	id int auto_increment primary key,
    name varchar(255)
);

create table Departments(
	id int auto_increment primary key,
    name varchar(255),
    faculty_id int not null,
    
    constraint foreign key(faculty_id) references Faculties(id)
);

create table Teachers(
	id int auto_increment primary key,
    name varchar(255) not null,
    department_id int not null,
    phone varchar(15),
    email varchar(255),
    
    constraint foreign key(department_id) references Departments(id)
);

create table Teacher_Degree(
	teacher_id int not null,
    degree_id int not null,
    
    constraint foreign key(teacher_id) references Teachers(id),
    constraint foreign key(degree_id) references Degrees(id),
    constraint primary key(teacher_id,degree_id)
);

create table Rooms(
	number int primary key,
    capacity int not null,
    numberOfComputers int not null,
    hasProjector bit not null,
    hasInternet bit not null,
    hasBlackBoard bit not null,
    hasWhiteBoard bit not null
);

create table Timetable(
	id int auto_increment primary key,
    date date not null,
    dayOfWeek enum('Mondey','Tuesday','Wednesday','Thursday','Friday','Saterday','Sunday'),
    time time not null,
    
    constraint unique(date,dayOfWeek,time)
);

create table Room_Timetable(
	room_id int not null,
    timetable_id int not null,
    teacher_id int not null,
    
    constraint foreign key(room_id) references Rooms(number),
    constraint foreign key(timetable_id) references Timetable(id),
    constraint foreign key(teacher_id) references Teachers(id),
    
    constraint primary key(room_id,timetable_id,teacher_id)
);