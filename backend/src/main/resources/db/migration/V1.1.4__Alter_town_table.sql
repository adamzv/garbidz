set foreign_key_checks = 0;
ALTER TABLE  `town`
    MODIFY `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY `id_region` BIGINT UNSIGNED NOT NULL;
set foreign_key_checks = 1;