-- MySQL Script generated by MySQL Workbench
-- Wed Jun 27 22:19:43 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Sistema de Cadastro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Sistema de Cadastro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Sistema de Cadastro` DEFAULT CHARACTER SET utf8 ;
USE `Sistema de Cadastro` ;

-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Area de Concentracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Area de Concentracao` (
  `idArea` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(120) NOT NULL,
  `Descricao` TEXT NOT NULL,
  `DataInicio` DATE NOT NULL,
  `DataFim` DATE NULL,
  PRIMARY KEY (`idArea`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Linha de Pesquisa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Linha de Pesquisa` (
  `idLinha` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(120) NOT NULL,
  `Descricao` TEXT NOT NULL,
  `DataInicio` DATE NOT NULL,
  `DataFim` DATE NULL,
  `Area de Concentracao_idArea` INT NOT NULL,
  PRIMARY KEY (`idLinha`, `Area de Concentracao_idArea`),
  INDEX `fk_Linha de Pesquisa_Area de Concentracao1_idx` (`Area de Concentracao_idArea` ASC),
  CONSTRAINT `fk_Linha de Pesquisa_Area de Concentracao1`
    FOREIGN KEY (`Area de Concentracao_idArea`)
    REFERENCES `Sistema de Cadastro`.`Area de Concentracao` (`idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Financiador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Financiador` (
  `idFinanciador` INT NOT NULL AUTO_INCREMENT,
  `CNPJ` VARCHAR(45) NOT NULL,
  `RazaoSocial` VARCHAR(120) NOT NULL,
  `NomeFantasia` VARCHAR(120) NULL,
  `StatusJuridico` ENUM('Federal', 'Estadual', 'Municipal', 'Privado') NOT NULL,
  `Pais` VARCHAR(120) NOT NULL,
  `Site` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`idFinanciador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Programa de Fomento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Programa de Fomento` (
  `idPrograma` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(120) NOT NULL,
  `Financiador_idFinanciador` INT NOT NULL,
  PRIMARY KEY (`idPrograma`, `Financiador_idFinanciador`),
  INDEX `fk_Programa de Fomento_Financiador_idx` (`Financiador_idFinanciador` ASC),
  CONSTRAINT `fk_Programa de Fomento_Financiador`
    FOREIGN KEY (`Financiador_idFinanciador`)
    REFERENCES `Sistema de Cadastro`.`Financiador` (`idFinanciador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Professor` (
  `idProfessor` INT NOT NULL AUTO_INCREMENT,
  `Documento` ENUM('RG', 'CPF', 'Passaporte') NOT NULL,
  `NumeroDocumento` INT NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  `Sexo` ENUM('Masculino', 'Feminino') NOT NULL,
  `NomeSocial` VARCHAR(120) NULL,
  `Nacionalidade` VARCHAR(120) NOT NULL,
  `BolsaProdutividadePesquisa` TINYINT NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `InstituicaoOrigem` VARCHAR(120) NOT NULL,
  `Nivel` ENUM('Graduacao', 'Especializacao', 'Mestrado', 'Doutorado') NOT NULL,
  `AnoTitulacao` YEAR NOT NULL,
  `PaisTitulacao` VARCHAR(120) NOT NULL,
  `InstituicaoTitulacao` VARCHAR(120) NOT NULL,
  `VinculoInstituicao` ENUM('ServidorPublico', 'CLT', 'PessoaJuridica') NOT NULL,
  `RegimeTrabalho` ENUM('Exclusivo', '20H', '40H') NOT NULL,
  `Categoria` ENUM('Permanente', 'Colaborador') NOT NULL,
  `CargaSemanal` INT NOT NULL,
  `InicioVinculo` DATE NOT NULL,
  `FimVinculo` DATE NULL,
  PRIMARY KEY (`idProfessor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Discente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Discente` (
  `idDiscente` INT NOT NULL AUTO_INCREMENT,
  `Documento` ENUM('RG', 'CPF', 'Passaporte') NOT NULL,
  `NumeroDocumento` INT NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  `Sexo` ENUM('Masculino', 'Feminino') NOT NULL,
  `NomeSocial` VARCHAR(120) NULL,
  `Nacionalidade` VARCHAR(120) NOT NULL,
  `Deficiencia` TINYINT NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `Nivel` ENUM('Mestrado', 'Doutorado') NOT NULL,
  `Situacao` ENUM('Matriculado', 'Trancado', 'Desistente') NOT NULL,
  `DataMatricula` DATE NOT NULL,
  `DataOrientacao` DATE NOT NULL,
  `DataFimOrientacao` DATE NULL,
  `idOrientador` INT NOT NULL,
  `DataCoOrientacao` DATE NULL,
  `DataFimCoOrientacao` DATE NULL,
  `idCoOrientador` INT NULL,
  PRIMARY KEY (`idDiscente`),
  INDEX `fk_Discente_Professor1_idx` (`idOrientador` ASC),
  INDEX `fk_Discente_Professor2_idx` (`idCoOrientador` ASC),
  CONSTRAINT `fk_Discente_Professor1`
    FOREIGN KEY (`idOrientador`)
    REFERENCES `Sistema de Cadastro`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discente_Professor2`
    FOREIGN KEY (`idCoOrientador`)
    REFERENCES `Sistema de Cadastro`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Projeto` (
  `idProjeto` INT NOT NULL,
  `DataInicio` DATE NOT NULL,
  `Natureza` ENUM('Pesquisa', 'Desenvolvimento', 'Inovacao') NOT NULL,
  `Situacao` ENUM('EmAndamento', 'Cancelado', 'Concluido') NOT NULL,
  `Descricao` TEXT NOT NULL,
  `idLinhaPesquisa` INT NOT NULL,
  `idArea` INT NOT NULL,
  `Financiador_idFinanciador` INT NOT NULL,
  PRIMARY KEY (`idProjeto`),
  INDEX `fk_Projeto_Linha de Pesquisa1_idx` (`idLinhaPesquisa` ASC, `idArea` ASC),
  INDEX `fk_Projeto_Financiador1_idx` (`Financiador_idFinanciador` ASC),
  CONSTRAINT `fk_Projeto_Linha de Pesquisa1`
    FOREIGN KEY (`idLinhaPesquisa` , `idArea`)
    REFERENCES `Sistema de Cadastro`.`Linha de Pesquisa` (`idLinha` , `Area de Concentracao_idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projeto_Financiador1`
    FOREIGN KEY (`Financiador_idFinanciador`)
    REFERENCES `Sistema de Cadastro`.`Financiador` (`idFinanciador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Externo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Externo` (
  `idExterno` INT NOT NULL AUTO_INCREMENT,
  `Documento` ENUM('RG', 'CPF', 'Passaporte') NOT NULL,
  `NumeroDocumento` INT NOT NULL,
  `Nome` VARCHAR(120) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  `Sexo` ENUM('Masculino', 'Feminino') NOT NULL,
  `NomeSocial` VARCHAR(120) NULL,
  `Nacionalidade` VARCHAR(120) NOT NULL,
  `BolsaProdutividadePesquisa` TINYINT NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `InstituicaoOrigem` VARCHAR(120) NOT NULL,
  `Nivel` ENUM('Graduacao', 'Especializacao', 'Mestrado', 'Doutorado') NOT NULL,
  `AnoTitulacao` YEAR NOT NULL,
  `PaisTitulacao` VARCHAR(120) NOT NULL,
  `InstituicaoTitulacao` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`idExterno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Trabalho de Conclusao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Trabalho de Conclusao` (
  `idTrabalho` INT NOT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `Discente_idDiscente` INT NOT NULL,
  `Tipo` ENUM('Dissertacao', 'Tese') NOT NULL,
  `DataDefesa` DATE NOT NULL,
  `Resumo` TEXT NOT NULL,
  `PalavrasChave` TEXT NOT NULL,
  `Abstract` TEXT NOT NULL,
  `Keywords` TEXT NOT NULL,
  `Paginas` INT NOT NULL,
  `Idioma` ENUM('Portugues', 'Ingles') NOT NULL,
  `Linha de Pesquisa_idLinha` INT NOT NULL,
  `Linha de Pesquisa_Area de Concentracao_idArea` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  `Financiador_idFinanciador` INT NOT NULL,
  `TipoVinculoEmpregaticio` ENUM('ServidorPublico', 'CLT', 'Pessoa Juridica') NOT NULL,
  `TipoInstituicao` ENUM('Publica', 'Privada', 'InstituicaoDeEnsinoEPesquisa', 'Outros') NOT NULL,
  `ExpectativaAtuacao` ENUM('EnsinoEPesquisa', 'Pesquisa', 'Empresas', 'ProfissionalAutonomo', 'Outros') NOT NULL,
  `MesmaArea` TINYINT NOT NULL,
  PRIMARY KEY (`idTrabalho`),
  INDEX `fk_Trabalho de Conclusao_Discente1_idx` (`Discente_idDiscente` ASC),
  INDEX `fk_Trabalho de Conclusao_Linha de Pesquisa1_idx` (`Linha de Pesquisa_idLinha` ASC, `Linha de Pesquisa_Area de Concentracao_idArea` ASC),
  INDEX `fk_Trabalho de Conclusao_Projeto1_idx` (`Projeto_idProjeto` ASC),
  INDEX `fk_Trabalho de Conclusao_Professor1_idx` (`Professor_idProfessor` ASC),
  INDEX `fk_Trabalho de Conclusao_Financiador1_idx` (`Financiador_idFinanciador` ASC),
  CONSTRAINT `fk_Trabalho de Conclusao_Discente1`
    FOREIGN KEY (`Discente_idDiscente`)
    REFERENCES `Sistema de Cadastro`.`Discente` (`idDiscente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalho de Conclusao_Linha de Pesquisa1`
    FOREIGN KEY (`Linha de Pesquisa_idLinha` , `Linha de Pesquisa_Area de Concentracao_idArea`)
    REFERENCES `Sistema de Cadastro`.`Linha de Pesquisa` (`idLinha` , `Area de Concentracao_idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalho de Conclusao_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `Sistema de Cadastro`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalho de Conclusao_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `Sistema de Cadastro`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalho de Conclusao_Financiador1`
    FOREIGN KEY (`Financiador_idFinanciador`)
    REFERENCES `Sistema de Cadastro`.`Financiador` (`idFinanciador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Producao Intelectual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Producao Intelectual` (
  `idProducao` INT NOT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `Ano` INT NOT NULL,
  `VinculadoATrabalho` TINYINT NOT NULL,
  `Relevante` TINYINT NULL,
  `Tipo` ENUM('Artistica', 'Bibliografica', 'Tecnica') NULL,
  `Subtipo` ENUM('ArtigoEmJornalOuRevista', 'ArtigoEmPeriodico') NULL,
  `JornalOuRevista` VARCHAR(45) NULL,
  `PrimPagina` INT NULL,
  `UltPagina` INT NULL,
  `ISSN` INT NULL,
  `URL` VARCHAR(45) NULL,
  `DOI` INT NULL,
  `Producao Intelectualcol` VARCHAR(45) NULL,
  `Linha de Pesquisa_idLinha` INT NOT NULL,
  `Linha de Pesquisa_Area de Concentracao_idArea` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`idProducao`),
  INDEX `fk_Producao Intelectual_Linha de Pesquisa1_idx` (`Linha de Pesquisa_idLinha` ASC, `Linha de Pesquisa_Area de Concentracao_idArea` ASC),
  INDEX `fk_Producao Intelectual_Projeto1_idx` (`Projeto_idProjeto` ASC),
  CONSTRAINT `fk_Producao Intelectual_Linha de Pesquisa1`
    FOREIGN KEY (`Linha de Pesquisa_idLinha` , `Linha de Pesquisa_Area de Concentracao_idArea`)
    REFERENCES `Sistema de Cadastro`.`Linha de Pesquisa` (`idLinha` , `Area de Concentracao_idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producao Intelectual_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `Sistema de Cadastro`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Externo_Esta_Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Externo_Esta_Projeto` (
  `Externo_idExterno` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`Externo_idExterno`, `Projeto_idProjeto`),
  INDEX `fk_Externo_has_Projeto_Projeto1_idx` (`Projeto_idProjeto` ASC),
  INDEX `fk_Externo_has_Projeto_Externo1_idx` (`Externo_idExterno` ASC),
  CONSTRAINT `fk_Externo_has_Projeto_Externo1`
    FOREIGN KEY (`Externo_idExterno`)
    REFERENCES `Sistema de Cadastro`.`Externo` (`idExterno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Externo_has_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `Sistema de Cadastro`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Discente_Esta_Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Discente_Esta_Projeto` (
  `Discente_idDiscente` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`Discente_idDiscente`, `Projeto_idProjeto`),
  INDEX `fk_Discente_has_Projeto_Projeto1_idx` (`Projeto_idProjeto` ASC),
  INDEX `fk_Discente_has_Projeto_Discente1_idx` (`Discente_idDiscente` ASC),
  CONSTRAINT `fk_Discente_has_Projeto_Discente1`
    FOREIGN KEY (`Discente_idDiscente`)
    REFERENCES `Sistema de Cadastro`.`Discente` (`idDiscente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discente_has_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `Sistema de Cadastro`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Professor_Esta_Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Professor_Esta_Projeto` (
  `Professor_idProfessor` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`Professor_idProfessor`, `Projeto_idProjeto`),
  INDEX `fk_Professor_has_Projeto_Projeto1_idx` (`Projeto_idProjeto` ASC),
  INDEX `fk_Professor_has_Projeto_Professor1_idx` (`Professor_idProfessor` ASC),
  CONSTRAINT `fk_Professor_has_Projeto_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `Sistema de Cadastro`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_has_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `Sistema de Cadastro`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Externo_Esta_Producao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Externo_Esta_Producao` (
  `Producao Intelectual_idProducao` INT NOT NULL,
  `Externo_idExterno` INT NOT NULL,
  PRIMARY KEY (`Producao Intelectual_idProducao`, `Externo_idExterno`),
  INDEX `fk_Producao Intelectual_has_Externo_Externo1_idx` (`Externo_idExterno` ASC),
  INDEX `fk_Producao Intelectual_has_Externo_Producao Intelectual1_idx` (`Producao Intelectual_idProducao` ASC),
  CONSTRAINT `fk_Producao Intelectual_has_Externo_Producao Intelectual1`
    FOREIGN KEY (`Producao Intelectual_idProducao`)
    REFERENCES `Sistema de Cadastro`.`Producao Intelectual` (`idProducao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producao Intelectual_has_Externo_Externo1`
    FOREIGN KEY (`Externo_idExterno`)
    REFERENCES `Sistema de Cadastro`.`Externo` (`idExterno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Discente_Esta_Producao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Discente_Esta_Producao` (
  `Producao Intelectual_idProducao` INT NOT NULL,
  `Discente_idDiscente` INT NOT NULL,
  PRIMARY KEY (`Producao Intelectual_idProducao`, `Discente_idDiscente`),
  INDEX `fk_Producao Intelectual_has_Discente_Discente1_idx` (`Discente_idDiscente` ASC),
  INDEX `fk_Producao Intelectual_has_Discente_Producao Intelectual1_idx` (`Producao Intelectual_idProducao` ASC),
  CONSTRAINT `fk_Producao Intelectual_has_Discente_Producao Intelectual1`
    FOREIGN KEY (`Producao Intelectual_idProducao`)
    REFERENCES `Sistema de Cadastro`.`Producao Intelectual` (`idProducao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producao Intelectual_has_Discente_Discente1`
    FOREIGN KEY (`Discente_idDiscente`)
    REFERENCES `Sistema de Cadastro`.`Discente` (`idDiscente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Professor_Esta_Producao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Professor_Esta_Producao` (
  `Producao Intelectual_idProducao` INT NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`Producao Intelectual_idProducao`, `Professor_idProfessor`),
  INDEX `fk_Producao Intelectual_has_Professor_Professor1_idx` (`Professor_idProfessor` ASC),
  INDEX `fk_Producao Intelectual_has_Professor_Producao Intelectual1_idx` (`Producao Intelectual_idProducao` ASC),
  CONSTRAINT `fk_Producao Intelectual_has_Professor_Producao Intelectual1`
    FOREIGN KEY (`Producao Intelectual_idProducao`)
    REFERENCES `Sistema de Cadastro`.`Producao Intelectual` (`idProducao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producao Intelectual_has_Professor_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `Sistema de Cadastro`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Professor_Esta_Trabalho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Professor_Esta_Trabalho` (
  `Trabalho de Conclusao_idTrabalho` INT NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`Trabalho de Conclusao_idTrabalho`, `Professor_idProfessor`),
  INDEX `fk_Trabalho de Conclusao_has_Professor_Professor1_idx` (`Professor_idProfessor` ASC),
  INDEX `fk_Trabalho de Conclusao_has_Professor_Trabalho de Conclusa_idx` (`Trabalho de Conclusao_idTrabalho` ASC),
  CONSTRAINT `fk_Trabalho de Conclusao_has_Professor_Trabalho de Conclusao1`
    FOREIGN KEY (`Trabalho de Conclusao_idTrabalho`)
    REFERENCES `Sistema de Cadastro`.`Trabalho de Conclusao` (`idTrabalho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalho de Conclusao_has_Professor_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `Sistema de Cadastro`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sistema de Cadastro`.`Externo_Esta_Trabalho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sistema de Cadastro`.`Externo_Esta_Trabalho` (
  `Externo_idExterno` INT NOT NULL,
  `Trabalho de Conclusao_idTrabalho` INT NOT NULL,
  PRIMARY KEY (`Externo_idExterno`, `Trabalho de Conclusao_idTrabalho`),
  INDEX `fk_Externo_has_Trabalho de Conclusao_Trabalho de Conclusao1_idx` (`Trabalho de Conclusao_idTrabalho` ASC),
  INDEX `fk_Externo_has_Trabalho de Conclusao_Externo1_idx` (`Externo_idExterno` ASC),
  CONSTRAINT `fk_Externo_has_Trabalho de Conclusao_Externo1`
    FOREIGN KEY (`Externo_idExterno`)
    REFERENCES `Sistema de Cadastro`.`Externo` (`idExterno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Externo_has_Trabalho de Conclusao_Trabalho de Conclusao1`
    FOREIGN KEY (`Trabalho de Conclusao_idTrabalho`)
    REFERENCES `Sistema de Cadastro`.`Trabalho de Conclusao` (`idTrabalho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
