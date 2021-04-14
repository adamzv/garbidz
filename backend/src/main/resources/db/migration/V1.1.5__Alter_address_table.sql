set foreign_key_checks = 0;
ALTER TABLE  `address`
    MODIFY `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY `id_town` BIGINT UNSIGNED NOT NULL;
set foreign_key_checks = 1;