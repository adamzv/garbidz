CREATE TABLE IF NOT EXISTS `container_type`
(
    `id`   INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(255) NOT NULL,
    `size` VARCHAR(30)  NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `id_UNIQUE` (`id` ASC)
)
    ENGINE = InnoDB;