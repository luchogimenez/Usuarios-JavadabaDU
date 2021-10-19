-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: usuarios
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `historialpassword`
--

DROP TABLE IF EXISTS `historialpassword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historialpassword` (
  `idHistorialPassword` tinyint NOT NULL,
  `Usuarios_idUsuarios` tinyint NOT NULL,
  `oldPassword` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`idHistorialPassword`),
  KEY `fk_HistorialPassword_Usuarios1_idx` (`Usuarios_idUsuarios`),
  CONSTRAINT `fk_HistorialPassword_Usuarios1` FOREIGN KEY (`Usuarios_idUsuarios`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisos` (
  `idPermisos` tinyint NOT NULL,
  `Permisos_idPermisos` tinyint DEFAULT NULL,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`idPermisos`),
  KEY `fk_Permisos_Permisos1_idx` (`Permisos_idPermisos`),
  CONSTRAINT `fk_Permisos_Permisos1` FOREIGN KEY (`Permisos_idPermisos`) REFERENCES `permisos` (`idPermisos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permisosroles`
--

DROP TABLE IF EXISTS `permisosroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisosroles` (
  `Permisos_idPermisos` tinyint NOT NULL,
  `Roles_idRol` tinyint NOT NULL,
  PRIMARY KEY (`Permisos_idPermisos`,`Roles_idRol`),
  KEY `fk_Permisos_has_Roles_Roles1_idx` (`Roles_idRol`),
  KEY `fk_Permisos_has_Roles_Permisos1_idx` (`Permisos_idPermisos`),
  CONSTRAINT `fk_Permisos_has_Roles_Permisos1` FOREIGN KEY (`Permisos_idPermisos`) REFERENCES `permisos` (`idPermisos`),
  CONSTRAINT `fk_Permisos_has_Roles_Roles1` FOREIGN KEY (`Roles_idRol`) REFERENCES `roles` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `idRol` tinyint NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idRol`),
  UNIQUE KEY `idx_roles_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuario` tinyint NOT NULL,
  `Roles_idRol` tinyint NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `usuario` varchar(20) NOT NULL,
  `pass` varchar(32) DEFAULT NULL,
  `estado` char(1) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `user_UNIQUE` (`usuario`),
  KEY `fk_Usuarios_Roles_idx` (`Roles_idRol`),
  CONSTRAINT `fk_Usuarios_Roles` FOREIGN KEY (`Roles_idRol`) REFERENCES `roles` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'usuarios'
--
/*!50003 DROP PROCEDURE IF EXISTS `new_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`(`pIdUsuario` INT)
SALIR:BEGIN
  /*
  Permite cambiar el estado de una persona   a A: Activo siempre y cuando no  esté activo ya. 
  Devuelve OK o el mensaje de error en Mensaje. 
  */
  
  
	IF (SELECT estado FROM usuarios WHERE idUsuario = pIdUsuario) = 'D' THEN
		SELECT 'el usuario  ya está desactivado.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    -- Activa
    UPDATE	usuarios
    SET		estado = 'D'
    WHERE	idUsuario = pIdUsuario;
    
    SELECT 'OK' AS Mensaje;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_activar_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_activar_rol`(pIdRol int)
SALIR:BEGIN

  /*
  Permite cambiar el estado de un rol y de los usuarios cno ese rol   a A: Activo siempre y cuando no  esté activo ya. 
  Devuelve OK o el mensaje de error en Mensaje. 
  */
  
  
	IF (SELECT estado FROM roles WHERE idRol = pIdRol) = 'A' THEN
		SELECT 'el rol  ya está activo.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    -- Activa
    UPDATE	roles
    SET		estado = 'A'
    WHERE	idRol = pIdRol;
    
	UPDATE usuarios
    SET  estado = 'A'
    WHERE Roles_IdRol= pidRol;
    
    SELECT 'OK' AS Mensaje;



    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_activar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_activar_usuario`(pIdUsuario int)
