-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-12-2023 a las 18:33:52
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `d-ability`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrator`
--

CREATE TABLE `administrator` (
  `id` int(11) NOT NULL,
  `firstName` varchar(250) DEFAULT NULL,
  `lastName` varchar(250) DEFAULT NULL,
  `login` varchar(250) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `administrator`
--

INSERT INTO `administrator` (`id`, `firstName`, `lastName`, `login`, `password`) VALUES
(1, 'luis', 'orts', 'luisorts', '1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE `agenda` (
  `id` int(11) NOT NULL,
  `idStudent` int(11) NOT NULL,
  `idTask` int(11) NOT NULL,
  `done` tinyint(1) NOT NULL,
  `dateStart` date NOT NULL,
  `dateEnd` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `agenda`
--

INSERT INTO `agenda` (`id`, `idStudent`, `idTask`, `done`, `dateStart`, `dateEnd`) VALUES
(4, 3, 20, 0, '2023-11-26', '2023-11-29'),
(5, 3, 19, 1, '2023-11-22', '2023-11-25'),
(6, 23, 19, 0, '2023-12-08', '2024-02-29'),
(7, 23, 20, 0, '2023-12-10', '2023-12-31'),
(8, 23, 48, 0, '2023-12-05', '2023-12-24'),
(9, 23, 50, 0, '2023-12-01', '2023-12-14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `appadmin`
--

CREATE TABLE `appadmin` (
  `idAdmin` int(11) NOT NULL,
  `idAdministrator` int(11) NOT NULL,
  `idStudent` int(11) NOT NULL,
  `idTask` int(11) NOT NULL,
  `idPetition` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `educator`
--

CREATE TABLE `educator` (
  `id` int(11) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `educator`
--

INSERT INTO `educator` (`id`, `firstName`, `lastName`, `user`, `password`) VALUES
(1, 'Carlos', 'Perez', 'carlos', '1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `passwordstudent`
--

CREATE TABLE `passwordstudent` (
  `id` int(11) NOT NULL,
  `idStudent` int(11) NOT NULL,
  `pictogram1` varchar(255) NOT NULL,
  `pictogram2` varchar(255) NOT NULL,
  `pictogram3` varchar(255) NOT NULL,
  `pictogram4` varchar(255) NOT NULL,
  `pictogram5` varchar(255) NOT NULL,
  `pictogram6` varchar(255) NOT NULL,
  `pass` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `passwordstudent`
--

INSERT INTO `passwordstudent` (`id`, `idStudent`, `pictogram1`, `pictogram2`, `pictogram3`, `pictogram4`, `pictogram5`, `pictogram6`, `pass`) VALUES
(1, 3, 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', '451'),
(2, 23, 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', 'illojuan.jpg', '111');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `petitions`
--

CREATE TABLE `petitions` (
  `idPetition` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `steps`
--

CREATE TABLE `steps` (
  `id` int(11) NOT NULL,
  `numStep` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `idTask` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `steps`
--

INSERT INTO `steps` (`id`, `numStep`, `description`, `image`, `idTask`) VALUES
(16, 1, 'Introducir el plato con comida fría en el microondas y cerrar la puerta.', 'pruebaPaso.png', 19),
(17, 2, 'Poner la ruleta del tiempo a 30 segundos.', 'pruebaPaso.png', 19),
(18, 3, 'Abrir la puerta y sacar el plato caliente, ¡Cuidado que quema!', 'pruebaPaso.png', 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `picture` varchar(255) NOT NULL,
  `text` tinyint(4) NOT NULL,
  `audio` tinyint(4) NOT NULL,
  `video` tinyint(4) NOT NULL,
  `idEducator` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `student`
--

INSERT INTO `student` (`id`, `firstName`, `lastName`, `picture`, `text`, `audio`, `video`, `idEducator`) VALUES
(3, 'Felipe', 'Reyes', 'descarga.jpg', 1, 1, 1, 1),
(23, 'Pepe', 'Robertino', '1679999020091.jpg', 1, 0, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tasks`
--

CREATE TABLE `tasks` (
  `idTask` int(11) NOT NULL,
  `taskName` varchar(45) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tasks`
--

INSERT INTO `tasks` (`idTask`, `taskName`, `description`, `thumbnail`, `video`) VALUES
(19, 'Poner el microondas', 'Descripcion para poner el microondas', 'images.png', NULL),
(20, 'Barrer el aula', 'Descripcion para barrer el aula 2', 'horario.png', NULL),
(48, 'pruebaa', 'f SC wegeerw3rwe', 'images.png', ''),
(50, 'segeegwef', 'wefw3fw3t', 'horario.png', 'VID-20230615-WA0009.mp4');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idTareas` (`idTask`),
  ADD KEY `idAlumnoForeignKey` (`idStudent`);

--
-- Indices de la tabla `appadmin`
--
ALTER TABLE `appadmin`
  ADD KEY `idAlumno` (`idStudent`),
  ADD KEY `idAdmin` (`idAdministrator`),
  ADD KEY `idTarea` (`idTask`),
  ADD KEY `idPeticion` (`idPetition`);

--
-- Indices de la tabla `educator`
--
ALTER TABLE `educator`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `passwordstudent`
--
ALTER TABLE `passwordstudent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idAlumnoContraseña` (`idStudent`);

--
-- Indices de la tabla `petitions`
--
ALTER TABLE `petitions`
  ADD PRIMARY KEY (`idPetition`);

--
-- Indices de la tabla `steps`
--
ALTER TABLE `steps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idTarea` (`idTask`);

--
-- Indices de la tabla `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idEducador` (`idEducator`);

--
-- Indices de la tabla `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`idTask`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `educator`
--
ALTER TABLE `educator`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `passwordstudent`
--
ALTER TABLE `passwordstudent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `steps`
--
ALTER TABLE `steps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `tasks`
--
ALTER TABLE `tasks`
  MODIFY `idTask` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD CONSTRAINT `idAlumnoForeignKey` FOREIGN KEY (`idStudent`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `idTareas` FOREIGN KEY (`idTask`) REFERENCES `tasks` (`idTask`);

--
-- Filtros para la tabla `appadmin`
--
ALTER TABLE `appadmin`
  ADD CONSTRAINT `idAdmin` FOREIGN KEY (`idAdministrator`) REFERENCES `administrator` (`id`),
  ADD CONSTRAINT `idAlumno` FOREIGN KEY (`idStudent`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `idPeticion` FOREIGN KEY (`idPetition`) REFERENCES `petitions` (`idPetition`);

--
-- Filtros para la tabla `passwordstudent`
--
ALTER TABLE `passwordstudent`
  ADD CONSTRAINT `idAlumnoContraseña` FOREIGN KEY (`idStudent`) REFERENCES `student` (`id`);

--
-- Filtros para la tabla `steps`
--
ALTER TABLE `steps`
  ADD CONSTRAINT `idTarea` FOREIGN KEY (`idTask`) REFERENCES `tasks` (`idTask`);

--
-- Filtros para la tabla `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `idEducador` FOREIGN KEY (`idEducator`) REFERENCES `educator` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
