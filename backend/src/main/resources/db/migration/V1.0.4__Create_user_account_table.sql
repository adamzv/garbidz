CREATE SEQUENCE user_account_seq;

CREATE TABLE IF NOT EXISTS user_account
(
    id         BIGINT CHECK (id > 0)         NOT NULL DEFAULT NEXTVAL('user_account_seq'),
    name       VARCHAR(255)                  NOT NULL,
    surname    VARCHAR(255)                  NOT NULL,
    email      VARCHAR(255)                  NOT NULL UNIQUE,
    password   TEXT                          NOT NULL,
    id_role    BIGINT CHECK (id_role > 0)    NOT NULL,
    id_address BIGINT CHECK (id_address > 0) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE (id, email),
    CONSTRAINT fk_users_roles
        FOREIGN KEY (id_role)
            REFERENCES user_role (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_users_addresses
        FOREIGN KEY (id_address)
            REFERENCES address (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_users_roles_idx ON user_account (id_role ASC);
CREATE INDEX fk_users_addresses_idx ON user_account (id_address ASC);