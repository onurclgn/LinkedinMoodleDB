-- Table: public.likes

-- DROP TABLE IF EXISTS public.likes;

CREATE TABLE IF NOT EXISTS public.likes
(
    user_id character(20) COLLATE pg_catalog."default" NOT NULL,
    post_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "LIKE_pkey" PRIMARY KEY (user_id, post_id),
    CONSTRAINT "Post_id" FOREIGN KEY (post_id)
        REFERENCES public.post (post_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.likes
    OWNER to postgres;