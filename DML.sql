
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ServiziDelivery
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ServiziDelivery` ;

-- -----------------------------------------------------
-- Schema ServiziDelivery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ServiziDelivery` DEFAULT CHARACTER SET utf8 ;
USE `ServiziDelivery` ;

-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Cliente` (
  `CodiceFiscale` VARCHAR(16) NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `Cognome` VARCHAR(50) NOT NULL,
  `Via` VARCHAR(30) NOT NULL,
  `NumeroCivico` VARCHAR(10) NOT NULL,
  `CAP` VARCHAR(10) NOT NULL,
  `Contatto` VARCHAR(20) NOT NULL,
  `DataRegistrazione` DATE NOT NULL,
  `Password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`CodiceFiscale`),
  UNIQUE INDEX `CodiceFiscale_UNIQUE` (`CodiceFiscale` ASC) VISIBLE,
  UNIQUE INDEX `Contatto_UNIQUE` (`Contatto` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Ristorante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Ristorante` (
  `Contatto` VARCHAR(20) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Servizi` VARCHAR(45) NOT NULL,
  `Via` VARCHAR(30) NOT NULL,
  `NumeroCivico` VARCHAR(10) NOT NULL,
  `CAP` VARCHAR(10) NOT NULL,
  `MAXprenotazioni` INT NOT NULL,
  `NumOrdiniCoda` INT NOT NULL,
  PRIMARY KEY (`Contatto`),
  UNIQUE INDEX `Contatto_UNIQUE` (`Contatto` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Ordine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Ordine` (
  `NumeroGiornaliero` INT NOT NULL DEFAULT 1,
  `C_Ristorante` VARCHAR(20) NOT NULL,
  `Data` DATE NOT NULL,
  `Stato` VARCHAR(25) NOT NULL,
  `Tipo` VARCHAR(25) NOT NULL,
  `Descrizione` VARCHAR(50) NOT NULL,
  `CF_Cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NumeroGiornaliero`, `C_Ristorante`, `Data`),
  INDEX `CodiceFiscale_idx` (`CF_Cliente` ASC) VISIBLE,
  INDEX `C_Ristorante_idx` (`C_Ristorante` ASC) VISIBLE,
  INDEX `Data` (`Data` ASC) VISIBLE,
  CONSTRAINT `CF_Cliente`
    FOREIGN KEY (`CF_Cliente`)
    REFERENCES `ServiziDelivery`.`Cliente` (`CodiceFiscale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `C_Ristorante`
    FOREIGN KEY (`C_Ristorante`)
    REFERENCES `ServiziDelivery`.`Ristorante` (`Contatto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`ServizioDelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`ServizioDelivery` (
  `Codice` VARCHAR(20) NOT NULL,
  `DataUtilizzo` DATE NOT NULL,
  `Disponibilita` VARCHAR(20) NOT NULL,
  `Descrizione` VARCHAR(45) NOT NULL,
  `TipoServizio` BIT(1) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE INDEX `Codice_UNIQUE` (`Codice` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Dipendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Dipendente` (
  `CodiceFiscale` VARCHAR(16) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `AnniEsperienza` INT NOT NULL,
  `Curriculum` VARCHAR(100) NOT NULL,
  `TipoContratto` VARCHAR(20) NOT NULL,
  `DataAssunzione` DATE NOT NULL,
  `C_ServizioDelivery` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CodiceFiscale`),
  INDEX `C_Delivery_idx` (`C_ServizioDelivery` ASC) VISIBLE,
  UNIQUE INDEX `CodiceFiscale_UNIQUE` (`CodiceFiscale` ASC) VISIBLE,
  CONSTRAINT `C_Delivery`
    FOREIGN KEY (`C_ServizioDelivery`)
    REFERENCES `ServiziDelivery`.`ServizioDelivery` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Società`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Società` (
  `Partita_IVA` VARCHAR(11) NOT NULL,
  `Nome` VARCHAR(20) NOT NULL,
  `Amministratore` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Partita_IVA`),
  UNIQUE INDEX `Partita_IVA_UNIQUE` (`Partita_IVA` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Rider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Rider` (
  `IDRider` VARCHAR(45) NOT NULL,
  `DataPrimoImpiego` DATE NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `NumeroSocieta` INT NOT NULL,
  `ScoreMedio` FLOAT NOT NULL,
  `Disponibilità` TINYINT NOT NULL,
  PRIMARY KEY (`IDRider`),
  UNIQUE INDEX `IDRider_UNIQUE` (`IDRider` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Assunzione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Assunzione` (
  `IVA_Societa` VARCHAR(11) NOT NULL,
  `ID_Rider` VARCHAR(20) NOT NULL,
  `DataAssunzione` DATE NOT NULL,
  `QuotaOraria` FLOAT NOT NULL,
  PRIMARY KEY (`IVA_Societa`, `ID_Rider`),
  INDEX `ID_Rider_idx` (`ID_Rider` ASC) VISIBLE,
  CONSTRAINT `IVA_Società`
    FOREIGN KEY (`IVA_Societa`)
    REFERENCES `ServiziDelivery`.`Società` (`Partita_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Rider`
    FOREIGN KEY (`ID_Rider`)
    REFERENCES `ServiziDelivery`.`Rider` (`IDRider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Veicolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Veicolo` (
  `ID_Veicolo` VARCHAR(20) NOT NULL,
  `ID_Rider` VARCHAR(20) NOT NULL,
  `Tipo` VARCHAR(20) NOT NULL,
  `Targa` VARCHAR(10) NULL,
  PRIMARY KEY (`ID_Veicolo`),
  INDEX `ID_Rider2_idx` (`ID_Rider` ASC) VISIBLE,
  CONSTRAINT `ID_Rider2`
    FOREIGN KEY (`ID_Rider`)
    REFERENCES `ServiziDelivery`.`Rider` (`IDRider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Valutazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Valutazione` (
  `CF_Cliente` VARCHAR(16) NOT NULL,
  `ID_Rider` VARCHAR(20) NOT NULL,
  `DataValutazione` DATE NOT NULL,
  `Score` FLOAT NOT NULL,
  PRIMARY KEY (`CF_Cliente`, `ID_Rider`),
  INDEX `ID_Rider3_idx` (`ID_Rider` ASC) VISIBLE,
  CONSTRAINT `ID_Rider3`
    FOREIGN KEY (`ID_Rider`)
    REFERENCES `ServiziDelivery`.`Rider` (`IDRider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CF_Cliente2`
    FOREIGN KEY (`CF_Cliente`)
    REFERENCES `ServiziDelivery`.`Cliente` (`CodiceFiscale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Scelta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Scelta` (
  `C_Ristorante` VARCHAR(20) NOT NULL,
  `C_ServizioDelivery` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`C_Ristorante`, `C_ServizioDelivery`),
  INDEX `Codice2_idx` (`C_ServizioDelivery` ASC) VISIBLE,
  CONSTRAINT `Codice2`
    FOREIGN KEY (`C_ServizioDelivery`)
    REFERENCES `ServiziDelivery`.`ServizioDelivery` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `C_Ristorante2`
    FOREIGN KEY (`C_Ristorante`)
    REFERENCES `ServiziDelivery`.`Ristorante` (`Contatto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`Contatto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`Contatto` (
  `C_ServizioDelivery` VARCHAR(20) NOT NULL,
  `P_Societa` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`C_ServizioDelivery`, `P_Societa`),
  INDEX `IVA_Societa2_idx` (`P_Societa` ASC) VISIBLE,
  CONSTRAINT `IVA_Societa2`
    FOREIGN KEY (`P_Societa`)
    REFERENCES `ServiziDelivery`.`Società` (`Partita_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codice3`
    FOREIGN KEY (`C_ServizioDelivery`)
    REFERENCES `ServiziDelivery`.`ServizioDelivery` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`ConsegnaRider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`ConsegnaRider` (
  `ID_Rider` VARCHAR(20) NOT NULL,
  `D_Ordine` DATE NOT NULL,
  `Num_Ordine` INT NOT NULL,
  `C_Ordine` VARCHAR(20) NOT NULL,
  `OrarioPresunto` TIME NOT NULL,
  `OrarioEffettivo` TIME NOT NULL,
  `NomeClienteRitiro` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Rider`, `D_Ordine`, `Num_Ordine`, `C_Ordine`),
  INDEX `Num_Ordine_idx` (`Num_Ordine` ASC) VISIBLE,
  INDEX `C_Ordine_idx` (`C_Ordine` ASC) VISIBLE,
  INDEX `D_Ordine` (`D_Ordine` ASC) VISIBLE,
  CONSTRAINT `ID_Rider4`
    FOREIGN KEY (`ID_Rider`)
    REFERENCES `ServiziDelivery`.`Rider` (`IDRider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Num_Ordine`
    FOREIGN KEY (`Num_Ordine`)
    REFERENCES `ServiziDelivery`.`Ordine` (`NumeroGiornaliero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `C_Ordine`
    FOREIGN KEY (`C_Ordine`)
    REFERENCES `ServiziDelivery`.`Ordine` (`C_Ristorante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `D_Ordine1`
    FOREIGN KEY (`D_Ordine`)
    REFERENCES `ServiziDelivery`.`Ordine` (`Data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiziDelivery`.`ConsegnaDipendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiziDelivery`.`ConsegnaDipendente` (
  `CF_Dipendente` VARCHAR(16) NOT NULL,
  `Num_Ordine` INT NOT NULL,
  `C_Ordine` VARCHAR(20) NOT NULL,
  `D_Ordine` DATE NOT NULL,
  `OrarioPresunto` TIME NOT NULL,
  `OrarioEffettivo` TIME NOT NULL,
  `NomeClienteRitiro` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CF_Dipendente`, `Num_Ordine`, `C_Ordine`, `D_Ordine`),
  INDEX `Num_Ordine2_idx` (`Num_Ordine` ASC) INVISIBLE,
  INDEX `C_Ordine2_idx` (`C_Ordine` ASC) INVISIBLE,
  INDEX `D_Ordine2_idx` (`D_Ordine` ASC) VISIBLE,
  INDEX `D_Ordine` (`D_Ordine` ASC) VISIBLE,
  CONSTRAINT `Num_Ordine2`
    FOREIGN KEY (`Num_Ordine`)
    REFERENCES `ServiziDelivery`.`Ordine` (`NumeroGiornaliero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `C_Ordine2`
    FOREIGN KEY (`C_Ordine`)
    REFERENCES `ServiziDelivery`.`Ordine` (`C_Ristorante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CF_Dipendente2`
    FOREIGN KEY (`CF_Dipendente`)
    REFERENCES `ServiziDelivery`.`Dipendente` (`CodiceFiscale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `D_Ordine2`
    FOREIGN KEY (`D_Ordine`)
    REFERENCES `ServiziDelivery`.`Ordine` (`Data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Cliente` (`CodiceFiscale`, `Nome`, `Cognome`, `Via`, `NumeroCivico`, `CAP`, `Contatto`, `DataRegistrazione`, `Password`) VALUES ('NVNCLD74C08H703Q', 'Claudio', 'Novanini', 'Roma', '23', '84100', '3334445673', '2019-10-18', 'claudio22');
INSERT INTO `ServiziDelivery`.`Cliente` (`CodiceFiscale`, `Nome`, `Cognome`, `Via`, `NumeroCivico`, `CAP`, `Contatto`, `DataRegistrazione`, `Password`) VALUES ('GIOFBA96L06F205E', 'Fabio', 'Giorno', 'Dante Alighieri', '40', '21012', '3456678432', '2020-04-01', 'minanoF');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Ristorante`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Ristorante` (`Contatto`, `Nome`, `Servizi`, `Via`, `NumeroCivico`, `CAP`, `MAXprenotazioni`, `NumOrdiniCoda`) VALUES ('0894537596', 'Trattoria del popolo', 'Asporto', 'Gaetano gubbio', '67', '84081', 16, 3);
INSERT INTO `ServiziDelivery`.`Ristorante` (`Contatto`, `Nome`, `Servizi`, `Via`, `NumeroCivico`, `CAP`, `MAXprenotazioni`, `NumOrdiniCoda`) VALUES ('08283412456', 'Casa dei benvenuti', 'Ristorazione', 'Hainsenberg giorgio', '123', '84126', 6, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Ordine`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Ordine` (`NumeroGiornaliero`, `C_Ristorante`, `Data`, `Stato`, `Tipo`, `Descrizione`, `CF_Cliente`) VALUES (DEFAULT, '0894537596', '2020-12-09', 'Ordinato', 'Primo', 'Spaghetti e cozze', 'NVNCLD74C08H703Q');
INSERT INTO `ServiziDelivery`.`Ordine` (`NumeroGiornaliero`, `C_Ristorante`, `Data`, `Stato`, `Tipo`, `Descrizione`, `CF_Cliente`) VALUES (DEFAULT, '08283412456', '2020-12-04', 'Consegnato', 'Secondo', 'Cotoletta e patatine', 'GIOFBA96L06F205E');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`ServizioDelivery`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`ServizioDelivery` (`Codice`, `DataUtilizzo`, `Disponibilita`, `Descrizione`, `TipoServizio`) VALUES ('55TT43', '2020-12-09', 'feriale', 'Dal lunedì al venerdì', 1);
INSERT INTO `ServiziDelivery`.`ServizioDelivery` (`Codice`, `DataUtilizzo`, `Disponibilita`, `Descrizione`, `TipoServizio`) VALUES ('67FG34', '2020-12-04', 'festivo', 'weekend\'', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Dipendente`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Dipendente` (`CodiceFiscale`, `Nome`, `Cognome`, `AnniEsperienza`, `Curriculum`, `TipoContratto`, `DataAssunzione`, `C_ServizioDelivery`) VALUES ('CNPGTN66S13H683C', 'Cino', 'Piaga', 20, 'Con molta espierenza lavorativa', 'Tempo Indeterminato', '2000-11-03', '55TT43');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Società`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Società` (`Partita_IVA`, `Nome`, `Amministratore`) VALUES ('IT023423455', 'PizzaAndCo', 'Fabio Fusani');
INSERT INTO `ServiziDelivery`.`Società` (`Partita_IVA`, `Nome`, `Amministratore`) VALUES ('IT345765432', 'JustMangiare', 'Hudson Gians');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Rider`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Rider` (`IDRider`, `DataPrimoImpiego`, `Nome`, `Cognome`, `NumeroSocieta`, `ScoreMedio`, `Disponibilità`) VALUES ('TT453252GGA3', '2018-05-03', 'Maria Giorgia', 'Gionnini', 1, 4.7, true);
INSERT INTO `ServiziDelivery`.`Rider` (`IDRider`, `DataPrimoImpiego`, `Nome`, `Cognome`, `NumeroSocieta`, `ScoreMedio`, `Disponibilità`) VALUES ('YT3223242JJ3', '2019-03-01', 'Gaetano', 'Enaudi', 2, 4.1, false);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Assunzione`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Assunzione` (`IVA_Societa`, `ID_Rider`, `DataAssunzione`, `QuotaOraria`) VALUES ('IT023423455', 'TT453252GGA3', '2020-05-03', 5.5);
INSERT INTO `ServiziDelivery`.`Assunzione` (`IVA_Societa`, `ID_Rider`, `DataAssunzione`, `QuotaOraria`) VALUES ('IT023423455', 'YT3223242JJ3', '2019-10-04', 4.5);
INSERT INTO `ServiziDelivery`.`Assunzione` (`IVA_Societa`, `ID_Rider`, `DataAssunzione`, `QuotaOraria`) VALUES ('IT345765432', 'YT3223242JJ3', '2020-05-23', 7.6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Veicolo`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Veicolo` (`ID_Veicolo`, `ID_Rider`, `Tipo`, `Targa`) VALUES ('56YT6', 'YT3223242JJ3', 'Bicicletta', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Valutazione`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Valutazione` (`CF_Cliente`, `ID_Rider`, `DataValutazione`, `Score`) VALUES ('GIOFBA96L06F205E', 'YT3223242JJ3', '2020-12-04', 3.6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Scelta`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Scelta` (`C_Ristorante`, `C_ServizioDelivery`) VALUES ('0894537596', '55TT43');
INSERT INTO `ServiziDelivery`.`Scelta` (`C_Ristorante`, `C_ServizioDelivery`) VALUES ('08283412456', '67FG34');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`Contatto`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`Contatto` (`C_ServizioDelivery`, `P_Societa`) VALUES ('67FG34', 'IT023423455');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`ConsegnaRider`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`ConsegnaRider` (`ID_Rider`, `D_Ordine`, `Num_Ordine`, `C_Ordine`, `OrarioPresunto`, `OrarioEffettivo`, `NomeClienteRitiro`) VALUES ('YT3223242JJ3', '2020-12-04', 2, '0894537596', '20:45', '21:00', 'Alfonso Salvatori');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ServiziDelivery`.`ConsegnaDipendente`
-- -----------------------------------------------------
START TRANSACTION;
USE `ServiziDelivery`;
INSERT INTO `ServiziDelivery`.`ConsegnaDipendente` (`CF_Dipendente`, `Num_Ordine`, `C_Ordine`, `D_Ordine`, `OrarioPresunto`, `OrarioEffettivo`, `NomeClienteRitiro`) VALUES ('CNPGTN66S13H683C', 1, '0894537596', '2020-12-09', '21:30', '21:25', 'Giuseppe Giordano');

COMMIT;

