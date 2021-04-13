set foreign_key_checks = 0;
ALTER TABLE `user_report`
    MODIFY `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY `id_user` BIGINT UNSIGNED NOT NULL;
set foreign_key_checks  = 1;