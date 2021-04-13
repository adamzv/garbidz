set foreign_key_checks = 0;
ALTER TABLE `user_role`
    MODIFY `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY `user_role` VARCHAR(255) NOT NULL;
set foreign_key_checks = 1;