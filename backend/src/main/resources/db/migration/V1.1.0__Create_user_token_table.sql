CREATE SEQUENCE user_token_seq;

CREATE TABLE IF NOT EXISTS user_token (
                                          id BIGINT NOT NULL DEFAULT NEXTVAL ('user_token_seq'),
                                          revoked boolean(1) DEFAULT NULL,
                                          token varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (id)
) ;