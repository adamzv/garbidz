CREATE SEQUENCE town_seq;

CREATE TABLE IF NOT EXISTS town
(
    id        BIGINT CHECK (id > 0) NOT NULL DEFAULT NEXTVAL ('town_seq'),
    town      VARCHAR(255) NOT NULL,
    id_region BIGINT CHECK (id_region > 0) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE (id)
    ,
    CONSTRAINT fk_town_region1
        FOREIGN KEY (id_region)
            REFERENCES region (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_town_region1_idx ON town (id_region ASC);