CREATE TABLE IF NOT EXISTS `container_has_schedule`
(
    `id_container` BIGINT(20) UNSIGNED NOT NULL,
    `id_schedule` BIGINT(20) UNSIGNED NOT NULL,
    INDEX `fk_container_schedule_idx` (`id_container` ASC),
    CONSTRAINT `fk_container_schedule`
        FOREIGN KEY(`id_container`)
            REFERENCES `container` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    INDEX `fk_schedule_container_idx` (`id_schedule` ASC),
    CONSTRAINT `fk_schedule_container`
        FOREIGN KEY(`id_schedule`)
            REFERENCES `schedule` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;