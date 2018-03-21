
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `flows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flows` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flow_name` varchar(255) NOT NULL,
  `creator_key` varchar(255) DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `create_datetime` datetime DEFAULT NULL,
  `application_datetime` datetime DEFAULT NULL,
  `archive_datetime` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `latest_person_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `latest_person_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `person_event_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_latest_person_events_on_person_id` (`person_id`),
  KEY `index_latest_person_events_on_person_event_id` (`person_event_id`),
  CONSTRAINT `fk_rails_4ae662d6a0` FOREIGN KEY (`person_event_id`) REFERENCES `person_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rails_cf7aca8335` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `latest_step_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `latest_step_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `step_id` bigint(20) NOT NULL,
  `step_event_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_latest_step_events_on_step_id` (`step_id`),
  KEY `index_latest_step_events_on_step_event_id` (`step_event_id`),
  CONSTRAINT `fk_rails_4ad0657f28` FOREIGN KEY (`step_id`) REFERENCES `steps` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rails_9c95000d4d` FOREIGN KEY (`step_event_id`) REFERENCES `step_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_key` varchar(255) NOT NULL,
  `step_event_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_people_on_step_event_id_and_person_key` (`step_event_id`,`person_key`),
  KEY `index_people_on_step_event_id` (`step_event_id`),
  CONSTRAINT `fk_rails_3ae00d3444` FOREIGN KEY (`step_event_id`) REFERENCES `step_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `person_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_event_class` int(11) NOT NULL COMMENT 'イベント区分',
  `comment` text,
  `person_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_person_events_on_person_id` (`person_id`),
  KEY `index_person_events_on_person_id_and_person_event_class` (`person_id`,`person_event_class`),
  CONSTRAINT `fk_rails_23d4081652` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `step_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `step_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `step_event_class` int(11) NOT NULL COMMENT 'イベント区分',
  `step_order` int(11) NOT NULL DEFAULT '0' COMMENT '実行順',
  `step_name` varchar(255) NOT NULL COMMENT '名称',
  `step_operator` int(11) NOT NULL COMMENT '演算子(10:AND,20:OR)',
  `step_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_step_events_on_step_id` (`step_id`),
  CONSTRAINT `fk_rails_2f0649da98` FOREIGN KEY (`step_id`) REFERENCES `steps` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `steps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `step_class` int(11) NOT NULL COMMENT 'ステップ区分(10:開始,20:承認,30:配信,90:終了)',
  `flow_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_steps_on_flow_id` (`flow_id`),
  KEY `index_steps_on_flow_id_and_step_class` (`flow_id`,`step_class`),
  CONSTRAINT `fk_rails_dd10677e21` FOREIGN KEY (`flow_id`) REFERENCES `flows` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `view_flow_statuses`;
/*!50001 DROP VIEW IF EXISTS `view_flow_statuses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_flow_statuses` (
  `id` tinyint NOT NULL,
  `flow_name` tinyint NOT NULL,
  `creator_key` tinyint NOT NULL,
  `meta` tinyint NOT NULL,
  `create_datetime` tinyint NOT NULL,
  `application_datetime` tinyint NOT NULL,
  `archive_datetime` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `flow_status` tinyint NOT NULL,
  `step_name` tinyint NOT NULL,
  `step_order` tinyint NOT NULL,
  `step_class` tinyint NOT NULL,
  `step_status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_latest_person_events`;
/*!50001 DROP VIEW IF EXISTS `view_latest_person_events`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_latest_person_events` (
  `id` tinyint NOT NULL,
  `person_event_class` tinyint NOT NULL,
  `comment` tinyint NOT NULL,
  `person_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_latest_step_events`;
/*!50001 DROP VIEW IF EXISTS `view_latest_step_events`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_latest_step_events` (
  `id` tinyint NOT NULL,
  `step_event_class` tinyint NOT NULL,
  `step_order` tinyint NOT NULL,
  `step_name` tinyint NOT NULL,
  `step_operator` tinyint NOT NULL,
  `step_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_person_statuses`;
/*!50001 DROP VIEW IF EXISTS `view_person_statuses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_person_statuses` (
  `id` tinyint NOT NULL,
  `person_key` tinyint NOT NULL,
  `step_event_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `person_event_class` tinyint NOT NULL,
  `comment` tinyint NOT NULL,
  `none_flag` tinyint NOT NULL,
  `active_flag` tinyint NOT NULL,
  `finish_flag` tinyint NOT NULL,
  `reject_flag` tinyint NOT NULL,
  `rejected_flag` tinyint NOT NULL,
  `person_status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_step_statuses`;
/*!50001 DROP VIEW IF EXISTS `view_step_statuses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_step_statuses` (
  `id` tinyint NOT NULL,
  `flow_id` tinyint NOT NULL,
  `step_class` tinyint NOT NULL,
  `step_event_id` tinyint NOT NULL,
  `step_name` tinyint NOT NULL,
  `step_order` tinyint NOT NULL,
  `step_operator` tinyint NOT NULL,
  `step_status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `view_flow_statuses`*/;
