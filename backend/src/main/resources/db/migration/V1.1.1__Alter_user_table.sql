ALTER TABLE `user_account`
    ADD `user_token_id` bigint(20) DEFAULT NULL,
    ADD KEY `fk_users_tokens_idx` (`user_token_id`),
    ADD CONSTRAINT `fk_users_tokens_idx` FOREIGN KEY (`user_token_id`) REFERENCES `user_token` (`id`);