# table hibernate_sequence
CREATE TABLE `hibernate_sequence`
(
    `next_val` BIGINT(20) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `hibernate_sequence` (`next_val`)
VALUES (1);

# table user_role
CREATE TABLE `user_role`
(
    `id`        BIGINT(20) UNSIGNED NOT NULL,
    `user_role` varchar(255) DEFAULT NULL,
     PRIMARY KEY (`id`),
     UNIQUE INDEX `id_UNIQUE` (`id` ASC)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;