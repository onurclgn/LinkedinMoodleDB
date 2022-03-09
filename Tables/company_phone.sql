-- Table: public.company_phone

-- DROP TABLE IF EXISTS public.company_phone;

CREATE TABLE IF NOT EXISTS public.company_phone
(
    company_id character(20) COLLATE pg_catalog."default" NOT NULL,
    phonen character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "COMPANY_PHONE_pkey" PRIMARY KEY (company_id, phonen),
    CONSTRAINT "Company_id" FOREIGN KEY (company_id)
        REFERENCES public.company (company_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT company_phone_phonen_check CHECK (char_length(phonen) = 11) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.company_phone
    OWNER to postgres;
-- Index: fki_Company_id

-- DROP INDEX IF EXISTS public."fki_Company_id";

CREATE INDEX IF NOT EXISTS "fki_Company_id"
    ON public.company_phone USING btree
    (company_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;