/*!50001 DROP VIEW IF EXISTS `view_flow_statuses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_flow_statuses` AS select `f`.`id` AS `id`,`f`.`flow_name` AS `flow_name`,`f`.`creator_key` AS `creator_key`,`f`.`meta` AS `meta`,`f`.`create_datetime` AS `create_datetime`,`f`.`application_datetime` AS `application_datetime`,`f`.`archive_datetime` AS `archive_datetime`,`f`.`created_at` AS `created_at`,`f`.`updated_at` AS `updated_at`,(case when ((`vss`.`step_class` = 10) and (`vss`.`step_status` = 'active')) then 'draft' when ((`vss`.`step_class` = 10) and (`vss`.`step_status` = 'rejected')) then 'rejected' when (`vss`.`step_class` = 90) then 'archive' else 'active' end) AS `flow_status`,`vss`.`step_name` AS `step_name`,`vss`.`step_order` AS `step_order`,`vss`.`step_class` AS `step_class`,`vss`.`step_status` AS `step_status` from (`flows` `f` join `view_step_statuses` `vss` on(((`f`.`id` = `vss`.`flow_id`) and ((`vss`.`step_status` = 'rejected') or (`vss`.`step_status` = 'active'))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `view_latest_person_events`*/;
/*!50001 DROP VIEW IF EXISTS `view_latest_person_events`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_latest_person_events` AS select `pe`.`id` AS `id`,`pe`.`person_event_class` AS `person_event_class`,`pe`.`comment` AS `comment`,`pe`.`person_id` AS `person_id`,`pe`.`created_at` AS `created_at`,`pe`.`updated_at` AS `updated_at` from (`latest_person_events` `lpe` join `person_events` `pe` on((`lpe`.`person_event_id` = `pe`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `view_latest_step_events`*/;
/*!50001 DROP VIEW IF EXISTS `view_latest_step_events`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_latest_step_events` AS select `se`.`id` AS `id`,`se`.`step_event_class` AS `step_event_class`,`se`.`step_order` AS `step_order`,`se`.`step_name` AS `step_name`,`se`.`step_operator` AS `step_operator`,`se`.`step_id` AS `step_id`,`se`.`created_at` AS `created_at`,`se`.`updated_at` AS `updated_at` from (`latest_step_events` `lse` join `step_events` `se` on((`lse`.`step_event_id` = `se`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `view_person_statuses`*/;
/*!50001 DROP VIEW IF EXISTS `view_person_statuses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_person_statuses` AS select `p`.`id` AS `id`,`p`.`person_key` AS `person_key`,`p`.`step_event_id` AS `step_event_id`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at`,`vlpe`.`person_event_class` AS `person_event_class`,`vlpe`.`comment` AS `comment`,(isnull(`vlpe`.`person_event_class`) or (`vlpe`.`person_event_class` = 800)) AS `none_flag`,((`vlpe`.`person_event_class` = 100) or (`vlpe`.`person_event_class` = 200) or (`vlpe`.`person_event_class` = 300) or (`vlpe`.`person_event_class` = 900)) AS `active_flag`,((`vlpe`.`person_event_class` = 110) or (`vlpe`.`person_event_class` = 210) or (`vlpe`.`person_event_class` = 240) or (`vlpe`.`person_event_class` = 310)) AS `finish_flag`,(`vlpe`.`person_event_class` = 220) AS `reject_flag`,((`vlpe`.`person_event_class` = 120) or (`vlpe`.`person_event_class` = 230)) AS `rejected_flag`,(case when (isnull(`vlpe`.`person_event_class`) or (`vlpe`.`person_event_class` = 800)) then 'none' when ((`vlpe`.`person_event_class` = 100) or (`vlpe`.`person_event_class` = 200) or (`vlpe`.`person_event_class` = 300) or (`vlpe`.`person_event_class` = 900)) then 'active' when ((`vlpe`.`person_event_class` = 110) or (`vlpe`.`person_event_class` = 210) or (`vlpe`.`person_event_class` = 240) or (`vlpe`.`person_event_class` = 310)) then 'finish' when (`vlpe`.`person_event_class` = 220) then 'none' when ((`vlpe`.`person_event_class` = 120) or (`vlpe`.`person_event_class` = 230)) then 'active' else 'none' end) AS `person_status` from (`people` `p` left join `view_latest_person_events` `vlpe` on((`p`.`id` = `vlpe`.`person_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `view_step_statuses`*/;
/*!50001 DROP VIEW IF EXISTS `view_step_statuses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_step_statuses` AS select `s`.`id` AS `id`,`s`.`flow_id` AS `flow_id`,`s`.`step_class` AS `step_class`,`vlse`.`id` AS `step_event_id`,`vlse`.`step_name` AS `step_name`,`vlse`.`step_order` AS `step_order`,`vlse`.`step_operator` AS `step_operator`,(case when ((`s`.`step_class` in (10,20,90)) and (0 < sum(`vps`.`active_flag`))) then 'active' when ((`s`.`step_class` = 10) and (count(1) <= sum(`vps`.`finish_flag`))) then 'finish' when ((`s`.`step_class` = 10) and (0 < sum(`vps`.`rejected_flag`))) then 'rejected' when ((`s`.`step_class` = 20) and (0 < sum(`vps`.`reject_flag`))) then 'reject' when ((`s`.`step_class` = 20) and (0 < sum(`vps`.`rejected_flag`))) then 'active' when ((`s`.`step_class` = 20) and (`vlse`.`step_operator` = 10) and (count(1) <= sum(`vps`.`finish_flag`))) then 'finish' when ((`s`.`step_class` = 20) and (`vlse`.`step_operator` = 20) and (0 < sum(`vps`.`finish_flag`))) then 'finish' when ((`s`.`step_class` = 30) and (0 < sum(`vps`.`active_flag`))) then 'finish' when ((`s`.`step_class` = 30) and (0 < sum(`vps`.`finish_flag`))) then 'finish' else 'none' end) AS `step_status` from ((`steps` `s` join `view_latest_step_events` `vlse` on((`s`.`id` = `vlse`.`step_id`))) join `view_person_statuses` `vps` on((`vlse`.`id` = `vps`.`step_event_id`))) group by `s`.`id`,`s`.`flow_id`,`s`.`step_class`,`vlse`.`id`,`vlse`.`step_name`,`vlse`.`step_order`,`vlse`.`step_operator` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `schema_migrations` (version) VALUES
('20180305124121'),
('20180306124748'),
('20180306125012'),
('20180306125249'),
('20180306125506'),
('20180306125738'),
('20180306125824'),
('20180311113820'),
('20180311113828'),
('20180311113912'),
('20180317152427'),
('20180317152443');


