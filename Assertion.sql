--Assertion

create or replace function check_numberof_course()
returns trigger
language plpgsql
as
$$
declare 
	given_course integer;
begin 
	select count(*) into given_course 
	from give_course
	where give_course.ins_id=new.ins_id;
	
	if(given_course<5)then
		return new;
	else
		raise notice'Maksimum 5 ders verebilir.';
		return null;
	end if;
	
end;
$$

create trigger max_give_course
before insert 
on public.give_course 
for each row 
execute procedure check_numberof_course();

------------------------------------------------------------------------------------

create or replace function check_numberof_apply()
returns trigger
language plpgsql
as
$$
declare 
	apply_job integer;
begin 
	select count(*) into apply_job 
	from apply
	where emp_id=new.emp_id ;
	
	if(apply_job<10)then
		return new;
	else
		raise notice'Maksimum 10 iş ilanına başvurabilirsiniz.';
		return null;
	end if;
	
end;
$$

create trigger max_apply_job
before insert 
on public.apply 
for each row 
execute procedure check_numberof_apply();

---------------------------------------------------------------------------------------

create or replace function check_participant()
returns trigger
language plpgsql
as
$$
declare 
	participant integer;
declare 
	current_participant integer;
begin 
	
	select maximum_participant  into participant  
	from events
	where event_id=new.event_id  ;
	
	select count(*)  into current_participant 
	from enroll_event ee 
	where event_id=new.event_id ;

	
	
	if(current_participant <participant)then
		return new;
	else
		raise notice'Bu event katitilimci sinirina ulasmistir.';
		return null;
	end if;
	
end;
$$


create trigger join_event
before insert 
on public.enroll_event
for each row 
execute procedure check_participant();