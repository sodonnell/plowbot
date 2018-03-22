-- plowbot mysql database schema and default table(s) --
CREATE DATABASE IF NOT EXISTS `plowbot`;

USE plowbot;

CREATE TABLE IF NOT EXISTS `plowbot_logs` (
  `id` mediumint(11) NOT NULL auto_increment,
  `nick` varchar(25) default NULL,
  `address` varchar(100) NOT NULL,
  `chan` varchar(50) default NULL,
  `server` varchar(50) default NULL,
  `textinput` varchar(255) default NULL,
  `logstamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `textinput` (`textinput`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IRC Channel Logging Table for the PlowBot Perl Script.';

CREATE TABLE IF NOT EXISTS `plowbot_quotes` (
`id` int(11) NOT NULL auto_increment,
`quote` TEXT NOT NULL,
`nickname` varchar(50) NOT NULL,
`channel` varchar(50) NOT NULL,
`network` varchar(50) NOT NULL,
`created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
PRIMARY KEY  (`id`),
KEY `nickname` (`nickname`),
KEY `channel` (`channel`),
KEY `network` (`network`)
) ENGINE=InnoDB;
