CREATE  TABLE IF NOT EXISTS `address` (
     `id` INT NOT NULL AUTO_INCREMENT ,
     `address` VARCHAR(255) NOT NULL ,
     `id_town` INT NOT NULL ,
     PRIMARY KEY (`id`) ,
     UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
     INDEX `fk_addresses_towns_idx` (`id_town` ASC) ,
     CONSTRAINT `fk_addresses_towns`
         FOREIGN KEY (`id_town` )
             REFERENCES `town` (`id` )
             ON DELETE NO ACTION
             ON UPDATE NO ACTION)
ENGINE = InnoDB;