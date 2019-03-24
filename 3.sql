-- име на трен и спорт
-- име на студ и спорт
-- име на спорт и място
-- име на спорт и място, но и тези за които няма място
-- име на спорт и място, но и залите в които няма спорт
-- име на спорт и място, но и гопрните 2

use school_sport_clubs;

select coaches.name as Coach, sports.name as Sport 
from coaches 
join sports
on coaches.id in
	( select coach_id from sportGroups
	where sportGroups.sport_id=sports.id);

select students.name as Student, sports.name as Sport 
from students 
join sports 
on students.id in 
	( select student_id from student_sport 
    where student_sport.sportGroup_id 
	in 
		(select id from sportGroups 
		where sportGroups.sport_id=sports.id ));

select sports.name as Sport, sportGroups.location as Place  
from sports 
join sportGroups
on sports.id=sportGroups.sport_id;

select sports.name as Sport, sportGroups.location as Place  
from sports 
left join sportGroups
on sports.id=sportGroups.sport_id;

select sports.name as Sport, sportGroups.location as Place  
from sports 
right join sportGroups
on sports.id=sportGroups.sport_id;

select sports.name as Sport, sportGroups.location as Place  
from sports 
left join sportGroups
on sports.id=sportGroups.sport_id
union
select sports.name as Sport, sportGroups.location as Place  
from sports 
right join sportGroups
on sports.id=sportGroups.sport_id;

-- име и тел на всички студ трен волейб


select students.name as Student, students.phone as Phone
from students
where students.id in
(select student_id from student_sport
	where sportGroup_id in
    (select id from sportGroups 
    where sport_id in
		(select id from sports
		where sports.name='Volleyball')
	)
);

-- име на студ, които трен в понед, като резулт са подред по име на ст 


select students.name as Student
from Students
where students.id in 
	(select student_id from student_sport
    where sportGroup_id in
		(select id from sportGroups
        where dayOfWeek='Monday')
	);

-- име на учен, клас, ид на групата в която трен, но само за учен в неделя при труньо Иван Тодоров Петков


select students.name as Student, students.class as Class, sportGroups.id as GroupNo 
from students
join sportGroups 
on students.id in 
	(select student_id from student_sport
    where sportGroup_id in
		(select id from sportGroups
        where dayOfWeek='Sunday' and coach_id in 
			(select id from coaches
			where name='Ivan Todorov Petkov'
			)
        )
	);
    
-- име на учен и общата сума, която е платил по години, като резултатите са подредени по име на учен

select students.name as Student, sum(taxespayments.paymentAmount) as PaidTax, taxespayments.year as forYear 
from students
join taxespayments
on students.id=taxespayments.student_id
group by Student,forYear
order by Student;
