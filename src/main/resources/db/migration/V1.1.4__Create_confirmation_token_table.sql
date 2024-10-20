CREATE TABLE IF NOT EXISTS `confirmation_token`
(
    `id`      BIGINT(20) UNSIGNED  NOT NULL AUTO_INCREMENT,
    `token`   VARCHAR(255) NOT NULL,
    `id_user` BIGINT(20) UNSIGNED   NOT NULL,
    INDEX `fk_confirmation_token_user_account1_idx` (`id_user` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_confirmation_token_user_account1`
        FOREIGN KEY (`id_user`)
            REFERENCES `user_account` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;

ALTER TABLE `user_account`
    ADD `enabled` BOOLEAN NOT NULL AFTER `user_token_id`;
