-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.31 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para mydb
CREATE DATABASE IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;

-- Volcando estructura para procedimiento mydb.Alta20Jugadores
DELIMITER //
CREATE PROCEDURE `Alta20Jugadores`()
BEGIN
INSERT INTO jugador(nombre,apellido,pais) VALUES
('Lucas', 'Rodriguez', 'Argentina'),
('Carla', 'Garcia', 'Mexico'),
('Alex', 'Sanchez', 'España'),
('Anna', 'Lopez', 'Colombia'),
('Joshua', 'Smith', 'Estados Unidos'),
('Sophie', 'Lee', 'Corea del Sur'),
('Mateo', 'Perez', 'Argentina'),
('Isabella', 'Gomez', 'Colombia'),
('David', 'Hernandez', 'Mexico'),
('Emily', 'Brown', 'Inglaterra'),
('Hugo', 'Gonzalez', 'España'),
('Olivia', 'Johnson', 'Estados Unidos'),
('Diego', 'Martin', 'Argentina'),
('Mia', 'Gutierrez', 'Colombia'),
('Cameron', 'Lee', 'Canadá'),
('Eva', 'Hernandez', 'España'),
('Santiago', 'Sosa', 'Argentina'),
('Natalia', 'Castro', 'Colombia'),
('William', 'Taylor', 'Estados Unidos'),
('Sofia', 'Diaz', 'México');
END//
DELIMITER ;

-- Volcando estructura para procedimiento mydb.Alta3Torneos
DELIMITER //
CREATE PROCEDURE `Alta3Torneos`()
BEGIN
INSERT INTO torneos(nombre,ciudad,premio,fecha_inicio,fecha_fin,partidasmax,participantesmax)
VALUES ('AmericanTournament','Miami','5000',DATE('2024-04-03'),DATE('2024-06-03'),'5','11'),
 		 ('EuropaStars','Barcelona','4000',DATE('2025-04-02'),DATE('2025-06-02'),'6','25'),
		 ('AndaluciaLegend','Granada','35000',DATE('2026-07-07'),DATE('2026-08-09'),'4','12');
END//
DELIMITER ;

