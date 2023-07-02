ALTER TABLE `user_account`
    DROP FOREIGN KEY `fk_users_roles`;
ALTER TABLE `user_account`
    DROP `id_role`;

CREATE TABLE IF NOT EXISTS `user_has_role`
(
    `id_user` BIGINT(20) UNSIGNED NOT NULL,
    `id_role` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`id_user`, `id_role`),
    INDEX `fk_user_account_has_role_user_role1_idx` (`id_role` ASC),
    INDEX `fk_user_account_has_roles_user_account1_idx` (`id_user` ASC),
    CONSTRAINT `fk_user_account_has_role_user_account1`
        FOREIGN KEY (`id_user`)
            REFERENCES `user_account` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_user_account_has_role_user_role1`
        FOREIGN KEY (`id_role`)
            REFERENCES `user_role` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;

