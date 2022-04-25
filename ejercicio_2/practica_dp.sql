/*
 Navicat Premium Data Transfer

 Source Server         : HotelePalace
 Source Server Type    : MySQL
 Source Server Version : 100419
 Source Host           : localhost:3306
 Source Schema         : practica_dp

 Target Server Type    : MySQL
 Target Server Version : 100419
 File Encoding         : 65001

 Date: 25/04/2022 11:38:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses`  (
  `Id_Distribuidor` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Calle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Numero_Casa` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Colonia` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addresses
-- ----------------------------

-- ----------------------------
-- Table structure for distributors
-- ----------------------------
DROP TABLE IF EXISTS `distributors`;
CREATE TABLE `distributors`  (
  `Id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Fecha_Registro` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of distributors
-- ----------------------------

-- ----------------------------
-- Table structure for persons
-- ----------------------------
DROP TABLE IF EXISTS `persons`;
CREATE TABLE `persons`  (
  `Id_Distribuidor` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Apellido_Paterno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Apellido_Materno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of persons
-- ----------------------------

-- ----------------------------
-- Procedure structure for GUARDAR_DISTRIBUIDOR
-- ----------------------------
DROP PROCEDURE IF EXISTS `GUARDAR_DISTRIBUIDOR`;
delimiter ;;
CREATE PROCEDURE `GUARDAR_DISTRIBUIDOR`(IN `BAN` INT,
	IN `ID_I` VARCHAR(25),
	IN `NOMBRE_I` VARCHAR(120),
	IN `APELLIDOP_I` VARCHAR(120),
	IN `APELLIDOM_I` VARCHAR(120),
	IN `CALLE_I` VARCHAR(120),
	IN `NUMERO_I` VARCHAR(120),
	IN `COLONIA_I` VARCHAR(120))
BEGIN

	-- 1. Guarda un registro y guarda cambios
	DECLARE hasError BOOLEAN DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR sqlexception SET hasError = 1;
	
	CASE
		WHEN BAN = 1 THEN
			
			START TRANSACTION;
			
				INSERT INTO distributors 
					(
						Id,
						Fecha_Registro
					) 
					VALUES 
					(
						ID_I,
						NOW()
					);
					
				INSERT INTO persons 
				(
					Id_Distribuidor,
					Nombre,
					Apellido_Paterno,
					Apellido_Materno
				) 
				VALUES 
				(
					ID_I,
					NOMBRE_I,
					APELLIDOP_I, 
					APELLIDOM_I
				);
					
				INSERT INTO addresses 
				(
					Id_Distribuidor,
					Calle,
					Numero_Casa,
					Colonia
				) 
				VALUES 
				(
					ID_I,
					CALLE_I,
					NUMERO_I, 
					COLONIA_I
				);
					
			IF hasError THEN
		
				ROLLBACK;
				SELECT 'error';
				
			ELSE
		 
				COMMIT;
				
			END IF;
			
	END CASE;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for OBTENER_DISTRIBUIDOR
-- ----------------------------
DROP PROCEDURE IF EXISTS `OBTENER_DISTRIBUIDOR`;
delimiter ;;
CREATE PROCEDURE `OBTENER_DISTRIBUIDOR`(IN `BAN` INT,
	IN `ID_I` VARCHAR(25))
BEGIN
	
	-- 1. Obtenemos registro en especifico (Form)
	-- 2. Obtenemos registro en especifico
	
	CASE
		WHEN BAN = 1 THEN
		
			SELECT 
				a1.Id AS ID,
				B1.Nombre AS NOMBRE,
				b1.Apellido_Paterno AS APELLIDO_PATERNO,
				b1.Apellido_Materno AS APELLIDO_MATERNO,
				c1.Calle AS CALLE,
				c1.Numero_Casa AS NUMERO,
				c1.Colonia AS COLONIA
			FROM distributors AS a1
			
			LEFT JOIN persons AS b1 ON b1.Id_Distribuidor = a1.Id
			LEFT JOIN addresses AS c1 ON c1.Id_Distribuidor = a1.Id
			
			WHERE a1.Id = ID_I;
			
		WHEN BAN = 2 THEN
		
			SELECT 
				a1.Id AS ID,
				CONCAT(b1.Nombre,' ',b1.Apellido_Paterno,' ',b1.Apellido_Materno) AS NOMBRE_COMPLETO,
				c1.Calle AS CALLE,
				c1.Numero_Casa AS NUMERO,
				c1.Colonia AS COLONIA
			FROM distributors AS a1
			
			LEFT JOIN persons AS b1 ON b1.Id_Distribuidor = a1.Id
			LEFT JOIN addresses AS c1 ON c1.Id_Distribuidor = a1.Id
			
			WHERE a1.Id = ID_I;
				
	END CASE;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
