CREATE SEQUENCE user_report_seq;

CREATE TABLE IF NOT EXISTS user_report
(
    id       BIGINT CHECK (id > 0)      NOT NULL DEFAULT NEXTVAL('user_report_seq'),
    message  TEXT                       NOT NULL,
    datetime TIMESTAMP(0)               NOT NULL,
    id_user  BIGINT CHECK (id_user > 0) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT id_UNIQUE UNIQUE (id),
    CONSTRAINT fk_reports_users
        FOREIGN KEY (id_user)
            REFERENCES user_account (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_reports_users_idx ON user_report (id_user ASC);