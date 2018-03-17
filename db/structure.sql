
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
DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_class` int(11) NOT NULL COMMENT '承認イベント',
  `comment` text,
  `person_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_events_on_person_id` (`person_id`),
  KEY `index_events_on_person_id_and_event_class` (`person_id`,`event_class`),
  CONSTRAINT `fk_rails_0dd58ac981` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `flows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flows` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `create_datetime` datetime DEFAULT NULL,
  `application_datetime` datetime DEFAULT NULL,
  `archive_datetime` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `latest_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `latest_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `event_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_latest_events_on_person_id_and_event_id` (`person_id`,`event_id`),
  KEY `index_latest_events_on_person_id` (`person_id`),
  KEY `index_latest_events_on_event_id` (`event_id`),
  CONSTRAINT `fk_rails_6d98f5c276` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rails_f492be0340` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `latest_step_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `latest_step_histories` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `step_id` bigint(20) NOT NULL,
  `step_history_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_latest_step_histories_on_step_id_and_step_history_id` (`step_id`,`step_history_id`),
  KEY `index_latest_step_histories_on_step_id` (`step_id`),
  KEY `index_latest_step_histories_on_step_history_id` (`step_history_id`),
  CONSTRAINT `fk_rails_3fe78cb76c` FOREIGN KEY (`step_history_id`) REFERENCES `step_histories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rails_d6407819de` FOREIGN KEY (`step_id`) REFERENCES `steps` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` varchar(255) NOT NULL,
  `step_history_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_people_on_step_history_id_and_person_id` (`step_history_id`,`person_id`),
  KEY `index_people_on_step_history_id` (`step_history_id`),
  CONSTRAINT `fk_rails_9f02094812` FOREIGN KEY (`step_history_id`) REFERENCES `step_histories` (`id`) ON DELETE CASCADE
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
DROP TABLE IF EXISTS `step_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `step_histories` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operator` int(11) NOT NULL COMMENT '演算子(10:AND,20:OR)',
  `step_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_step_histories_on_step_id` (`step_id`),
  CONSTRAINT `fk_rails_bd6c7ef37b` FOREIGN KEY (`step_id`) REFERENCES `steps` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `steps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `step_num` int(11) NOT NULL,
  `step_class` int(11) NOT NULL COMMENT 'ステップ区分(10:開始,20:承認,30:配信,90:終了)',
  `flow_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_steps_on_flow_id_and_step_num` (`flow_id`,`step_num`),
  KEY `index_steps_on_flow_id` (`flow_id`),
  KEY `index_steps_on_flow_id_and_step_class` (`flow_id`,`step_class`),
  CONSTRAINT `fk_rails_dd10677e21` FOREIGN KEY (`flow_id`) REFERENCES `flows` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `view_flow_statuses`;
/*!50001 DROP VIEW IF EXISTS `view_flow_statuses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_flow_statuses` AS SELECT 
 1 AS `id`,
 1 AS `creator_id`,
 1 AS `meta`,
 1 AS `create_datetime`,
 1 AS `application_datetime`,
 1 AS `archive_datetime`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `status`,
 1 AS `step_num`,
 1 AS `step_class`,
 1 AS `step_status`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_latest_events`;
/*!50001 DROP VIEW IF EXISTS `view_latest_events`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_latest_events` AS SELECT 
 1 AS `id`,
 1 AS `event_class`,
 1 AS `comment`,
 1 AS `person_id`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_latest_step_histories`;
/*!50001 DROP VIEW IF EXISTS `view_latest_step_histories`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_latest_step_histories` AS SELECT 
 1 AS `id`,
 1 AS `operator`,
 1 AS `step_id`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_person_statuses`;
/*!50001 DROP VIEW IF EXISTS `view_person_statuses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_person_statuses` AS SELECT 
 1 AS `id`,
 1 AS `person_id`,
 1 AS `step_history_id`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `event_class`,
 1 AS `comment`,
 1 AS `none_flag`,
 1 AS `active_flag`,
 1 AS `complete_flag`,
 1 AS `reject_flag`,
 1 AS `rejected_flag`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `view_step_statuses`;
/*!50001 DROP VIEW IF EXISTS `view_step_statuses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_step_statuses` AS SELECT 
 1 AS `id`,
 1 AS `flow_id`,
 1 AS `step_num`,
 1 AS `step_class`,
 1 AS `operator`,
 1 AS `step_status`*/;