SALIR:BEGIN


  /*
  Permite cambiar el estado de un usuario   a A: Activo siempre y cuando no  esté activo ya. 
  Devuelve OK o el mensaje de error en Mensaje. 
  */
  
  
	IF (SELECT estado FROM usuarios WHERE idUsuario = pIdUsuario) = 'A' THEN
		SELECT 'el usuario  ya está activo.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    
    -- Activa
    UPDATE	usuarios
    SET		estado = 'A'
    WHERE	idUsuario = pIdUsuario;
    
    SELECT 'OK' AS Mensaje;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_alta_permiso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_alta_permiso`(pIdPermisoPadre tinyint(4), pNombre varchar(30))
SALIR:BEGIN
	/*
    Permite dar de alta un usuario
    */
     DECLARE pIdPermiso tinyint(4) ;

     
      -- Manejo de error en la transacción
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;

	-- Controla que el nombre sea obligatorio 
	IF pNombre = '' OR pNombre IS NULL THEN
		SELECT 'Debe proveer un nombre para el permiso' AS Mensaje;
		LEAVE SALIR;
    END IF;

    
START TRANSACTION;
    	SET  pIdPermiso = 1 + (SELECT COALESCE(MAX(idPermisos),0)FROM permisos);       
		INSERT INTO permisos (idPermisos,Permisos_idPermisos,nombre) VALUES(pIdPermiso,pIdPermisoPadre,pNombre);
        SELECT 'OK' AS Mensaje;
    COMMIT;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_alta_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_alta_rol`(`pNombre` VARCHAR(45))
SALIR:BEGIN
     DECLARE pIdRol int ;
     
	-- Manejo de error en la transacción
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;
    
	-- Controla que el nombre sea obligatorio 
	IF pNombre = '' OR pNombre IS NULL THEN
		SELECT 'Debe proveer un nombre para el rol' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;

	-- controla la existencia de un nombre 
  IF EXISTS(SELECT nombre FROM roles WHERE nombre = pNombre) THEN
		SELECT 'ya existe  un rol  con ese nombre' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;
    
      
    START TRANSACTION;
    	SET  pIdRol = 1 + (SELECT COALESCE(MAX(idRol),0)FROM roles);
		INSERT INTO roles (idRol,nombre, estado) VALUES(pIdRol, upper(pNombre),'A');
        SELECT 'OK' AS Mensaje;
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_alta_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_alta_usuario`(`pApellido` VARCHAR(60), `pNombre` VARCHAR(60), `pUser` VARCHAR(60), `pPassword` VARCHAR(30), `pIdRol` tinyint)
SALIR:BEGIN
	/*
    Permite dar de alta un usuario
    */
     DECLARE pIdusuario tinyint(4) ;
     DECLARE pIdHistorialPassword tinyint(4);
     
      -- Manejo de error en la transacción
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;
     
     -- Controla que el apellido sea obligatorio 
	IF pApellido = '' OR pApellido IS NULL THEN
		SELECT 'Debe proveer un apellido para el usuario' AS Mensaje;
		LEAVE SALIR;
    END IF;
	-- Controla que el nombre sea obligatorio 
	IF pNombre = '' OR pNombre IS NULL THEN
		SELECT 'Debe proveer un nombre para el usuario' AS Mensaje;
		LEAVE SALIR;
    END IF;
	-- Controla que el user sea obligatorio 
	IF pUser = '' OR pUser IS NULL THEN
		SELECT 'Debe proveer un user para el usuario' AS Mensaje;
		LEAVE SALIR;
    END IF;
-- controla la existencia del user 
	IF EXISTS(SELECT usuario FROM usuarios WHERE usuarios.usuario = pUser) THEN
		SELECT 'ya existe  un usuario  con ese nombre' AS Mensaje;
		LEAVE SALIR;
    END IF;
    
	-- Controla que el password sea obligatorio 
	IF pPassword = '' OR pPassword IS NULL THEN
		SELECT 'Debe proveer un password para el usuario' AS Mensaje;
		LEAVE SALIR;
    END IF;
    
START TRANSACTION;
    	SET  pIdusuario = 1 + (SELECT COALESCE(MAX(idUsuario),0)FROM usuarios);
        SET  pIdHistorialPassword = 1 + (SELECT COALESCE(MAX(idHistorialPassword),0)FROM historialpassword);
		INSERT INTO usuarios (idUsuario,Roles_idRol,apellido,nombre,usuario,pass,estado) VALUES(pIdusuario,pIdRol,pApellido,pNombre,pUser,md5(pPassword),'A');
        INSERT INTO historialpassword (idHistorialPassword ,Usuarios_idUsuarios ,oldPassword) VALUES (pIdHistorialPassword,pIdusuario,md5(pPassword));
        SELECT 'OK' AS Mensaje;
    COMMIT;
    
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_dame_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_dame_usuario`(`pIdUsuario` INT)
BEGIN
	/*
	Procedimiento que sirve para instanciar un Usuario desde la base de datos. 
    */
	 SELECT idUsuario, Roles_idRol As idRol, apellido, nombre, usuario, estado FROM usuarios WHERE idUsuario = pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_desactivar_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_desactivar_rol`(pIdRol int)
SALIR:BEGIN

  /*
  Permite cambiar el estado de un rol  de  A a D:  Activo a Desactivo siempre y cuando el rol no este desactivado. 
  Devuelve OK o el mensaje de error en Mensaje. 
  */
  
  
	IF (SELECT estado FROM roles WHERE idRol = pIdRol) = 'D' THEN
		SELECT 'el rol  ya está desactivo.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    -- Desactivo
    UPDATE	roles
    SET		estado = 'D'
    WHERE	idRol = pIdRol;
    UPDATE usuarios
    SET  estado = 'D'
    WHERE Roles_IdRol= pidRol;
    
    SELECT 'OK' AS Mensaje;



    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_desactivar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_desactivar_usuario`(`pIdUsuario` INT)
