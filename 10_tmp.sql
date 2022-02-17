-- 1
CREATE TABLE IF NOT EXISTS `Homeworks` (
    `ID`          BIGINT UNSIGNED    NOT NULL     AUTO_INCREMENT,
    `DueDate`     DATETIME           NOT NULL     COMMENT 'Use UTC time',
    `TaskText`    VARCHAR(8000)      NOT NULL,
    `LessonID`    BIGINT UNSIGNED    NOT NULL,

    CONSTRAINT    `PK_Homework`           PRIMARY KEY (`ID`),
    CONSTRAINT    `FK_LessonHomeworks`    FOREIGN KEY (`LessonID`)    REFERENCES `Lessons` (`ID`),

    INDEX    `IX_Lesson`    (`LessonID` ASC)
);
--  2
INSERT INTO `Homeworks`
(`DueDate`, `TaskText`, `LessonID`)
VALUES
('2021-07-30 10:00:00', 'Homework task placeholder', 2),
-- ...//24 rows
-- 3
ALTER TABLE `Homeworks`
    ADD    `PublishingDate`    DATETIME,
    ADD    `CreatedBy`         BIGINT UNSIGNED;
-- 4
CREATE TEMPORARY TABLE `Soft`.`TempHomeworks` (
	`ID`				BIGINT UNSIGNED    NOT NULL         AUTO_INCREMENT,
    `PublishingDate`    DATETIME           NOT NUll,
	`CreatedBy`	        BIGINT UNSIGNED    NOT NULL,
    
    CONSTRAINT    `PK_THomework`    PRIMARY KEY (`ID`)
);
-- 
INSERT INTO `Soft`.`TempHomeworks`
(`PublishingDate`, `CreatedBy`)
VALUES
('2021-06-30 10:00:00', 24),
-- ...//24 rows
-- 
UPDATE `Soft`.`Homeworks` AS H
	INNER JOIN `Soft`.`TempHomeworks` AS T
	ON H.`ID` = T.`ID`
	SET H.`PublishingDate` = T.`PublishingDate`,
		H.`CreatedBy` = T.`CreatedBy`
	WHERE H.`ID` = T.`ID`;
-- 
ALTER TABLE `Homeworks`  
    ADD CONSTRAINT    `FK_AccountOfHomework`    FOREIGN KEY (`CreatedBy`)    REFERENCES `Accounts` (`ID`);
-- 

-- line 377
ALTER TABLE `Homeworks`
    MODIFY    `PublishingDate`    DATETIME           NOT NULL,
    MODIFY    `CreatedBy`         BIGINT UNSIGNED    NOT NULL;
-- 
-- │ Error running command 'mysql ... --host=mysqlinstance.cgdizvert0bq.eu-central-1.rds.amazonaws.com < ./scripts/4_update_data_for_homeworks.sql':
-- │ exit status 1. Output: ERROR 1832 (HY000) at line 377: Cannot change column 'CreatedBy': used in a foreign key
-- │ constraint 'FK_AccountOfHomework'