-- Volcando estructura para tabla mydb.elo
CREATE TABLE IF NOT EXISTS `elo` (
  `elomin` int NOT NULL,
  `elomax` int NOT NULL,
  `titulo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mydb.elo: ~7 rows (aproximadamente)
INSERT INTO `elo` (`elomin`, `elomax`, `titulo`) VALUES
	(0, 1499, 'noob'),
	(1500, 1799, 'amateur'),
	(1800, 2199, 'semiprofesional'),
	(2200, 2299, 'candidato a maestro'),
	(2300, 2399, 'maestro fide'),
	(2400, 2499, 'maestro internacional'),
	(2500, 4000, 'gran maestro');

-- Volcando estructura para tabla mydb.elochanged
CREATE TABLE IF NOT EXISTS `elochanged` (
  `id_jugador` int NOT NULL,
  `nuevotitulo` varchar(45) NOT NULL,
  `anteriortitulo` varchar(45) NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id_jugador`),
  CONSTRAINT `elochangedfk` FOREIGN KEY (`id_jugador`) REFERENCES `jugador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mydb.elochanged: ~6 rows (aproximadamente)
INSERT INTO `elochanged` (`id_jugador`, `nuevotitulo`, `anteriortitulo`, `fecha`) VALUES
	(23, 'semiprofesional', 'noob', '2023-05-08 05:06:00');

-- Volcando estructura para función mydb.func_probabilidad
DELIMITER //
CREATE FUNCTION `func_probabilidad`(`rat1` INT,
	`rat2` INT
) RETURNS float
    DETERMINISTIC
BEGIN
	SET @c=(1*1.0
           / (1
              + 1.0
                    * pow(10,
                          1.0 * (rat1 - rat2) / 400)));

	RETURN (1*1.0
           / (1
              + 1.0
                    * pow(10,
                          1.0 * (rat1 - rat2) / 400)));

END//
DELIMITER ;

-- Volcando estructura para procedimiento mydb.Generar10Partidas
DELIMITER //
CREATE PROCEDURE `Generar10Partidas`()
BEGIN
INSERT INTO partidos(jugadorblancas,jugadornegras,id_torneo,resultado)
VALUES 
	('1','2','2','1'),
	('2','3','2','2'),
	('3','2','2','1'),
	('2','5','2','2'),
	('1','4','2','1'),
	('6','7','2','2'),
	('6','9','2','1'),
	('2','4','2','2'),
	('1','4','2','1'),
	('3','8','2','2');
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento mydb.Inscribir20jugadores
DELIMITER //
CREATE PROCEDURE `Inscribir20jugadores`()
BEGIN
INSERT INTO inscripciones(jugador_id,torneos_id)
VALUES ('1','2'),
		('2','2'),
		('3','2'),
		('4','2'),
		('5','2'),
		('6','2'),
		('7','2'),
		('8','2'),
		('9','2'),
		('10','2'),
		('11','2'),
		('12','2'),
		('13','2'),
		('14','2'),
		('15','2'),
		('16','2'),
		('17','2'),
		('18','2'),
		('19','2'),
		('20','2');
		
END//
DELIMITER ;

-- Volcando estructura para tabla mydb.inscripciones
CREATE TABLE IF NOT EXISTS `inscripciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `jugador_id` int NOT NULL,
  `torneos_id` int NOT NULL,
  `eloInicial` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `jugador_torneo_Norepetido` (`jugador_id`,`torneos_id`) USING BTREE,
  KEY `fk_jugador_has_torneos_torneos1_idx` (`torneos_id`),
  KEY `fk_jugador_has_torneos_jugador_idx` (`jugador_id`),
  CONSTRAINT `fk_jugador_has_torneos_jugador` FOREIGN KEY (`jugador_id`) REFERENCES `jugador` (`id`),
  CONSTRAINT `fk_jugador_has_torneos_torneos1` FOREIGN KEY (`torneos_id`) REFERENCES `torneos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mydb.inscripciones: ~20 rows (aproximadamente)
INSERT INTO `inscripciones` (`id`, `jugador_id`, `torneos_id`, `eloInicial`) VALUES
	(82, 1, 2, 1000),
	(83, 2, 2, 1000),
	(84, 3, 2, 1000),
	(85, 4, 2, 1000),
	(86, 5, 2, 1000),
	(87, 6, 2, 1000),
	(88, 7, 2, 1000),
	(89, 8, 2, 1000),
	(90, 9, 2, 1000),
	(91, 10, 2, 1000),
	(92, 11, 2, 1000),
	(93, 12, 2, 1000),
	(94, 13, 2, 1000),
	(95, 14, 2, 1000),
	(96, 15, 2, 1000),
	(97, 16, 2, 1000),
	(98, 17, 2, 1000),
	(99, 18, 2, 1000),
	(100, 19, 2, 1000),
	(101, 20, 2, 1000),
	(102, 4, 1, 986);

-- Volcando estructura para procedimiento mydb.InsertarTitutlos
DELIMITER //
CREATE PROCEDURE `InsertarTitutlos`()
BEGIN
INSERT INTO elo(elomin,elomax,titulo)
VALUES ('0','1499','noob'),
		 ('1500','1799','amateur'),
		 ('1800','2199','semiprofesional'),
		 ('2200','2299','candidato a maestro'),
		 ('2300','2399','maestro fide'),
		 ('2400','2499','maestro internacional'),
		 ('2500','4000','gran maestro');
END//
DELIMITER ;

-- Volcando estructura para procedimiento mydb.insertar_clasificacion_torneo
DELIMITER //
CREATE PROCEDURE `insertar_clasificacion_torneo`(
	IN `torneo` INT
)
BEGIN
TRUNCATE TABLE puntuaciones_torneo;
INSERT INTO puntuaciones_torneo (id_torneo,id_jugador, puntuacion)
SELECT torneo,jugador, SUM(puntuacion) AS puntuacion
FROM (
  SELECT jugadorblancas AS jugador, 
         CASE resultado 
           WHEN 1 THEN 1 
           WHEN 2 THEN 0 
           ELSE 0.5 
         END AS puntuacion 
  FROM partidos 
  WHERE id_torneo = torneo
  UNION ALL
  SELECT jugadornegras AS jugador, 
         CASE resultado 
           WHEN 1 THEN 0 
           WHEN 2 THEN 1 
           ELSE 0.5 
         END AS puntuacion 
  FROM partidos 
  WHERE id_torneo = torneo
) AS puntuaciones_totales
GROUP BY jugador;

END//
DELIMITER ;

-- Volcando estructura para tabla mydb.jugador
CREATE TABLE IF NOT EXISTS `jugador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(16) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `pais` varchar(32) NOT NULL,
  `victorias` int NOT NULL DEFAULT '0',
  `derrotas` int NOT NULL DEFAULT '0',
  `elo` int NOT NULL DEFAULT '1000',
  `titulo` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 'noob',
  PRIMARY KEY (`id`,`elo`),
  CONSTRAINT `DerrotasNoNegativo` CHECK ((`derrotas` >= 0)),
  CONSTRAINT `EloNoNegativo` CHECK ((`elo` >= 0)),
  CONSTRAINT `VictoriasNonegativo` CHECK ((`victorias` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mydb.jugador: ~22 rows (aproximadamente)
INSERT INTO `jugador` (`id`, `nombre`, `apellido`, `pais`, `victorias`, `derrotas`, `elo`, `titulo`) VALUES
	(1, 'Lucas', 'Rodriguez', 'Argentina', 3, 3, 995, 'noob'),
	(2, 'Carla', 'Garcia', 'Mexico', 3, 5, 978, 'noob'),
	(3, 'Alex', 'Sanchez', 'España', 2, 3, 988, 'noob'),
	(4, 'Anna', 'Lopez', 'Colombia', 1, 2, 986, 'noob'),
	(5, 'Joshua', 'Smith', 'Estados Unidos', 3, 0, 1039, 'noob'),
	(6, 'Sophie', 'Lee', 'Corea del Sur', 1, 1, 1001, 'noob'),
	(7, 'Mateo', 'Perez', 'Argentina', 1, 0, 1014, 'noob'),
	(8, 'Isabella', 'Gomez', 'Colombia', 1, 0, 1014, 'noob'),
	(9, 'David', 'Hernandez', 'Mexico', 0, 1, 985, 'noob'),
	(10, 'Emily', 'Brown', 'Inglaterra', 0, 0, 1000, 'noob'),
	(11, 'Hugo', 'Gonzalez', 'España', 0, 0, 1000, 'noob'),
	(12, 'Olivia', 'Johnson', 'Estados Unidos', 0, 0, 1000, 'noob'),
	(13, 'Diego', 'Martin', 'Argentina', 0, 0, 1000, 'noob'),
	(14, 'Mia', 'Gutierrez', 'Colombia', 0, 0, 1000, 'noob'),
	(15, 'Cameron', 'Lee', 'Canadá', 0, 0, 1000, 'noob'),
	(16, 'Eva', 'Hernandez', 'España', 0, 0, 1000, 'noob'),
	(17, 'Santiago', 'Sosa', 'Argentina', 0, 0, 1000, 'noob'),
	(18, 'Natalia', 'Castro', 'Colombia', 0, 0, 1000, 'noob'),
	(19, 'William', 'Taylor', 'Estados Unidos', 0, 0, 1000, 'noob'),
	(20, 'Sofia', 'Diaz', 'México', 0, 0, 1000, 'noob'),
	(21, 'Prueba', 'PRUEBA', 'PRUEBA', 0, 0, 1000, 'noob'),
	(22, 'Prueba', 'PRUEBA', 'PRUEBA', 0, 0, 1000, 'noob'),
	(23, 'Prueba2', 'PRUEBA2', 'PRUEBA2', 0, 0, 2100, 'semiprofesional');

-- Volcando estructura para tabla mydb.partidos
CREATE TABLE IF NOT EXISTS `partidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `jugadorblancas` int NOT NULL,
  `jugadornegras` int NOT NULL,
  `id_torneo` int NOT NULL,
  `resultado` int NOT NULL,
  `eloBlancas` int DEFAULT NULL,
  `eloNegras` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jugadorblanca_idx` (`jugadorblancas`),
  KEY `torneo_idx` (`id_torneo`),
  KEY `jugadornegra_idx` (`jugadornegras`),
  CONSTRAINT `jugadorblanca` FOREIGN KEY (`jugadorblancas`) REFERENCES `jugador` (`id`),
  CONSTRAINT `jugadornegra` FOREIGN KEY (`jugadornegras`) REFERENCES `jugador` (`id`),
  CONSTRAINT `torneo` FOREIGN KEY (`id_torneo`) REFERENCES `torneos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mydb.partidos: ~10 rows (aproximadamente)
INSERT INTO `partidos` (`id`, `jugadorblancas`, `jugadornegras`, `id_torneo`, `resultado`, `eloBlancas`, `eloNegras`) VALUES
	(9, 1, 2, 2, 1, 986, 1014),
	(10, 2, 3, 2, 2, 999, 973),
	(11, 3, 2, 2, 1, 988, 984),
	(12, 2, 5, 2, 2, 970, 1027),
	(13, 1, 4, 2, 1, 1001, 1000),
	(14, 6, 7, 2, 2, 1000, 1000),
	(15, 6, 9, 2, 1, 986, 1000),
	(16, 2, 4, 2, 2, 958, 986),
	(17, 1, 4, 2, 1, 1015, 999),
	(18, 3, 8, 2, 2, 1002, 1000),
	(19, 1, 2, 2, 2, 1028, 945),
	(20, 1, 2, 2, 2, 1011, 962);

-- Volcando estructura para procedimiento mydb.proc_calculateELO
DELIMITER //
CREATE PROCEDURE `proc_calculateELO`(
	INOUT `Elo1` INT,
	INOUT `Elo2` INT,
	IN `Victoria1` INT
)
    DETERMINISTIC
BEGIN
	DECLARE var_prob1 FLOAT;
	DECLARE var_prob2 FLOAT;
	DECLARE const_K INT DEFAULT 28;

	-- Calculamos la probabilidad de victoria para cada caso
	--	probabilidad de victoria de jug1
	SET var_prob1=func_probabilidad(Elo2,Elo1);
	--	probabilidad de victoria de jug2
	SET var_prob2=func_probabilidad(Elo1,Elo2);
	
	SET @a=var_prob1;
	SET @b=var_prob2;
	
	-- No esta calculado para empate, por lo que lo quizas sea necesario modificar el proc o no llamarlo
	
	-- victoria1 significa que gana el jugador 1 y pierde jugador 2
	IF (victoria1=1) THEN
		SET Elo1=ROUND(Elo1+const_k*(1-var_prob1));
		SET Elo2=ROUND(Elo2+const_k*(0-var_prob2));
	ELSE 
	-- este seria el caso en el jugador 2 gana y el jugador 1 pierde
		SET Elo1=Elo1+const_k*(0-var_prob1);
		SET Elo2=Elo2+const_k*(1-var_prob2);
	END IF;
	

END//
DELIMITER ;

-- Volcando estructura para tabla mydb.puntuaciones_torneo
CREATE TABLE IF NOT EXISTS `puntuaciones_torneo` (
  `id_jugador` int NOT NULL,
  `puntuacion` float NOT NULL,
  `id_torneo` int DEFAULT NULL,
  PRIMARY KEY (`id_jugador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mydb.puntuaciones_torneo: ~9 rows (aproximadamente)
INSERT INTO `puntuaciones_torneo` (`id_jugador`, `puntuacion`, `id_torneo`) VALUES
	(1, 3, 2),
	(2, 2, 2),
	(3, 2, 2),
	(4, 1, 2),
	(5, 1, 2),
	(6, 1, 2),
	(7, 1, 2),
	(8, 1, 2),
	(9, 0, 2);

-- Volcando estructura para tabla mydb.torneos
CREATE TABLE IF NOT EXISTS `torneos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `ciudad` varchar(45) NOT NULL,
  `premio` int DEFAULT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `partidasmax` int NOT NULL,
  `participantesmax` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fecha_valida` CHECK ((`fecha_inicio` <= `fecha_fin`)),
  CONSTRAINT `participantes_valida` CHECK ((`participantesmax` > 2)),
  CONSTRAINT `partidas_valida` CHECK ((`partidasmax` > 1))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mydb.torneos: ~3 rows (aproximadamente)
INSERT INTO `torneos` (`id`, `nombre`, `ciudad`, `premio`, `fecha_inicio`, `fecha_fin`, `partidasmax`, `participantesmax`) VALUES
	(1, 'AmericanTournament', 'Miami', 5000, '2024-04-03 00:00:00', '2024-06-03 00:00:00', 5, 11),
	(2, 'EuropaStars', 'Barcelona', 4000, '2025-04-02 00:00:00', '2025-06-02 00:00:00', 6, 20),
	(3, 'AndaluciaLegend', 'Granada', 35000, '2026-07-07 00:00:00', '2026-08-09 00:00:00', 4, 12);

-- Volcando estructura para procedimiento mydb.VaciarTablas
DELIMITER //
CREATE PROCEDURE `VaciarTablas`()
BEGIN
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE elo;
TRUNCATE TABLE elochanged;
TRUNCATE TABLE inscripciones;
TRUNCATE TABLE jugador;
TRUNCATE TABLE partidos;
TRUNCATE TABLE puntuaciones_torneo;
TRUNCATE TABLE torneos;
SET FOREIGN_KEY_CHECKS=1;
END//
DELIMITER ;

-- Volcando estructura para disparador mydb.Actualizar elo
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `Actualizar elo` AFTER INSERT ON `partidos` FOR EACH ROW BEGIN
    DECLARE elo_blancas1   int;
    DECLARE elo_negras2    int;
    DECLARE winner1        int;

    SELECT elo into elo_blancas1  FROM jugador WHERE id = NEW.jugadorblancas;
    SELECT elo into elo_negras2   FROM jugador WHERE id = NEW.jugadornegras;
	 SELECT resultado INTO winner1 FROM partidos WHERE id = NEW.id;

IF winner1 is not null then
        call proc_calculateELO(elo_blancas1, elo_negras2, winner1);
        UPDATE  jugador SET elo = elo_blancas1 WHERE id = NEW.jugadorblancas;
        UPDATE  jugador SET elo = elo_negras2 WHERE id = NEW.jugadornegras;
    END IF;
    END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.Actualizar titulo
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `Actualizar titulo` BEFORE UPDATE ON `jugador` FOR EACH ROW BEGIN
DECLARE elo_actual INT;
SELECT NEW.elo INTO elo_actual;

SET NEW.titulo = (SELECT titulo FROM elo WHERE elomin <= elo_actual AND elomax >= elo_actual);
IF NEW.titulo != OLD.titulo THEN
		INSERT INTO elochanged(id_jugador, nuevotitulo, anteriortitulo, fecha)
		VALUES (OLD.id, NEW.titulo, OLD.titulo, NOW());
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.ActualizarDerrotas-victorias
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `ActualizarDerrotas-victorias` AFTER INSERT ON `partidos` FOR EACH ROW BEGIN

IF new.resultado = 1 then
	UPDATE jugador SET victorias = victorias + 1 WHERE id = NEW.jugadorblancas;
	UPDATE jugador SET derrotas = derrotas + 1 WHERE id = NEW.jugadornegras;
ELSEIF new.resultado = 2 then
	UPDATE jugador SET victorias = victorias + 1 WHERE id = NEW.jugadornegras;
	UPDATE jugador SET derrotas = derrotas + 1 WHERE id = NEW.jugadorblancas;
END if;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.EloBlancaNegraPartidos
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `EloBlancaNegraPartidos` BEFORE INSERT ON `partidos` FOR EACH ROW BEGIN
SET NEW.eloBlancas = (SELECT elo FROM jugador WHERE id = NEW.jugadorblancas);
SET NEW.eloNegras = (SELECT elo FROM jugador WHERE id = NEW.jugadornegras);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.GuardarElo
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `GuardarElo` BEFORE INSERT ON `inscripciones` FOR EACH ROW BEGIN
SET NEW.eloInicial = (SELECT elo FROM jugador WHERE id = NEW.jugador_id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.JugadorInscrito
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `JugadorInscrito` BEFORE INSERT ON `partidos` FOR EACH ROW BEGIN
IF ((SELECT COUNT(*) FROM inscripciones WHERE jugador_id = NEW.jugadornegras AND torneos_id = NEW.id_torneo) = 0) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El jugador de las negras no está inscrito en el torneo.';
   END IF;
	IF ((SELECT COUNT(*) FROM inscripciones WHERE jugador_id = NEW.jugadorblancas AND torneos_id = NEW.id_torneo) = 0) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El jugador de las blancas no está inscrito en el torneo.';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.Maxjugadoresinscritos
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `Maxjugadoresinscritos` BEFORE INSERT ON `inscripciones` FOR EACH ROW BEGIN
    DECLARE cant_jugadores INT;
    
    SELECT COUNT(*) INTO cant_jugadores
    FROM inscripciones
    WHERE torneos_id = NEW.torneos_id;
    
    IF (cant_jugadores >= (SELECT participantesmax FROM torneos WHERE id = NEW.torneos_id)) THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Maximo de jugadores permitido';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.MaxjugadoresPartidas
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `MaxjugadoresPartidas` BEFORE INSERT ON `partidos` FOR EACH ROW BEGIN
    IF (SELECT COUNT(*) FROM partidos WHERE jugadorblancas = NEW.jugadorblancas OR jugadornegras = NEW.jugadornegras) >= 
        (SELECT partidasmax FROM torneos WHERE id = NEW.id_torneo) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El jugador ya ha jugado el máximo de partidas permitidas en este torneo';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.MismoAño_Ciudad
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `MismoAño_Ciudad` BEFORE INSERT ON `torneos` FOR EACH ROW BEGIN
    IF EXISTS(SELECT 1 FROM torneos WHERE ciudad = NEW.ciudad AND YEAR(fecha_inicio) = YEAR(NEW.fecha_inicio))
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede crear un torneo en la misma ciudad en el mismo año';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador mydb.NoPartidaContraSimismo
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `NoPartidaContraSimismo` BEFORE INSERT ON `partidos` FOR EACH ROW BEGIN
    IF NEW.jugadorblancas = NEW.jugadornegras THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El jugador blanco y el jugador negro tienen que ser diferentes.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
