-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Monedas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Monedas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Monedas` (
  `monedaID` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `acronimo` VARCHAR(5) NOT NULL,
  `MonedaBase` TINYINT NOT NULL DEFAULT 0,
  `Simbolo` NVARCHAR(3) NOT NULL,
  PRIMARY KEY (`monedaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Paises` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Paises` (
  `paisID` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `monedaID` INT NOT NULL,
  PRIMARY KEY (`paisID`),
  INDEX `fk_Paises_Monedas_idx` (`monedaID` ASC) VISIBLE,
  CONSTRAINT `fk_Paises_Monedas`
    FOREIGN KEY (`monedaID`)
    REFERENCES `mydb`.`Monedas` (`monedaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EstadosEntrenamiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EstadosEntrenamiento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EstadosEntrenamiento` (
  `estadoEntrenamientoID` SMALLINT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`estadoEntrenamientoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TiposDeCambio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TiposDeCambio` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TiposDeCambio` (
  `tipoDeCambioID` INT NOT NULL AUTO_INCREMENT,
  `inicioVigencia` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finalVigencia` VARCHAR(45) NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `precioCambio` DECIMAL(18,6) NOT NULL,
  `monedaID` INT NOT NULL,
  PRIMARY KEY (`tipoDeCambioID`),
  INDEX `fk_TiposDeCambio_Monedas1_idx` (`monedaID` ASC) VISIBLE,
  CONSTRAINT `fk_TiposDeCambio_Monedas1`
    FOREIGN KEY (`monedaID`)
    REFERENCES `mydb`.`Monedas` (`monedaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Roles` (
  `rolID` SMALLINT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`rolID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Empleados` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Empleados` (
  `empleadoID` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(65) NOT NULL,
  `correo` VARCHAR(65) NOT NULL,
  `rolID` SMALLINT NOT NULL,
  `paisID` INT NOT NULL,
  PRIMARY KEY (`empleadoID`),
  INDEX `fk_Empleados_Roles1_idx` (`rolID` ASC) VISIBLE,
  INDEX `fk_Empleados_Paises1_idx` (`paisID` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Roles1`
    FOREIGN KEY (`rolID`)
    REFERENCES `mydb`.`Roles` (`rolID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleados_Paises1`
    FOREIGN KEY (`paisID`)
    REFERENCES `mydb`.`Paises` (`paisID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EntradasEmpleadosLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EntradasEmpleadosLogs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EntradasEmpleadosLogs` (
  `empleadoID` INT NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_EntradasEmpleadosLogs_Empleados1_idx` (`empleadoID` ASC) VISIBLE,
  PRIMARY KEY (`empleadoID`, `timestamp`),
  CONSTRAINT `fk_EntradasEmpleadosLogs_Empleados1`
    FOREIGN KEY (`empleadoID`)
    REFERENCES `mydb`.`Empleados` (`empleadoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SalidasEmpleadosLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SalidasEmpleadosLogs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SalidasEmpleadosLogs` (
  `empleadoID` INT NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_EntradasEmpleadosLogs_Empleados1_idx` (`empleadoID` ASC) VISIBLE,
  PRIMARY KEY (`empleadoID`, `timestamp`),
  CONSTRAINT `fk_EntradasEmpleadosLogs_Empleados10`
    FOREIGN KEY (`empleadoID`)
    REFERENCES `mydb`.`Empleados` (`empleadoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EntrenamientosLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EntrenamientosLogs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EntrenamientosLogs` (
  `empleadoID` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `estadoEntrenamientoID` SMALLINT NOT NULL,
  INDEX `fk_EntrenamientosLogs_Empleados1_idx` (`empleadoID` ASC) VISIBLE,
  PRIMARY KEY (`empleadoID`, `fecha`),
  INDEX `fk_EntrenamientosLogs_EstadosEntrenamiento1_idx` (`estadoEntrenamientoID` ASC) VISIBLE,
  CONSTRAINT `fk_EntrenamientosLogs_Empleados1`
    FOREIGN KEY (`empleadoID`)
    REFERENCES `mydb`.`Empleados` (`empleadoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EntrenamientosLogs_EstadosEntrenamiento1`
    FOREIGN KEY (`estadoEntrenamientoID`)
    REFERENCES `mydb`.`EstadosEntrenamiento` (`estadoEntrenamientoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CargosXPaises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CargosXPaises` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CargosXPaises` (
  `paisID` INT NOT NULL,
  `inicioVigencia` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finalVigencia` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `porcentaje` DECIMAL(18,6) NOT NULL,
  INDEX `fk_CargosXPaises_Paises1_idx` (`paisID` ASC) VISIBLE,
  PRIMARY KEY (`paisID`, `inicioVigencia`),
  CONSTRAINT `fk_CargosXPaises_Paises1`
    FOREIGN KEY (`paisID`)
    REFERENCES `mydb`.`Paises` (`paisID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UnidadesDeTiempo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`UnidadesDeTiempo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`UnidadesDeTiempo` (
  `unidadDeTiempoID` TINYINT NOT NULL AUTO_INCREMENT,
  `unidad` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`unidadDeTiempoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SalariosLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SalariosLogs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SalariosLogs` (
  `empleadoID` INT NOT NULL,
  `inicioVigencia` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finalVigencia` DATETIME NULL,
  `salario` DECIMAL(18,6) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `monedaID` INT NOT NULL DEFAULT 1,
  `rolID` SMALLINT NOT NULL,
  `cantidadTiempo` DECIMAL(18,6) NOT NULL DEFAULT 1,
  `unidadDeTiempoID` TINYINT NOT NULL DEFAULT 3,
  INDEX `fk_SalariosLogs_Empleados1_idx` (`empleadoID` ASC) VISIBLE,
  PRIMARY KEY (`empleadoID`, `inicioVigencia`),
  INDEX `fk_SalariosLogs_Monedas1_idx` (`monedaID` ASC) VISIBLE,
  INDEX `fk_SalariosLogs_Roles1_idx` (`rolID` ASC) VISIBLE,
  INDEX `fk_SalariosLogs_UnidadesDeTiempo1_idx` (`unidadDeTiempoID` ASC) VISIBLE,
  CONSTRAINT `fk_SalariosLogs_Empleados1`
    FOREIGN KEY (`empleadoID`)
    REFERENCES `mydb`.`Empleados` (`empleadoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalariosLogs_Monedas1`
    FOREIGN KEY (`monedaID`)
    REFERENCES `mydb`.`Monedas` (`monedaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalariosLogs_Roles1`
    FOREIGN KEY (`rolID`)
    REFERENCES `mydb`.`Roles` (`rolID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalariosLogs_UnidadesDeTiempo1`
    FOREIGN KEY (`unidadDeTiempoID`)
    REFERENCES `mydb`.`UnidadesDeTiempo` (`unidadDeTiempoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`QuincenasLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`QuincenasLogs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`QuincenasLogs` (
  `empleadoID` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `inicioQuincena` DATE NOT NULL,
  `finalQuincena` DATE NOT NULL,
  `paisID` INT NOT NULL,
  `montoBruto` DECIMAL(18,6) NOT NULL,
  `cargos` DECIMAL(18,6) NOT NULL,
  `montoNeto` DECIMAL(18,6) NOT NULL,
  `tiempoTrabajado` DECIMAL(10,2) NOT NULL,
  `unidadDeTiempoID` TINYINT NOT NULL,
  `monedaID` INT NOT NULL DEFAULT 1,
  INDEX `fk_QuincenasLogs_Empleados1_idx` (`empleadoID` ASC) VISIBLE,
  PRIMARY KEY (`empleadoID`, `fecha`),
  INDEX `fk_QuincenasLogs_Monedas1_idx` (`monedaID` ASC) VISIBLE,
  INDEX `fk_QuincenasLogs_Paises1_idx` (`paisID` ASC) VISIBLE,
  INDEX `fk_QuincenasLogs_UnidadesDeTiempo1_idx` (`unidadDeTiempoID` ASC) VISIBLE,
  CONSTRAINT `fk_QuincenasLogs_Empleados1`
    FOREIGN KEY (`empleadoID`)
    REFERENCES `mydb`.`Empleados` (`empleadoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuincenasLogs_Monedas1`
    FOREIGN KEY (`monedaID`)
    REFERENCES `mydb`.`Monedas` (`monedaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuincenasLogs_Paises1`
    FOREIGN KEY (`paisID`)
    REFERENCES `mydb`.`Paises` (`paisID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuincenasLogs_UnidadesDeTiempo1`
    FOREIGN KEY (`unidadDeTiempoID`)
    REFERENCES `mydb`.`UnidadesDeTiempo` (`unidadDeTiempoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ConversionesDeTiempo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ConversionesDeTiempo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ConversionesDeTiempo` (
  `unidadDeTiempoID1` TINYINT NOT NULL,
  `unidadDeTiempoID2` TINYINT NOT NULL,
  `proporcion` DECIMAL(12,4) NOT NULL,
  INDEX `fk_ConversionesDeTiempo_UnidadesDeTiempo1_idx` (`unidadDeTiempoID1` ASC) VISIBLE,
  PRIMARY KEY (`unidadDeTiempoID1`, `unidadDeTiempoID2`),
  INDEX `fk_ConversionesDeTiempo_UnidadesDeTiempo2_idx` (`unidadDeTiempoID2` ASC) VISIBLE,
  CONSTRAINT `fk_ConversionesDeTiempo_UnidadesDeTiempo1`
    FOREIGN KEY (`unidadDeTiempoID1`)
    REFERENCES `mydb`.`UnidadesDeTiempo` (`unidadDeTiempoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConversionesDeTiempo_UnidadesDeTiempo2`
    FOREIGN KEY (`unidadDeTiempoID2`)
    REFERENCES `mydb`.`UnidadesDeTiempo` (`unidadDeTiempoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
