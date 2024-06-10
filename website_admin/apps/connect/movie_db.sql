-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 08, 2024 at 06:59 PM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movie_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_no` int(14) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `Auto` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `email`, `phone_no`, `NAME`, `PASSWORD`, `Auto`) VALUES
(10, 'admin@gmail.com', 2147483646, 'admin', '123456', '1');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `B_ID` int(11) NOT NULL,
  `U_ID` int(11) NOT NULL,
  `BOOKING_DATE` datetime NOT NULL DEFAULT current_timestamp(),
  `SEAT_NO` varchar(20) NOT NULL,
  `BOOKING_ID` varchar(30) NOT NULL,
  `S_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`B_ID`, `U_ID`, `BOOKING_DATE`, `SEAT_NO`, `BOOKING_ID`, `S_ID`) VALUES
(235, 1, '2024-04-26 07:36:01', 'GE18', '96_GE18_GE19', 96),
(236, 1, '2024-04-26 07:36:01', 'GE19', '96_GE18_GE19', 96),
(245, 92, '2024-04-26 12:43:32', 'GD12', '96_GD12_GE13', 96),
(246, 92, '2024-04-26 12:43:32', 'GD13', '96_GD12_GE13', 96),
(247, 92, '2024-04-26 12:43:32', 'GE12', '96_GD12_GE13', 96),
(248, 92, '2024-04-26 12:43:32', 'GE13', '96_GD12_GE13', 96),
(249, 1, '2024-04-26 14:52:04', 'BD22', '96_BD22_BD22', 96),
(251, 1, '2024-04-26 18:19:51', 'GB22', '96_GB22_GB22', 96),
(258, 93, '2024-04-28 17:33:01', 'BA21', '97_BA19_BA21', 97),
(259, 93, '2024-04-28 17:33:01', 'BA20', '97_BA19_BA21', 97),
(260, 93, '2024-04-28 17:33:01', 'BA19', '97_BA19_BA21', 97),
(261, 93, '2024-04-30 11:22:59', 'BE9', '99_BE7_BE9', 99),
(262, 93, '2024-04-30 11:22:59', 'BE8', '99_BE7_BE9', 99),
(263, 93, '2024-04-30 11:22:59', 'BE7', '99_BE7_BE9', 99),
(264, 95, '2024-04-30 14:06:25', 'GA19', '101_GA19_GA19', 101),
(265, 95, '2024-04-30 14:07:15', 'GA7', '100_GA7_GA7', 100),
(289, 96, '2024-05-05 15:42:25', 'GC20', '103_GC20_GC22', 103),
(290, 96, '2024-05-05 15:42:25', 'GC21', '103_GC20_GC22', 103),
(291, 96, '2024-05-05 15:42:25', 'GC22', '103_GC20_GC22', 103),
(292, 96, '2024-05-09 09:22:21', 'GM22', '103_GM22_GM22', 103),
(293, 96, '2024-05-09 14:51:58', 'GK17', '103_GK17_GK17', 103),
(294, 96, '2024-05-10 05:58:22', 'BA19', '104_BA19_BA19', 104),
(295, 96, '2024-05-10 06:50:21', 'BB18', '104_BB18_BB18', 104),
(296, 96, '2024-05-10 07:28:28', 'GI16', '104_GI16_GI16', 104),
(297, 96, '2024-05-10 09:46:06', 'GF17', '104_GF17_GF17', 104),
(298, 96, '2024-05-11 09:03:59', 'GF24', '104_GF24_GF24', 104),
(299, 92, '2024-05-13 06:53:58', 'BE20', '104_BE19_BE21', 104),
(300, 92, '2024-05-13 06:53:58', 'BE19', '104_BE19_BE21', 104),
(301, 92, '2024-05-13 06:53:58', 'BE21', '104_BE19_BE21', 104),
(302, 92, '2024-05-13 06:54:31', 'GA19', '104_GA19_GD19', 104),
(303, 92, '2024-05-13 06:54:31', 'GD19', '104_GA19_GD19', 104),
(304, 96, '2024-05-13 06:58:27', 'BE24', '104_BE24_BE24', 104),
(305, 92, '2024-05-13 07:10:29', 'GA1', '106_GA1_GA2', 106),
(306, 92, '2024-05-13 07:10:29', 'GA2', '106_GA1_GA2', 106),
(307, 96, '2024-05-13 14:18:33', 'BA24', '106_BA24_BA24', 106),
(308, 96, '2024-05-15 06:22:58', 'BA24', '104_BA23_BA24', 104),
(309, 96, '2024-05-15 06:22:58', 'BA23', '104_BA23_BA24', 104),
(310, 96, '2024-05-15 07:07:55', 'BB24', '104_BB23_BB24', 104),
(311, 96, '2024-05-15 07:07:55', 'BB23', '104_BB23_BB24', 104),
(312, 96, '2024-05-15 09:33:35', 'BA22', '106_BA19_BA22', 106),
(313, 96, '2024-05-15 09:33:35', 'BA21', '106_BA19_BA22', 106),
(314, 96, '2024-05-15 09:33:35', 'BA20', '106_BA19_BA22', 106),
(315, 96, '2024-05-15 09:33:35', 'BA19', '106_BA19_BA22', 106),
(316, 96, '2024-05-17 10:26:37', 'GB7', '104_GB7_GB7', 104),
(317, 117, '2024-05-17 12:01:38', 'BA24', '112_BA23_BA24', 112),
(318, 117, '2024-05-17 12:01:38', 'BA23', '112_BA23_BA24', 112),
(320, 117, '2024-05-17 12:43:31', 'BA23', '109_BA23_BA24', 109),
(321, 117, '2024-05-17 12:43:31', 'BA24', '109_BA23_BA24', 109),
(322, 117, '2024-05-17 12:56:38', 'GA20', '112_GA20_GA21', 112),
(323, 117, '2024-05-17 12:56:38', 'GA21', '112_GA20_GA21', 112),
(324, 117, '2024-05-17 13:22:07', 'BD24', '112_BD24_BD24', 112),
(325, 117, '2024-05-17 13:33:03', 'GA19', '112_GA19_GA19', 112),
(326, 117, '2024-05-17 13:34:02', 'BE19', '112_BE19_BE19', 112),
(327, 117, '2024-05-17 13:40:57', 'BE22', '112_BE22_BE22', 112),
(328, 116, '2024-05-18 13:00:42', 'BA19', '118_BA19_BA20', 118),
(329, 116, '2024-05-18 13:00:42', 'BA20', '118_BA19_BA20', 118),
(330, 116, '2024-05-18 13:05:19', 'BA24', '114_BA10_BA24', 114),
(331, 116, '2024-05-18 13:05:19', 'BA23', '114_BA10_BA24', 114),
(332, 116, '2024-05-18 13:05:19', 'BA22', '114_BA10_BA24', 114),
(333, 116, '2024-05-18 13:05:19', 'BA21', '114_BA10_BA24', 114),
(334, 116, '2024-05-18 13:05:19', 'BA20', '114_BA10_BA24', 114),
(335, 116, '2024-05-18 13:05:19', 'BA19', '114_BA10_BA24', 114),
(336, 116, '2024-05-18 13:05:19', 'BA18', '114_BA10_BA24', 114),
(337, 116, '2024-05-18 13:05:19', 'BA17', '114_BA10_BA24', 114),
(338, 116, '2024-05-18 13:05:19', 'BA16', '114_BA10_BA24', 114),
(339, 116, '2024-05-18 13:05:19', 'BA14', '114_BA10_BA24', 114),
(340, 116, '2024-05-18 13:05:19', 'BA13', '114_BA10_BA24', 114),
(341, 116, '2024-05-18 13:05:19', 'BA15', '114_BA10_BA24', 114),
(342, 116, '2024-05-18 13:05:19', 'BA12', '114_BA10_BA24', 114),
(343, 116, '2024-05-18 13:05:19', 'BA11', '114_BA10_BA24', 114),
(344, 116, '2024-05-18 13:05:19', 'BA10', '114_BA10_BA24', 114),
(346, 113, '2024-05-22 05:54:21', 'GB20', '115_GB20_GB20', 115),
(347, 113, '2024-05-22 06:05:35', 'BA24', '115_BA24_BA24', 115),
(348, 117, '2024-05-22 06:34:50', 'BD24', '115_BD24_GA26', 115),
(349, 117, '2024-05-22 06:34:50', 'GA26', '115_BD24_GA26', 115),
(350, 113, '2024-05-22 06:35:06', 'BE10', '115_BE10_GA12', 115),
(351, 113, '2024-05-22 06:35:06', 'BE9', '115_BE10_GA12', 115),
(352, 113, '2024-05-22 06:35:06', 'GA12', '115_BE10_GA12', 115),
(353, 113, '2024-05-22 06:35:06', 'GA11', '115_BE10_GA12', 115),
(354, 113, '2024-05-22 07:02:13', 'BC22', '115_BC21_BC22', 115),
(355, 113, '2024-05-22 07:02:13', 'BC21', '115_BC21_BC22', 115),
(356, 113, '2024-05-22 07:15:42', 'BE21', '115_BE20_BE21', 115),
(357, 113, '2024-05-22 07:15:42', 'BE20', '115_BE20_BE21', 115),
(358, 113, '2024-05-22 07:31:23', 'BA21', '115_BA20_BA21', 115),
(359, 113, '2024-05-22 07:31:23', 'BA20', '115_BA20_BA21', 115),
(360, 113, '2024-05-22 07:32:54', 'BE18', '115_BE18_GA19', 115),
(361, 113, '2024-05-22 07:32:54', 'GA19', '115_BE18_GA19', 115),
(362, 113, '2024-05-22 08:08:37', 'BE22', '115_BE22_GA24', 115),
(363, 113, '2024-05-22 08:08:37', 'GA24', '115_BE22_GA24', 115),
(364, 113, '2024-05-22 08:56:02', 'GA26', '116_GA19_GB23', 116),
(365, 113, '2024-05-22 08:56:02', 'GA25', '116_GA19_GB23', 116),
(366, 113, '2024-05-22 08:56:02', 'GA24', '116_GA19_GB23', 116),
(367, 113, '2024-05-22 08:56:02', 'GA23', '116_GA19_GB23', 116),
(368, 113, '2024-05-22 08:56:02', 'GA20', '116_GA19_GB23', 116),
(369, 113, '2024-05-22 08:56:02', 'GA21', '116_GA19_GB23', 116),
(370, 113, '2024-05-22 08:56:02', 'GA22', '116_GA19_GB23', 116),
(371, 113, '2024-05-22 08:56:02', 'GB23', '116_GA19_GB23', 116),
(372, 113, '2024-05-22 08:56:02', 'GB22', '116_GA19_GB23', 116),
(373, 113, '2024-05-22 08:56:02', 'GB21', '116_GA19_GB23', 116),
(374, 113, '2024-05-22 08:56:02', 'GB20', '116_GA19_GB23', 116),
(375, 113, '2024-05-22 08:56:02', 'GB19', '116_GA19_GB23', 116),
(376, 113, '2024-05-22 08:56:02', 'GB18', '116_GA19_GB23', 116),
(377, 113, '2024-05-22 08:56:02', 'GA19', '116_GA19_GB23', 116),
(378, 113, '2024-05-22 08:56:32', 'BE18', '116_BE10_GA9', 116),
(379, 113, '2024-05-22 08:56:32', 'BE17', '116_BE10_GA9', 116),
(380, 113, '2024-05-22 08:56:32', 'BE16', '116_BE10_GA9', 116),
(381, 113, '2024-05-22 08:56:32', 'BE15', '116_BE10_GA9', 116),
(382, 113, '2024-05-22 08:56:32', 'BE14', '116_BE10_GA9', 116),
(383, 113, '2024-05-22 08:56:32', 'BE13', '116_BE10_GA9', 116),
(384, 113, '2024-05-22 08:56:32', 'BE12', '116_BE10_GA9', 116),
(385, 113, '2024-05-22 08:56:32', 'BE10', '116_BE10_GA9', 116),
(386, 113, '2024-05-22 08:56:32', 'BE11', '116_BE10_GA9', 116),
(387, 113, '2024-05-22 08:56:32', 'GA13', '116_BE10_GA9', 116),
(388, 113, '2024-05-22 08:56:32', 'GA11', '116_BE10_GA9', 116),
(389, 113, '2024-05-22 08:56:32', 'GA10', '116_BE10_GA9', 116),
(390, 113, '2024-05-22 08:56:32', 'GA12', '116_BE10_GA9', 116),
(391, 113, '2024-05-22 08:56:32', 'GA9', '116_BE10_GA9', 116),
(392, 113, '2024-05-22 08:56:32', 'GA8', '116_BE10_GA9', 116),
(393, 113, '2024-05-22 08:56:32', 'GA7', '116_BE10_GA9', 116),
(394, 113, '2024-05-22 09:43:08', 'BA19', '117_BA19_GG22', 117),
(395, 113, '2024-05-22 09:43:08', 'BA21', '117_BA19_GG22', 117),
(396, 113, '2024-05-22 09:43:08', 'BA23', '117_BA19_GG22', 117),
(397, 113, '2024-05-22 09:43:08', 'BB22', '117_BA19_GG22', 117),
(398, 113, '2024-05-22 09:43:08', 'BB20', '117_BA19_GG22', 117),
(399, 113, '2024-05-22 09:43:08', 'BC21', '117_BA19_GG22', 117),
(400, 113, '2024-05-22 09:43:08', 'GF20', '117_BA19_GG22', 117),
(401, 113, '2024-05-22 09:43:08', 'GF19', '117_BA19_GG22', 117),
(402, 113, '2024-05-22 09:43:08', 'GF18', '117_BA19_GG22', 117),
(403, 113, '2024-05-22 09:43:08', 'GE22', '117_BA19_GG22', 117),
(404, 113, '2024-05-22 09:43:08', 'GE21', '117_BA19_GG22', 117),
(405, 113, '2024-05-22 09:43:08', 'GG22', '117_BA19_GG22', 117),
(406, 113, '2024-05-22 09:43:08', 'GG16', '117_BA19_GG22', 117),
(407, 113, '2024-05-22 10:01:11', 'GA19', '117_BD16_GC15', 117),
(408, 113, '2024-05-22 10:01:11', 'GA18', '117_BD16_GC15', 117),
(409, 113, '2024-05-22 10:01:11', 'GA17', '117_BD16_GC15', 117),
(410, 113, '2024-05-22 10:01:11', 'GA16', '117_BD16_GC15', 117),
(411, 113, '2024-05-22 10:01:11', 'BE18', '117_BD16_GC15', 117),
(412, 113, '2024-05-22 10:01:11', 'BE17', '117_BD16_GC15', 117),
(413, 113, '2024-05-22 10:01:11', 'BD17', '117_BD16_GC15', 117),
(414, 113, '2024-05-22 10:01:11', 'BD16', '117_BD16_GC15', 117),
(415, 113, '2024-05-22 10:01:11', 'GB17', '117_BD16_GC15', 117),
(416, 113, '2024-05-22 10:01:11', 'GB14', '117_BD16_GC15', 117),
(417, 113, '2024-05-22 10:01:11', 'GC15', '117_BD16_GC15', 117),
(418, 113, '2024-05-22 14:20:38', 'BE24', '115_BE24_BE24', 115),
(419, 113, '2024-05-22 14:50:55', 'BA23', '115_BA23_BA23', 115),
(420, 117, '2024-05-23 13:25:14', 'BC24', '115_BC24_BC24', 115),
(421, 117, '2024-05-23 13:40:52', 'GC21', '115_GC21_GC21', 115),
(422, 117, '2024-05-27 11:47:35', 'GB18', '122_GB18_GB18', 122),
(423, 117, '2024-05-27 11:49:35', 'GA23', '122_GA23_GA23', 122),
(424, 117, '2024-05-27 11:56:38', 'BD20', '122_BD20_BD20', 122),
(425, 117, '2024-05-27 11:57:00', 'BE19', '122_BE19_BE19', 122),
(426, 117, '2024-05-27 12:02:43', 'GC15', '122_GC15_GC15', 122);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `F_ID` int(11) NOT NULL,
  `U_ID` int(11) NOT NULL,
  `SERVICES` varchar(50) NOT NULL,
  `RATING` int(11) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `DATE` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`F_ID`, `U_ID`, `SERVICES`, `RATING`, `DESCRIPTION`, `DATE`) VALUES
