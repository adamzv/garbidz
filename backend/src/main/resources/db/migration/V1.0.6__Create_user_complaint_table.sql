CREATE SEQUENCE user_complaint_seq;

CREATE TABLE IF NOT EXISTS user_complaint
(
    idBIGINT CHECK (id > 0)                  NOT NULL DEFAULT NEXTVAL('user_complaint_seq'),
    datetime   TIMESTAMP(0)                  NOT NULL,
    image      BYTEA,
    text       TEXT                          NOT NULL,
    id_user    BIGINT CHECK (id_user > 0)    NOT NULL,
    id_address BIGINT CHECK (id_address > 0) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE (id),
    CONSTRAINT fk_complaints_users
        FOREIGN KEY (id_user)
            REFERENCES user_account (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_complaints_addresses
        FOREIGN KEY (id_address)
            REFERENCES address (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_complaints_users_idx ON user_complaint (id_user ASC);
CREATE INDEX fk_complaints_addresses_idx ON user_complaint (id_address ASC);