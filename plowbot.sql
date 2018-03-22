-- plowbot mysql database schema and default table(s) --
CREATE DATABASE IF NOT EXISTS `plowbot`;

USE plowbot;

CREATE TABLE `plowbot_logs` (
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

-- needs plowbot_quotes table. wtf. --
