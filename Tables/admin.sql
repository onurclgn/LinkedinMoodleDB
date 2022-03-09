-- Table: public.admins

-- DROP TABLE IF EXISTS public.admins;

CREATE TABLE IF NOT EXISTS public.admins
(
    user_id character(20) COLLATE pg_catalog."default" NOT NULL,
    company_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "ADMINS_pkey" PRIMARY KEY (user_id, company_id),
    CONSTRAINT "Company_id" FOREIGN KEY (company_id)
        REFERENCES public.company (company_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "User_id" FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.admins
    OWNER to postgres;