CREATE  TABLE IF NOT EXISTS `user_complaint` (
     `id`BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT ,
     `datetime` DATETIME NOT NULL ,
     `image` BLOB ,
     `text` TEXT NOT NULL ,
     `id_user` BIGINT(20) UNSIGNED NOT NULL ,
     `id_address` BIGINT(20) UNSIGNED NOT NULL ,
     PRIMARY KEY (`id`) ,
     UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
     INDEX `fk_complaints_users_idx` (`id_user` ASC) ,
     CONSTRAINT `fk_complaints_users`
         FOREIGN KEY (`id_user` )
             REFERENCES `user_account` (`id` )
             ON DELETE NO ACTION
             ON UPDATE NO ACTION,
     INDEX `fk_complaints_addresses_idx` (`id_address` ASC) ,
     CONSTRAINT `fk_complaints_addresses`
          FOREIGN KEY (`id_address` )
             REFERENCES `address` (`id` )
             ON DELETE NO ACTION
             ON UPDATE NO ACTION)
ENGINE = InnoDB;