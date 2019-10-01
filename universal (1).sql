-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 30-09-2019 a las 07:11:17
-- Versión del servidor: 5.7.26
-- Versión de PHP: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `universal`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `actualizar_nombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_nombre` (`nom` VARCHAR(30), `valor` INT)  BEGIN
UPDATE cliente set NOMBRE = nom WHERE CI = valor;

END$$

DROP PROCEDURE IF EXISTS `calc_edad`$$
CREATE DEFINER=`userlg`@`%` PROCEDURE `calc_edad` (`year1` INT)  BEGIN
   DECLARE this_year INT DEFAULT YEAR(now());
   DECLARE edad int;
   SET edad = this_year - year1;
   SELECT edad;
END$$

DROP PROCEDURE IF EXISTS `cuenta_reg`$$
CREATE DEFINER=`userlg`@`%` PROCEDURE `cuenta_reg` (IN `f` DATE, IN `cod` INT)  BEGIN
    DECLARE num INT;
    SET num = 0;
    SET num = (SELECT COUNT(ci) from cliente ) ;
    
    INSERT INTO  clientes_lista (cuenta,fecha) VALUES (num, now());
    
    if (f is null) THEN
    
    set f = (now());
    UPDATE cliente SET cliente.fecha_insert = f where cod = cliente.CI;
    
    END IF;

end$$

DROP PROCEDURE IF EXISTS `respaldo_cliente`$$
CREATE DEFINER=`userlg`@`%` PROCEDURE `respaldo_cliente` (`num` INT)  BEGIN
INSERT INTO clientes_lista (cuenta,fecha) VALUES (num, now());

END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `actualizar_fecha`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `actualizar_fecha` () RETURNS VARCHAR(60) CHARSET latin1 BEGIN
DECLARE x int;
DECLARE cad varchar (15);

set x = (SELECT count(ci) FROM cliente WHERE fecha_insert is null);
set cad =   (  SELECT CONVERT(x,CHAR(5)));

update cliente set fecha_insert = now() WHERE fecha_insert IS null;
if x > 0 then
RETURN (select concat('realizado || Registros Modificados-->>', cad));
ELSE
RETURN (select concat('No realizado || Registros Modificados-->>',cad));
end if;
end$$

DROP FUNCTION IF EXISTS `cliente_registrados`$$
CREATE DEFINER=`userlg`@`%` FUNCTION `cliente_registrados` () RETURNS VARCHAR(40) CHARSET latin1 BEGIN
DECLARE x INT DEFAULT 0;

set x = (SELECT COUNT(ci) from cliente);

RETURN concat('Clientes Registrados-->>',x);
END$$

DROP FUNCTION IF EXISTS `contar_clientes`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `contar_clientes` () RETURNS INT(11) BEGIN

DECLARE x int;

set x = (SELECT count(ci) from cliente);

RETURN x;

end$$

DROP FUNCTION IF EXISTS `contar_item`$$
CREATE DEFINER=`userlg`@`%` FUNCTION `contar_item` () RETURNS VARCHAR(35) CHARSET latin1 BEGIN

DECLARE cont int;

set cont = (SELECT COUNT(cod_producto) FROM producto);

RETURN concat('Numero de Items-->>',cont);

END$$

