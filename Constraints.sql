ALTER TABLE IF EXISTS public.users
    ADD CHECK (age>17)
    NOT VALID;

ALTER TABLE IF EXISTS public.post
    ADD CHECK (post_time<CURRENT_DATE)
    NOT VALID;

ALTER TABLE IF EXISTS public.events
    ADD CHECK (event_time>CURRENT_DATE)
    NOT VALID;

ALTER TABLE IF EXISTS public.users
    ADD CHECK (sex='F' or sex='M')
    NOT VALID;

  ALTER TABLE IF EXISTS public.job
    ADD CHECK (job_type='full-time' or job_type='part-time' or job_type='intern')
    NOT VALID;

  ALTER TABLE IF EXISTS public.student
    ADD CHECK (char_length (student_number) > 10 )
    NOT VALID;

  ALTER TABLE IF EXISTS public.users
    ADD CHECK (char_length (phone) = 11)
    NOT VALID;

  ALTER TABLE IF EXISTS public.company_phone
    ADD CHECK (char_length (phonen) = 11)
    NOT VALID;
    
   ALTER TABLE IF EXISTS public.connects
    ADD CHECK (connector_id!=connect_by_id)
    NOT VALID;
    
   ALTER TABLE IF EXISTS public.follow
    ADD CHECK (follower!=follower_by)
    NOT VALID;