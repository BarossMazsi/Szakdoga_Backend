-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Jan 21. 12:19
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `focis_mobil_regi`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `edzes`
--

CREATE TABLE `edzes` (
  `edzes_id` int(11) NOT NULL,
  `edzes_felhid` int(11) NOT NULL,
  `edzes_datum` date NOT NULL,
  `edzes_tipus` int(11) NOT NULL,
  `edzes_idotartam` int(11) NOT NULL,
  `edzes_egetes` int(11) NOT NULL,
  `edzes_leiras` text NOT NULL,
  `edzes_megjegyzes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `edzes`
--

INSERT INTO `edzes` (`edzes_id`, `edzes_felhid`, `edzes_datum`, `edzes_tipus`, `edzes_idotartam`, `edzes_egetes`, `edzes_leiras`, `edzes_megjegyzes`) VALUES
(1, 1, '2024-12-06', 1, 30, 500, '', ''),
(2, 4, '2024-12-06', 1, 60, 500, '', ''),
(3, 4, '2024-12-12', 1, 60, 500, '', ''),
(4, 4, '2024-12-12', 1, 1, 1, '', ''),
(5, 4, '2024-12-12', 2, 2, 2, '', ''),
(6, 4, '2024-12-12', 1, 3, 3, '', ''),
(7, 4, '2024-12-12', 1, 88, 88, '', ''),
(8, 4, '2024-12-12', 1, 1, 1, '1', '1'),
(9, 4, '2025-01-08', 2, 60, 500, 'Futas', 'Dddd');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `edzes`
--
ALTER TABLE `edzes`
  ADD PRIMARY KEY (`edzes_id`),
  ADD KEY `edzes_felhid` (`edzes_felhid`),
  ADD KEY `edzes_tipus` (`edzes_tipus`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `edzes`
--
ALTER TABLE `edzes`
  MODIFY `edzes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `edzes`
--
ALTER TABLE `edzes`
  ADD CONSTRAINT `edzes_ibfk_1` FOREIGN KEY (`edzes_felhid`) REFERENCES `felhasznalok` (`fel_id`),
  ADD CONSTRAINT `edzes_ibfk_2` FOREIGN KEY (`edzes_tipus`) REFERENCES `tipus` (`tipus_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
