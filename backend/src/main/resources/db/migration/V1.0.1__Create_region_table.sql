CREATE TABLE IF NOT EXISTS `region`
(
    `id`   INT          NOT NULL AUTO_INCREMENT,
    `region` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB;