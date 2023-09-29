-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema discord_app
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema discord_app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `discord_app` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `discord_app` ;

-- -----------------------------------------------------
-- Table `discord_app`.`user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discord_app`.`user_roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_name` (`role_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `discord_app`.`user_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discord_app`.`user_status` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE INDEX `status_name` (`status_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `discord_app`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discord_app`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `date_of_birth` DATE NULL DEFAULT NULL,
  `phone_number` VARCHAR(15) NULL DEFAULT NULL,
  `creation_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` TIMESTAMP NULL DEFAULT NULL,
  `user_status_status_id` INT NOT NULL,
  `user_roles_role_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `user_status_status_id`, `user_roles_role_id`),
  UNIQUE INDEX `username` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `fk_users_user_status1_idx` (`user_status_status_id` ASC) VISIBLE,
  INDEX `fk_users_user_roles1_idx` (`user_roles_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_user_status1`
    FOREIGN KEY (`user_status_status_id`)
    REFERENCES `discord_app`.`user_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_user_roles1`
    FOREIGN KEY (`user_roles_role_id`)
    REFERENCES `discord_app`.`user_roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `discord_app`.`servers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discord_app`.`servers` (
  `server_Id` INT NOT NULL AUTO_INCREMENT,
  `server_name` VARCHAR(45) NULL,
  PRIMARY KEY (`server_Id`),
  UNIQUE INDEX `server_Id_UNIQUE` (`server_Id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discord_app`.`channels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discord_app`.`channels` (
  `chanel_id` INT NOT NULL AUTO_INCREMENT,
  `chanel_name` VARCHAR(45) NULL,
  `Servers_server_Id` INT NOT NULL,
  PRIMARY KEY (`chanel_id`, `Servers_server_Id`),
  UNIQUE INDEX `chanel_id_UNIQUE` (`chanel_id` ASC) VISIBLE,
  INDEX `fk_chanel_Servers1_idx` (`Servers_server_Id` ASC) VISIBLE,
  CONSTRAINT `fk_chanel_Servers1`
    FOREIGN KEY (`Servers_server_Id`)
    REFERENCES `discord_app`.`servers` (`server_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discord_app`.`suscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discord_app`.`suscription` (
  `users_user_id` INT NOT NULL,
  `servers_server_Id` INT NOT NULL,
  PRIMARY KEY (`users_user_id`, `servers_server_Id`),
  INDEX `fk_users_has_servers_servers1_idx` (`servers_server_Id` ASC) VISIBLE,
  INDEX `fk_users_has_servers_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_servers_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `discord_app`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_servers_servers1`
    FOREIGN KEY (`servers_server_Id`)
    REFERENCES `discord_app`.`servers` (`server_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `discord_app`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discord_app`.`messages` (
  `messages_id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `creation_date` TEXT(500) NULL,
  `channels_chanel_id` INT NOT NULL,
  `users_user_id` INT NOT NULL,
  PRIMARY KEY (`messages_id`, `channels_chanel_id`, `users_user_id`),
  UNIQUE INDEX `messages_id_UNIQUE` (`messages_id` ASC) VISIBLE,
  INDEX `fk_messages_channels1_idx` (`channels_chanel_id` ASC) VISIBLE,
  INDEX `fk_messages_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_messages_channels1`
    FOREIGN KEY (`channels_chanel_id`)
    REFERENCES `discord_app`.`channels` (`chanel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `discord_app`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
