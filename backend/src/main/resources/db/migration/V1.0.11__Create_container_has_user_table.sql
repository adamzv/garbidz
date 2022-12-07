CREATE TABLE IF NOT EXISTS container_has_user
(
    id_container BIGINT CHECK (id_container > 0) NOT NULL,
    id_user BIGINT CHECK (id_user > 0) NOT NULL
    ,
    CONSTRAINT fk_container_user
        FOREIGN KEY(id_container)
            REFERENCES container (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    ,
    CONSTRAINT fk_user_container
        FOREIGN KEY(id_user)
            REFERENCES user_account (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_container_user_idx ON container_has_user (id_container ASC);
CREATE INDEX fk_user_container_idx ON container_has_user (id_user ASC);