DROP FUNCTION IF EXISTS `sumar`$$
CREATE DEFINER=`userlg`@`%` FUNCTION `sumar` (`x1` INT, `x2` INT) RETURNS INT(11) BEGIN
DECLARE resultado INT;
set resultado = 0;
set resultado = x1 + x2;
RETURN resultado;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cli`
--

DROP TABLE IF EXISTS `cli`;
CREATE TABLE IF NOT EXISTS `cli` (
  `usuario` varchar(30) NOT NULL,
  `fecha` date NOT NULL,
  `cod_cliente` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Respaldo de la tabla cliente';

--
-- Volcado de datos para la tabla `cli`
--

INSERT INTO `cli` (`usuario`, `fecha`, `cod_cliente`, `nombre`, `apellido`) VALUES
('root@localhost', '2019-09-14', 105, 'Jesus', 'Gomez'),
('userlg@%', '2019-09-15', 100, 'Luis', 'Güipe'),
('userlg@%', '2019-09-29', 5565, '', ''),
('userlg@%', '2019-09-29', 116, 'Jose Manuel', 'Betancourt'),
('userlg@%', '2019-09-29', 215, 'Luisjose', 'Gill');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `CI` int(10) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(20) DEFAULT NULL,
  `APELLIDO` varchar(20) DEFAULT NULL,
  `DIRECCION` tinytext,
  `TELEFONO` varchar(12) DEFAULT '',
  `fecha_insert` date DEFAULT NULL,
  PRIMARY KEY (`CI`),
  UNIQUE KEY `TELEFONO` (`TELEFONO`)
) ENGINE=InnoDB AUTO_INCREMENT=5571 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`CI`, `NOMBRE`, `APELLIDO`, `DIRECCION`, `TELEFONO`, `fecha_insert`) VALUES
(76, 'Pedro', 'Urdaneja', 'San Felix, Estado Bolivar', '028695478945', '2019-09-30'),
(101, 'Lilibeth', 'Perez', 'Puerto Ordaz Estado Bolivar Unare', '04249545343', '2019-09-14'),
(103, 'Amira', 'Gomez', 'Puerto Ordaz Unare', '02869518187', '2019-09-14'),
(111, 'Rafael', 'Urdaneja', 'Fundacion Mendoza. Ciudad Bolivar', '02856558712', '2019-09-14'),
(112, 'Jonathan', 'Rodriguez', 'Urb San Rafael. Ciudad Bolivar', '0285655942', '2019-09-30'),
(113, 'Eduardo', 'Leon', 'Carmen Isabel, Anaco', '02824247978', '2019-09-30'),
(114, 'Jose', 'Buffalino', 'Las mercedes, Caracas Venezuela', '02129536582', '2019-09-30'),
(115, 'Roxane', 'Diaz', 'Caracas, Distrito Federal Urb 15', '04127526587', '2019-09-14'),
(130, 'Elena', 'Martinez', 'Puerto La Cruz, Edo Anzoategui', '02879566658', '2019-09-14'),
(135, 'leo', 'gonzales', 'Trujillo, Avenida Independencia', '027898825', '2019-09-30'),
(138, 'Cristiano', 'Ronaldo', 'Portugal, La rinconada Rancho', '+6985226', '2019-09-14'),
(150, 'Emmanuel', 'Lopez', 'Amazonas, Calle de 23 de enero', '028995632', '2019-09-14'),
(161, 'Martha', 'Stwuart', 'New York, Estados Unidos', '+1478552388', '2019-09-14'),
(207, 'Elena', 'Rodriguez', 'Urbanizacion Los vientos', '41689852', '2019-09-30'),
(5559, 'Rafael', 'Arias', 'El tigre Edo Anzoategui', '0416855295', '2019-09-30'),
(5561, 'Mauricio', 'Castro', 'Trujillo , Calle Independencia Numero 26', '04125699852', '2019-09-25'),
(5562, 'Fabiola', 'Mendez', 'Puerto Rico Calle capital', '+155488368', '2019-09-21'),
(5563, 'Juan', 'Melendez', 'Santa Monica US', '+1558266', '2019-09-29'),
(5564, 'maria', 'martinez', 'Los guayaneses', '0414855265', '2019-09-29'),
(5567, 'Lucios', 'Castroel', 'Argentina. Calle Independencia', '04148552662', '2019-09-30'),
(5568, 'Mario', 'Rodriguez', 'San Los Roques Cundinamarca', '+52455851222', '2019-09-29'),
(5569, 'Mario', 'Ferrero', 'Los Mexicanos Calle 13', '+5245585365', '2019-09-30'),
(5570, 'Carlos', 'Leon', 'Avenida de los chicos malos', '+52455852226', '2019-09-30');

--
-- Disparadores `cliente`
--
DROP TRIGGER IF EXISTS `respaldo_cli`;
DELIMITER $$
CREATE TRIGGER `respaldo_cli` AFTER DELETE ON `cliente` FOR EACH ROW BEGIN
insert into cli (usuario,fecha,cod_cliente,nombre,apellido) 
values (current_user,now(),old.ci,old.nombre,old.apellido);

end
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `test1`;
DELIMITER $$
CREATE TRIGGER `test1` AFTER INSERT ON `cliente` FOR EACH ROW CALL cuenta_reg(new.fecha_insert,new.ci)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_lista`
--

