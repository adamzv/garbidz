CREATE TABLE IF NOT EXISTS `user_token` (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT,
                              `revoked` bit(1) DEFAULT NULL,
                              `token` varchar(255) DEFAULT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;