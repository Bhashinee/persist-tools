-- AUTO-GENERATED FILE.
-- This file is an auto-generated file by Ballerina persistence layer for the migrate command.
-- Please verify the generated scripts and execute them against the target DB server.


CREATE TABLE `Engine` (
	`id` INT NOT NULL,
	`make` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`id`)
);

ALTER TABLE Car
ADD COLUMN engineId INT NOT NULL;

ALTER TABLE Car
ADD CONSTRAINT FK_Car_Engine FOREIGN KEY (engineId) REFERENCES Engine(id);