DROP TABLE IF EXISTS `clientes_lista`;
CREATE TABLE IF NOT EXISTS `clientes_lista` (
  `cuenta` int(11) NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clientes_lista`
--

INSERT INTO `clientes_lista` (`cuenta`, `fecha`) VALUES
(75, '2019-09-02 20:16:12'),
(161, '2019-09-03 07:55:54'),
(2086, '2019-09-03 08:10:33'),
(2086, '2019-09-03 08:11:00'),
(17, '2019-09-03 08:12:06'),
(18, '2019-09-03 08:15:12'),
(19, '2019-09-03 08:16:22'),
(19, '2019-09-03 08:27:12'),
(19, '2019-09-15 21:16:49'),
(19, '2019-09-22 00:53:07'),
(20, '2019-09-29 07:36:02'),
(21, '2019-09-29 07:47:52'),
(22, '2019-09-29 07:48:08'),
(23, '2019-09-29 07:52:40'),
(23, '2019-09-29 07:54:45'),
(24, '2019-09-30 04:50:22'),
(23, '2019-09-30 07:00:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

DROP TABLE IF EXISTS `compra`;
CREATE TABLE IF NOT EXISTS `compra` (
  `CI` int(13) NOT NULL,
  `COD_PRODUCTO` int(13) NOT NULL,
  `FECHA_COMPRA` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `CANTIDAD` int(100) DEFAULT NULL,
  PRIMARY KEY (`CI`,`COD_PRODUCTO`),
  KEY `Cod_producto_fk` (`COD_PRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`CI`, `COD_PRODUCTO`, `FECHA_COMPRA`, `CANTIDAD`) VALUES
(101, 5000, '2019-08-30 18:56:08', 5),
(101, 5002, '2019-09-16 06:46:35', 35),
(111, 100, '2019-09-15 22:04:01', 1),
(113, 125, '2019-08-30 19:18:48', 15),
(115, 125, '2019-08-30 19:19:30', 50),
(138, 5002, '2019-09-16 06:46:35', 99);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `first_10_users_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `first_10_users_view`;
CREATE TABLE IF NOT EXISTS `first_10_users_view` (
`nombre` varchar(20)
,`apellido` varchar(20)
,`direccion` tinytext
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_09_045726_create_projects_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
  `COD_PRODUCTO` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(25) DEFAULT NULL,
  `MARCA` varchar(25) DEFAULT NULL,
  `COLOR` varchar(25) DEFAULT NULL,
  `STOCK` int(11) DEFAULT NULL,
  `PRECIO` float DEFAULT NULL,
  `DESCRIPCION` text,
  PRIMARY KEY (`COD_PRODUCTO`)
) ENGINE=InnoDB AUTO_INCREMENT=5006 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`COD_PRODUCTO`, `NOMBRE`, `MARCA`, `COLOR`, `STOCK`, `PRECIO`, `DESCRIPCION`) VALUES
(15, 'Flash Universo 10', 'Dc Comics', 'Red', 60, 15.99, 'Nueva aventura de flash , donde se crea otra paradoja de tiempo espacio'),
(100, 'Hulk 2', 'Marvel Comics', 'Green', 20, 20.99, 'Nueva aventura del gigante verde'),
(101, 'Capitan America', 'Marvel Comics', 'Red', 30, 25, 'Nuevo volumen del  primer vengador el legendario Steve Rogers.'),
(102, 'Iron Man', 'Marvel Comics', 'Red', 50, 24.9, 'El hombre de hierro ha escapado de una prision interdimensional'),
(103, 'Dr Strange Vol 1', 'Marvel Comics', 'Blue', 50, 15, 'El dr Strange se adentra en las profundidades del inframundo para ayudar a su gran amigo el doctor Erick Raines quien esta atrapado por una fuerza del mal'),
(114, 'Fantastic Four', 'Marvel Comics', 'Blue', 50, 20, 'Nueva aventura de los 4 fantasticos'),
(125, 'Flash Universo 10', 'Dc Comics', 'Red', 70, 15.99, 'Nueva aventura de flash , donde se crea otra paradoja de tiempo espacio'),
(5000, 'Superman vol 1', 'dc comics', 'Unico', 30, 5.99, 'Primer volumen de superman, donde se cuentan los origenes del hombre de acero'),
(5002, 'Aquaman  Vol 5', 'dc comics', 'azul', 55, 15.39, 'Historia del rey de los oceanos en una aventura nueva contra su enemigo el hombre de la tierra que lucha por seguir el dominio de los mares'),
(5003, 'Flash Universo 10', 'Dc Comics', 'Red', 60, 15.99, 'Nueva aventura de flash , donde se crea otra paradoja de tiempo espacio'),
(5004, 'Spiderman 01', 'Marvel Comics', 'Black', 99, 15.24, 'Volumen 1 del sorprendete hombre araña'),
(5005, 'Hulk the monster', 'universe comics', 'blue', 100, 10.25, 'Aventura obscura del gigante verde, donde Bruce Banner adquiere una nueva mutacion tras ingerir accidentalmente una sustancia alienigena');

--
-- Disparadores `producto`
--
DROP TRIGGER IF EXISTS `actualizar_cod_producto`;
DELIMITER $$
CREATE TRIGGER `actualizar_cod_producto` AFTER UPDATE ON `producto` FOR EACH ROW BEGIN
DECLARE valor int;

SET valor = producto.cod_producto;

UPDATE provee SET provee.COD_PRODUCTO = valor WHERE provee.COD_PRODUCTO = old.cod_producto;




END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `actualizar_producto2`;
DELIMITER $$
CREATE TRIGGER `actualizar_producto2` AFTER UPDATE ON `producto` FOR EACH ROW update producto2 set nombre=old.nombre,stock=new.stock, COLOR = old.color where producto2.cod_producto = old.COD_PRODUCTO
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `borrar_producto`;
DELIMITER $$
CREATE TRIGGER `borrar_producto` AFTER DELETE ON `producto` FOR EACH ROW BEGIN
DELETE FROM provee WHERE  provee.COD_PRODUCTO = old.COD_PRODUCTO;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `t_producto_ai`;
DELIMITER $$
CREATE TRIGGER `t_producto_ai` AFTER INSERT ON `producto` FOR EACH ROW INSERT into producto2 (NOMBRE,COLOR,STOCK) VALUES (new.nombre,new.color,new.stock)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto2`
--

