CREATE TABLE IF NOT EXISTS `codemstaff` (
  `identifier` char(50) DEFAULT NULL,
  `stateattr` longtext DEFAULT NULL,
  `name` char(50) DEFAULT NULL,
  `rank` int(11) DEFAULT 0,
  `banned` tinyint(4) DEFAULT 0,
  `time` bigint(20) DEFAULT NULL,
  `lastreason` text DEFAULT NULL,
  `bannedidentifier` char(50) DEFAULT NULL,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;