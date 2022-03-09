-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    user_id character(40) COLLATE pg_catalog."default" NOT NULL,
    phone character(12) COLLATE pg_catalog."default",
    sex character(10) COLLATE pg_catalog."default",
    email character(64) COLLATE pg_catalog."default",
    firstname character(30) COLLATE pg_catalog."default" NOT NULL,
    lastname character(30) COLLATE pg_catalog."default" NOT NULL,
    age integer,
    CONSTRAINT "USER_pkey" PRIMARY KEY (user_id),
    CONSTRAINT "EMAILSK" UNIQUE (email),
    CONSTRAINT "PHONESK" UNIQUE (phone),
    CONSTRAINT users_sex_check CHECK (sex = 'F'::bpchar OR sex = 'M'::bpchar) NOT VALID,
    CONSTRAINT users_age_check CHECK (age > 17) NOT VALID,
    CONSTRAINT users_phone_check CHECK (char_length(phone) = 11) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;