(80, 1, 'Shop Feedback', 4, '', '2024-04-25'),
(81, 84, 'Barber Feedback', 2, 'feed vacj', '2024-04-25'),
(82, 1, 'Stay Feedback', 2, '', '2024-04-25'),
(83, 1, 'Stay Feedback', 2, '', '2024-04-26'),
(84, 1, 'Stay Feedback', 2, '', '2024-04-26'),
(85, 1, 'Barber Feedback', 2, '', '2024-04-26'),
(86, 1, 'Stay Feedback', 2, 'dr', '2024-04-28'),
(87, 96, 'Barber Feedback', 3, 'yy', '2024-05-03'),
(88, 96, 'Canteen Feedback', 2, 'yv', '2024-05-04'),
(89, 96, 'Barber Feedback', 3, '', '2024-05-09'),
(90, 96, 'Stay Feedback', 2, 'feedback,............. .......... ', '2024-05-13'),
(91, 92, 'Stay Feedback', 4, 'ok ok ok', '2024-05-13'),
(92, 117, 'Stay Feedback', 2, '', '2024-05-17'),
(93, 116, 'Barber Feedback', 2, 'jsja', '2024-05-18'),
(94, 116, 'Barber Feedback', 5, '', '2024-05-18'),
(95, 117, 'Canteen Feedback', 2, 'feedback', '2024-05-21');

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `M_ID` int(11) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `IMAGE` varchar(255) NOT NULL,
  `STARRING` text NOT NULL,
  `RATING` varchar(20) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `TRAILER` varchar(255) DEFAULT NULL,
  `STATUS` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`M_ID`, `NAME`, `IMAGE`, `STARRING`, `RATING`, `DESCRIPTION`, `TRAILER`, `STATUS`) VALUES