SALIR:BEGIN
  /*
  Permite cambiar el estado de una persona   a A: Activo siempre y cuando no  esté activo ya. 
  Devuelve OK o el mensaje de error en Mensaje. 
  */
  
  
	IF (SELECT estado FROM usuarios WHERE idUsuario = pIdUsuario) = 'D' THEN
		SELECT 'el usuario  ya está desactivado.' AS Mensaje;
        LEAVE SALIR;
	END IF;
    -- Activa
    UPDATE	usuarios
    SET		estado = 'D'
    WHERE	idUsuario = pIdUsuario;
    
    SELECT 'OK' AS Mensaje;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_listar_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_listar_rol`()
BEGIN
		/*
		Permite listar los roles ordenados por el Id.
		*/
  -- Manejo de error en la transacción
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;
	SELECT idRol, nombre, estado FROM roles WHERE estado = 'A';


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_listar_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_listar_usuarios`()
BEGIN
		/*
		Permite listar los usuarios 
		*/
  -- Manejo de error en la transacción
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;
	SELECT idUsuario ,Roles_idRol,apellido,nombre,usuario FROM usuarios where estado ='A';



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_login_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_login_usuario`(pUser varchar(30), pPassword varchar(30))
SALIR:BEGIN
     -- Controla que el user sea obligatorio 
	IF pUser = '' OR pUser IS NULL THEN
		SELECT 'Debe proveer un valor en el campo usuario' AS Mensaje;
		LEAVE SALIR;
    END IF;
	-- Controla que el password sea obligatorio 
	IF pPassword = '' OR pPassword IS NULL THEN
		SELECT 'Debe proveer un valor en el campo password' AS Mensaje;
		LEAVE SALIR;
    END IF;
    
    	-- Controla que exista un ususario con ese nombre y esa contraseña
	IF  (SELECT COUNT(*) FROM usuarios where  usuario = pUser and pass = pPassword and estado = 'A' ) > 0 THEN
		SELECT 'Bienvenidos al Sistema Calculator 1.0.0' AS Mensaje;
		LEAVE SALIR;
    END IF;
    
	SELECT 'usuario o contraseña invalido' AS Mensaje;
	LEAVE SALIR;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_modificar_password_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_modificar_password_usuario`(PidUsuario tinyint(4) ,pPassword varchar(30))
