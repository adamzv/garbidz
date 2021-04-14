# table hibernate_sequence
CREATE TABLE `hibernate_sequence`
(
    `next_val` bigint(20) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `hibernate_sequence` (`next_val`)
VALUES (1);

# table user_role
CREATE TABLE `user_role`
(
    `id`        int(11) NOT NULL,
    `user_role` varchar(255) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

ALTER TABLE `user_role`
    ADD PRIMARY KEY (`id`);

# added 1 role for testing purposes
INSERT INTO `user_role` (`id`, `user_role`)
VALUES (1, 'user');