(120, 'Aadujeevitham', 'uploads/662a205b5896d_aadujeevitham.jpg', 'Prithviraj Sukumaran Najeeb Muhammad  Amala Paul Sainu  Vineeth Sreenivasan Maher  Jimmy Jean-Louis Ibrahim Khadiri  Santhosh Keezhattoor Hamza  Rik Aby', '6', 'Aadujeevitham  movie description', NULL, 0),
(121, 'aaaaa', 'uploads/662a4d8789309_manjumalboys.jpeg', 'a', '5', 'aaaaaaaaaa', NULL, 0),
(122, 'Aavesham', 'uploads/662e8baa970cd_download.jpeg', 'Fahad fasil', '5', 'Movie description', NULL, 0),
(123, 'Aavesam', 'uploads/662e8c1b363bd_download.jpeg', 'Fahad fasil', '5', 'Movie desc', NULL, 0),
(124, 'Aavesham', 'uploads/66338aae9ff0f_download.jpeg', 'Fahad fasil, Fahad fasil, Fahad fasil, Fahad fasil', '5', 'Movie desc', NULL, 0),
(125, 'Batman', 'uploads/663cf2e9c56a4_ef3c9d8d311a314d8f92291acebd418a.jpg', 'Batman', '9', 'D c', NULL, 0),
(126, 'Deadpool & Wolverine', 'uploads/6641b9aca9cc2_Deadpool_&_Wolverine_poster.jpg', 'Star1, star2, start 3,star4, star5, star, 6', '8', 'Wolverine is recovering from his injuries when he crosses paths with the loudmouth, Deadpool. They team up to defeat a common enemy.', NULL, 1),
(127, 'squre img', 'uploads/66446411d7e70_1286146771.png', '5,5,,7,8', '2', 'ddddddddddddddddddddddddddddddddddddddd', NULL, 0),
(128, 'hhh', 'uploads/6644650186077_images (2).jpeg', '54', '8', 'qqqqqqqqqq', NULL, 0),
(129, 'Batman: Mask of the Phantasm', 'https://image.tmdb.org/t/p/w500/l4jaQjkgznu2Rz05X18f24UjPNW.jpg', 'Kevin Conroy, Dana Delany, Hart Bochner, Stacy Keach, Abe Vigoda, Dick Miller, John P. Ryan, Efrem Zimbalist Jr., Bob Hastings, Robert Costanzo, Mark Hamill, Jane Downs, Pat Musick, Vernee Watson-Johnson, Ed Gilbert, Peter Renaday, Jeff Bennett, Charles Howerton, Thom Pinto, Marilu Henner, Neil Ross, Arleen Sorkin, Judi M. Durand', '7.472', 'When a powerful criminal, who is connected to Bruce Wayne\'s ex-girlfriend, blames the Dark Knight for killing a crime lord, Batman decides to fight against him.', 'https://www.youtube.com/watch?v=imtYrQEZ4H8', 0),
(130, 'zzzzz', 'https://welfareadmin.000webhostapp.com/apps/admin/uploads/664748e031e76_MV5BZjM5ODBkYTUtNjAwMy00MmY5LWEyZjEtMDg0Y2NlZjQyMzQ1XkEyXkFqcGdeQXVyMTQ3Mzk2MDg4._V1_.jpg', 'zz', '5', 'zzzzzzzz', NULL, 0),
(131, 'Captain Marvel', 'https://image.tmdb.org/t/p/w500/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg', 'Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Jude Law, Annette Bening, Djimon Hounsou, Lee Pace, Lashana Lynch, Gemma Chan, Clark Gregg, Rune Temte, Algenis Perez Soto, Mckenna Grace, Akira Akbar, Matthew Maher, Chuku Modu, Vik Sahay, Colin Ford, Kenneth Mitchell, Stephen A. Chang, Pete Ploszek, Matthew \'Spider\' Kimmel, Stephen \'Cajun\' Del Bagno, London Fuller, Azari Akbar, Mark Daugherty, Diana Toshiko, Barry Curtis, Emily Ozrey, Abigaille Ozrey, Marilyn Brett, Stan Lee, Robert Kazinsky, Nelson Franklin, Patrick Brennan, Patrick Gallagher, Ana Ayora, Lyonetta Flowers, Rufus Flowers, Sharon Blynn, Auden L. Ophuls, Harriet L. Ophuls, Matthew Bellows, Richard Zeringue, Duane Henry, Chris Evans, Scarlett Johansson, Don Cheadle, Mark Ruffalo, Kelly Sue DeConnick, Vinny O\'Brien, Joey Courteau, Anthony Molinari', '6.8', 'The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races. Set in the 1990s, Captain Marvel is an all-new adventure from a previously unseen period in the history of the Marvel Cinematic Universe.', 'https://www.youtube.com/watch?v=GX33bIOA5aA', 0),
(132, 'Spider-Man: No Way Home', 'https://image.tmdb.org/t/p/w500/5weKu49pzJCt06OPpjvT80efnQj.jpg', 'Tom Holland, Zendaya, Benedict Cumberbatch, Jacob Batalon, Jon Favreau, Jamie Foxx, Willem Dafoe, Alfred Molina, Benedict Wong, Tony Revolori, Marisa Tomei, Andrew Garfield, Tobey Maguire, Angourie Rice, Arian Moayed, Paula Newsome, Hannibal Buress, Martin Starr, J.B. Smoove, J.K. Simmons, Rhys Ifans, Charlie Cox, Thomas Haden Church, Haroon Khan, Emily Fong, Mary Rivera, Rudy Eisenzopf, Kathleen Cardoso, Jonathan Sam, Andrew Dunlap, Zany Dunlap, B. Clutch Dunlap, Minnah Dunlap, Ben VanderMey, Gary Weeks, Gregory Konow, Carol Anne Dines, Anisa Nyell Johnson, Willie Burton, Mallory Hoff, Greg Clarkson, Regina Ting Chen, Robert Mitchel Owenby, Glenn Keogh, Paris Benjamin, Jwaundace Candece, Taylor St. Clair, Rolando Fernandez, Gabriella Cila, Darnell Appling, Edward Force, Michael Le, Dean Meminger, Frederick A. Brown, Cristo Fernández, Clay Savage, Tom Hardy, Jake Gyllenhaal, Jay Karales, Gina Aponte, John Barnes, Harry Holland, John M. Maiers', '7.967', 'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.', 'https://www.youtube.com/watch?v=1mTjfMFyPi8', 0),
(133, 'Batman v Superman: Dawn of Justice', 'https://image.tmdb.org/t/p/w500/5UsK3grJvtQrtzEgqNlDljJW96w.jpg', 'Ben Affleck, Henry Cavill, Jesse Eisenberg, Gal Gadot, Amy Adams, Diane Lane, Jeremy Irons, Holly Hunter, Laurence Fishburne, Callan Mulvey, Scoot McNairy, Tao Okamoto, Jena Malone, Lauren Cohan, Brandon Spink, Hugh Maguire, Michael Cassidy, Alan D. Purwin, Dan Amboyer, Rebecca Buller, Harry Lennix, Christina Wren, Jade Chynoweth, Chad Krowchuk, Kevin Costner, Ezra Miller, Charlie Rose, Vikram Gandhi, Andrew Sullivan, Neil deGrasse Tyson, Jon Stewart, Soledad O\'Brien, Erika R. Erickson, Dana Bash, Nancy Grace, Anderson Cooper, Brooke Baldwin, Jason Momoa, Joe Morton, Ray Fisher, Joseph Cranford, Emily Peterson, Patrick Wilson, Carla Gugino, Sammi Rotibi, Hanna Dworkin, Tiffany L. Addison, Owais Ahmed, Anish Jethmalani, Tiffany Bedwell, Natalee Arteaga, Keith D. Gallagher, Jeff Dumas, Miriam Lee, Alicia Regan, Stephanie Koenig, Ripley Sobo, Richard Burden, Julius Tennon, Wunmi Mosaku, Dennis North, Kiff VandenHeuvel, Mason Heidger, Ahney Her, Kristine Cabanban, Sebastian Sozzi, Kent Shocknek, Ralph Lister, Sammy A. Publes, Jay R. Adams, David Midura, Jay Towers, Michael Ellison, Kirill Ostapenko, Rashontae Wawrzyniak, Tom Luginbill, Dave Pasch, Danny Mooney, Henry Frost III, Nicole Forester, Debbie Stabenow, Milica Govich, John Lepard, Sandra Love Aldridge, Graham W.J. Beal, Henri Franklin, Jonathan Leigh West, T.J. Martinelli, Chris Newman, Lulu Dahl, Sam Logan Khaleghi, Anne Marie Damman, Connie Craig, Henrietta Hermelin, Patrick Leahy, Albert Valladares, David Paris, Abigail Kuklis, Greg Violand, Tiren Jhames, Steve Jasgur, Jonathan Stanley, Jesse Nagy, Duvale Murchison, Thomas J. Fentress, Coburn Goss, Jeff Hanlin, Gary A. Hecker, Robin Atkin Downes, Brandon Bautista, Carmen Gangale, Mark Edward Taylor, Michael Shannon, Matahi Drollet, Mormon Maitui, Taraina Sanford, Jean Ho, Julia Glander, Cleve McTier, Bevin Kowal, Carmen Ayala, Josh Carrizales, James Quesada, Aida Munoz, David Dailey Green, Madison Autumn Mies, Thomas M. Taylor, Thom Kikot, John Seibert, Liam Matthews, Zachary Schafer, Monrico Ward, Ryan D\'Silva, Tom Whalen, Jeffrey Dean Morgan, Richard Cetrone, Marcus Goddard, Joe Fishel, Jalene Mack, Patrick O\'Connor Cronin, Isabella Gielniak', '5.967', 'Fearing the actions of a god-like Super Hero left unchecked, Gotham City’s own formidable, forceful vigilante takes on Metropolis’s most revered, modern-day savior, while the world wrestles with what sort of hero it really needs. And with Batman and Superman at war with one another, a new threat quickly arises, putting mankind in greater danger than it’s ever known before.', 'https://www.youtube.com/watch?v=s9EkdAHqtvU', 0),
(134, 'Spider-Man: No Way Home', 'https://image.tmdb.org/t/p/w500/5weKu49pzJCt06OPpjvT80efnQj.jpg', 'Tom Holland, Zendaya, Benedict Cumberbatch, Jacob Batalon, Jon Favreau, Jamie Foxx, Willem Dafoe, Alfred Molina, Benedict Wong, Tony Revolori, Marisa Tomei, Andrew Garfield, Tobey Maguire, Angourie Rice, Arian Moayed, Paula Newsome, Hannibal Buress, Martin Starr, J.B. Smoove, J.K. Simmons, Rhys Ifans, Charlie Cox, Thomas Haden Church, Haroon Khan, Emily Fong, Mary Rivera, Rudy Eisenzopf, Kathleen Cardoso, Jonathan Sam, Andrew Dunlap, Zany Dunlap, B. Clutch Dunlap, Minnah Dunlap, Ben VanderMey, Gary Weeks, Gregory Konow, Carol Anne Dines, Anisa Nyell Johnson, Willie Burton, Mallory Hoff, Greg Clarkson, Regina Ting Chen, Robert Mitchel Owenby, Glenn Keogh, Paris Benjamin, Jwaundace Candece, Taylor St. Clair, Rolando Fernandez, Gabriella Cila, Darnell Appling, Edward Force, Michael Le, Dean Meminger, Frederick A. Brown, Cristo Fernández, Clay Savage, Tom Hardy, Jake Gyllenhaal, Jay Karales, Gina Aponte, John Barnes, Harry Holland, John M. Maiers', '7.967', 'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.', 'https://www.youtube.com/watch?v=1mTjfMFyPi8', 0);

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `S_ID` int(11) NOT NULL,
  `M_ID` int(11) NOT NULL,
  `SHOW_TIME` time NOT NULL,
  `DATE` date NOT NULL,
  `STATUS` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`S_ID`, `M_ID`, `SHOW_TIME`, `DATE`, `STATUS`) VALUES
