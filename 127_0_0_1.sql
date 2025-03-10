-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Már 03. 12:49
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
-- Tábla szerkezet ehhez a táblához `belepes`
--

CREATE TABLE `belepes` (
  `belepes_id` int(11) NOT NULL,
  `szemely_id` int(11) NOT NULL,
  `belepes_idopont` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `belepes`
--

INSERT INTO `belepes` (`belepes_id`, `szemely_id`, `belepes_idopont`) VALUES
(2, 11, '2025-03-03 11:44:44'),
(3, 10, '2025-03-03 11:50:57'),
(4, 10, '2025-03-03 11:59:43'),
(5, 10, '2025-03-03 12:01:57'),
(6, 10, '2025-03-03 12:04:56'),
(7, 5, '2025-03-03 12:31:35');

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
  `edzes_egetes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `edzes`
--

INSERT INTO `edzes` (`edzes_id`, `edzes_felhid`, `edzes_datum`, `edzes_tipus`, `edzes_idotartam`, `edzes_egetes`) VALUES
(1, 1, '2024-12-06', 1, 30, 500),
(2, 4, '2024-12-06', 1, 60, 500);

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
  `felh_nem` int(11) NOT NULL,
  `felh_nemszeret` varchar(255) NOT NULL,
  `felh_kep` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`fel_id`, `felh_email`, `felh_jelszo`, `felh_nev`, `felh_mag`, `felh_suly`, `felh_nem`, `felh_nemszeret`, `felh_kep`) VALUES
(5, 'Aa', '$2a$10$BZ.Nsm3Pl1cOo8aliFRfiONT7xMv3jGHc8ZVJsm2rpLAwOoVmUBAK', '', 0, 0, 1, '', ''),
(8, 'Bb', '$2a$10$2hbYMA8DFVlxI8/qom.fx.AHJsPINnZDRBIAV5CF26SY0Zd/NwNd.', '', 0, 0, 1, '', ''),
(9, 'A', '$2a$10$LHz.V04h449VQPvtUmqEV.YNDTVtJ1ZvXGOAYjUCflVM.tQHyONcO', '', 0, 0, 1, '', ''),
(10, 'Admin', '$2a$10$zIAWJwmuIsg3gxPZOf5BMeXn/yyny1lTf.pdE1v17gUosSyWl.TmS', '', 0, 0, 1, '', ''),
(11, 'Gaál István', '$2a$10$cDd0Cjh1uqc.fe8UbWQcTeL6vgigRL1YiJ4gNL6yfZufVrSn8W.lC', 'Gaál István', 175, 65, 1, 'zöldségek többsége', '');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `nemek`
--

CREATE TABLE `nemek` (
  `id` int(11) NOT NULL,
  `nem` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `nemek`
--

INSERT INTO `nemek` (`id`, `nem`) VALUES
(1, 'Férfi'),
(2, 'Nő');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rang`
--

CREATE TABLE `rang` (
  `rang_id` int(11) NOT NULL,
  `rang_felhasznalo` int(11) NOT NULL,
  `rang_ertek` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `rang`
--

INSERT INTO `rang` (`rang_id`, `rang_felhasznalo`, `rang_ertek`) VALUES
(1, 10, 1),
(3, 11, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sportolok`
--

CREATE TABLE `sportolok` (
  `ID` int(11) NOT NULL,
  `Nev` varchar(100) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `Kor` int(11) NOT NULL,
  `Nem` enum('Férfi','Nő') CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `Pozicio` varchar(50) CHARACTER SET utf8 COLLATE utf8_hungarian_ci DEFAULT NULL,
  `Suly` decimal(5,2) DEFAULT NULL,
  `Magassag` decimal(5,2) DEFAULT NULL,
  `Elozo_Csapatai` varchar(100) CHARACTER SET utf8 COLLATE utf8_hungarian_ci DEFAULT NULL,
  `Jelenlegi_csapata` varchar(100) CHARACTER SET utf8 COLLATE utf8_hungarian_ci DEFAULT NULL,
  `Allampolgarsag` varchar(111) NOT NULL,
  `Statusza` varchar(100) NOT NULL,
  `Kepek` varchar(255) NOT NULL,
  `wikipedia` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `sportolok`
--

INSERT INTO `sportolok` (`ID`, `Nev`, `Kor`, `Nem`, `Pozicio`, `Suly`, `Magassag`, `Elozo_Csapatai`, `Jelenlegi_csapata`, `Allampolgarsag`, `Statusza`, `Kepek`, `wikipedia`) VALUES
(1, 'Kovács Péter', 46, 'Férfi', 'Csatár', 97.00, 198.00, 'Újpest FC\r\nVác FC\r\nFC Lahti\r\nFC Haka\r\nTromsø IL\r\nViking FK\r\nStrømsgodset\r\nOdd Grenland\r\nLierse SK', 'Arendal Fotball', 'magyar', 'Jelenleg is aktív', 'Kovacs_Peter.png', 'https://hu.wikipedia.org/wiki/Kov%C3%A1cs_P%C3%A9ter_(labdar%C3%BAg%C3%B3,_1978)'),
(2, 'Csiszár Henrietta', 30, 'Nő', 'középpályás', 58.00, 164.00, 'Hajdúnánás FK\r\nFerencvárosi TC\r\nBelvárosi NLC\r\nMTK Hungária FC\r\nASA Tîrgu Mureş\r\n1. FC Lübars\r\nBayer', 'Football Club Internazionale Milano', 'magyar', 'Jelenleg is aktív', 'Csiszar_Henrietta.png', 'https://hu.wikipedia.org/wiki/Csisz%C3%A1r_Henrietta'),
(3, 'Puskás Ferenc', 79, 'Férfi', 'csatár (balösszekötő)', 72.00, 172.00, 'Kispest AC / Bp. Honvéd', 'Real Madrid', 'magyar, spanyol', 'Elhunyt', 'Puskas_Ferenc.png', 'https://hu.wikipedia.org/wiki/Pusk%C3%A1s_Ferenc_(labdar%C3%BAg%C3%B3)'),
(4, 'Szoboszlai Dominik', 24, 'Férfi', 'középpályás', 74.00, 187.00, 'Videoton\r\nFőnix Gold\r\nMTK Budapest\r\nSalzburg\r\nLiefering\r\nRB Leipzig', 'Liverpool Football Club', 'magyar', 'Jelenleg is aktív', 'Szoboszlai_Dominik.png', 'https://hu.wikipedia.org/wiki/Szoboszlai_Dominik'),
(5, 'Cristiano Ronaldo', 39, 'Férfi', 'csatár', 85.00, 187.00, 'CF Andorinha\r\nNacional\r\nSporting\r\nManchester United\r\nReal Madrid\r\nJuventus\r\nManchester United', 'En-Naszr FC', 'portugál', 'Jelenleg is aktív', 'Cristiano_Ronaldo.png', 'https://hu.wikipedia.org/wiki/Cristiano_Ronaldo'),
(6, 'Lionel Messi', 37, 'Férfi', 'szélső és támadó középpályás', 72.00, 170.00, 'Newell’s Old Boys\r\nFC Barcelona\r\nParis Saint-Germain', 'Inter Miami CF', 'argentin, spanyol', 'Jelenleg is aktív', 'Lionel_Messi.png', 'https://hu.wikipedia.org/wiki/Lionel_Messi'),
(7, 'Mohamed Szaláh Gáli', 32, 'Férfi', 'szélső támadó', 72.00, 175.00, 'al-Mukavilun\r\nBasel\r\nChelsea\r\nFiorentina\r\nRoma', 'Liverpool Football Club', 'egyiptomi', 'Jelenleg is aktív', 'Mohamed_Szalah_Gali.png', 'https://hu.wikipedia.org/wiki/Mohamed_Szal%C3%A1h');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tanacsok`
--

CREATE TABLE `tanacsok` (
  `id` int(11) NOT NULL,
  `tanacs_cim` varchar(544) NOT NULL,
  `tanacs_szoveg` varchar(544) NOT NULL,
  `datum` date NOT NULL,
  `sportoloid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `tanacsok`
--

INSERT INTO `tanacsok` (`id`, `tanacs_cim`, `tanacs_szoveg`, `datum`, `sportoloid`) VALUES
(1, 'Szoboszlai Dominik Étrendje', 'A Liverpool csapatkonyháján a játékosok rendelkezésére áll egy gyümölcscentrifuga, hogy frissen facsart leveket igyanak, ezenkívül mindig van az étkezőben kitéve dióféle, granola és egy salátás részleg is. Szoboszlaiék nem ehetnek előregyártott készételeket és mártásokat sem. A salátaönteteket, szószokat is a Liverpool konyháján készítik el nekik. A desszertekhez pedig mandulatejet, kiváló minőségű kakaót és melaszt használnak.', '2023-07-04', 4),
(2, 'Cristiano Ronaldo étrendje', 'Cristiano Ronaldo, a világ egyik legjobb focistája, az étrendjét gondosan megtervezi, hogy fenntartsa kiemelkedő formáját. A következő étkezési szokások segítik a regenerációt és a teljesítmény maximalizálását:\r\nReggeli: Zabkása, tojásfehérje, avokádó és friss gyümölcsök.\r\nTízórai: Proteines ital vagy túró.\r\nEbéd: Grillezett csirke, barna rizs, zöldségek, például brokkoli vagy spenót.\r\nUzsonna: Mandula vagy egy kis adag joghurt.\r\nVacsora: Hal, például lazac, édesburgonya és saláta.', '2024-11-26', 5),
(3, 'Lionel Messi étrendje', 'Lionel Messi, aki szintén a világ legnagyobb labdarúgóinak egyike, szintén nagy hangsúlyt fektet a táplálkozásra. Messi étrendje gazdag tápanyagokban, amely segíti őt a gyors regenerációban és az energiaszint fenntartásában.\r\nReggeli: Pita kenyér, tojás, sajt, zöldségek.\r\nTízórai: Friss gyümölcs vagy smoothie.\r\nEbéd: Grillezett csirke, quinoa vagy barna rizs, saláta.\r\nUzsonna: Diófélék vagy túró.\r\nVacsora: Fehér hús, például csirke vagy pulyka, zöldségekkel.', '2024-11-26', 6),
(4, 'Mohamed Salah étrendje', 'Mohamed Salah, a Liverpool sztárja, szintén különös figyelmet fordít az étrendjére, hogy támogassa intenzív edzésmunkáját. Az ő étrendje is a kiegyensúlyozott tápanyagbevitelre épít.\r\nReggeli: Zabkása, friss bogyós gyümölcsök és joghurt.\r\nTízórai: Fehérje shake vagy protein szelet.\r\nEbéd: Grillezett hal, például tonhal, quinoa és zöldség.\r\nUzsonna: Szeletelt avokádó és teljes kiőrlésű kenyér.\r\nVacsora: Csirke, édesburgonya és brokkoli.', '2024-11-26', 7);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tipus`
--

CREATE TABLE `tipus` (
  `tipus_id` int(11) NOT NULL,
  `tipus_nev` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `tipus`
--

INSERT INTO `tipus` (`tipus_id`, `tipus_nev`) VALUES
(1, 'futás'),
(2, 'Állóképességi edzés'),
(3, 'Technikai edzés'),
(4, 'Gyorsasági edzés'),
(5, 'Erőnléti edzés'),
(6, 'Taktikai edzés');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `uzenet`
--

CREATE TABLE `uzenet` (
  `uzenet_id` int(11) NOT NULL,
  `felado` int(11) NOT NULL,
  `cimzett` int(11) NOT NULL,
  `szoveg` varchar(255) NOT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `uzenet`
--

INSERT INTO `uzenet` (`uzenet_id`, `felado`, `cimzett`, `szoveg`, `datum`) VALUES
(1, 5, 5, 'Hello', '2025-01-20'),
(2, 5, 1, 'Hello', '2025-01-20'),
(3, 5, 2, 'Hello', '2025-01-20'),
(4, 5, 2, 'Sajt', '2025-01-20'),
(5, 5, 2, 'Hali', '2025-01-20'),
(6, 5, 1, 'Sajt', '2025-01-20'),
(7, 5, 1, 'E', '2025-01-20'),
(8, 5, 1, 'Teszt', '2025-01-20'),
(9, 8, 1, 'Hali', '2025-01-20');

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
-- A tábla indexei `belepes`
--
ALTER TABLE `belepes`
  ADD PRIMARY KEY (`belepes_id`),
  ADD KEY `szemely_id` (`szemely_id`);

--
-- A tábla indexei `edzes`
--
ALTER TABLE `edzes`
  ADD PRIMARY KEY (`edzes_id`),
  ADD KEY `edzes_felhid` (`edzes_felhid`),
  ADD KEY `edzes_tipus` (`edzes_tipus`);

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`fel_id`),
  ADD KEY `felh_nem` (`felh_nem`);

--
-- A tábla indexei `nemek`
--
ALTER TABLE `nemek`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `rang`
--
ALTER TABLE `rang`
  ADD PRIMARY KEY (`rang_id`);

--
-- A tábla indexei `sportolok`
--
ALTER TABLE `sportolok`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `tanacsok`
--
ALTER TABLE `tanacsok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sportoloid` (`sportoloid`);

--
-- A tábla indexei `uzenet`
--
ALTER TABLE `uzenet`
  ADD PRIMARY KEY (`uzenet_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `belepes`
--
ALTER TABLE `belepes`
  MODIFY `belepes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `fel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `nemek`
--
ALTER TABLE `nemek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `rang`
--
ALTER TABLE `rang`
  MODIFY `rang_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `sportolok`
--
ALTER TABLE `sportolok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `tanacsok`
--
ALTER TABLE `tanacsok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `uzenet`
--
ALTER TABLE `uzenet`
  MODIFY `uzenet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `belepes`
--
ALTER TABLE `belepes`
  ADD CONSTRAINT `belepes_ibfk_1` FOREIGN KEY (`szemely_id`) REFERENCES `felhasznalok` (`fel_id`);

--
-- Megkötések a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD CONSTRAINT `felhasznalok_ibfk_1` FOREIGN KEY (`felh_nem`) REFERENCES `nemek` (`id`);

--
-- Megkötések a táblához `tanacsok`
--
ALTER TABLE `tanacsok`
  ADD CONSTRAINT `tanacsok_ibfk_1` FOREIGN KEY (`sportoloid`) REFERENCES `sportolok` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
