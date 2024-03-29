CREATE TABLE IF NOT EXISTS `container`
(
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `id_address` BIGINT(20) UNSIGNED NOT NULL,
    `id_type` BIGINT(20) UNSIGNED NOT NULL,
    `garbage_type` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_container_address_idx` (`id_address` ASC),
    CONSTRAINT `fk_container_address`
        FOREIGN KEY(`id_address`)
            REFERENCES `address` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    INDEX `fk_container_type_idx` (`id_type` ASC),
    CONSTRAINT `fk_container_type`
        FOREIGN KEY(`id_type`)
            REFERENCES `container_type` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;