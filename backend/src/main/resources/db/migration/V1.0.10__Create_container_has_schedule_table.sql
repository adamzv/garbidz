CREATE TABLE IF NOT EXISTS container_has_schedule
(
    id_container BIGINT CHECK (id_container > 0) NOT NULL,
    id_schedule BIGINT CHECK (id_schedule > 0) NOT NULL
    ,
    CONSTRAINT fk_container_schedule
        FOREIGN KEY(id_container)
            REFERENCES container (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    ,
    CONSTRAINT fk_schedule_container
        FOREIGN KEY(id_schedule)
            REFERENCES schedule (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_container_schedule_idx ON container_has_schedule (id_container ASC);
CREATE INDEX fk_schedule_container_idx ON container_has_schedule (id_schedule ASC);