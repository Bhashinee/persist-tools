-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `MedicalNeed`;
DROP TABLE IF EXISTS `MedicalItem`;

CREATE TABLE `MedicalItem` (
	`itemId` INT NOT NULL,
	`string` VARCHAR(191) NOT NULL,
	`type` VARCHAR(191) NOT NULL,
	`unit` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`itemId`)
);

CREATE TABLE `MedicalNeed` (
	`record` INT NOT NULL,
	`beneficiaryId` INT NOT NULL,
	`time` DATETIME NOT NULL,
	`urgency` VARCHAR(191) NOT NULL,
	`quantity` INT NOT NULL,
	`itemItemId` INT UNIQUE NOT NULL,
	FOREIGN KEY(`itemItemId`) REFERENCES `MedicalItem`(`itemId`),
	PRIMARY KEY(`record`)
);
