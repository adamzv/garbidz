CREATE SEQUENCE address_seq;

CREATE TABLE IF NOT EXISTS address
(
    id      BIGINT CHECK (id > 0) DEFAULT NEXTVAL('address_seq'),
    address VARCHAR(255)               NOT NULL,
    lat     VARCHAR(255),
    lon     VARCHAR(255),
    id_town BIGINT CHECK (id_town > 0) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE (id),
    CONSTRAINT fk_addresses_towns
        FOREIGN KEY (id_town)
            REFERENCES town (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_addresses_towns_idx ON address (id_town ASC);