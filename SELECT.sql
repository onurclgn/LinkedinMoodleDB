select * --YAŞI 25TEN BÜYÜK OLAN KULLANICILAR
from users u
where U.age>25;


select *--ÜLKESİ TR OLAN ŞİRKETLER
from company c
where c.country ='TR';

select * --MAX KATILIMCISI 200 VE 200 DEN FAZLA OLAN ETKİNLİKLER
from events e 
where e.maximum_participant>=200;
------------------------------------------------------

select u.firstname,u.lastname, s.student_number --20 KREDİDEN FAZLA ALAN ÖĞRENCİLERİN BİLGİLERİ
from student s ,users u 
where u.user_id=s.student_id and s.taken_credit>20


select public.users.firstname ,public.users.lastname,public.community.community_name --GRUP YÖNETİCİSİ OLAN KADINLAR
from public.users,public.community
where public.users.sex='F' and public.community.creator_id=public.users.user_id

select public.company.company_name,public.job.job_name,public.job.job_type --FULL TİME İŞ İLANI VEREN ŞİRKETLER
from public.company,public.job
where public.job.job_type='full-time' and public.job.company_id =public.company.company_id

select public.company.company_name,public.job.job_name -- full STACK DEVELOPER ARAYAN ŞİRKETLER
from public.company,public.job
where public.job.job_name ='FULL STACK DEVELOPER' and public.job.company_id=public.company.company_id

-----------------------------------------------------------

select public.users.firstname ,public.users.lastname,public.company.company_name --ŞİRKET SAYFASI YÖNETEN KULLANICILARIN İSİM VE SOY İSİMLERİ
from public.users,public.company,public.admins 
where public.admins.user_id=public.users.user_id and public.admins.company_id=public.company.company_id;

select public.users.firstname ,public.users.lastname ,public.events.event_name,public.community.community_name --Hem event hemde community yaratıcısı olanlar
from public.users ,public.events,public.community
where public.events.creator_id=public.users.user_id and public.community.creator_id =public.users.user_id

select distinct u.firstname,u.lastname --advisor olan eğitmenler
from student s , instructor i ,users u 
where s.advisor_id =i.instructor_id and i.instructor_id =u.user_id


------------------------------------------------------------

select u.firstname ,u.lastname ,e.event_name -- BİLMUH HOCALARININ KATILDIĞI ETKİNLİKLER
from department d ,instructor i ,users u ,enroll_event ee ,events e 
where d.dep_id =i.dep_id and u.user_id =i.instructor_id and ee.user_id =u.user_id and d.dname='BİLMUH' and ee.event_id =e.event_id 

select distinct u.firstname ,u.lastname,c.names,c2.community_name  -- CALCULUS DERSİ ALANLARIN KATILDIĞI TOPLULUKLAR
from course c ,student s  ,users u ,enroll_course ec ,join_community jc  ,community c2 
where  ec.student_id =s.student_id and s.student_id =u.user_id and ec.course_code=c.course_code and jc.user_id =u.user_id and jc.community_id = c2.community_id
and c.names ='CALCULUS'


select u.firstname ,u.lastname, j.job_name, a.appdate  --- VESTELE BAŞVURANLARIN İSİM SOYİSİMLERİ
from job j ,apply a  ,users u ,company c 
where a.job_name =j.job_name and a.emp_id = u.user_id
and a.company_id =j.company_id and c.company_id =a.company_id and c.company_name ='VESTEL'


select s.student_number ---- ADVİSORI MURAT ÜNALIR OLAN ÖĞRENCİLERİN NUMARASI
from student s ,instructor i ,users u ,users u2 
where i.instructor_id =s.advisor_id and u.user_id =i.instructor_id and u.firstname ='MURAT' and u.lastname='ÜNALIR'
and u2.user_id =s.student_id 


select public.users.email,public.company.company_name ------Ankara'daki şirketlerin sayfalarını yöneten kullanıcının mail adresi ve yönettiği şirket bilgisi
from public.admins,public.company,public.users 
where public.company.city='ANKARA' and public.admins.company_id=public.company.company_id and public.admins.user_id=public.users.user_id
-------------------------------------------------------------
