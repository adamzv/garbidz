CREATE SEQUENCE container_seq;

CREATE TABLE IF NOT EXISTS container
(
    id BIGINT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('container_seq'),
    id_address BIGINT CHECK (id_address > 0) NOT NULL,
    id_type BIGINT CHECK (id_type > 0) NOT NULL,
    garbage_type VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE (id)
    ,
    CONSTRAINT fk_container_address
        FOREIGN KEY(id_address)
            REFERENCES address (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    ,
    CONSTRAINT fk_container_type
        FOREIGN KEY(id_type)
            REFERENCES container_type (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_container_address_idx ON container (id_address ASC);
CREATE INDEX fk_container_type_idx ON container (id_type ASC);