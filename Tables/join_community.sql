-- Table: public.join_community

-- DROP TABLE IF EXISTS public.join_community;

CREATE TABLE IF NOT EXISTS public.join_community
(
    user_id character(20) COLLATE pg_catalog."default" NOT NULL,
    community_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "JOIN_GROUP_pkey" PRIMARY KEY (user_id, community_id),
    CONSTRAINT "Group_id" FOREIGN KEY (community_id)
        REFERENCES public.community (community_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT "User_id" FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.join_community
    OWNER to postgres;