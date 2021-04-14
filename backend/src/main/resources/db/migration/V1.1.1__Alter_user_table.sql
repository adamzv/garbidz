ALTER TABLE `user_account`
    ADD `user_token_id` bigint(20) DEFAULT NULL,
    ADD KEY `fk_users_tokens_idx` (`user_token_id`),
    ADD CONSTRAINT `fk_users_tokens_idx` FOREIGN KEY (`user_token_id`) REFERENCES `user_token` (`id`);

#do not insert other lines of code here if its not related to changing foreign keys
set foreign_key_checks = 0;
ALTER TABLE  `user_account`
    MODIFY `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY `id_role` BIGINT UNSIGNED NOT NULL,
    MODIFY `id_address` BIGINT UNSIGNED NOT NULL,
    MODIFY `email` VARCHAR(255) UNIQUE NOT NULL ;
set foreign_key_checks = 1;
