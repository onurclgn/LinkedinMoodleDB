create or replace function credit_check() -- kredi kontrol fonksiyonu
returns trigger
language plpgsql
as
$$
declare 
	 stu_credit integer;
declare 
	 cour_credit integer;


begin
	
		select taken_credit into stu_credit  
		from student s  
		where student_id  = new.student_id;
	
		select credit into cour_credit 
		from course c 
		where course_code = new.course_code;
	
	stu_credit := stu_credit + cour_credit ;
	
	if (stu_credit<=40) then
		UPDATE public.student
		SET  taken_credit=stu_credit 
		WHERE student_id=new .student_id ;
		return new;
	else
		RAISE NOTICE '40 krediyi asti';
		return null;
	end if;

end;
$$



create trigger student_max_credit -- kredi kontrol triggeri
before insert or update 
on public.enroll_course
for each row 
execute procedure credit_check();

drop trigger student_max_credit on public.enroll_course; --kredi kontrol triggerini sil


---------------------------------------------------------------------------------------

create or replace function no_update_number()
returns trigger
language plpgsql
as
$$
declare 
	stu_number bpchar(64);
begin 
	select student_number into stu_number 
	from student s
	where student_id=new.student_id;
	
	if (new.student_number!=stu_number) then 
		raise notice 'Ogrenci numarasi guncellenemez.';
		return null;
	else 
		return new;
	end if;	
end;
$$

create trigger student_number_check
before update 
on public.student 
for each row
execute procedure no_update_number();

drop trigger student_number_check  on public.enroll_course 

--------------------------------------------------------------------------------------------


create or replace function message_to_connect() --bağlantı kurulmadan mesaj atılmaz
returns trigger
language plpgsql
as
$$

declare 
	messageto bpchar(20);
begin 
	
	select c.connect_by_id into messageto 
	from connects c
	where connector_id = new.sender and connect_by_id = new.receiver;

	if (messageto is NULL) then 
		raise notice 'takiplesmiyorlar';
		return null;
	else
		return new; 
	end if;
end;
$$

create trigger message_control
before insert
on public.message 
for each row 
execute procedure message_to_connect();

drop trigger message_control on public.message ;

-------------------------------------------------------------------------------------------

create or replace function connect_each_other() --x y ye bağlanırsa y x e bağlanır
returns trigger
language plpgsql
as
$$
declare 
	temp1 bpchar(20);
begin 
	select * into temp1
	from connects c
	where connector_id=new.connect_by_id and connect_by_id=new.connector_id;
	
	if (temp1 is  NULL) then
			INSERT INTO public.connects
			(connector_id, connect_by_id)
			VALUES(new.connect_by_id , new.connector_id);
			return new;
	else 
		return null;
	end if;
end;
$$

create trigger connect_to
after insert
on public.connects 
for each row 
execute procedure connect_each_other();

drop trigger connect_to on public.connects

-------------------------------------------------------------------------------------------

create or replace function unconnect_each_other() --x y yi bağlantıdan çıkarırsa y x i çıkarır
returns trigger
language plpgsql
as
$$
declare 
	temp1 character;
begin 
	select * into temp1
	from connects c
	where connector_id=old.connect_by_id and connect_by_id=old.connector_id;
	
	if (temp1 is not  NULL) then
			DELETE FROM public.connects
			WHERE connector_id=old.connect_by_id  AND connect_by_id=old.connector_id ;
			return old;
	else 
		return null;
	end if;
end;
$$

create trigger unconnect_to
after delete
on public.connects 
for each row 
execute procedure unconnect_each_other();

----------------------------------------------------------------------------------------------

create or replace function creator_join_event() --eventin yaratıcısı eventa otomatik katılır
returns trigger
language plpgsql
as
$$
begin 
	 INSERT INTO public.enroll_event
	(user_id, event_id)
	VALUES(new.creator_id, new.event_id);
	return new;
end;
$$

create trigger creato_join
after insert 
on public.events 
for each row 
execute procedure creator_join_event ();

-----------------------------------------------------------------------------------------------

create or replace function same_id_dept_and_studept()
returns trigger
language plpgsql
as
$$
declare 
	stu_dep bpchar(20);
declare 
	course_dep bpchar(20);
begin 
	select dep_id into stu_dep 
	from student 
	where student_id = new.student_id;
	
	select department_id into course_dep 
	from course c 
	where course_code=new.course_code;

	if (stu_dep=course_dep) then 
		return new;
	else 
		raise notice 'ogrenci kendi departmanindan course secebilir';
		return null;
	end if;
end;
$$

create trigger same_id_control
before insert 
on public.enroll_course 
for each row 
execute procedure same_id_dept_and_studept();

--------------------------------------------------------------------------------------------------

create or replace function same_id_dept_and_insdept()
returns trigger
language plpgsql
as
$$
declare 
	ins_dep bpchar(20);
declare 
	course_dep bpchar(20);
begin 
	select dep_id  into ins_dep 
	from instructor 
	where instructor_id  = new.ins_id;
	
	select department_id into course_dep 
	from course c 
	where course_code=new.course_code;

	if (ins_dep=course_dep) then 
		return new;
	else 
		raise notice 'egitmen kendi departmanindan course verebilir';
		return null;
	end if;
end;
$$

create trigger same_id_control_ins
before insert 
on public.give_course  
for each row 
execute procedure same_id_dept_and_insdept();

----------------------------------------------------------------------------------------------------
create or replace function same_course_project_ins()
returns trigger
language plpgsql
as
$$
declare 
	project_course bpchar(20);
	
begin 
	
	select course_code into project_course 
	from project p
	where project_id = new.project_id and course_code in(select course_code 
	from give_course gc 
	where ins_id=new.ins_id);
	
	if(project_course is null) then 
		raise notice 'egitmen kendi dersinin projesini verebilir';
		return null;
	else 
		return new;
	end if;

end;
$$

create trigger upload_project_trigger
before insert 
on public.upload_project
for each row 
execute procedure same_course_project_ins();

-----------------------------------------------------------------------------------------------------------

create or replace function same_course_project_stu()
returns trigger
language plpgsql
as
$$
declare 
	project_course bpchar(20);
	
begin 
	
	select course_code into project_course 
	from project p
	where project_id = new.project_id and course_code in(select course_code 
	from enroll_course ec 
	where student_id=new.student_id);
	
	if(project_course is null) then 
		raise notice 'ogrenci kendi dersinin projesini alabilir';
		return null;
	else 
		return new;
	end if;

end;
$$

create trigger take_project_trigger
before insert 
on public.takeproject
for each row 
execute procedure same_course_project_stu();


