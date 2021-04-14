CREATE TABLE IF NOT EXISTS `user_account` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(255) NOT NULL ,
    `surname` VARCHAR(255) NOT NULL ,
    `email` VARCHAR(255) NOT NULL  ,
    `password` TEXT NOT NULL ,
    `id_role` BIGINT(20) UNSIGNED NOT NULL ,
    `id_address` BIGINT(20) UNSIGNED NOT NULL ,
     PRIMARY KEY (`id`) ,
     UNIQUE INDEX `id_UNIQUE` (`id`, `email`  ASC) ,
     INDEX `fk_users_roles_idx` (`id_role` ASC) ,
     CONSTRAINT `fk_users_roles`
        FOREIGN KEY (`id_role`)
            REFERENCES `user_role` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
     INDEX `fk_users_addresses_idx` (`id_address` ASC) ,
     CONSTRAINT `fk_users_addresses`
        FOREIGN KEY (`id_address`)
             REFERENCES `address` (`id`)
             ON DELETE NO ACTION
             ON UPDATE NO ACTION)
ENGINE = InnoDB;