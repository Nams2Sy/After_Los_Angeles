CREATE TABLE `allreports` (
	`id` INT(11) NULL DEFAULT NULL,
	`data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`profilephoto` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci'
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;


CREATE TABLE `m_reports` (
	`identifier` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci'
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;
