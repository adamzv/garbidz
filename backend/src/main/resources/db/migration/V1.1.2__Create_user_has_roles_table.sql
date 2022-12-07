ALTER TABLE user_account
    DROP FOREIGN KEY fk_users_roles;
ALTER TABLE user_account
    DROP id_role;

CREATE TABLE IF NOT EXISTS user_has_role
(
    id_user BIGINT CHECK (id_user > 0) NOT NULL,
    id_role BIGINT CHECK (id_role > 0) NOT NULL,
    PRIMARY KEY (id_user, id_role)
    ,
    CONSTRAINT fk_user_account_has_role_user_account1
        FOREIGN KEY (id_user)
            REFERENCES user_account (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_user_account_has_role_user_role1
        FOREIGN KEY (id_role)
            REFERENCES user_role (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

CREATE INDEX fk_user_account_has_role_user_role1_idx ON user_has_role (id_role ASC);
CREATE INDEX fk_user_account_has_roles_user_account1_idx ON user_has_role (id_user ASC);

