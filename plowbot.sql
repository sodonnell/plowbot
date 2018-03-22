-- plowbot mysql database schema and default table(s) --
CREATE DATABASE IF NOT EXISTS `plowbot`;

USE plowbot;

CREATE TABLE IF NOT EXISTS `plowbot_logs` (
  `id` mediumint(11) NOT NULL auto_increment,
  `nickname` varchar(25) default NULL,
  `address` varchar(100) NOT NULL,
  `channel` varchar(50) default NULL,
  `server` varchar(50) default NULL,
  `message` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `message` (`message`)
) ENGINE=InnoDB COMMENT='IRC Channel Logging Table for the PlowBot Perl Script.';

CREATE TABLE IF NOT EXISTS `plowbot_quotes` (
`id` int(11) NOT NULL auto_increment,
`quote` TEXT NOT NULL,
`nickname` varchar(50) NOT NULL,
`channel` varchar(50) NOT NULL,
`server` varchar(50) NOT NULL,
`created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
PRIMARY KEY  (`id`),
KEY `nickname` (`nickname`),
KEY `channel` (`channel`),
KEY `server` (`server`)
) ENGINE=InnoDB COMMENT='IRC Channel Quote Table for the PlowBot Perl Script.';
