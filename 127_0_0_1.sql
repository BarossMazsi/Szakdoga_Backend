-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Nov 28. 10:45
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
-- Adatbázis: `focis_mobil`
--
CREATE DATABASE IF NOT EXISTS `focis_mobil` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `focis_mobil`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `fel_id` int(11) NOT NULL,
  `felh_email` varchar(255) DEFAULT NULL,
  `felh_jelszo` varchar(255) DEFAULT NULL,
  `felh_nev` varchar(255) NOT NULL,
  `felh_mag` int(11) NOT NULL,
  `felh_suly` int(11) NOT NULL,
  `felh_nem` enum('Férfi','Nő','Semleges') NOT NULL,
  `felh_szeret` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`fel_id`, `felh_email`, `felh_jelszo`, `felh_nev`, `felh_mag`, `felh_suly`, `felh_nem`, `felh_szeret`) VALUES
(1, NULL, NULL, 'Botond', 180, 80, 'Férfi', 'Mindent'),
(2, NULL, NULL, 'Szabolcs', 190, 75, 'Férfi', 'mindent'),
(3, NULL, NULL, 'Robesz', 187, 80, 'Férfi', 'Gluténerzékeny'),
(4, NULL, NULL, 'Mazsi', 185, 65, 'Férfi', 'Mindent');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `video`
--

CREATE TABLE `video` (
  `video_id` int(11) NOT NULL,
  `video_felh` int(11) NOT NULL,
  `video_link` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `video`
--

INSERT INTO `video` (`video_id`, `video_felh`, `video_link`) VALUES
(1, 4, 'https://www.youtube.com/embed/gB8BK9eBd7w?si=4yUMR7K8WGoTrrBI'),
(2, 1, 'https://www.youtube.com/embed/W90mt_Y2NtU?si=xI9fRXcpKaXrl35k'),
(3, 3, 'https://www.youtube.com/embed/XgtnslkITmg?si=5blsoJNZq1_TGBHf'),
(4, 2, 'https://www.youtube.com/embed/wvlztaJYKYI?si=ZBv9xid3Pz_F8J7T');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`fel_id`);

--
-- A tábla indexei `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `video_felh` (`video_felh`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `fel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `video`
--
ALTER TABLE `video`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `video_ibfk_1` FOREIGN KEY (`video_felh`) REFERENCES `felhasznalok` (`fel_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
