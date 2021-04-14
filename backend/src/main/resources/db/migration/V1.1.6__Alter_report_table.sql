set foreign_key_checks = 0;
ALTER TABLE  `user_report`
    MODIFY `id` BIGINT UNSIGNED AUTO_INCREMENT;
set foreign_key_checks = 1;