CREATE DATABASE IF NOT EXISTS competitive_users;
USE competitive_users;

CREATE TABLE IF `users`( 
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100),
  `account_age` INT,
  `created_at` TIMESTAMP NOT NULL default current_timestamp,
  `updated_at` TIMESTAMP NOT NULL default current_timestamp on update current_timestamp
);

CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


CREATE TABLE `maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


CREATE TABLE `matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id_orange` int(11) DEFAULT NULL,
  `player_id_blue` int(11) DEFAULT NULL,
  `duration_secs` int(11) DEFAULT NULL,
  `map_id` int(11) DEFAULT NULL,
  `winner_player_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id_orange` (`player_id_orange`),
  KEY `player_id_blue` (`player_id_blue`),
  KEY `map_id` (`map_id`),
  KEY `matches_ibfk_4_idx` (`winner_player_id`),
  CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`player_id_orange`) REFERENCES `players` (`id`),
  CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`player_id_blue`) REFERENCES `players` (`id`),
  CONSTRAINT `matches_ibfk_3` FOREIGN KEY (`map_id`) REFERENCES `maps` (`id`),
  CONSTRAINT `matches_ibfk_4` FOREIGN KEY (`winner_player_id`) REFERENCES `players` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=120001 DEFAULT CHARSET=latin1;

