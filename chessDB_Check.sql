-- 1. Victorias por defecto 0
-- Ejemplo: 
INSERT INTO jugador(nombre,apellido,pais) VALUES
('Prueba', 'PRUEBA', 'PRUEBA')
SELECT * FROM jugador WHERE pais = 'prueba'
-- 2. Elo por defecto 1000

-- 3. Victorias no puede ser negativo
-- Ejemplo:
INSERT INTO jugador(nombre,apellido,pais,victorias) VALUES
('Lucas', 'Rodriguez', 'Argentina','-40')
	-- En caso de que se muestre un mensaje de error ya estaria
	-- En caso de lo que se hace es convertirlo a un 0, se debe hacer un SELECT * from jugadores ORDER BY id DESC y que se muestre el valor


-- ️4. ELO no puede ser negativo 
	INSERT INTO jugador(nombre,apellido,pais,elo) VALUES
('Lucas', 'Rodriguez', 'Argentina','-1000')
-- ️5. Un mismo jugador no puede inscribirse 2 veces
INSERT INTO inscripciones(jugador_id,torneos_id)
VALUES ('4','1')
-- ️6. Guardar ELO al iniciar Torneo ARRIBA LO PODEMOS COMPROBAR 
SELECT * FROM inscripciones WHERE jugador_id = '4';
--  7. No es posible un mismo torneo en misma ciudad y año
INSERT INTO torneos(nombre,ciudad,premio,fecha_inicio,fecha_fin,partidasmax,participantesmax)
VALUES ('AmericanTournament','Miami','5000',DATE('2024-04-03'),DATE('2024-06-03'),'5','11'),
('AmericanTournament','Miami','5000',DATE('2024-04-03'),DATE('2024-06-03'),'5','11');

--  ️8. Fecha de inicio no puede superior a fecha fin
INSERT INTO torneos(nombre,ciudad,premio,fecha_inicio,fecha_fin,partidasmax,participantesmax)
VALUES ('CataluñaCompeti','españa','5000',DATE('2025-04-03'),DATE('2024-06-03'),'5','11');

-- 9. max_participantes >2
INSERT INTO torneos(nombre,ciudad,premio,fecha_inicio,fecha_fin,partidasmax,participantesmax)
VALUES ('CataluñaCompeti','españa','5000',DATE('2024-04-03'),DATE('2025-06-03'),'5','1');
-- 10. max_partidas > 1
INSERT INTO torneos(nombre,ciudad,premio,fecha_inicio,fecha_fin,partidasmax,participantesmax)
VALUES ('CataluñaCompeti','españa','5000',DATE('2024-04-03'),DATE('2025-06-03'),'0','10');


-- 11. inscripciones no puede ser  > max_participantes
-- tenemos el torneo con id 2 que tiene un max de participantes en 20 si agregamos uno mas 
	INSERT INTO inscripciones(jugador_id,torneos_id) VALUES('21','2')
-- 12. Un jugador no puede jugar contra si mismo
   INSERT INTO partidos(jugadorblancas,jugadornegras,id_torneo,resultado)
VALUES 
	('1','1','2','1')
-- 13. un jugador solo puede jugar partidas en torneo inscrito
-- como hemos visto antes el jugador 21 no esta inscrito por lo tanto lo siguiente deberia dar error

INSERT INTO partidos(jugadorblancas,jugadornegras,id_torneo,resultado)
VALUES ('21','1','2','1')


-- 14. Calcular y guardar ELO tras la partida
-- Esto ocurre tras insertar una partida  1028- 945// 1011-962
INSERT INTO partidos(jugadorblancas,jugadornegras,id_torneo,resultado)
VALUES ('1','2','2','2')

-- 15. Actualizar victorias/derrotas
-- Esto ocurre tras insertar una partida

-- 16. Asignar titulos inicialmente
INSERT INTO jugador(nombre,apellido,pais) VALUES
('Prueba2', 'PRUEBA2', 'PRUEBA2')
SELECT * FROM jugador WHERE nombre = 'prueba2'


-- 17. Asignar titulos cuando sube ELO
UPDATE jugador SET elo = '2100' WHERE id = '23'

-- 19. Vaciado de tablas
CALL `VaciarTablas`()

-- 20. Rellene la tabla maestra con los títulos
CALL `InsertarTitutlos`()
-- 21. Procedure que de da alta 20 jugadores
CALL `Alta20Jugadores`()
-- 22. Procedure que de da alta 3 torneos
CALL `Alta3Torneos`()
-- 23. Procedure que inscriba a 20 jugadores en un torneo
 CALL `Inscribir20jugadores`()
-- 24. Procedure que genere 10 partidas de un torneo
CALL `Generar10Partidas`()
-- 25. Generar Tabla Clasificacion
CALL `insertar_clasificacion_torneo`(2)
