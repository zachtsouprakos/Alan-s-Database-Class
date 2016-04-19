--
-- The table of courses.
--
create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;


--
-- An example stored procedure ("function")
--
create or replace function get_courses_by_credits(int, REFCURSOR) returns refcursor as 
$$
declare
   num_credits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  credits >= num_credits;
   return resultset;
end;
$$ 
language plpgsql;
-- This function selects preReqNum from prerequisites and compares the courseNum that is passed
-- into the function as reqNum, thus resulting the prerequisites from the given course
CREATE OR REPLACE FUNCTION PreReqsFor(INT, REFCURSOR) returns refcursor AS
$$
DECLARE
  reqNum INT          := $1;
  resultset REFCURSOR := $2;
BEGIN
  open resultset FOR
   SELECT preReqNum
   FROM Prerequisites
   WHERE courseNum = reqNum ;
  RETURN resultset ;
END;
$$
LANGUAGE plpgsql;

SELECT PreReqsFor(499, 'resultset');
FETCH ALL FROM resultset;
-- This function selects the courseNum from the prereq table where the preReqNum is equal to the number
-- that is passed into the function, thus showing the classes that needs the prereqs
CREATE OR REPLACE FUNCTION IsPreReqFor(INT, REFCURSOR) returns refcursor AS
$$
DECLARE
  reqNum INT          := $1;
  resultset REFCURSOR := $2;
BEGIN
  open resultset FOR
   SELECT courseNum
   FROM Prerequisites
   WHERE preReqNum = reqNum;
  RETURN resultset ;
END;
$$
LANGUAGE plpgsql;

SELECT IsPreReqFor(120,'resultset');
FETCH ALL from resultset;

select get_courses_by_credits(0, 'results');
Fetch all from results;