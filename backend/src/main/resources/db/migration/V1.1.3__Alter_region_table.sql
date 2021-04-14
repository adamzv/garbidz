set foreign_key_checks = 0;
ALTER TABLE  `region`
    MODIFY `id` BIGINT UNSIGNED AUTO_INCREMENT;
set foreign_key_checks = 1;