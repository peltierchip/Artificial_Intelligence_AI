-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema classicmodels
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `classicmodels` ;

-- -----------------------------------------------------
-- Schema classicmodels
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `classicmodels` DEFAULT CHARACTER SET latin1 ;
USE `classicmodels` ;

-- -----------------------------------------------------
-- Table `classicmodels`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`customers` (
  `customerID` INT NOT NULL,
  `customerName` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `addressLine1` VARCHAR(50) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `rewards_points` INT NOT NULL,
  `preferred mode` VARCHAR(45) NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `classicmodels`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`payments` (
  `customerID` INT NOT NULL,
  `paymentNumber` VARCHAR(50) NOT NULL,
  `paymentDate` DATE NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`customerID`, `paymentNumber`),
  CONSTRAINT `payments_ibfk_1`
    FOREIGN KEY (`customerID`)
    REFERENCES `classicmodels`.`customers` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `classicmodels`.`coupon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`coupon` (
  `idcoupon` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `issueDate` DATE NOT NULL,
  `expiryDate` DATE NOT NULL,
  `couponstatus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcoupon`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `classicmodels`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`orders` (
  `OrderID` INT NOT NULL,
  `quantity` VARCHAR(45) NOT NULL,
  `orderdate` DATE NOT NULL,
  `customerID` INT NOT NULL,
  `coupon_idcoupon` INT NULL,
  PRIMARY KEY (`OrderID`, `customerID`),
  INDEX `fk_order_customers1_idx` (`customerID` ASC) VISIBLE,
  INDEX `fk_order_coupon1_idx` (`coupon_idcoupon` ASC) VISIBLE,
  CONSTRAINT `fk_order_customers1`
    FOREIGN KEY (`customerID`)
    REFERENCES `classicmodels`.`customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_coupon1`
    FOREIGN KEY (`coupon_idcoupon`)
    REFERENCES `classicmodels`.`coupon` (`idcoupon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `classicmodels`.`voucher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`voucher` (
  `VoucherID` INT NOT NULL,
  `voucher_category` VARCHAR(45) NOT NULL,
  `voucher_amount` INT NOT NULL,
  `voucher_qty` VARCHAR(45) NOT NULL,
  `voucher_design` INT NOT NULL,
  `OrderID` INT NOT NULL,
  `voucher_expiry` VARCHAR(45) NULL,
  PRIMARY KEY (`VoucherID`, `OrderID`),
  INDEX `fk_voucher_order1_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_voucher_order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `classicmodels`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `classicmodels`.`recipient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`recipient` (
  `idrecipient` INT NOT NULL,
  `recipient_name` VARCHAR(45) NOT NULL,
  `recipient_message` VARCHAR(45) NOT NULL,
  `recipient_email` VARCHAR(45) NOT NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`idrecipient`),
  INDEX `fk_receiptent_order1_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_receiptent_order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `classicmodels`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `classicmodels`.`customer_activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`customer_activity` (
  `customerID` INT NOT NULL,
  `active` VARCHAR(45) NOT NULL,
  `last_use_date` DATE NOT NULL,
  PRIMARY KEY (`customerID`),
  INDEX `fk_user_activity_customers1_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_user_activity_customers1`
    FOREIGN KEY (`customerID`)
    REFERENCES `classicmodels`.`customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `classicmodels`.`payer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `classicmodels`.`payer` (
  `idpayer` INT NOT NULL,
  `payer_first_name` VARCHAR(45) NOT NULL,
  `payer_email` VARCHAR(45) NOT NULL,
  `payer_mode` VARCHAR(45) NOT NULL,
  `payment_status` VARCHAR(45) NOT NULL,
  `payments_customerID` INT NOT NULL,
  `payments_paymentNumber` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idpayer`),
  INDEX `fk_payer_payments1_idx` (`payments_customerID` ASC, `payments_paymentNumber` ASC) VISIBLE,
  CONSTRAINT `fk_payer_payments1`
    FOREIGN KEY (`payments_customerID` , `payments_paymentNumber`)
    REFERENCES `classicmodels`.`payments` (`customerID` , `paymentNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `classicmodels`.`customers`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`customers` (`customerID`, `customerName`, `phone`, `addressLine1`, `email`, `date_of_birth`, `rewards_points`, `preferred mode`) VALUES (10001, 'mary tan', '92029292', 'blk 8 jurong', 'marytan@gmail.com', '1980-03-03', 10, 'email');
INSERT INTO `classicmodels`.`customers` (`customerID`, `customerName`, `phone`, `addressLine1`, `email`, `date_of_birth`, `rewards_points`, `preferred mode`) VALUES (10002, 'henry lee', '93993939', 'blk 9 changi', 'henrylee@gmail.com', '1981-02-03', 0, 'email');
INSERT INTO `classicmodels`.`customers` (`customerID`, `customerName`, `phone`, `addressLine1`, `email`, `date_of_birth`, `rewards_points`, `preferred mode`) VALUES (10003, 'li xiao long', '89383893', '6 ave', 'lixiaolong@gmail.com', '1971-02-02', 500, 'email');
INSERT INTO `classicmodels`.`customers` (`customerID`, `customerName`, `phone`, `addressLine1`, `email`, `date_of_birth`, `rewards_points`, `preferred mode`) VALUES (10004, 'jeril joseph', '95485445', '5 ave', 'jeriljoseph@gmail.com', '1990-02-08', 20, 'sms');
INSERT INTO `classicmodels`.`customers` (`customerID`, `customerName`, `phone`, `addressLine1`, `email`, `date_of_birth`, `rewards_points`, `preferred mode`) VALUES (10005, 'milo chua', '85474556', '4 ave', 'mliochua@gmail.com', '2002-08-08', 50, 'sms');
INSERT INTO `classicmodels`.`customers` (`customerID`, `customerName`, `phone`, `addressLine1`, `email`, `date_of_birth`, `rewards_points`, `preferred mode`) VALUES (10006, 'phua chu kang', '94721324', '3 ave ', 'pck@gmail.com', '2013-08-08', 40, 'mail');
INSERT INTO `classicmodels`.`customers` (`customerID`, `customerName`, `phone`, `addressLine1`, `email`, `date_of_birth`, `rewards_points`, `preferred mode`) VALUES (10007, 'zoey tay', '84843555', 'changi coast road', 'zoeytay@gmail.com', '1950-04-04', 1000, 'mail');

COMMIT;


-- -----------------------------------------------------
-- Data for table `classicmodels`.`payments`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`payments` (`customerID`, `paymentNumber`, `paymentDate`, `amount`) VALUES (10001, '1', '2022-01-01', 10);
INSERT INTO `classicmodels`.`payments` (`customerID`, `paymentNumber`, `paymentDate`, `amount`) VALUES (10002, '2', '2022-01-02', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `classicmodels`.`coupon`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`coupon` (`idcoupon`, `value`, `issueDate`, `expiryDate`, `couponstatus`) VALUES (0, '0', '2022-01-01', '2099-01-01', 'no coupon');

COMMIT;


-- -----------------------------------------------------
-- Data for table `classicmodels`.`orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (1, '1', '2022-01-01', 10001, 0);
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (2, '1', '2022-01-02', 10002, 0);
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (3, '1', '2022-01-02', 10003, 0);
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (4, '2', '2022-01-02', 10001, 0);
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (5, '1', '2022-01-03', 10005, 0);
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (6, '2', '2022-01-03', 10007, 0);
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (7, '1', '2022-01-04', 10003, 0);
INSERT INTO `classicmodels`.`orders` (`OrderID`, `quantity`, `orderdate`, `customerID`, `coupon_idcoupon`) VALUES (8, '2', '2022-01-04', 10002, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `classicmodels`.`voucher`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (1, 'food', 10, '1', 1, 1, '2022-09-09');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (2, 'ride', 20, '1', 2, 2, '2022-09-10');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (3, 'food', 30, '2', 3, 2, '2022-09-11');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (4, 'food', 10, '1', 4, 3, '2022-09-12');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (5, 'food', 20, '2', 5, 4, '2022-09-13');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (6, 'ride', 15, '1', 3, 5, '2022-09-13');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (7, 'ride', 20, '1', 2, 6, '2022-09-13');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (8, 'ride', 40, '1', 1, 7, '2022-09-14');
INSERT INTO `classicmodels`.`voucher` (`VoucherID`, `voucher_category`, `voucher_amount`, `voucher_qty`, `voucher_design`, `OrderID`, `voucher_expiry`) VALUES (9, 'food', 50, '1', 2, 8, '2022-09-114');

COMMIT;


-- -----------------------------------------------------
-- Data for table `classicmodels`.`recipient`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`recipient` (`idrecipient`, `recipient_name`, `recipient_message`, `recipient_email`, `OrderID`) VALUES (1, 'jane', 'happy new year', 'janeli@gmail.com', 1);
INSERT INTO `classicmodels`.`recipient` (`idrecipient`, `recipient_name`, `recipient_message`, `recipient_email`, `OrderID`) VALUES (2, 'tony', 'have fun', 'tony@gmail.com', 2);
INSERT INTO `classicmodels`.`recipient` (`idrecipient`, `recipient_name`, `recipient_message`, `recipient_email`, `OrderID`) VALUES (3, 'thomas', 'for u', 'thomas@gmail.com', 3);
INSERT INTO `classicmodels`.`recipient` (`idrecipient`, `recipient_name`, `recipient_message`, `recipient_email`, `OrderID`) VALUES (4, 'minli', 'happy dinner', 'minli@gmail.com', 4);
INSERT INTO `classicmodels`.`recipient` (`idrecipient`, `recipient_name`, `recipient_message`, `recipient_email`, `OrderID`) VALUES (5, 'jason', 'tgif', 'jason@gmail.com', 5);
INSERT INTO `classicmodels`.`recipient` (`idrecipient`, `recipient_name`, `recipient_message`, `recipient_email`, `OrderID`) VALUES (6, 'gaga', 'go ride', 'gaga@gmail.com', 6);
INSERT INTO `classicmodels`.`recipient` (`idrecipient`, `recipient_name`, `recipient_message`, `recipient_email`, `OrderID`) VALUES (7, 'phua chu kang', 'for u', 'ppck@gmail.com', 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `classicmodels`.`customer_activity`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`customer_activity` (`customerID`, `active`, `last_use_date`) VALUES (10001, 'yes', '2022-01-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `classicmodels`.`payer`
-- -----------------------------------------------------
START TRANSACTION;
USE `classicmodels`;
INSERT INTO `classicmodels`.`payer` (`idpayer`, `payer_first_name`, `payer_email`, `payer_mode`, `payment_status`, `payments_customerID`, `payments_paymentNumber`) VALUES (10001, 'mary tan', 'marytan@gmail.com', 'visa', 'valid', 10001, '1');

COMMIT;