(96, 120, '18:00:00', '2024-04-27', 0),
(97, 120, '21:00:00', '2024-04-28', 0),
(98, 121, '18:10:00', '2024-04-25', 0),
(99, 123, '12:00:00', '2024-04-30', 0),
(100, 123, '15:00:00', '2024-04-30', 0),
(101, 123, '18:00:00', '2024-04-30', 0),
(102, 124, '12:00:00', '2024-05-04', 0),
(103, 124, '15:00:00', '2024-05-09', 0),
(104, 125, '15:00:00', '2024-05-17', 2),
(105, 125, '15:00:00', '2024-05-17', 1),
(106, 126, '12:00:00', '2024-05-17', 2),
(107, 126, '18:00:00', '2024-05-31', 2),
(108, 126, '21:00:00', '2024-05-24', 2),
(109, 126, '21:00:00', '2024-05-31', 2),
(110, 127, '18:00:00', '2024-05-16', 2),
(111, 128, '15:00:00', '2024-05-16', 0),
(112, 129, '18:00:00', '2024-05-18', 0),
(113, 130, '21:00:00', '2024-05-18', 0),
(114, 132, '12:00:00', '2024-05-20', 0),
(115, 132, '12:00:00', '2024-05-24', 0),
(116, 132, '15:00:00', '2024-05-24', 0),
(117, 132, '18:00:00', '2024-05-24', 0),
(118, 129, '15:00:00', '2024-05-18', 0),
(119, 129, '21:00:00', '2024-05-18', 0),
(120, 129, '12:00:00', '2024-05-21', 0),
(121, 129, '18:00:00', '2024-05-21', 0),
(122, 133, '15:00:00', '2024-06-09', 0),
(123, 133, '21:00:00', '2024-06-27', 0),
(124, 133, '12:00:00', '2024-06-25', 0),
(125, 133, '15:00:00', '2024-06-25', 0),
(126, 133, '18:00:00', '2024-06-25', 0),
(127, 133, '21:00:00', '2024-06-25', 0),
(128, 134, '12:00:00', '2024-06-07', 0),
(129, 134, '15:00:00', '2024-06-07', 0),
(130, 134, '18:00:00', '2024-06-07', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `U_ID` int(11) NOT NULL,
  `RANK` varchar(100) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `NAVY_NO` varchar(50) NOT NULL,
  `UNIT` varchar(50) NOT NULL,
  `MOB_NO` varchar(20) NOT NULL,
  `PASSWORD` varchar(30) NOT NULL,
  `STATUS` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`U_ID`, `RANK`, `NAME`, `NAVY_NO`, `UNIT`, `MOB_NO`, `PASSWORD`, `STATUS`) VALUES