SALIR:BEGIN

	-- Manejo de error en la transacción
    DECLARE pidHistorialPassword tinyint(4);
	DECLARE pidHistorialPasswordMin tinyint(4);
    DECLARE pBandera char(1);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;
    
    -- Controla que el telefono sea obligatorio 
	IF PidUsuario = '' OR PidUsuario IS NULL THEN
		SELECT 'Debe proveer un nombre de usuario.' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;
        -- Controla que el password sea obligatorio 
	IF pPassword = '' OR pPassword IS NULL THEN
		SELECT 'Debe proveer un valor para el campo password.' AS Mensaje;
		LEAVE SALIR;
    END IF;
    
    
    IF (SELECT COUNT(*) FROM historialpassword h  WHERE  h.Usuarios_idUsuarios = PidUsuario AND  h.oldPassword = md5(pPassword)) THEN
    		SELECT 'La contraseña ingresada ya fue utilizada anteriormente por este usuario.' AS Mensaje;
		LEAVE SALIR;
    END IF;
    
	SET   pBandera = 'F';
    IF (SELECT COUNT(*) FROM historialpassword h  WHERE  h.Usuarios_idUsuarios = PidUsuario)= 4  THEN
     SET   pBandera = 'T';
    END IF;
    
    
	START TRANSACTION;
     SET pidHistorialPassword = 1 + (SELECT COALESCE(MAX(idHistorialPassword),0)FROM historialpassword);
     
     IF(pBandera= 'T') THEN
	 SET pidHistorialPasswordMin = (SELECT min(idHistorialPassword) FROM historialpassword WHERE Usuarios_idUsuarios =PidUsuario);
     DELETE FROM historialpassword WHERE idHistorialPassword = pidHistorialPasswordMin AND Usuarios_idUsuarios = PidUsuario;
     END IF;
     
     UPDATE usuarios SET  pass = md5(pPassword) WHERE  idUsuario = pIdUsuario;
	 INSERT INTO historialpassword (idHistorialPassword ,Usuarios_idUsuarios ,oldPassword) VALUES (pIdHistorialPassword,pIdUsuario,md5(pPassword));
     SELECT 'se hizo la modificacion exitosamente' AS Mensaje ;  
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_modificar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_modificar_usuario`(`pIdUsuario` INT, `pApellido` VARCHAR(60), `pNombre` VARCHAR(60), `pUsuario` VARCHAR(30))
SALIR: BEGIN
			/*
			   Permite modificar un usuario existente,
			   Devuelve OK o el mensaje de error en Mensaje.
			*/
            
              -- Manejo de error en la transacción
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
		SHOW ERRORS;
		SELECT 'Error en la transacción. Contáctese con el administrador.' Mensaje;
		ROLLBACK;
	END;

    
    -- Controla que el cliente sea obligatorio 
	IF NOT EXISTS(SELECT idUsuario FROM usuarios WHERE idUsuario = pIdUsuario) THEN
		SELECT 'Debe proveer un usuario existen.' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;
      -- Controla que el apellido sea obligatorio 
	IF pApellido = '' OR pApellido IS NULL THEN
		SELECT 'Debe proveer un apellido para el usuario.' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;
     -- Controla que el nombre sea obligatorio 
	IF pNombre = '' OR pNombre IS NULL THEN
		SELECT 'Debe proveer un nombre para el usuario.' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;
        -- Controla que el email sea obligatorio. 
	IF pEmail = '' OR pEmail IS NULL THEN
		SELECT 'Debe proveer un email para el usuario.' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;
    -- Controla que el telefono sea obligatorio 
	IF pUsuario = '' OR pUsuario IS NULL THEN
		SELECT 'Debe proveer un nombre de usuario.' AS Mensaje, NULL AS Id;
		LEAVE SALIR;
    END IF;
    	-- controla la existencia del nombre de usuario 
  IF EXISTS(SELECT usuario FROM usuarios WHERE usuario = pUsuario) THEN
		SELECT 'ya existe  un usuario   con ese nombre' AS Mensaje;
		LEAVE SALIR;
    END IF;



  	START TRANSACTION;
		UPDATE usuarios SET apellido = pApellido, nombre = pNombre ,usuario = pUsuario  WHERE  idUsuario = pIdUsuario;
		SELECT 'OK' AS Mensaje;      
	COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-19 14:18:06
