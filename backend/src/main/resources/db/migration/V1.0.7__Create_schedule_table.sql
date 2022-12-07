CREATE SEQUENCE schedule_seq;

CREATE TABLE IF NOT EXISTS schedule
(
    id BIGINT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('schedule_seq'),
    datetime TIMESTAMP(0) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE(id)
)
;