(1, 'navy', 'name 1', '111', 'u1', '9876543210', '1234', 1),
(84, 'Army:Major', 'nane', 'nno', 'unit', '9876543211', '1234', 1),
(89, 'Army:Brigadier', 'name1', 'no', 'unit', '963', '963', 2),
(90, 'Army:Brigadier', 'name', 'number', 'unit', '987654987', '000', 2),
(91, 'Air Force:Flight Lieutenant', 't', 't', 't', '1234567890', '1234', 2),
(92, 'Others:Others', 'Kiran', '123', '21', '123456789', 'qweasd', 2),
(93, 'Army:Major', 'R Rajesh', '38184N', '50 AD', '9847670036', '1234', 2),
(94, 'Navy:Chief Petty Officer', 'Murugan', '145278B', 'v\'thy', '9645121050', '1234', 2),
(95, 'Navy:Petty Officer', 'SUSANT KUMAR JENA ', '221016K', 'INS VENDURUTHY ', '8667676874', 'Sagarika@221016', 2),
(96, 'Army:Brigadier', 'name', 'navy no', 'unit', '8888888888', '1111', 2),
(97, 'Army:Colonel', 'nana', 'bsbs', 'sbsb', '4444444444', '1234', 2),
(98, 'Air Force:Flight Lieutenant', 'sus', 'hshs', 'shsh', '0000000000', '1111', 2),
(99, 'Air Force:Flight Lieutenant', 'sus', 'hshs', 'shsh', '0000000001', '1111', 2),
(100, 'Air Force:Flight Lieutenant', 't', 'bdbd', 'heu', '3333333333', '0000', 2),
(101, 'Navy:Sub Commander', 'ggggggggg', 'tyt', 'tyg', '9999999993', '0000', 2),
(102, 'Air Force:Leading Aircraftsman', 'yaha', 'haha', 'ahah', '1111111112', '0000', 2),
(103, 'Navy:Lieutenant', 'ttt', 'fgg', 'ftg', '6666666666', '0000', 2),
(104, 'Navy:Lieutenant', 'ttt', 'fgg', 'ftg', '6666666669', '0000', 2),
(105, 'Navy:Lieutenant', 'ttt', 'fgg', 'ftg', '6666666668', '0000', 2),
(106, 'Air Force:Flight Lieutenant', 'bab', 'bsbs', 'nen', '9999999990', '0000', 2),
(107, 'Air Force:Squadron Leader', 'name', 'nssbns', 'ndnen', '1111111110', '0000', 2),
(108, 'Navy:Lieutenant', 'ejej', 'nsbs', 'ndsn', '5959999999', '0000', 2),
(109, 'Navy:Master Chief Petty Officer (Second Class)', 'ananNanznznznznznznznznznznznznznznznzznznnxn', 'sjsjsjsjzjjzjjsjsj', 'hshs', '9898989898', '0000', 2),
(110, 'Navy:Master Chief Petty Officer (Second Class)', 'aaaaaaaaabbb bbb bbb bbb bbb b', 'nsbssnsnsns', 'ndsb', '7777777777', '0000', 2),
(111, 'Navy:Master Chief Petty Officer (Second Class)', 'aaaaaaaaaaaa aaaaaaaaaaa', 'nssb', 'znsn', '1111111114', '0000', 2),
(112, 'Navy:Master Chief Petty Officer (Second Class)', 'nnnnnn nnnnnn nnnnnn nnn', 'heh', 'shsh', '3333333330', '0000', 2),
(113, 'Navy:Master Chief Petty Officer (Second Class)', 'Mr.ramachandran pallikutti pettanpara kottathil', '12345', 'serpant', '9630852741', '9999', 2),
(114, 'Others:Others', 'fsgsb', 'hshs', 'hshsh', '0852369874', 'asdzxc', 2),
(115, 'Others:Others', 'hshsh', 'hsha', 'bsbsb', '0852369741', 'asd', 2),
(116, 'Others:Others', 'hshsh', 'jsnsj', 'jsns', '1236547890', 'aaaaaaaaaa', 2),
(117, 'Navy:Master Chief Petty Officer (Second Class)', 'qwertyuiopasdfghhjklzxcvbnm', 'navyno', 'unit', '1112223334', '0000', 2),
(118, 'Air Force:Flight Lieutenant', 'u', 'hehe', 'heh', '6552353535', '000', 2),
(119, 'Air Force:Flying Officer', 'name', 'navy no', 'unit', '0123456789', '0000', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`B_ID`),
  ADD UNIQUE KEY `unique_seat_per_schedule` (`S_ID`,`SEAT_NO`),
  ADD KEY `U_ID` (`U_ID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`F_ID`),
  ADD KEY `U_ID` (`U_ID`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`M_ID`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`S_ID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`U_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `B_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=427;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `F_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `M_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `S_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `U_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `user` (`U_ID`),
  ADD CONSTRAINT `fk_booking_schedules` FOREIGN KEY (`S_ID`) REFERENCES `schedules` (`S_ID`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `user` (`U_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
