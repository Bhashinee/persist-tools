-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `ByteTest`;

CREATE TABLE `ByteTest` (
	`id` INT NOT NULL,
	`binary1` LONGBLOB NOT NULL,
	`binaryOptional` LONGBLOB,
	PRIMARY KEY(`id`)
);
