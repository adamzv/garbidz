CREATE TABLE hibernate_sequence
(
    next_val BIGINT DEFAULT NULL
)
;

INSERT INTO hibernate_sequence (next_val)
VALUES (1);

-- table user_role
CREATE TABLE user_role
(
    id        BIGINT CHECK (id > 0) NOT NULL,
    user_role varchar(255) DEFAULT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE (id)
)
;