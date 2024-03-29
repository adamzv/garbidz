CREATE TABLE IF NOT EXISTS `town`
(
    `id`        BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `town`      VARCHAR(255) NOT NULL,
    `id_region` BIGINT(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC),
    INDEX `fk_town_region1_idx` (`id_region` ASC),
    CONSTRAINT `fk_town_region1`
        FOREIGN KEY (`id_region`)
            REFERENCES `region` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;