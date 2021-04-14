CREATE TABLE IF NOT EXISTS `container_type`
(
    `id`   BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(255) UNIQUE NOT NULL,
    `size` VARCHAR(30)  NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id`, `type` ASC)
)
    ENGINE = InnoDB;