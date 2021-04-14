CREATE  TABLE IF NOT EXISTS `user_report` (
     `id` INT NOT NULL AUTO_INCREMENT ,
     `message` TEXT NOT NULL ,
     `datetime` DATETIME NOT NULL ,
     `id_user` INT NOT NULL ,
     PRIMARY KEY (`id`) ,
     UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
     INDEX `fk_reports_users_idx` (`id_user` ASC) ,
     CONSTRAINT `fk_reports_users`
         FOREIGN KEY (`id_user` )
             REFERENCES `user_account` (`id` )
             ON DELETE NO ACTION
             ON UPDATE NO ACTION)
ENGINE = InnoDB;