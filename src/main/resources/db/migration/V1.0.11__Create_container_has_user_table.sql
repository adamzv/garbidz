CREATE TABLE IF NOT EXISTS `container_has_user`
(
    `id_container` BIGINT(20) UNSIGNED NOT NULL,
    `id_user` BIGINT(20) UNSIGNED NOT NULL,
    INDEX `fk_container_user_idx` (`id_container` ASC),
    CONSTRAINT `fk_container_user`
        FOREIGN KEY(`id_container`)
            REFERENCES `container` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    INDEX `fk_user_container_idx` (`id_user` ASC),
    CONSTRAINT `fk_user_container`
        FOREIGN KEY(`id_user`)
            REFERENCES `user_account` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;