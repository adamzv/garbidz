CREATE SEQUENCE container_type_seq;

CREATE TABLE IF NOT EXISTS container_type
(
    id   BIGINT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('container_type_seq'),
    type VARCHAR(255) UNIQUE NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE  (id, type)
)
;