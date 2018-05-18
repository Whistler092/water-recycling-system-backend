  IF EXISTS(SELECT 1 FROM information_schema.tables 
  WHERE table_name = '
__EFMigrationsHistory' AND table_schema = DATABASE()) 
BEGIN
CREATE TABLE `__EFMigrationsHistory` (
    `MigrationId` varchar(150) NOT NULL,
    `ProductVersion` varchar(32) NOT NULL,
    PRIMARY KEY (`MigrationId`)
);

END;

CREATE TABLE `AspNetRoles` (
    `Id` varchar(767) NOT NULL,
    `ConcurrencyStamp` text NULL,
    `Discriminator` text NOT NULL,
    `Name` varchar(256) NULL,
    `NormalizedName` varchar(256) NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetUsers` (
    `Id` varchar(767) NOT NULL,
    `AccessFailedCount` int NOT NULL,
    `ConcurrencyStamp` text NULL,
    `Email` varchar(256) NULL,
    `EmailConfirmed` bit NOT NULL,
    `LockoutEnabled` bit NOT NULL,
    `LockoutEnd` timestamp NULL,
    `NormalizedEmail` varchar(256) NULL,
    `NormalizedUserName` varchar(256) NULL,
    `PasswordHash` text NULL,
    `PhoneNumber` text NULL,
    `PhoneNumberConfirmed` bit NOT NULL,
    `SecurityStamp` text NULL,
    `TwoFactorEnabled` bit NOT NULL,
    `UserName` varchar(256) NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `Devices` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Code` text NULL,
    `Created` datetime NOT NULL,
    `Ip` text NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetRoleClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` text NULL,
    `ClaimValue` text NULL,
    `RoleId` varchar(767) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` text NULL,
    `ClaimValue` text NULL,
    `UserId` varchar(767) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserLogins` (
    `LoginProvider` varchar(767) NOT NULL,
    `ProviderKey` varchar(767) NOT NULL,
    `ProviderDisplayName` text NULL,
    `UserId` varchar(767) NOT NULL,
    PRIMARY KEY (`LoginProvider`, `ProviderKey`),
    CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserRoles` (
    `UserId` varchar(767) NOT NULL,
    `RoleId` varchar(767) NOT NULL,
    PRIMARY KEY (`UserId`, `RoleId`),
    CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserTokens` (
    `UserId` varchar(767) NOT NULL,
    `LoginProvider` varchar(767) NOT NULL,
    `Name` varchar(767) NOT NULL,
    `Value` text NULL,
    PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
    CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `RecyclingProcesses` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `CaptureDate` datetime NOT NULL,
    `Distance` decimal(18, 2) NOT NULL,
    `Process` int NOT NULL,
    `Turbidity` decimal(18, 2) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_RecyclingProcesses_Devices_Id` FOREIGN KEY (`Id`) REFERENCES `Devices` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_AspNetRoleClaims_RoleId` ON AspNetRoleClaims (`RoleId`);

CREATE UNIQUE INDEX `RoleNameIndex` ON AspNetRoles (`NormalizedName`);

CREATE INDEX `IX_AspNetUserClaims_UserId` ON AspNetUserClaims (`UserId`);

CREATE INDEX `IX_AspNetUserLogins_UserId` ON AspNetUserLogins (`UserId`);

CREATE INDEX `IX_AspNetUserRoles_RoleId` ON AspNetUserRoles (`RoleId`);

CREATE INDEX `EmailIndex` ON AspNetUsers (`NormalizedEmail`);

CREATE UNIQUE INDEX `UserNameIndex` ON AspNetUsers (`NormalizedUserName`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20180511110840_firstSchema', '2.0.1-rtm-125');

CREATE TABLE `AspNetRoles` (
    `Id` varchar(767) NOT NULL,
    `ConcurrencyStamp` text NULL,
    `Discriminator` text NOT NULL,
    `Name` varchar(256) NULL,
    `NormalizedName` varchar(256) NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetUsers` (
    `Id` varchar(767) NOT NULL,
    `AccessFailedCount` int NOT NULL,
    `ConcurrencyStamp` text NULL,
    `Email` varchar(256) NULL,
    `EmailConfirmed` bit NOT NULL,
    `LockoutEnabled` bit NOT NULL,
    `LockoutEnd` timestamp NULL,
    `NormalizedEmail` varchar(256) NULL,
    `NormalizedUserName` varchar(256) NULL,
    `PasswordHash` text NULL,
    `PhoneNumber` text NULL,
    `PhoneNumberConfirmed` bit NOT NULL,
    `SecurityStamp` text NULL,
    `TwoFactorEnabled` bit NOT NULL,
    `UserName` varchar(256) NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `Devices` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Code` text NULL,
    `Created` datetime NOT NULL,
    `Ip` text NULL,
    `State` bit NOT NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetRoleClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` text NULL,
    `ClaimValue` text NULL,
    `RoleId` varchar(767) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` text NULL,
    `ClaimValue` text NULL,
    `UserId` varchar(767) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserLogins` (
    `LoginProvider` varchar(767) NOT NULL,
    `ProviderKey` varchar(767) NOT NULL,
    `ProviderDisplayName` text NULL,
    `UserId` varchar(767) NOT NULL,
    PRIMARY KEY (`LoginProvider`, `ProviderKey`),
    CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserRoles` (
    `UserId` varchar(767) NOT NULL,
    `RoleId` varchar(767) NOT NULL,
    PRIMARY KEY (`UserId`, `RoleId`),
    CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserTokens` (
    `UserId` varchar(767) NOT NULL,
    `LoginProvider` varchar(767) NOT NULL,
    `Name` varchar(767) NOT NULL,
    `Value` text NULL,
    PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
    CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `RecyclingProcesses` (
    `Id` int NOT NULL,
    `CaptureDate` datetime NOT NULL,
    `Distance` decimal(18, 2) NOT NULL,
    `Process` int NOT NULL,
    `Turbidity` decimal(18, 2) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_RecyclingProcesses_Devices_Id` FOREIGN KEY (`Id`) REFERENCES `Devices` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_AspNetRoleClaims_RoleId` ON AspNetRoleClaims (`RoleId`);

CREATE UNIQUE INDEX `RoleNameIndex` ON AspNetRoles (`NormalizedName`);

CREATE INDEX `IX_AspNetUserClaims_UserId` ON AspNetUserClaims (`UserId`);

CREATE INDEX `IX_AspNetUserLogins_UserId` ON AspNetUserLogins (`UserId`);

CREATE INDEX `IX_AspNetUserRoles_RoleId` ON AspNetUserRoles (`RoleId`);

CREATE INDEX `EmailIndex` ON AspNetUsers (`NormalizedEmail`);

CREATE UNIQUE INDEX `UserNameIndex` ON AspNetUsers (`NormalizedUserName`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20180511213700_stateDevice', '2.0.1-rtm-125');

CREATE TABLE `AspNetRoles` (
    `Id` varchar(767) NOT NULL,
    `ConcurrencyStamp` text NULL,
    `Discriminator` text NOT NULL,
    `Name` varchar(256) NULL,
    `NormalizedName` varchar(256) NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetUsers` (
    `Id` varchar(767) NOT NULL,
    `AccessFailedCount` int NOT NULL,
    `ConcurrencyStamp` text NULL,
    `Email` varchar(256) NULL,
    `EmailConfirmed` bit NOT NULL,
    `LockoutEnabled` bit NOT NULL,
    `LockoutEnd` timestamp NULL,
    `NormalizedEmail` varchar(256) NULL,
    `NormalizedUserName` varchar(256) NULL,
    `PasswordHash` text NULL,
    `PhoneNumber` text NULL,
    `PhoneNumberConfirmed` bit NOT NULL,
    `SecurityStamp` text NULL,
    `TwoFactorEnabled` bit NOT NULL,
    `UserName` varchar(256) NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `Devices` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Code` text NULL,
    `Created` datetime NOT NULL,
    `Ip` text NULL,
    `State` bit NOT NULL,
    PRIMARY KEY (`Id`)
);

CREATE TABLE `AspNetRoleClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` text NULL,
    `ClaimValue` text NULL,
    `RoleId` varchar(767) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `ClaimType` text NULL,
    `ClaimValue` text NULL,
    `UserId` varchar(767) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserLogins` (
    `LoginProvider` varchar(767) NOT NULL,
    `ProviderKey` varchar(767) NOT NULL,
    `ProviderDisplayName` text NULL,
    `UserId` varchar(767) NOT NULL,
    PRIMARY KEY (`LoginProvider`, `ProviderKey`),
    CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserRoles` (
    `UserId` varchar(767) NOT NULL,
    `RoleId` varchar(767) NOT NULL,
    PRIMARY KEY (`UserId`, `RoleId`),
    CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserTokens` (
    `UserId` varchar(767) NOT NULL,
    `LoginProvider` varchar(767) NOT NULL,
    `Name` varchar(767) NOT NULL,
    `Value` text NULL,
    PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
    CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `RecyclingProcesses` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `CaptureDate` datetime NOT NULL,
    `Distance` decimal(18, 2) NOT NULL,
    `Process` int NOT NULL,
    `Turbidity` decimal(18, 2) NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FK_RecyclingProcesses_Devices_Id` FOREIGN KEY (`Id`) REFERENCES `Devices` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `IX_AspNetRoleClaims_RoleId` ON AspNetRoleClaims (`RoleId`);

CREATE UNIQUE INDEX `RoleNameIndex` ON AspNetRoles (`NormalizedName`);

CREATE INDEX `IX_AspNetUserClaims_UserId` ON AspNetUserClaims (`UserId`);

CREATE INDEX `IX_AspNetUserLogins_UserId` ON AspNetUserLogins (`UserId`);

CREATE INDEX `IX_AspNetUserRoles_RoleId` ON AspNetUserRoles (`RoleId`);

CREATE INDEX `EmailIndex` ON AspNetUsers (`NormalizedEmail`);

CREATE UNIQUE INDEX `UserNameIndex` ON AspNetUsers (`NormalizedUserName`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20180517235659_idMigration', '2.0.1-rtm-125');