SET character_set_client = @saved_cs_client;
/*!50001 DROP VIEW IF EXISTS `view_flow_statuses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_flow_statuses` AS select `f`.`id` AS `id`,`f`.`creator_id` AS `creator_id`,`f`.`meta` AS `meta`,`f`.`create_datetime` AS `create_datetime`,`f`.`application_datetime` AS `application_datetime`,`f`.`archive_datetime` AS `archive_datetime`,`f`.`created_at` AS `created_at`,`f`.`updated_at` AS `updated_at`,(case when ((`vss`.`step_class` = 10) and (`vss`.`step_status` = 'active')) then 'draft' when ((`vss`.`step_class` = 10) and (`vss`.`step_status` = 'rejected')) then 'rejected' when (`vss`.`step_class` = 90) then 'archive' else 'active' end) AS `status`,`vss`.`step_num` AS `step_num`,`vss`.`step_class` AS `step_class`,`vss`.`step_status` AS `step_status` from (`flows` `f` join `view_step_statuses` `vss` on(((`f`.`id` = `vss`.`flow_id`) and ((`vss`.`step_status` = 'rejected') or (`vss`.`step_status` = 'active'))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `view_latest_events`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_latest_events` AS select `e`.`id` AS `id`,`e`.`event_class` AS `event_class`,`e`.`comment` AS `comment`,`e`.`person_id` AS `person_id`,`e`.`created_at` AS `created_at`,`e`.`updated_at` AS `updated_at` from (`latest_events` `le` join `events` `e` on((`le`.`event_id` = `e`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `view_latest_step_histories`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_latest_step_histories` AS select `sh`.`id` AS `id`,`sh`.`operator` AS `operator`,`sh`.`step_id` AS `step_id`,`sh`.`created_at` AS `created_at`,`sh`.`updated_at` AS `updated_at` from (`latest_step_histories` `lsh` join `step_histories` `sh` on((`lsh`.`step_history_id` = `sh`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `view_person_statuses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_person_statuses` AS select `p`.`id` AS `id`,`p`.`person_id` AS `person_id`,`p`.`step_history_id` AS `step_history_id`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at`,`vle`.`event_class` AS `event_class`,`vle`.`comment` AS `comment`,(isnull(`vle`.`event_class`) or (`vle`.`event_class` = 800)) AS `none_flag`,((`vle`.`event_class` = 100) or (`vle`.`event_class` = 200) or (`vle`.`event_class` = 300) or (`vle`.`event_class` = 900)) AS `active_flag`,((`vle`.`event_class` = 110) or (`vle`.`event_class` = 210) or (`vle`.`event_class` = 240) or (`vle`.`event_class` = 310)) AS `complete_flag`,(`vle`.`event_class` = 220) AS `reject_flag`,((`vle`.`event_class` = 120) or (`vle`.`event_class` = 230)) AS `rejected_flag` from (`people` `p` left join `view_latest_events` `vle` on((`p`.`id` = `vle`.`person_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `view_step_statuses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_step_statuses` AS select `s`.`id` AS `id`,`s`.`flow_id` AS `flow_id`,`s`.`step_num` AS `step_num`,`s`.`step_class` AS `step_class`,`vlsh`.`operator` AS `operator`,(case when ((`s`.`step_class` in (10,20,90)) and (0 < sum(`vps`.`active_flag`))) then 'active' when ((`s`.`step_class` = 10) and (count(1) <= sum(`vps`.`complete_flag`))) then 'complete' when ((`s`.`step_class` = 10) and (0 < sum(`vps`.`rejected_flag`))) then 'rejected' when ((`s`.`step_class` = 20) and (0 < sum(`vps`.`reject_flag`))) then 'reject' when ((`s`.`step_class` = 20) and (0 < sum(`vps`.`rejected_flag`))) then 'active' when ((`s`.`step_class` = 20) and (`vlsh`.`operator` = 10) and (count(1) <= sum(`vps`.`complete_flag`))) then 'complete' when ((`s`.`step_class` = 20) and (`vlsh`.`operator` = 20) and (0 < sum(`vps`.`complete_flag`))) then 'complete' when ((`s`.`step_class` = 30) and (0 < sum(`vps`.`active_flag`))) then 'complete' when ((`s`.`step_class` = 30) and (0 < sum(`vps`.`complete_flag`))) then 'complete' else 'none' end) AS `step_status` from ((`steps` `s` join `view_latest_step_histories` `vlsh` on((`s`.`id` = `vlsh`.`step_id`))) join `view_person_statuses` `vps` on((`vlsh`.`id` = `vps`.`step_history_id`))) group by `s`.`id`,`s`.`step_num`,`vlsh`.`operator` */;
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
('20180311124036'),
('20180311125834');