DROP TABLE IF EXISTS `producto2`;
CREATE TABLE IF NOT EXISTS `producto2` (
  `cod_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `color` varchar(30) NOT NULL,
  `stock` int(11) NOT NULL,
  PRIMARY KEY (`cod_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto2`
--

INSERT INTO `producto2` (`cod_producto`, `nombre`, `color`, `stock`) VALUES
(120, 'Flash Universo 10', 'Red', 70),
(125, 'flash vol 15', 'red', 50),
(126, 'Hulk the monster', 'blue', 100),
(127, 'Hulk 2', 'Green', 20),
(128, 'Capitan America', 'Red', 30),
(129, 'Iron Man', 'Red', 50),
(130, 'Dr Strange Vol 1', 'Blue', 50),
(131, 'Fantastic Four', 'Blue', 50),
(132, 'Ghost Rider', 'Black', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_url_unique` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `projects`
--

INSERT INTO `projects` (`id`, `title`, `url`, `created_at`, `updated_at`, `description`) VALUES
(1, 'Java Proyecto 1', 'java-proyecto-1', '2019-08-16 11:10:12', '2019-08-17 18:27:24', 'Proyecto hecho en java'),
(2, 'Php proyecto 1', 'php-proyecto-1', '2019-08-21 13:19:18', '2019-08-23 18:24:23', 'Proyecto hecho en lenguaje de programacion php'),
(3, 'Robot Python 1', 'robot-python-1', '2019-08-12 16:08:22', '2019-08-12 16:08:22', 'Codigo inteligente de robot escrito en lenguaje python'),
(4, 'inteligencia 507', 'inteligencia-507', '2019-08-12 16:11:11', '2019-08-12 16:11:11', 'Codigo en c y lenguaje de arduino para una inteligencia sencilla capaz de trabajar con varias interfaces'),
(5, 'Proyecto javascript 1', 'proyecto-javascript-1', '2019-08-13 12:26:42', '2019-08-13 12:26:42', 'Proyecto hecho en javascript'),
(6, 'python inteligencia', 'python-inteligencia', '2019-08-13 12:29:53', '2019-08-13 12:29:53', 'Proyecto escrito en lenguaje python con el proposito de realizar una inteligencia artifcial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provee`
--

DROP TABLE IF EXISTS `provee`;
CREATE TABLE IF NOT EXISTS `provee` (
  `ID_PROVEEDOR` int(11) NOT NULL,
  `COD_PRODUCTO` int(11) NOT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`ID_PROVEEDOR`,`COD_PRODUCTO`),
  KEY `producto_fk1` (`COD_PRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `provee`
--

INSERT INTO `provee` (`ID_PROVEEDOR`, `COD_PRODUCTO`, `CANTIDAD`, `fecha`) VALUES
(201, 125, 15, '2019-09-16'),
(201, 5002, 15, '2019-09-16'),
(202, 102, 60, '2019-09-16'),
(203, 100, 20, '2019-09-16'),
(203, 5002, 55, '2019-09-16'),
(215, 5003, 10, '2019-09-16'),
(215, 5004, 7, '2019-09-16');

--
-- Disparadores `provee`
--
DROP TRIGGER IF EXISTS `actualizar_fecha`;
DELIMITER $$
CREATE TRIGGER `actualizar_fecha` AFTER INSERT ON `provee` FOR EACH ROW BEGIN
DECLARE f date;
set f = now();
UPDATE provee p set p.fecha = f  WHERE p.fecha is null;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
  `ID_PROVEEDOR` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(20) DEFAULT NULL,
  `DIRECCION` varchar(35) DEFAULT NULL,
  `TELEFONO` int(13) DEFAULT NULL,
  PRIMARY KEY (`ID_PROVEEDOR`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`ID_PROVEEDOR`, `NOMBRE`, `DIRECCION`, `TELEFONO`) VALUES
(201, 'Martha C, A', 'Unare, Puerto Ordaz', 2129514774),
(202, 'Camiore S,A', 'Distrito Federal Zona Industrial', 288987741),
(203, 'Lois', 'Valencia, Carabobo', 555),
(211, 'ServiFull CD', 'Falcon, Coro Zona Del Puerto', 995441452),
(215, 'Universal Importador', 'Maracaibo Zulia, Sector Industrial', 28977741);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prueba`
--

DROP TABLE IF EXISTS `prueba`;
CREATE TABLE IF NOT EXISTS `prueba` (
  `numero` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `prueba`
--

INSERT INTO `prueba` (`numero`, `fecha`) VALUES
(1, '2019-09-02'),
(2, '2019-09-02'),
(3, '2019-09-25'),
(4, '2019-09-03'),
(5, '2019-09-02'),
(18, '2019-09-14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_productos`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vista_productos`;
CREATE TABLE IF NOT EXISTS `vista_productos` (
`COD_PRODUCTO` int(11)
,`NOMBRE` varchar(25)
,`MARCA` varchar(25)
,`COLOR` varchar(25)
,`STOCK` int(11)
,`PRECIO` float
,`DESCRIPCION` text
);

-- --------------------------------------------------------

--
-- Estructura para la vista `first_10_users_view`
--
DROP TABLE IF EXISTS `first_10_users_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `first_10_users_view`  AS  select `cliente`.`NOMBRE` AS `nombre`,`cliente`.`APELLIDO` AS `apellido`,`cliente`.`DIRECCION` AS `direccion` from `cliente` where (`cliente`.`CI` like '10_') ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_productos`
--
DROP TABLE IF EXISTS `vista_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_productos`  AS  select `producto`.`COD_PRODUCTO` AS `COD_PRODUCTO`,`producto`.`NOMBRE` AS `NOMBRE`,`producto`.`MARCA` AS `MARCA`,`producto`.`COLOR` AS `COLOR`,`producto`.`STOCK` AS `STOCK`,`producto`.`PRECIO` AS `PRECIO`,`producto`.`DESCRIPCION` AS `DESCRIPCION` from `producto` group by `producto`.`NOMBRE` order by `producto`.`COD_PRODUCTO` ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `Cod_cliente` FOREIGN KEY (`CI`) REFERENCES `cliente` (`CI`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_producto_fk` FOREIGN KEY (`COD_PRODUCTO`) REFERENCES `producto` (`COD_PRODUCTO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `provee`
--
ALTER TABLE `provee`
  ADD CONSTRAINT `producto_fk1` FOREIGN KEY (`COD_PRODUCTO`) REFERENCES `producto` (`COD_PRODUCTO`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedor_fk1` FOREIGN KEY (`ID_PROVEEDOR`) REFERENCES `proveedor` (`ID_PROVEEDOR`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
