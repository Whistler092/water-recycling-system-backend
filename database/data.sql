CREATE SCHEMA IF NOT EXISTS `water-recycling` DEFAULT CHARACTER SET latin1 ;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table __EFMigrationsHistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `__EFMigrationsHistory`;

CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `__EFMigrationsHistory` WRITE;
/*!40000 ALTER TABLE `__EFMigrationsHistory` DISABLE KEYS */;

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES
	('20180518005111_FirstMigration','2.0.1-rtm-125');

/*!40000 ALTER TABLE `__EFMigrationsHistory` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table AspNetRoleClaims
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AspNetRoleClaims`;

CREATE TABLE `AspNetRoleClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClaimType` text,
  `ClaimValue` text,
  `RoleId` varchar(767) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table AspNetRoles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AspNetRoles`;

CREATE TABLE `AspNetRoles` (
  `Id` varchar(767) NOT NULL,
  `ConcurrencyStamp` text,
  `Discriminator` text NOT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table AspNetUserClaims
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AspNetUserClaims`;

CREATE TABLE `AspNetUserClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClaimType` text,
  `ClaimValue` text,
  `UserId` varchar(767) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table AspNetUserLogins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AspNetUserLogins`;

CREATE TABLE `AspNetUserLogins` (
  `LoginProvider` varchar(767) NOT NULL,
  `ProviderKey` varchar(767) NOT NULL,
  `ProviderDisplayName` text,
  `UserId` varchar(767) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table AspNetUserRoles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AspNetUserRoles`;

CREATE TABLE `AspNetUserRoles` (
  `UserId` varchar(767) NOT NULL,
  `RoleId` varchar(767) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table AspNetUsers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AspNetUsers`;

CREATE TABLE `AspNetUsers` (
  `Id` varchar(767) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `ConcurrencyStamp` text,
  `Email` varchar(256) DEFAULT NULL,
  `EmailConfirmed` bit(1) NOT NULL,
  `LockoutEnabled` bit(1) NOT NULL,
  `LockoutEnd` timestamp NULL DEFAULT NULL,
  `NormalizedEmail` varchar(256) DEFAULT NULL,
  `NormalizedUserName` varchar(256) DEFAULT NULL,
  `PasswordHash` text,
  `PhoneNumber` text,
  `PhoneNumberConfirmed` bit(1) NOT NULL,
  `SecurityStamp` text,
  `TwoFactorEnabled` bit(1) NOT NULL,
  `UserName` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table AspNetUserTokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AspNetUserTokens`;

CREATE TABLE `AspNetUserTokens` (
  `UserId` varchar(767) NOT NULL,
  `LoginProvider` varchar(767) NOT NULL,
  `Name` varchar(767) NOT NULL,
  `Value` text,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table Devices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Devices`;

CREATE TABLE `Devices` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(8) DEFAULT NULL,
  `Created` datetime NOT NULL,
  `DeviceToken` varchar(512) DEFAULT NULL,
  `Ip` varchar(64) DEFAULT NULL,
  `State` bit(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Devices` WRITE;
/*!40000 ALTER TABLE `Devices` DISABLE KEYS */;

INSERT INTO `Devices` (`Id`, `Code`, `Created`, `DeviceToken`, `Ip`, `State`)
VALUES
	(1,'7021','2018-05-17 19:53:00','dU4nz9L99dc:APA91bEsYxGHrR9m7YM0Apmj9EhVTuMBNHQTQzQZvSNe_iZ_qp_9We8ZLadcsjy0ufHQM3pbkppZIyCirGHmto_dWU107nbgH8RV5bREGZT07GgR3s2uFrUVw8mSMAeSlZkLU3axEZn7','::1',b'0');

/*!40000 ALTER TABLE `Devices` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table RecyclingProcesses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RecyclingProcesses`;

CREATE TABLE `RecyclingProcesses` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CaptureDate` datetime NOT NULL,
  `Distance` decimal(18,2) NOT NULL,
  `IdFrom` int(11) NOT NULL,
  `Process` varchar(12) DEFAULT NULL,
  `Turbidity` decimal(18,2) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_RecyclingProcesses_IdFrom` (`IdFrom`),
  CONSTRAINT `FK_RecyclingProcesses_Devices_IdFrom` FOREIGN KEY (`IdFrom`) REFERENCES `Devices` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
