-- Table: public.comment

-- DROP TABLE IF EXISTS public.comment;

CREATE TABLE IF NOT EXISTS public.comment
(
    user_id character(20) COLLATE pg_catalog."default" NOT NULL,
    post_id character(20) COLLATE pg_catalog."default" NOT NULL,
    text character(128) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "COMMENT_pkey" PRIMARY KEY (user_id, post_id),
    CONSTRAINT "Post_id" FOREIGN KEY (post_id)
        REFERENCES public.post (post_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "User_id" FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.comment
    OWNER to postgres;
-- Index: fki_User_id

-- DROP INDEX IF EXISTS public."fki_User_id";

CREATE INDEX IF NOT EXISTS "fki_User_id"
    ON public.comment USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;