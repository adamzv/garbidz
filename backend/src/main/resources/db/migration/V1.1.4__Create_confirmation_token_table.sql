CREATE SEQUENCE confirmation_token_seq;

CREATE TABLE IF NOT EXISTS confirmation_token
(
    id      BIGINT CHECK (id > 0)  NOT NULL DEFAULT NEXTVAL ('confirmation_token_seq'),
    token   VARCHAR(255) NOT NULL,
    id_user BIGINT CHECK (id_user > 0)   NOT NULL
    ,
    PRIMARY KEY (id),
    CONSTRAINT fk_confirmation_token_user_account1
        FOREIGN KEY (id_user)
            REFERENCES user_account (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
;

CREATE INDEX fk_confirmation_token_user_account1_idx ON confirmation_token (id_user ASC);

ALTER TABLE user_account
    ADD enabled BOOLEAN NOT NULL AFTER user_token_id;
