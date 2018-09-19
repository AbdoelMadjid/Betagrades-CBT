-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 26, 2017 at 05:55 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cbt`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentName` (IN `e_no` VARCHAR(15))  NO SQL
SELECT CONCAT(surname ,' ',other_name) AS name FROM `students` WHERE exam_no = e_no$$

CREATE DEFINER=`onigbenga1`@`localhost` PROCEDURE `Get_Student_Result` (IN `c_id` INT(10), IN `s_id` INT(11), OUT `sc` INT(10))  NO SQL
BEGIN

DECLARE the_sc INT(10);

SELECT IFNULL(count(*), 0) AS score INTO the_sc FROM `student_answers` WHERE student_id= s_id AND course_id = c_id AND answer_selected = answer_true;

INSERT INTO student_results (course_id, student_id, score) VALUES (c_id, s_id, the_sc);

SELECT score INTO sc FROM student_results WHERE student_id=s_id AND course_id = c_id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(4) NOT NULL,
  `type` enum('admin','lecturer','manager') NOT NULL DEFAULT 'lecturer',
  `pass` varchar(255) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `type`, `pass`, `username`, `first_name`, `last_name`) VALUES
(14, 'lecturer', 'da9434edd3bf644cf6a556510aeb9bd36985e631', 'mavitech', 'Oni', 'Gbenga'),
(17, 'lecturer', 'c01671274729f18cd956827c7caaf0d007bdedbc', 'examhead', 'Kayode', 'Ogungbemi'),
(94, 'lecturer', 'e7dd983cffe420cba4af06e8c2cdcd873bd5429f', 'Aborisade', 'Matthew', 'Peter'),
(104, 'manager', '58aa1bf93f32f75835874ab2f60059a8a4279d2e', 'schoolmanager', 'liyuci', 'mavitech'),
(107, 'admin', '5cac39bc4e50235b15e973b14bea2346befeb235', 'schooladmin', 'Oladoyin', 'Ige'),
(108, 'lecturer', '25bd026d34880ab170fe26b3ca11ab5201104184', 'theteacher', 'olawale', 'oguns');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(4) NOT NULL,
  `title` varchar(50) NOT NULL,
  `status` enum('online','offline') DEFAULT 'online',
  `questions_to_answer` mediumint(9) DEFAULT NULL,
  `allocated_time` smallint(4) NOT NULL DEFAULT '30',
  `lecturer_id` int(4) NOT NULL,
  `class` enum('JS1','JS2','JS3','SS1','SS2','SS3','none') DEFAULT 'none',
  `term` enum('1ST','2ND','3RD','None') DEFAULT 'None'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `title`, `status`, `questions_to_answer`, `allocated_time`, `lecturer_id`, `class`, `term`) VALUES
(69, 'ENGLISH PASSAGES', 'online', 30, 35, 14, 'SS3', '2ND'),
(116, 'CURRENT AFFAIRS', 'online', 8, 80, 14, 'SS3', '3RD'),
(122, 'CHEMISTRY', 'online', NULL, 5, 14, 'SS3', '3RD'),
(125, 'AGRIC SCIENCE', 'online', 2, 3, 24, 'none', '3RD'),
(10004, 'GEOGRAPHY', 'online', NULL, 5, 25, 'SS2', '2ND'),
(10011, 'MATHEMATICS', 'online', NULL, 8, 17, 'JS1', '2ND'),
(10013, 'Maths', 'online', NULL, 9, 36, 'SS3', '2ND'),
(10018, 'Maths', 'online', NULL, 7, 36, 'SS1', '2ND'),
(10019, 'Maths', 'online', NULL, 30, 17, 'JS3', '3RD'),
(10021, 'COMPUTER', 'online', NULL, 1, 60, 'JS3', '2ND'),
(10049, 'COMPUTER', 'online', NULL, 5, 82, 'SS3', '3RD'),
(10050, 'BIOLOGY', 'offline', NULL, 30, 98, 'SS1', '2ND'),
(10059, 'tkbrw', 'online', NULL, 30, 100, 'JS2', '1ST'),
(10062, 'MUSIC', 'online', 2, 5, 108, 'JS3', '2ND');

-- --------------------------------------------------------

--
-- Table structure for table `instructions`
--

CREATE TABLE `instructions` (
  `id` int(4) NOT NULL,
  `instruction` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `instructions`
--

INSERT INTO `instructions` (`id`, `instruction`) VALUES
(1, 'Do not skip this question'),
(2, 'Choose the option opposite in meaning to the word(s) or phrase in italics.'),
(3, 'Choose the option opposite in meaning to the word(s) or phrase in italics.'),
(4, 'Choose the option opposite in meaning to the word(s) or phrase in italics.'),
(5, 'Choose the option NEAREST in meaning to the word(s) or phrase in italics.'),
(6, 'No instruction man, fuck shit up!'),
(7, ''),
(8, ''),
(9, 'Answer all questions '),
(10, 'This question has an image. Please view before proceeding to answer'),
(11, 'This question has an image. Please view before proceeding to answer'),
(12, ''),
(13, ''),
(14, 'This question has no image. '),
(15, ''),
(16, ''),
(17, 'This question has an image attachment.'),
(18, ''),
(19, ''),
(20, ''),
(21, ''),
(22, 'ljobuipq3b'),
(23, ''),
(24, ''),
(25, ''),
(26, ''),
(27, 'grytuituoyipu'),
(28, ''),
(29, 'Choose the option NEAREST in meaning to the word(s) or phrase in italics.'),
(30, 'Choose the option OPPOSITE in meaning to the word(s) or phrase in italics.'),
(31, 'Choose the option that is the PAST TENSE of the word(s) or phrase in italics.'),
(32, ''),
(33, ''),
(34, ''),
(35, 'This question has an image attachment.'),
(36, 'This question has an image attachment. second'),
(37, 'No image attachment'),
(38, 'random'),
(39, 'No instruction man, fuck shit up!'),
(40, 'No instruction man, fuck shit up!'),
(41, 'No instruction man, fuck shit up!'),
(42, 'No instruction man, fuck shit up!'),
(43, 'No instruction man, fuck shit up!'),
(44, 'No instruction man, fuck shit up!'),
(45, 'No instruction man, fuck shit up!'),
(46, 'Read the following passage and answer question'),
(47, 'Read the following passage and answer question'),
(48, 'Read the following passage and answer question'),
(49, 'Read the following passage and answer question'),
(50, 'Read the following passage and answer question'),
(51, ''),
(52, 'Read the following passage and answer question'),
(53, 'Read the following passage and answer question'),
(54, 'Read the following passage and answer question'),
(55, 'Read the following passage and answer question'),
(56, 'Question instruction'),
(57, 'Read the following passage and answer question'),
(58, 'Read the following passage and answer question'),
(59, 'Read the following passage and answer question'),
(60, 'Read the following passage and carefully answer question'),
(61, 'huyxuyiuc'),
(62, 'woui bjlk'),
(63, 'kjuyjxkclvl'),
(64, 'l.cktxyrtudlyik'),
(65, 'kytjhd'),
(66, ''),
(67, 'No instructions man, fuck shit up!'),
(68, 'Read each passage carefully and answer the questions that follow. '),
(69, 'Read each passage carefully and answer the questions that follow.'),
(70, 'Read each passage carefully and answer the questions that follow. '),
(71, 'hkjlbskveg'),
(72, 'Read the passage carefully and answer the questions that follow it.'),
(73, 'In questions below, choose the option nearest in meaning to the word(s) or phrase underlined'),
(74, 'No instruction'),
(75, ''),
(76, ''),
(77, ''),
(78, ''),
(79, ''),
(80, ''),
(81, ''),
(82, ''),
(83, ''),
(84, 'dsjknf sjfks skfknf lajndk'),
(85, ''),
(86, 'New Instruction added'),
(87, ''),
(88, ''),
(89, ''),
(90, ''),
(91, ''),
(92, ''),
(93, ''),
(94, ''),
(95, ''),
(96, ''),
(97, 'good'),
(98, 'wrkhv'),
(99, ''),
(100, ''),
(101, 'inst'),
(102, ''),
(103, ''),
(104, ''),
(105, ''),
(106, 'lhjkjl'),
(107, 'ciyoulvk'),
(108, 'tuxruilj'),
(109, 'kudg'),
(110, 'latest instruction update'),
(111, 'new'),
(112, 'qoi;l'),
(113, 'fhgjchkvjlb'),
(114, ''),
(115, ''),
(116, ''),
(117, 'ht'),
(118, 'vukj,nvw jwbv '),
(119, '24ou ty'),
(120, 'read the passage before answering updated'),
(121, ''),
(122, 'pbnke'),
(123, 'There is an image attached to this question'),
(124, ''),
(125, 'attachment'),
(126, 'nn'),
(127, ''),
(128, 'nope!!'),
(129, ''),
(130, ''),
(131, ''),
(132, 'New Instruction added'),
(133, 'Answer only the underline'),
(134, ''),
(135, 'YMCMB'),
(136, ''),
(137, 'Neew'),
(138, 'third instruction'),
(139, 'take pie = 0.14300'),
(140, ''),
(141, ''),
(142, ''),
(143, ''),
(144, ''),
(145, ''),
(146, ''),
(147, ''),
(148, ''),
(149, ''),
(150, ''),
(151, 'new question. answer all'),
(152, 'ett'),
(153, 'r3g23y'),
(154, 'bkjlb'),
(155, 'eukrilto;ti'),
(156, '7i486kue'),
(157, 'gtr'),
(158, 'Answer all questions'),
(159, 'oovjlbk'),
(160, 'No instruction for this question.'),
(161, ''),
(162, 'good'),
(163, 'khjgkclkj'),
(164, ''),
(165, 'ndggg'),
(166, ''),
(167, 'cukgj,hvlj'),
(168, 'ilyfelbjivr'),
(169, ''),
(170, 'old Instruction'),
(171, 'nothing'),
(172, 'no instruction, lads.'),
(173, ''),
(174, 'Read the following and answer question'),
(175, 'In questions below, choose the word(s) or phrase which best fills the gap(s)'),
(176, 'In questions below, choose the word(s) or phrase which best fills the gap(s)'),
(177, 'In questions below, choose the word(s) or phrase which best fills the gap(s)'),
(178, 'In questions below, choose the word(s) or phrase which best fills the gap(s)'),
(179, 'In questions below, choose the word(s) or phrase which best fills the gap(s)'),
(180, 'In questions below, choose the option nearest in meaning to the word(s) or phrase underlined'),
(181, 'In questions below, choose the option nearest in meaning to the word(s) or phrase underlined'),
(182, 'In questions below, choose the option nearest in meaning to the word(s) or phrase underlined'),
(183, 'In questions below, choose the option nearest in meaning to the word(s) or phrase underlined'),
(184, 'In questions below, choose the option nearest in meaning to the word(s) or phrase underlined'),
(185, 'Choose the option that has the same vowel sound as the one represented by the letters underlined.'),
(186, 'Choose the option that has the same vowel sound as the one represented by the letters underlined.'),
(187, 'Choose the option that has the same vowel sound as the one represented by the letters underlined.'),
(188, 'Select the word that has the same pattern of stress as the given word'),
(189, 'Select the word that has the same pattern of stress as the given word'),
(190, 'Choose the option nearest in meaning to the word(s) or phrase in italics'),
(191, 'Choose the option nearest in meaning to the word(s) or phrase in italics'),
(192, 'Choose the option nearest in meaning to the word(s) or phrase in italics'),
(193, 'this is a new question'),
(194, 'Read the following passage and answer question'),
(195, 'Read the following passage and answer question'),
(196, 'Question instruction'),
(197, 'Question instruction'),
(198, ''),
(199, 'qewret'),
(200, 'ethreyjtrhg');

-- --------------------------------------------------------

--
-- Table structure for table `passage`
--

CREATE TABLE `passage` (
  `id` int(4) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `lecturer_id` int(4) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `course_id` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `passage`
--

INSERT INTO `passage` (`id`, `title`, `content`, `lecturer_id`, `date_created`, `course_id`) VALUES
(1, 'THE SCHOOL BOY', ' <p>Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum... Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...Lorem ipsum...</p>\r\n', 14, '2017-03-25 17:49:28', NULL),
(2, 'NEW PASSAGE ', '<p>NEW PASSage is about blah blah blah ....</p>\r\n<ul>\r\n<li>list one&nbsp;</li>\r\n<li>hrns</li>\r\n</ul>\r\n<p>abef</p>', 14, '2017-03-25 20:37:05', 67),
(3, 'FIRST AMMENDMENT', '<p>In America, the first amendment to the Bill of Rights states, &ldquo;Congress shall make no law.... abridging the freedom of speech.....&rdquo; This amendment was passed to protect our right to express our opinions without fear. &nbsp;Yet, we must stop using the first amendment as a justification to say whatever we want, whenever we want. &nbsp;No speech is &ldquo;free&rdquo; when it has detrimental effect on the well-being of the others, the protection of our privacy, the safety of our borders, or the quality of our thinking.&nbsp;</p>\r\n<p>While censorship is not the way of this land, we must take into account the effect of musical lyrics that influence young listeners. &nbsp;How often do we find ourselves singing a tune or repeating a phrase from a song instinctively, without stopping to ponder the meaning of the words? When these words are demeaning to any group of people or when they incite violence, we are unknowingly repeating phrases of hate. &nbsp;How long does it take until those phrases become worn into our patterns of thought and we find ourselves believing the words we mindlessly hummed?</p>', 14, '2017-03-25 21:34:14', 69),
(5, ' THE GAME OF LUDO', '<p>Those who are familiar with it will tell you that Ludo, like human life itself, is a game both of chance and skill. You need skill in deciding how to make the most advantageous use of the figures, which turn up on the die when you cast it. Since each player has at least four alternative ways of using his figures, two players with equal luck may fare differently, depending on how cleverly each one uses his figures. The element of luck, again as in human life, plays a dominant role however. For no matter how skilful a player may be in using the figure he gets on the die, he has a slim chance of winning if he continually throws low figures. While a combination of ones and twos may be useful in checking the advance of one''s opponents, it will not take one home fast enough to win. On the other hand, consistent throws of sixes and fives, with even the very minimum of skill will help a player to home all his four counters before any of the three other players, unless, of course, he has no idea of the game at all.</p>', 14, '2017-03-27 20:56:36', 69),
(6, 'COLDS', '<p>You would think that the common cold should be easy enough to study, but it is not so easy as it looks. Colds often seem to spread from one person to another, so it is often assumed that the cold must be infectious, but there are some puzzling observations which do not fit in with this theory. An investigator in Holland examined some eight thousand volunteers from different areas, and came to the conclusion that in each group the colds appeared at the same time. Transfer of infection from case to case could not account for that. Yet at the Common Cold Research Unit in Salisbury the infection theory has been tested out; two series of about two hundred people each were inoculated, one with salt water and the other with secretions from known cold victims. Only one of the salt-water group got a cold, compared with seventythree in the other group. <br />In the British Medical Journal the other day, there was a report of a meeting ''The Common Cold-Fact and Fancy'', at which one of the speakers reported a study of cold made in Cirencester over the last five years. Three hundred and fifty volunteers had kept diary records of their colds and on an average each had seven every year, with an annual morbidity of seven days. So nearly one-fifth of our lives is spent in more or less misery, coughing and sneezing. Some widely held beliefs about the common cold have turned out not to be true. It seems that old people are just as liable to colds as the young. Sailors in isolated weather ship have just as many colds while on board and not in contact with colds as the young. Sailors in isolated weather ships have just as many colds while on board and not in contact with the outside world as when on shore. It is truism that common illnesses pose more problems than the rare. The rare disease is by comparison much easier to handle. There are not so many cases and all of them have been intensively studied. Someone has read up all the literature about the disease and published a digest of it. There will be more facts and fewer fancies.</p>', 14, '2017-03-29 19:58:53', 69),
(7, 'RANDOM PASSAGE', '<p>This is a random passage.</p>\r\n<p>&nbsp;</p>', 14, '2017-03-31 16:09:34', 69),
(8, 'NEW PASSAGES', '<p>This is a new passage</p>', 17, '2017-04-03 16:53:37', 10003),
(9, 'PYTHAGORAS THEOREM', '<p>ruitduylij;okn;lmmnb&nbsp; uyri7do86fp9uogi lgfytcukhvlkj kfyxtucyli;kjv,m 6si7oyiub</p>\r\n<p>rueryjkjfgb kgjhkjlkhnbvctuyi ti7dyoifujk dtri7do8iulkjiui iuoiphvri7o8poib7d6b 659768 yt</p>\r\n<p>ewtreytrytukjlk,iopo[l 8798pbhj dturi7879[0po iy760879</p>', 17, '2017-04-03 22:20:51', 10011),
(10, 'THE VILLAGE BOY', '<p>gjus&nbsp;</p><p>wjfkfhf jufklkkn</p>', 36, '2017-04-04 16:37:30', 10018),
(11, 'SHETTIMAH''s TRIUMPH', '<p>Shettimah was a noble man if nicaragua village. He had two sons who he loved dearly.....</p>', 14, '2017-05-09 10:04:29', 69),
(12, 'NEWEST PASSAGE', 'iuvilukjjh dclh kjfbio;le', 14, '2017-07-12 15:05:59', 69),
(13, 'pass', 'iir6i7oc8pvu[bipnol''', 108, '2017-07-23 13:47:35', 10062),
(14, '.khukclvijk.k', 'uiblkjlbl;lknlk', 108, '2017-07-23 14:14:43', 10062),
(15, '', '<table style="width: 100%;"><thead><tr><th>The boy</th><th><br></th><th><br></th><th><br></th><th><br></th></tr></thead><tbody><tr><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td></tr><tr><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td></tr><tr><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td></tr></tbody></table>', 14, '2017-08-16 22:00:39', 69),
(16, '', '<table style="width: 100%;"><thead><tr><th>The boy</th><th><br></th><th><br></th><th><br></th><th><br></th></tr></thead><tbody><tr><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td></tr><tr><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td></tr><tr><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td><td style="width: 20.0000%;"><br></td></tr></tbody></table>', 14, '2017-08-16 22:00:40', 69),
(17, 'nt3', '<p>lutcyjgkjkj</p><p>utxjgckhvlkjl</p>', 14, '2017-08-17 12:42:56', 69),
(18, 'hgjkjvmn', '<p>utrxjcghkvj</p>', 14, '2017-08-17 12:43:43', 69),
(19, 'hgjkjvmn', '<p>utrxjcghkvj</p>', 14, '2017-08-17 12:43:43', 69),
(20, 'she', '<p>It was part of her nefarious plot! Of that I had no doubt. She would slowly deprive me of my delicious slumber until finally, exhausted, I gave in to her wretched demands. She would claw her ways into my dreams, she could growl and complain, but no, I would not give in. I pulled the covers close over my head and rolled over. I was the stronger of we two. I was the determined one. I was the human, and she the beast. She must have understood my determination, for mercifully, the whining stopped. My breathing grew deeper and I returned to my wonderful sleep. Until moments later a crash awakened me. I bolted out of bed and there she was, in the kitchen guiltily lappily kitty treats off the floor. The mischievous beast had jumped onto the counter top and knocked the bag of food onto the floor. &ldquo;Bad kitty!&rdquo; I scolded, pushing her away from the mess of chow. But the sweet face, that little sandpaper tongue licking her chops somehow softened me.</p>', 14, '2017-08-24 08:49:18', 69);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint(100) NOT NULL,
  `course_id` int(4) DEFAULT NULL,
  `question` text NOT NULL,
  `option1` text NOT NULL,
  `option2` text NOT NULL,
  `option3` text NOT NULL,
  `option4` text NOT NULL,
  `answer_true` text NOT NULL,
  `image_name` varchar(60) DEFAULT NULL,
  `instruction_id` int(4) DEFAULT NULL,
  `passage_id` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `course_id`, `question`, `option1`, `option2`, `option3`, `option4`, `answer_true`, `image_name`, `instruction_id`, `passage_id`) VALUES
(10164, 69, 'fKh3OnkiriI90YHiUV445P36FxeWVFQOXZJDKhHApeOLguNrOxQNTfLDV1O17c0e3ga/eB4oI/nWmAg24xqh4JP9dQQcTqHaxHiV7i0j2SxfSNvhFcA2LHrPOJTEAr+N+ueoFXH/4c8KHascVm+Hzu9o0Qhz07iAPo6OEVGBdHBlDet3pnT1zBhQ5hTJMeVgk7HH3r1lcdd0ryb8tiMrd2+3JiW9rDmkiHTvZKpSHEnrB7d1B8GTuPzvtkoJP89W', '5qHb1MYPVpAvci3lpnKnPPa/jufIY0BN7QaUtsWFNcTuR/DSa83RLIzvaGFXfqKqvZD02qISeaEUwpK/kJX2nQ==', 'NTmNe2RsJw06NjvXQDwURLUzleVqXefuFmET4/klPYWfuuI9/XvxJEYKE8Cb5Ps0', 'MPkfz/Rc3l8Bc7hI3Of28mG1UXwgjhooJiRpSE5YwG/j6JvQzNok5pyO57skVxWQuEqPUjpN7DkaFIxYE0aHRQ==', 'j+FhRqEJPqschlcLhQHzygN4pLhhEeNdBTVI1VqhgHKhtglscebgNFTkt3RzTaHl', 'MPkfz/Rc3l8Bc7hI3Of28mG1UXwgjhooJiRpSE5YwG/j6JvQzNok5pyO57skVxWQuEqPUjpN7DkaFIxYE0aHRQ==', '', 55, 3),
(10165, 69, 'wTgOkE318pEsJR9JJ60aXfMuW8nZy+j4S1ra85nrIMTepvPX12Vln5MC4m3xRHDHsxaNDGYrIUURZYDhW1IFIRXT0Bxw70QJbyVnSWnNHJo=', '4CVCYXQL7Uvb4mJq3pMmZ12g8XBabMD+gYnr2Ny5qiWq7CrFwKqkJJObFx6/O08+', 'YX44SXBQAT6UVNCpknAwMgi/mJ5AgA7WGyiufAnrytIYHMw9i79DXxE8lKw3ReOq', 'tQ8nAcIXPbwE8HuNQYNpHC/QIWMHXMvE8lVJSWnt3sj2io32xkbcwzGyWENSlF/2', 'xIZBaVahOxnbTx2eHXZvoISgakk6zgenKgYYQ5ygTBIwFF55BzL8V6kPPHf768iapib5bpRi0my8esA/q6n5xQ==', '4CVCYXQL7Uvb4mJq3pMmZ12g8XBabMD+gYnr2Ny5qiWq7CrFwKqkJJObFx6/O08+', '', 56, 3),
(10166, 69, 'tbWcsL2FJ1bcHBzmmyDFxyembNdm7QasCBxaFH7BjE1XUZ8boOa5/XTN8BpRwVmhi0toHHl4x8yb5PlKo7GmqBUmrf1P7Q9FxznQJtXhvM0=', 'pLoCqAJ5cg0XHe16a0+9Wmkag9J92lqX90hS8hsVJbPQPgZLFgtzlLrA0nPIDyOQ', 'OReT1QnPpiRwzaPb9rnUZS3wFOIuECw+j8QLli5YYuC41bTSzFp5p4fHALjufLnq', 'CDaok3N69o22RXAxWTxd5tA5a7FAdM0F5a/08mFkiOJtOxKnBkbI38ezx44k2NSt', 'Y4mGlVzTMqZNRCoAvYK1CwUWuieZzPZ1mmFbrBVupSM=', 'OReT1QnPpiRwzaPb9rnUZS3wFOIuECw+j8QLli5YYuC41bTSzFp5p4fHALjufLnq', '', 57, 3),
(10167, 69, 'khaBpSaWVfGbWX9EvUWKRET5GJmiivk48P4vSkJhpG1n0JN7SnM3MmfRtkYrF8G3XOGoh3eTzg2qxK2zBTUcfDZjv/MR9EoPiIMbyMRGcq0+jfBvdF9VeyEQv9c29bg1xk/jyNgNyf6jGnA0UGfyGQ==', 'Ip9gWvq+iZVXP6r1/glLI4wUhl1LQB3Btv9af68LWNbYXzoIpZxcmxYwXSUekzlS80gNY+dnFypdwDHS71zadCe9j/5+MprmbLzF+FCkBZk=', 'CwF+Ct+MQ9B3uEH8m278NtNT53nbWxiJuGZ1x0CZSocUJSPuof4cM/IhT0zzNvFVQGSEEdIJ0FZNtGqVjRnXgw==', 'wlNFR1374HtbZlM2hXomHV+FEjC6TlRGwo7WXvjdR8hlbJewiQjsXh3a4eO7q/jDtTilT1YCYEnGEMLR+A82iQ==', 'OoRzRtGZqgcMr/mNsa/ngNvy0UJNw+/7kssWrGm1oqDnqLRY5/D/5XZvtvQGmWFsdWn2VFNJvyfvGxM0t4UqLQ==', 'wlNFR1374HtbZlM2hXomHV+FEjC6TlRGwo7WXvjdR8hlbJewiQjsXh3a4eO7q/jDtTilT1YCYEnGEMLR+A82iQ==', '', 58, 3),
(10169, 69, 'pvl16fk6CfUwvPMIEmm+x6DytaAUczlf8iClGWaUD7frwKYVeKfaAmtYWTVgzmgc/GpS25xggrsz+x8LdBz6JWmElH4ivLAUoJV36DyeUTHcRzMptRqBMSl8FQpokQ/E5SyvotYQxgT3GwBOSCSOjtpeJ9xBqoKfCMwGtkEI7Xw=', 'TmhniqU9XgufFG1RBdMcBYQCIaPyd9WMeaPUaNZOOzU=', 'H+RyTrMw99QMHLTA75IxupykCQhX2TuIT7U+rZwdASI=', 'NoNUns5iPZnrox65Uy1/phZRXP8B4CuGN14xcqTbBFE=', '1jc5ijGglH/vysf52J5aoa73h2sHvFYq9OQbwHY8ZCI=', '1jc5ijGglH/vysf52J5aoa73h2sHvFYq9OQbwHY8ZCI=', '', 60, 3),
(10172, 69, 'OBeWIMynTULfPOXal5tHcyFmmAMzGe4HeKqymPM2y3r0VRi+uhRB8cdx2WXRFCr4Osaz3nmBFoqHc7x0pz6Fbo1jyNmLk6uMxJ/MSmfkJGfKK35EL2mTWMgaUTDilvqv', 'F35YF/nVLQ96zwQewDXDy6jdogdA+FjklnBd3UAZEfk=', 'EWZzBA/+Uu0JG5POKYMdL75qzKF1zfx9mbfFjOcV1jYbWpOy1gnjjt7IfeovGn9Vo/2FQYSOPyAd20HfbKLeOA==', 'dE7UIr3jIKdEPAxkMR+C4CsUqii8oSSWe8DPtUBTNnpNIy0V0ef+cW23yKIFDbb0', 'KtbpJVkqK7hmYKyjeEFZbiNood2XC1mNJjEMYBHdqxk=', 'EWZzBA/+Uu0JG5POKYMdL75qzKF1zfx9mbfFjOcV1jYbWpOy1gnjjt7IfeovGn9Vo/2FQYSOPyAd20HfbKLeOA==', '', 68, 5),
(10173, 69, 'xhhcYwYn6PphkETvH7p3adcvMbht9d18l1A3LbVqGt+UCaf5zIDXrUusMFREHatkfsx6c88NJot0E05A9qxl+TXlQjogXcp3raNnzpJv18cPYlJlRafu1d/GvpYj/GXS', '7i1YHbXkLBwZdVD4X0jK2qIdmEiWbdXkpqCupJLopb8=', 'UEQlazbRZ8/W1xmye8BCO7UIqqd/T8SB1s+x8WVo4Ko=', 'vLkoDl5yxb/65RMu2nkYguooOGHrwUt4S0sZ2QtBMEI=', '6nJqEW5WmlvMU1rET9Gwcg0Dz/S7WcqjPU7UR35X/i8=', '7i1YHbXkLBwZdVD4X0jK2qIdmEiWbdXkpqCupJLopb8=', '', 69, 5),
(10174, 69, 'cSYGWumy4ubtyH+AxM/iTxl6tRlVQ0onIMERIzq8bB3AMvIH6JDrSW7VsqyzE/hpbBas64gbc5Y7gXNBSKQOhaOUKAKYQy+A5o/Ga6Jwst006DzYjEzoL0nu7pnmnH0s', 'bxYihU3gdZ9XVCjn1NlChG/jDZFvf6ZG1PV6RlJalAJg+orXcCqZ5xRbPnp64sJ6', 'jVhLH8k5TN9RY8xtbD7U7y+DuTvJ4DTP3hoIRZ0EPkgw2L2B0ZOm0SYZRT5qUOeu', 'ietxRIkgljiVXfq58w2m8HaOePzko8w6lyA5+368JyeDD7NHldyR6Yvxrq/G328d', '47PsEf0qHPaDielKvDtgNDqOgsaoqlHnYOB/9kT1hCMuEQtG0B780WP7vPKWcLso', 'ietxRIkgljiVXfq58w2m8HaOePzko8w6lyA5+368JyeDD7NHldyR6Yvxrq/G328d', '', 70, 5),
(11436, 69, '7oSVXx/2fvRimW4AgFftKJw29wI5ztOy8yVU010z6m2rdSZSaaPQbo4OyNvQZpp/A+cGXGJOhg3YCqmqliBB6AQtwkAEt3lSGptg2sdgwtc6KFn/JG1CzVDfzJuX83lb', '0gwf/oTHOU8qFTt0itusF4QbzwhRitu3jrIwlf/1xhjDbt1RpKmko5DACpDA8al1', 'wuIZx/iyFwzh07zkRi+S+4RenUIDOj1c4qLq31ahXrsVMH5T2jIluQ+b9zO8liM6', 'zjKJ8AbLOm7RF3Lg9/u58VetjGphTlrzDTCeFo6yHf0=', 'biufdyKxbAGpKQDAzHnjXc1Yca5nOMhN6GEJ+hj1wMY=', 'zjKJ8AbLOm7RF3Lg9/u58VetjGphTlrzDTCeFo6yHf0=', '', 72, 6),
(11437, 69, '+Wu8nhWU2FOTfsuNPRIe9U2WGeSJ/zcJqEsvS1OPBBzzvayJRakXiXcgiN9XHaASCI2C7ejt7gK3Hg91d9tPCzv2ximpkgvniQHr24hxJq2ztgzZ17klazYGjo4fMZG/FtuwAi6KzaX03hXKv262SjlgrAf33Vr3r3QtZCajRnzIBqXS49Xq6neMH4x4JdQ3neWfgI0z6Rh0TjaCDYKWaDQzI/rSZoyhY5BFC0HxPWFAoScXkBesWC/G8/r1pC3pA5uzcQ+B6FrIigYsxi5L0YblWpNxK7LaMcNy8jE8kK8=', 'qSkAwMx5413SDB/+hMc5T+ssegJb+QObL+ilZyVVyAk=', 'KhU7dIrbrBfuhJVfH/Z+9I648H7aeyOZZnUltHwfeG8=', 'YpluAIBX7SjClQWW8D078aoFPKlP9lGMy+cp4htrdcs=', 'UraZY67pp5FPPmym+ptwSBSz+ty/Gohceej+w6pHN0c=', 'qSkAwMx5413SDB/+hMc5T+ssegJb+QObL+ilZyVVyAk=', '', 73, NULL),
(11438, 116, 'Bmz1WZFQZPPzuv03tlILjHl/TrSydlPuQE9gypcs6Ap9F6vNQX55VCT9IA4B2UVpqbrhtrjlriEeOUzCRJdV2Q==', 'SY2tPpxao4FILEXs0qva6TbVTgtTSQW9Mct2z0dkR+M=', 'RAEsYSbTgLl/TJ/b1xLSL/Z9IUD86S5ZxUSnWTTdGFc=', 'N0zhmyelFIqtQzLhVM6DDE8OLtwOe85o1J47FHGjxuY=', 'I3DP7qDOYPLUE/sBSuTqgFUifZtHRdVQkMpm9fkFplU=', 'SY2tPpxao4FILEXs0qva6TbVTgtTSQW9Mct2z0dkR+M=', '', 74, NULL),
(11439, 116, '0QCpK0uEpCECzEFNHqBnOt1UeemWIT/mM0/lDrLnhyc3KVH916MIHlv7AfOKUsjliVpKMEzpxiErFjA6hS9bTg==', '7pfIjBwgV+ZGLEg3loSCCH9IHl2qQCrWX6mjzxQrPUU=', 's29tYMe28cd3oHhG7fboZUd6JsOnauS5qx6yo9S18vE=', 'gHe8sUjB1H1scK8gF0ozI7Yu8ENv90ewROlZRTE6/Kc=', 'aw9HzkybaozqbK4Bb0j8tSwMV08HlnqfEKZgMSa7LcY=', 'aw9HzkybaozqbK4Bb0j8tSwMV08HlnqfEKZgMSa7LcY=', '', 75, NULL),
(11440, 116, '69dDrV9r4ymtGBPBIEbZnze5hsYtbxDq26kz5lRREgn2AgkauR0sn25fjwdAoDDLD4v1aB97pkKoZACQoTCFcIt/cViqL0vaLqdnyJSOqqo=', 'hVOchJ5l8c0zr3dUi5w1QHcxbDWZXhiIdY8YcrRl6PA=', '06z+J87o5golvd6KIJPt0DIRIsXx8UT1O3p8Zn/IAss=', 'bxKxOid59Gl5uoh2rz1ziGYiNDr5Y8X+jIMqv11O7bGmOARV9pmlMjLHQ/C9ZHHC', 'keg+SGcm8Nz33BLvjHWqp3xq0/Fdk7zFXc9mlysDrmQb1N8QxPgfFdGP57ANXIgF', '06z+J87o5golvd6KIJPt0DIRIsXx8UT1O3p8Zn/IAss=', '', 76, NULL),
(11441, 116, 'KYnYPhaM9bxGsMohgt7fE2GdjwpleUIfnFUy+GPyEhKi/c3X3NY2Jz461Cm3fJJ1AWGY+xDeYaD7D54b1lSzVg==', 'uKb7v63R4SZlnv7yqfPazEJB3ZSjA0Wbl168XMAEgv8=', 'gWj6znH+fMFmd3VaJrltP7SyhKl9+JuGHf/6SXF64os=', '+C1tmqe5/BN6yCTROEBqfV+R8DMjn+g3Sh/LIkBSoLE=', 'wDx/23NccscKvr26S0voWjwx9an+XG1narGTt13XXlg=', 'uKb7v63R4SZlnv7yqfPazEJB3ZSjA0Wbl168XMAEgv8=', '', 77, NULL),
(11442, 116, 'zqdL9hxjPr0oLQZ0+yxoBj5TPKdVmplIo3+WrDHZoaIFK5uQxUT6rw7cKCKkl4NfdegCVQe7penqrmPmOlKsd1kiRsWgwCVewuto4q+zsGc=', 'lOuq/QbcItf1mi1jbk2UiG3EhQd+8DeHcg9JerFg57A=', '9Z2erpSzFL7SOD4guVHiuvO9bFSN06aA6+ei2N9PavI=', 'OpDpZc615VOjZjWyv82ga3CUeIRSCU95cE2+YaECeqk=', 'q5Ju5W7caAmQVNU/GyJ+bYkfAPgY94f+yRYHuSl4WHw=', 'OpDpZc615VOjZjWyv82ga3CUeIRSCU95cE2+YaECeqk=', '', 78, NULL),
(11443, 116, '2VyXB95qUQpopLVtIFErNx3Un5c47t++p6mBwM70b2RLGJHeROg4Muhc4w1XorwO/CGUOgnulICVD4G//4uIeQ==', '7hIfHOEGlxV5xdkOX5lNDkUtgX61yfCdbCbc61Sobqk=', '+xR8E+ep3l7Z62uIeiGImnAB48oa08ABcRvQO7cs9pI=', 'ukjZnTMa58Px12ALncipeDG/00QHB88tERqoOH4qSoY=', 'XrWsltzl0GtBIv5/M7Ge28J+pujpSN5mIE4TdWPBN4g=', '+xR8E+ep3l7Z62uIeiGImnAB48oa08ABcRvQO7cs9pI=', '', 79, NULL),
(11444, 116, 'WMac303xgUYGvp4TSRR76zPrAzSHUhJlNwdt9NpYGliiMJZEKbjKkLKQ/Fdp0FUQDiLr+MzLRrGgDlRnrA/A1watbMbLkhrXaZEzcLb2aCKfIe7tihw6N4CJSNFDc4F2dgtM2RgnK5u0QXkot91gzQ==', 'kJninEvhnnFp7DHLs6AkU0HsVkXCY5WKlwH1r1RFkT8vMDLBzrFTcChinKDwYFJW', 'aGQ/4WW37DClLFJk8Kn2JjSYfz9quPIXYtYhHtH1LE+ZzkpSAmhvKEX9LNDwMtFw', 'CcoRnL9/aPwaNtcj39XltkZSRXnq0QSgVt6FP1Jf454fL6jiMe+C+icMwi6dHqFc', 'cGV9MGklxwvlRQkLra7I2G9M1L2UD18YmU3fpE0FISU=', 'aGQ/4WW37DClLFJk8Kn2JjSYfz9quPIXYtYhHtH1LE+ZzkpSAmhvKEX9LNDwMtFw', '', 80, NULL),
(11445, 116, 'BQXS98eU/baks0aZA2vUZ82fExTI1hlUE1LoFHAXLYCDMLyzVV6MWm2t0tKfaK+bE//iC+Ky/ppwwxYGGSc6faiZBQyFhmbsHhYE8JG5Ai0=', 'v/HfQFYmvgPHqXuoeoQ9+geBh23wwEjM4adaE8Zdsbk=', 'Vj+sQMPh8UGq8rRFcnwdFSEJp1iMMwA3qaeLLC5YhMM=', 'QB1p94JjY/z82JnEGYU2GQAPOOOYRXkwxV/E214ERe4=', '2b9MZ0WY3i5KfxCYUX4GboBNRBVtzXUrREs5RVoegY8=', '2b9MZ0WY3i5KfxCYUX4GboBNRBVtzXUrREs5RVoegY8=', '', 81, NULL),
(11446, 116, 'QoAcDSW4SQNvRbLxqNCeQpdrcbmfZClfVUwe6iy2ugVJ86eTYGlhTOK8qL7uM/tH', 'o1maVzjKqXYU8dPuv3ZiKdc7aNPDVk7hy8BIUViodbg=', 'lfFjwkASGWDSB4l303n9b0Ov5jcWb/pRTh0rfzR7HcQ=', '+wpQuMI1wYGwdi4FTnXdqJWwv5Ogqb6EAvQlrHt0X2Y=', 'TZE+McX3kSVF0r8yVcsSwDRsBgV603Y2WvEnhT7gem4=', 'lfFjwkASGWDSB4l303n9b0Ov5jcWb/pRTh0rfzR7HcQ=', '', 82, NULL),
(11447, 116, '3v2W1ivBbDOEWTRXE4vUytGAuNzBDFUqz8sKYJp0AR6vNahxmx++97GwF+rCie3o+HPSxWRzRSo8/Y3LXWGLiPVJHc8F8eOzAy4t2qCWRWfR8wBI4J/SKEkvmk2U2kmK', 'x50EinxpAq69iHEbtMI6VlFp2R8CFpC1ahr6T58D/Cuuhw27ejp8+AWkPWGaNn4m', 'o90dQCMlB4FxAaJJtDfXISL4LXLVgnQJDjArRYRFyxkT83+dWQXE3gI62M8+CTYW', 'lBIOEDtXLp5OUJ/T98VKOmva4QoRrgx44RvOIAWPhMEXhY/K9jYVeTcDFI7ETV+7', 'CmHEaeMr+NvraD61SOB8f16GxK72OJLRs+Wyyyj6YX3mVk5q1xIpNRIjaSUKK6b+3zxfobn5Dt5iophANphtEg==', 'x50EinxpAq69iHEbtMI6VlFp2R8CFpC1ahr6T58D/Cuuhw27ejp8+AWkPWGaNn4m', '', 83, NULL),
(11450, 122, 'UwpmWfGUeTS7yOs7+A7FmCnlBwIsc+cWDNtqF/di5VunIVA3PMcgEOmAb6BFuilgy4StheyrtIpExXkHWwzX5mUCktiytzReTZF+rDG1v9ktgzxsEVAiBmBQ7l8NhW3dLPsfnJ5RFhgddtyNI0dH6Uzsh6qg9f5X6muvFzwQjfzgYSkI0LirksBCNPfB92VWstBq7HvVL/LsX56pwqhbUGzJeisxUDCBYbjx7rcyjEJUQUDZa5ElXutCgsYwKwhTHfAfclSkZyPDdlR8K+I7bIET//2i3eyEWEozrMGjKOTUGhPO/waMLWeu9TIIQJS75iEEZl6F6WynJoUITBVuv5sv4nuBsT/F5kCovYKO8do=', 'C+9xYzEizKUDfQeUx2spWj7y4dMHrXZ+6sKPQTzBAr61rtG2dnLKhWTxIapdSvRg', 'SdG6nMwbw4QdLMy6gHDcZZJmiDRWrHYnggPbuc+VzKyjBfUl6xlfxLGbBrlwEzlu', 'vsx8LiGrsjxv8go47w2HSapfZJUBxt/Xlbx2VwE1XcOvluvoN5CTlBlazEXzVOVD', 'bd+1GC3Tmsv40b4OGEErBednfd2gQu/0BBto6lV8Qes9A94tFkb1BfaFd8lBJb5F', 'C+9xYzEizKUDfQeUx2spWj7y4dMHrXZ+6sKPQTzBAr61rtG2dnLKhWTxIapdSvRg', '', 86, NULL),
(11451, 122, 'AuCYuKSx+9Qrw7b2XABRxt10DGOm7G7pIiF2JZkDPipvDvNhqpZUAR5qTNStfIrhzL9a10+W6ZHSAGWexGD9sx1xJefMv6Avb0JNAmrMJSV2syzFkk9tNjA7FAAtGpv8G2MhMX300rjRqXIJGL7dBGrxT+v4CT91JO3ds6ECJ5M=', 'Kc8K2NA00WobmrC/0Oovg8J1FLprXtnf8idJ6/YFiHI=', 'MR5bWtsXh17q0YroJDXsoNa9ao6oo7jD++e4NQ/5tUo=', 'OoxV3B5nqnPG4zhv+uiEeaRDmyWDmsfacQYG1fFVJcw=', '0aq2rboacLgm6SHo3gRS5c0vc4zhb5YZzqHap+KC+eo=', 'MR5bWtsXh17q0YroJDXsoNa9ao6oo7jD++e4NQ/5tUo=', '', 87, NULL),
(11452, 122, 'Dgc1hFbokzvktlsSYLj0EKxM3ZJ6GmpRvnfbVK3IKDWfRLYPOHN3bfHPoSB1kf+uAQAsDu8WwdvywtDMhY7Rijr9QNNE4DOLIEMuCAcVnkIQqFt9qQc2GeoPQvdEHXbkpSc3IY/JOlQykrxOcNKwTg==', 'ApA6wsSVA0wtZJTU4khYZLX4ivirb1MGMZjNedyNbwM=', '7n7aTyDo4E4WvtDseUcSMz7J95/2jdCsEbbdd6tK7CEIvOu6BjGpFpTFQ3HlRYrI', 'ckyMqKkVqVVFaE/C7o/m9adzBW2vQQnCyNSBXUKEwpYcKpuzDjDc9Ce4Pm0t6UOQ', 'zlJXeYv4ClVNSuUPvI9TsaNZVc3t0LFYM4RpH/nc40Zp/MwIDDP3yIChE3k2s8HS', '7n7aTyDo4E4WvtDseUcSMz7J95/2jdCsEbbdd6tK7CEIvOu6BjGpFpTFQ3HlRYrI', '', 88, NULL),
(11454, 122, 'Xyf8UssXVYS6nvOhEkR/8v4imiRNOi10VkEbUHndtEFZh/em3AUKM3kYu8OQzJfzstWxgFSTI4nTV+JfT/uJQ7V3IPVUzibZz01rhfvM1LVmJC34yWZBwalS0XgJ3Q3wwS62wlrC0/MhU5bK6FbQiwJBJrnEJQyntOqWmPNsha7PptndrX4W2ZlMHNUyOJFSmdWpT/CGCYpCG/h6ZKja8M/1Vsp5itIGRQBLg4bojus=', '3CvdyXHiH4MIsSWphyCYgtF9jz/XOXTu2HSYNJFN2l4=', 'bTk9Hm6MChSwONu1HcJcS5iPGk5YYNf0oaXvpV+l00Y=', 'GjSwm5EWg+/pb/sQDMfBQ3mj3A93pDaRm9c8CJgGqHk=', 'WTah12R76O8Q+JSTRjVOC/rYJDwbBs9savgYnk0i5I8=', '3CvdyXHiH4MIsSWphyCYgtF9jz/XOXTu2HSYNJFN2l4=', '', 90, NULL),
(11455, 122, 'IcJ78hxrHgmxIl/DSPFl6YmY/I2Jp/muqe0C65fDgox3dpiSGr5UWXJtRtyWaYWTV80UwS1gVeOwc7tVS2SYij7WMIMyKho2ZMHtA6tgb8SjN2NEvWlVT5xIPzfzBuKtW2Zv81Kjp5i50EUnx8n5g8CcMk6zkcxwgbBcAIo+qQlXPUBOk0SY2nMTlJze7sk5s6qWpZdMWeEVwj0Bu61wPMh0ujn6rQnVzIT/ckkOMeNM7lAxURrFabqkqQqDBbF6pLQvoECbFwqFA65zio8ruLtXvmTlPYxzxn8H+FTN46frzw0YVFmRTUSwdDdQQOYguvOFPO6SNElKH8E4IB9EMVtXsxpbsVg4EG/lqfrYa/oNA13ewN65KImH4Q9udHDFwc1/Chp7BHLiNCHVk88GLWi9GmgKopzaxR7wbexwdWThWiPwoANGIMP7z3nTdEcOES5V9mWAkkIhqOpRlKhmmEiX6qLf67svyQsROUeHrHA=', 'HPDHeuo9H5UUWNMT/ksOvfqsNvM5mhsy22n8BH1sk5Y=', 'kp112jhYMjPWAuwQ1qLNN3McyquxC/o39AV2sy9rHvM=', 'dv504RrufwHWbqhDFYUXcfigV0sqzWX24fL9DewCX6U=', 'vLty0TYa4y9pJxLPvesmeyoZ3+3W5bdEpuxe0kxWaes=', 'dv504RrufwHWbqhDFYUXcfigV0sqzWX24fL9DewCX6U=', '', 91, NULL),
(11456, 122, 'MSGmHrS+pM5ZE4mKB6f6mSgXJnUhZHaUgjz4AdJlTmkDAsjm6NsYY/wTOR6NjoWsaAQ3ubDmXduHA5uOwWrlbbqZr2oF9HCbKz2pCebXm2PKbKZ6+eVr1kt9w2wBaGoLzOiQEIrjTdo/W0lqxp4nIkvuzk8OGRzoDRBZFdCxVz3h1tdC9Id9romj8vnwsZVqyuWWeo2LETYJWtwmVf3sVdiNeJIrIkmdgXaYmFrVbMwuQ4MzqdLn1y1X5HjiB6Opry3V7jEoQ/6Rh+n653WmYA4GpeVOKeGaIQf0qYA7Y5TOUFZ2jkAuLsXMIwJpG/j5', '48dDe4Q7sJFnBiJTc7BCCZka7leMPO/gRTsrLNx4Kn0=', '1LUDr+HE+gJwbDlAaDJlscXMX3fmTQeOTTPqYCtksIY=', 'T0QotfmpD+1GR1qxHKO0SVHRPMUiO4kxW6iLPU5p4wk=', 'EEI3eSdEqe0gvMEu4TUngWXK+PYPb6qzQS6vsm+rAqU=', 'T0QotfmpD+1GR1qxHKO0SVHRPMUiO4kxW6iLPU5p4wk=', '', 92, NULL),
(11457, 122, 'gu/rub/nsuQxsaAmnTQ+JQ+zCyiQXaWGen8X1UO4yEr0ndfssB+yITt9D5sebFRfGfQ669XSTAlPyJNkhy9gWSUXfgjlhaWcSUIxpwXwI8s=', 'gT4A6sddjv7AzsOnNXoqjs9MDbEfGxGC7+WvX5+OtKk=', 'bcbG2jGcIzTIY0fD+wW6MEnFqURMjzZGjDMcAin6Bxk=', 'bp89Qq1htacBVTWCMGJFe/QIh7tyTuFEfNSwed1x3Zs=', 'EuaFotPyMMGIkMK2+afDKiNgMMCpjfKEYiEQF1HidM8=', 'gT4A6sddjv7AzsOnNXoqjs9MDbEfGxGC7+WvX5+OtKk=', '', 93, NULL),
(11458, 122, 'rG9TTU0w05U3cSFw0jlkp6BraJcIazF/kQMIwVL1KoxIJNi9sz0FdIm0ZII+R/Oi9UzlKs+WLKXweYRfMmVbb5wUs6M/2JNn9KDghRUd9Hj3qfXk3gnlbqRsaeQbou4KWZdA1hOlHSfXPdiSIJO5cA==', 'P5V4DTR6LNgynm33oQtlM9Xq2usLhHZDTck4E8dd6Qs=', 'Mpr8rHqj5PyMrBtgz7zFnkHw8nkQoViwu7UOoYC+1L8=', 'LVyOAQuTnE9T6ZjPbGepTcsEDGspx+Uflf2tLWQcGXY=', 'aka50fRZk5soy5vYbaX4UZ1SRypGBH3S6Y+d3QcRBpo=', 'Mpr8rHqj5PyMrBtgz7zFnkHw8nkQoViwu7UOoYC+1L8=', '', 94, NULL),
(11459, 122, 'TobqT1LCEYKsBeLd5/Snyysl8nX4hzVvXSjh1iIwSCVEIfyz3VuWy8j5YIc5dEcHYqsqsEP0YBRQPDPs7hfvzwU/uJGG1HXgop/MnJVEDFE=', 'v6cW0idYAVimzVbIxLFfilEK2H40kNoifnsLbrKfumBjICRc/nqW0u0zY5idL3tGY2DnZVlkoerKNPEsD0t4ag==', 'iyvkhYDhLSGt/QFHmienXvKbpNWQHHmXbDnQmC+jjpFmNsM3shcgax2Ov9JErWP4kNMdUHdVwTLSy60d/rBe7w==', 'EigitN1M0I+A9qoTgs73qFueUJ9MSr+FakRilFaZtHsyepJNdwULV8xn+7nowrsEwlkaYRCFHsOii5Bdm34WWw==', '7PuAOEYmjCiXduNiaJTPTSsZSjPKZtIkXW2LI9oEATlO6n9a8y1ywZ3biewPTxk7T7teQSeSD0pyjG5UWnSSkA==', 'EigitN1M0I+A9qoTgs73qFueUJ9MSr+FakRilFaZtHsyepJNdwULV8xn+7nowrsEwlkaYRCFHsOii5Bdm34WWw==', '', 95, NULL),
(11460, 122, 'r2dubDyKLAsMzqGP5x1VoB3nXiWzcdOH6prTktXt4Cc7OQFKnu7+q1XuUY5R20gy2+Ru9kx0hq75Jt4hO3bb/BI9AI3kB9yw40YmDy8rRqC2SQ2XliYMYO5WrtpI1s2L8HGseD6CX9Tdop8JrBRG49GmmmOT9H8qrgBd8gLditXxOMv4q+sWxxDbaOutlC7x', 'B0aQ/Jf8sRAslUvHi/fjzcIQ3jeLo3pxhr209EtyUN8=', 'P4WS7dPPGHQsvNRgEDJRWhELOQliwahr2Bf36rK5q04=', '/oqDSE44suG/Znq/Hv1gi/VRI3TE9dYLY4YMfA931Kw=', 'xpmViRraKZZQXRSoMgneaG3WSpfUQWQN0g31EVCdjIM=', 'P4WS7dPPGHQsvNRgEDJRWhELOQliwahr2Bf36rK5q04=', '', 96, NULL),
(12746, 10004, 'mkQFnKxMOgDvXOU/Tfuuof3X5hZZaTleyM90X2sL91JiUYSmF0TSKenXFkizLkHROzZOf7I99gD3MhVrbeN9nQ==', 'eEbt9uhl0QCpK0uEpCECzPc3IXMNmvK0HsJerod8fyQ=', 'QU0eoGc6R0h+7aaKb/HisNebT9qBJ3BmFem2VJqWpAU=', 'SDeWhIIIs29tYMe28cd3oEH8k3ABPWgC2k+SgEZCoIc=', 'oU0lgv2HFUjqqdnIUjsdTWoEw9wYDm0VBke1KJiDy1Q=', 'SDeWhIIIs29tYMe28cd3oEH8k3ABPWgC2k+SgEZCoIc=', '', 124, NULL),
(16536, 10018, 'TwpHse5eDMWbuxFnmotcvs1f3VelJd5XmSfe3ODONNkYoyvpvZeSZvgl2jATkdhePJJblJ7XzbfE0l6mvQwWvr3virt0H/jA5UvxOEDOWomp4CrevLqvcwVK5gsTV+/rdt2R0VencvOD44Gk3aiGYCKeMrXkymZSNJpK72hYVlXzmIhtAUF/yyvtqqh1yYJhOFx80f7D+G1q4KlNHdysqF3X6bIQ8Lpod20LK7QzVFE=', '5k8zGw9LQJfC0QwhSkig4JGkQ74vxIguhrHP5u9F4TgGgiP5CeQNsJgfXw+zvgUX', 'bJmDfXMsvh8l59lvyTXblDQScqeY4gx8cyHNfHgSIGI=', 'K/tNN4+kNn6+Fx4VArkPICJpAnhWbXjtqAceB87mNAuLGUi6VO4o04uNzwfuB8lOEqm1fhhlFhvnCXQ+rObuuFEzXnP1bdPpnsKIboxDNfE=', 'IXaOSGO1pbaQXdsS8dY6g/yyHRxkwWVhnK4t4QoqlGk=', '5k8zGw9LQJfC0QwhSkig4JGkQ74vxIguhrHP5u9F4TgGgiP5CeQNsJgfXw+zvgUX', 'fst shirt.jpg', 133, NULL),
(16542, 10019, 'aND6FaOaNmlBJElEC1i7S+HPuCYGLTo2v4ecxdbiZMTf5K5XRKqIYk46B/mfBNyDUjVHaW7V7mWa9FTQoh5HziFZ4YWXSYQRnT5s1HTaSlU=', 'GPr5aphiiqwdqpOUbLycyqLDVt51/pTlmQvUH7kiEIM=', 'QJxXWbxvhSh9ZGrbSWGOHsSi0h+tyxIGUErgOJ+EHTE=', 'zwCsdQ9dTD5xO4NMvoPZSBhpXFIyiBkK3MPRau6x7I8=', 'GI4+Nlp/QnOAsZy1Ug7XpP/iIGFqVzelP/DnrlZvpvo=', 'GI4+Nlp/QnOAsZy1Ug7XpP/iIGFqVzelP/DnrlZvpvo=', '', 139, NULL),
(17813, 69, '44ES4MqS1OSSHD20JKTymKoHd/dLmwfniq4fGJ0SA57SEFDiINKezO8UdrOIaifoV6adDqn3oeoiQ8x5XKtHNxxSqq3t1eXo2q/4ljFjZWqL7xLtUp5RwJbOtR9a2yF9', 'ZTj+zmogMDhwHyYOYLyJl1cmeo+JKnnFz/ptzRWMJw4=', 'wGVTOM8+/cRAD86c+WBsCBxY6Iax8m/VBMMq6OdNmAw=', 'ogOCnB14uWQ5JlW43pL+3wDYTqyQmFpEqGU0L5NSvDo=', 'dsbeoudKm0mZJV2adt/M3xKXCICaokUOWqbvJS0OV5U=', 'wGVTOM8+/cRAD86c+WBsCBxY6Iax8m/VBMMq6OdNmAw=', 'Screenshot (47).png', 161, NULL),
(17815, 10050, '6aVrx++sRDQtGacqKZLeEpPjeYq3JEc/hpxxtAl3FlKIdETmSfyRBzDaagO+iH6nLBrsaYIOBe0WiSbfqFFPmQ==', 'jaeDjVuV4qHfak+/pMsOT2UJf07va/WxvQxQSDQEoJo=', '3uFd1Vbi1yzlqL1rFNxW/Fq8muaJL8G4WQ10rCI7wzE=', 'y/aH+jVxI7qWEQvEd3+GgL7s/OSWf4JR3VZoiTIIMHg=', 'sOLoOIxXJ+I/UpE2UnlumyaDYLnfZf1e3E1ovcumeJ8=', 'jaeDjVuV4qHfak+/pMsOT2UJf07va/WxvQxQSDQEoJo=', '', 165, NULL),
(19207, 116, 'EVVnXWCV28KU4FpmVoBJU8I8gr39wIiIgLTx/nqi6lCIDo+27tQVGR9rXcfjtD6gR5ED5LTJPCI/07PHnb9W8w==', '7vJ3GquYKvRt6gav3DBzUYeEJ4wLiWaNnNuBTmgXymo=', 'IjFaY+Q1I+tNBbR0A+d4BSUgQ3Pgt694yK4ttHk8yT8=', 'LqZVJHaJs9oFV3uxgFgVr9/L71vGQGHwq8WRWNuh8/A=', 'kuysSMm0yfVlCW9iDzAHlppwSh7MpTKWzp7jZhNw/kI=', 'kuysSMm0yfVlCW9iDzAHlppwSh7MpTKWzp7jZhNw/kI=', '', 168, NULL),
(19209, 10062, 'Dc/Fy3IEEUoXxbA5Az1rgnO0rhJOmSi8PH2bHFvGJKYXe8dqY1KMTBXULsFpBOaB', 'E1RlE5u8NaQkchhotJ3WRRpdjRoY8V7lGrbIdYjNSrE=', '+DnkuaXVOF8Sf2D2Rl4jZzRoYgGryAAu12o2TAY/LNo=', '0+a4o4t0hmth74gFX4GFV+yuDNnsYtpKc929g2zUaC0=', 'yRvIGqTcG/VfTWBjAZJgSoPNvq22hxmP4PLO5qBjKqQ=', '+DnkuaXVOF8Sf2D2Rl4jZzRoYgGryAAu12o2TAY/LNo=', 'IMG-20170311-WA0001.jpg', 170, NULL),
(19210, 10062, 'QQWhQdTqTis8wsJKPnOFR8NM+WgtCO3P+vPFXznaeqhFnfKHkh4eBLY4DeUTq+K6Su6e7524eMnvIrw88R0XCg==', '33NVk3yAyWRrAIXrdtgR0GWkaMsAYr1SC4GPfhjKCF0=', '5HN0O363N9KLDWG/01t6qvM9gcxvDv9YXLkvELQzwBE=', 'FT2aEipsebXz7f7uOKi0ZY+15wB7tbzwvKwCuifZGkA=', 'oAyLurgGHJhjsTRravVb21Bng5URta8BkHAyzQRURQU=', '33NVk3yAyWRrAIXrdtgR0GWkaMsAYr1SC4GPfhjKCF0=', '', 171, NULL),
(19213, 69, 'VN1F7fgzKammx5q5xaPB4+X58h7kqF/46BPX1omaDZQJxHj8QmwE7Ve5zvqMtGRTGNz20FKdc5FNlSFGJdJqcVDF8uthJ5OsaiFh4ECTHcej8flRooQ+qQKBMz1vzhzEHEjhs7xCd671iUWyCamVNg==', 'x2RKDr/cYk6BVcehddWiz4UctgEiuFf4zW7Z6favyNA=', 'geSbIhCM2WAIUgXQ0UBGPhEu8Pp7cfSR2HMUFXLBXQA=', 'JVtQsQcmwnMT0OEpsGLWmTwEHQbCCsTCXIQz+gT0zlg=', 'mcmuDuZm+tG8w1Rog+bjm21xyEySTsk6JCSdPqXHvHY=', 'mcmuDuZm+tG8w1Rog+bjm21xyEySTsk6JCSdPqXHvHY=', '', 174, 20),
(19214, 69, '2IRHJ7BlIl2fC2d9Lh9g7oFKKPHyCmHQXb4QneHP+b741URB4UwXJnc/71KsrTxAFMSEMxyyWLsBNiU9v1Ot0fKt8/cKxB83DDVElBUCSi2d02eq/vp1uxr/hBZlz0EtOLDUMGBaNV95dPwNGPqhMiA/Ei9ACSLopJsgGsGTqTY=', 'qoXSiuXZcRT4sztIbLt4jXFAFsh+GHcjIr72nSj06ss=', 'CMnsXzWXrVQaTHlSP42YwcSPpCV42GsXsmcMtb13JN4=', 'RhnwzA9z7W3Q8zVXEUER8thskGLYvI+0+dirM5HPdvg=', 'XOU/TfuuoSszvO5zibhwjBZx83kQdZsbP+dt3JXPiJA=', 'XOU/TfuuoSszvO5zibhwjBZx83kQdZsbP+dt3JXPiJA=', '', 175, NULL),
(19215, 69, 'FUjqqdnIUjsdTZpEBZysTLs+ev2+POkg0YkKGPpDYVNsgteCwoGLi0VEWR6JKO+89vsqxu9YVE7oLvPluHhCuFaCWtZJM9Ts7pygcE0rYSGTOPFLbowFEaZ9Uh8CuEK+z+yXVy78GQ3SgeRtEkg5X9FpKf6iRNHvSYF1eGIgoB8=', '0QCpK0uEpCECzEFNHqBnOkZ2wHxqSmh08MynlkQpWfg=', 's29tYMe28cd3oHhG7fboZQXcbyGF4r2cKIKhhcAkMq464vn1MKGJ8xY+VYD9aH5o', '7pfIjBwgV+ZGLEg3loSCCIqeGG+0syckL2xMqwSC1n7Lr++vdtdeaglb5NqgdHV3', 'R0h+7aaKb/HisKFNJYL9h2ccfszn67/To5dkN+GDhLE=', '7pfIjBwgV+ZGLEg3loSCCIqeGG+0syckL2xMqwSC1n7Lr++vdtdeaglb5NqgdHV3', '', 176, NULL),
(19216, 69, 'shOalq1WZBBR+Fz9BwOpJtIdNZFovgJy9gFKQBat3Ii6KHK5CRv4nOPEcsFYPS1sNqTxnLXF3AK31f6JWV3XiRgdFNF1/fOhdScjoJdQs/Oc/0zzECh17FLmlh8ZxZVSQfDKdco6CcQncGCiEY6jrGadPZ70yE18G2eNQoIAvV8=', 'mB+k1Tup1lcHFLXMZGZr/ey8pHAp5XtILCPOq06pHRc=', 'OyidMvNhdjJ1mZtFKdk3NKHgQEVBECXqpg2AjAR4MRc=', '9ajvRkQQ7UT7lth1hUTaoRM9I9VCBchfFgVcFzc7khA=', 'yKKYEi23PY6aDG5deqdWSK8AYbl+UTbOqaKZ1jxNxzY=', 'mB+k1Tup1lcHFLXMZGZr/ey8pHAp5XtILCPOq06pHRc=', '', 177, NULL),
(19217, 69, 'k+3QhVOchJ5l8c0zr3dUiyNerQ5JJCl4/OM/T9tJjRRqC9TzLXtpKScQlqnbHRASsWGYnCJG0MJJYPD/ioRwRKGgG6n2Bb3QnmvjK7RjjPE=', 'Skd5WR7ZIbYE0x9P4r0ZayLvFpDFLC22mWm2pPUB8uo=', 'I54506z+J87o5golvd6KIGtuBhdAeB6yAqDQGAfHtx8=', 'YYGCDUn3Hq4Dlc9LdeI+K8O3JUjZhrR+Y5IVbhmZ2wY=', 'CueSF6ctc1a3uAuwIBQAbyhRGbfBqnQn6dNeYn5tDF8=', 'YYGCDUn3Hq4Dlc9LdeI+K8O3JUjZhrR+Y5IVbhmZ2wY=', '', 178, NULL),
(19218, 69, '6MLKUBJLOwM6IL3lamsd4mGGYdDedxiS5xWeXg8RV8SiNhSMmcmP/Js0OPssXoyMCJe11Vj2eT9V1ELR4UO8eFp6Fq1THW0vVqlk1W+0Am0=', '9Z2erpSzFL7SOD4guVHiuldsBWm7ZdFzDEZUceHQaGA=', 'IAmu15rqoNP0e4ZhN98naEibQPQbou7Uo1CEd5ssGh0=', 'lOuq/QbcItf1mi1jbk2UiGOOUQXmu9S5Xn9miWemgng=', 'zqdL9hxjPr0oLQZ0+yxoBp7LWdDyku4It2N8I72vxUc=', 'lOuq/QbcItf1mi1jbk2UiGOOUQXmu9S5Xn9miWemgng=', '', 179, NULL),
(19219, 69, 'tDfXIZQSDhA7Vy6eTlCf0z60rT4nczofkcU8ikyEqiF4Czzi6yukMPv1DF1bGoh0hMOAd3GNhz+K7ZrbmTVpRFP6uX9VP1mDI+/V4YTx8N+C/aw1m1W7E3wmWaQHbv2Z', 'SOB8f6PdHUAjJQeBcQGiSQMh9KM39CNSSbX0yeJO4jw=', '+NwPpcedBIp8aQKuvYhxG7vSOw6zWwkejHKP4tqDs58=', 'tMI6VgphxGnjK/jb62g+tVucUy5bNllVSScpqjsjNzk=', 'Fi/8bN6R2qPs3iP552A8d1IHyFseLOWT3hxVusxKv8w=', 'Fi/8bN6R2qPs3iP552A8d1IHyFseLOWT3hxVusxKv8w=', '', 180, NULL),
(19220, 69, 'OJsZCrgCqk09SrM1jFy8asFK5cAAhUk1eXZi0jLtKwPQDamVHXG32wxW5pzOtYz+vfAl232lHZloTitliC8+zdoY17w+IISwksIdAkBLUOPHpME1I/ByXJvMxQT0mdbnxFTQzPABv6FOiTWp0EuwSA==', 'h3j8SxAIVnYc96fGdDJ44+bjPQ/QtkyqvMFqzO0wxdM=', 'Xx3P9qaiN6eQKbYe5pjUAptwTdlvUEbfWGefrlzfxD4=', '71qbenRVkDG88b1NkBeqd3Km4NZkVmpkaGgURsj7wO4=', 'OC9e1nogYhOgUrxVcq32RVDkqkyXtxmcT0prr3ddUww=', 'h3j8SxAIVnYc96fGdDJ44+bjPQ/QtkyqvMFqzO0wxdM=', '', 181, NULL),
(19221, 69, 'TULfPOXal5tHc50P2hQZXvNqhJp03J++cgx3KauK+ge1xj3ZmnAMz6MXAoCiz2JPKgT1rTNBkgW0mygMFWvYgdhNr30wYom+5iJL4f3vMIw1DMYWmAelH9fu1TqzSmpt', 'IKdEPAxkMR+C4CrW6SVZKrDAlDBnPaviOjSWTB0Cx7me203FMsgIPteOfIWIyBC6h3hVKD3AgyF/Rs0de76zxw==', 'LQ96zwQewDXDy3RO1CK9483ujv4fityd2XzhgFJe4pbRDj6UxWVHV85lBM4HPENW', 'K7hmYKyjeEFZbjgXliDMp0afufs704AnaayvmnegO2Y=', 'Uu0JG5POKYMdLxd+WBf51WBgXmVNZxv6pfXxWRZdi2GxHeXkZL+NtY3ggDhKlzwV', 'Uu0JG5POKYMdLxd+WBf51WBgXmVNZxv6pfXxWRZdi2GxHeXkZL+NtY3ggDhKlzwV', '', 182, NULL),
(19222, 69, '6PphkETvH7p3aQmOChFmc+tlNObJrDuyEGd8YZGfR0haPpGuhRdqhHnpy2aMJebcIJiScTia5tnoqAJ6jvD1VXGUw2t+oY9WYL+sxxyjhoBBykMxeWbWqS26wb+IS5aP', 'mlvMU1rET9Gwcry5KA5echjJhjIONTxUAVXvq7FVAGk=', 'xb/65RMu2nkYgsYYXGMGJ00YfbMdv6srykO7WbdFAPs=', 'Z8/W1xmye8BCO+pyahFuVhttguQyjpqHDNWIeso8P1k=', 'LBwZdVD4X0jK2lBEJWs20WwrTxIkJzSQT4qOWP1+U/w=', 'LBwZdVD4X0jK2lBEJWs20WwrTxIkJzSQT4qOWP1+U/w=', '', 183, NULL),
(19223, 69, 'KO2Q6EGSK/6X+mdLU+4tWImpCp2/LCizoRwUTpT3aIhwU+xRe+wNmIrYGrv3XZKiZ+N+2ysjNayg4FhX3qtsMz4GKgVwKjidtkGfTwIYdvtpBZb9fYE5ViZiglI8+zEigdX3D2aMERCC3ezh3VQc5o2nM8ODziYzeXPFh5bQBOI=', 'wPwtjEKp8GqBmtT+pZbC0/vj2FyG+eFVRNpgbTFEVWePORNOejl7EDSPEhmACRYr', 'V+Ui771Q2tuCHlWezBh5wEzbpvGepYxFSxUzfRB5umdlpOkMRWL9NnLxmVxZE+fbrliCP6y/4tDHPgI9sfzCHQ==', 'it3TnT1E9yWNTh/Eo8QvAwlDLjVJaElHJChe7/l9qOXJ6okMVZwTB7vER8S9Ci9f', 'RIWuSxIu3cTbWm41zNJIJmohm+0MCD+3WYF+QrHVVkqilxA/Bnx9G/QRUCCtyI0HQFT2usSs0NejLjbmikS5G0wfUcBg+qshKmRyph4kYO8CvLzJmuEvPDZEuv8MfCO4', 'wPwtjEKp8GqBmtT+pZbC0/vj2FyG+eFVRNpgbTFEVWePORNOejl7EDSPEhmACRYr', '', 184, NULL),
(19224, 69, 'Op1hg8zQIZ48HnHXzetYVVOkNdc0YMkqhDVlyFHDrDay7mLdmn67cgkDMzPRNu6l', 'U5k62oxLsMNBNlXqucIzdnX5Dm3yMc24zRQHh1UCjM4=', 'Xy/cnVUMrtIGY++FuZuo3aZSTromFW1PuM0a5fVrYdU=', 'IXMd/DxOJYCzwzygzTprh+DhXu7HbzHVip6Gp/bPzEc=', 'vdjPEJTfM98IwOaMXuLxPuPO8tyF8HIVmIPfP64dgUU=', 'IXMd/DxOJYCzwzygzTprh+DhXu7HbzHVip6Gp/bPzEc=', '', 185, NULL),
(19225, 69, 'JPEGye+p+HBUcYm6ulDfcPEKqx0MtI6YAl0bZ/Zp76skWSXeM9FKLNdFg889SFZJp3yHh8iP5Npq3HigaOmaxg==', 'np/S0T77enw3J36K8SoJw856o1hlBPql6h3BoJHZ2tw=', 'ACs96EmY/dVMtn0GcYvgQnSdcoGaYrsLZ7CTRoOW/zg=', 'VYzAccpXzVo6ENfGCsEIflkRIjsl0hqDKkddgSG+zGQ=', 'eS0AuOwtWmh5vNM6iOOR9+ZqXGCRNSJeUfyCZfB+mZM=', 'eS0AuOwtWmh5vNM6iOOR9+ZqXGCRNSJeUfyCZfB+mZM=', '', 186, NULL),
(19226, 69, 'vOoCPpEJDdHrU8DDcxCFHukDPyJF4s1DIlF3d7KDYrZ/QcyMiHfWFmazEZWYQ7nxa4KgxIB3IACk4PS8BhiX7Q==', 'AQXXjVBFTPGEkcmWRjC5goyv3Jv9CBbMlLkM7CNqA7c=', 'EuDKktTkkhw9tCSk8pjnNF22qM1jw9d/2tpjFqo+2Bc=', 'HlfEVGY5Iwv0B+rhcAiE3+WlSRTqaEAYtzIdckEJyMc=', '3qLnSptJmSVdmnbfzN/jgZ3V1v7E9Xr/jtMKpv0X9VM=', '3qLnSptJmSVdmnbfzN/jgZ3V1v7E9Xr/jtMKpv0X9VM=', '', 187, NULL),
(19227, 69, 'l6IDgpwdeLlkOSZVuN6S/l9/IyMBsjv88g/td5/pHOU=', 'L8BlUzjPPv3EQA/OnPlgbIwOEn+BzeLn15AAz1JU7YY=', 'D7SJgNlN1SUIp/dPYqt6pigaIO/2dewJvLKU2nycvVM=', 'pz+mhLPi46IEptinYHQOOYuwAcCgEOFPX+8rKKrQXJk=', 'CGU4/s5qIDA4cB8mDmC8ibn0rmqiwitHKS6ZhyZBlS8=', 'pz+mhLPi46IEptinYHQOOYuwAcCgEOFPX+8rKKrQXJk=', '', 188, NULL),
(19228, 69, 'T5tl9mO7YMWPa3m3PrHXlYLn1k2tl1cuEfDVcaC8mb4=', 'y/M9N13JBksozw0klA14hw9MfZ1LhfiZY7AewoUPLGY=', 'YZYA/h7IFRBVaqckbYPfBH2lZrlQI6PBGJFwlq58nw0=', 'ignxvnHNoZEy4C5INUzAqQ+VFVVhT3m7gIh64c9AeZU=', 'JVfeZuC+Qj01NkO3i8UJnZ5+1hiQ2MZKTpLFD/5yS4A=', 'JVfeZuC+Qj01NkO3i8UJnZ5+1hiQ2MZKTpLFD/5yS4A=', '', 189, NULL),
(19229, 69, 'H7FxljLZTvurVmdaFdAEGzUfV6eIRUaoYbsOEG5wWfxgbnfkN634JZ+KE7AB7WRgqLbTG+9ei0Akum3/wWiBtNjLE8NOsLbzvRr/tnXPpHMPgDfI8a/HLa43c9upidu4S5YiupNQAX6QO2Wiga0p7OukVSLVf6OjFciTkOlPWisHGRiOhh/1GM6KgHgjN28W', '6YJTepLYVt1CozVbgow3WZrZFsHVO5BmS03TblGmkECD0e+e31rMytMTZ+5ikq07', 'WbolwE/VRvptB2PtO/XDAgMXJnuYWXv/OmIoHjgt2H/9xxakFiA8Ru2OPlCxHv3g', 'wMkvIIQs7a+QQ8iYbLcHQlNyzlqtAQ1E321bivlJtXlNKQJxiNbTJewh8+Bxyr7m', 'ciO4TE0zHlkPGD/fQXpjSMTKvkUogGcZsVXfICdVjUBZQ2pVRO5z6DgeaM7lQLQN', 'ciO4TE0zHlkPGD/fQXpjSMTKvkUogGcZsVXfICdVjUBZQ2pVRO5z6DgeaM7lQLQN', '', 190, NULL),
(19230, 69, 'X+Lv85tWNYDknWzUZIB9dy5al3I2LYeD1bIl4ftNMMsgbZwYGwyfHpTvbfZ2raj9IqUi5t6160Ys9BlL3as3lQgphLtcabcA9zsMPUR5/dvtf0XR/RIcfTNC2tuhEqjN', 'pEL13RQ6UE5SxVtGhawATWny5tUvpVR+VBZUZAY7uyY=', 'VjambOssNyvv1RiRiPozJ2BmOYhP8+1WNTbg03lJBWk=', 'SYJdp+z9yvsfzaqXBrfiA9UAgErmRDX1i+oGpAnrVPM=', 'SgbdRhWAgegMbTfyWZbl7K1R8VwNm6y8I6pVWBDNOzY=', 'SYJdp+z9yvsfzaqXBrfiA9UAgErmRDX1i+oGpAnrVPM=', '', 191, NULL),
(19231, 69, 'QlX87PAvoJbJs6JuF0kNm6DhrWR/k91Bek2T8GxUSxahYFg2h1ufAkGKwxVi8ioYaJ1mW+xV4PYCoZLpeYoerFwK6tpo2sig3yKuJGoUBosGSsCtnruT5Bs00uznWGyn5MQ4HjXmLGJbZFrGH342FBHgMxapQMycEtyef+mFKnU=', 'HOoMa+svge7HfDYB9jwyx922n83vhM87+x44lT/0m7U=', 'd12Rbwz1KyhrV8Mt3upjqB/0qsSqkpoF1x4t8nDVj7A=', 'LpeTQaDGWh/9XkDqj8dOzPJotjRilO2dPcDYz8joj0s=', '+ToJ9TC88wgSab7H5qZwXdwfI2Ze6rPWagxVlmnAtnw=', '+ToJ9TC88wgSab7H5qZwXdwfI2Ze6rPWagxVlmnAtnw=', '', 192, NULL),
(19235, 69, 'vVaW6oEs8kQZ8xfTS5SKQOHDu7w2hKk2phRxcUgETHY=', '0c3P+hftXg8RX5S3hQr5nn0g0phkcN/epnXSvUp4bsQ=', 'XcNKPCnBbn1IMdp1g/kWyfVpGIA3w1iS0Gfq0oD6QkQ=', 'ndwB4+TGQTHAYgl09pfgVVP8OX0E81k0nWo5M5oLCQ0=', 'IYQpo+q4m6so/XYJoT0/Y+mXWIf8DnOXDPBcwYB2mUA=', 'XcNKPCnBbn1IMdp1g/kWyfVpGIA3w1iS0Gfq0oD6QkQ=', '', 200, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `school`
--

CREATE TABLE `school` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(100) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `school`
--

INSERT INTO `school` (`id`, `name`, `logo`, `date_created`) VALUES
(7, 'IDRIS PREMIER COLLEGE', 'logo-footer.jpg', '2017-05-03 09:44:50');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `other_name` varchar(65) DEFAULT NULL,
  `exam_no` varchar(35) NOT NULL,
  `class` varchar(10) NOT NULL DEFAULT 'None',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `surname`, `other_name`, `exam_no`, `class`, `date_created`) VALUES
(28, 'Oni', 'Tope', '101996', 'SS3', '2017-07-09 19:54:06'),
(29, 'Oni', 'Gbenga', 'ANONYMOUS1', 'SS2', '2017-07-09 19:54:28'),
(30, 'Head', 'other name', '654321', 'SS3', '2017-07-09 19:56:52'),
(31, 'Gbenga', 'Tope', 'ANONYMOUS4', 'SS3', '2017-07-09 19:57:18'),
(32, 'Oni2', 'other name', 'ANONYMOUS1', 'JS2', '2017-07-09 20:01:29'),
(33, 'Head', 'other name', '654321', 'JS3', '2017-07-09 20:01:42'),
(34, 'Gbenga', 'other name', 'ANONYMOUS7', 'SS2', '2017-07-09 20:02:05'),
(35, 'Gbenga', 'Tope', '654321', 'SS3', '2017-07-09 20:06:12'),
(36, 'oni', 'kytyxjkuli', '654321', 'JS1', '2017-07-09 20:07:12'),
(37, 'Akilapa', 'other name', '654321', 'JS1', '2017-07-09 20:14:33'),
(38, 'Gbenga', 'other name', '654321', 'SS3', '2017-07-09 20:15:50'),
(39, 'Oni', 'other name', '654321', 'JS1', '2017-07-09 20:17:27'),
(40, 'marshall', 'other name', 'ANONYMOUS1', 'JS1', '2017-07-09 20:20:19'),
(41, 'Head', 'other name', 'ANONYMOUS1', 'JS1', '2017-07-09 21:15:31'),
(42, 'Oni', 'other name', 'ANONYMOUS1', 'JS1', '2017-07-09 21:15:51'),
(43, 'number one', 'other name', 'ANONYMOUS1', 'SS3', '2017-07-09 21:16:56'),
(44, 'number two', 'Topen', '654321', 'SS3', '2017-07-09 21:18:16'),
(45, 'number three', 'Tope', '654321', 'JS3', '2017-07-09 21:19:11'),
(46, 'jghhg', 'other name', '666666', 'JS2', '2017-07-09 23:28:22'),
(47, 'Gbenga', 'other name', '654321', 'SS3', '2017-07-11 11:15:08'),
(48, 'Tekno', 'Samsung', 'HTC4', 'JS3', '2017-07-11 15:56:40'),
(49, 'Gbengaq', 'Tope', '654321', 'SS3', '2017-07-11 15:59:53'),
(50, 'Head', 'other name', 'ANONYMOUS1', 'SS1', '2017-07-11 16:20:22'),
(51, 'griffin', 'other name', '666666', 'JS2', '2017-07-11 16:26:15'),
(52, 'Oni', 'other name', 'ANONYMOUS1', 'SS2', '2017-07-11 16:26:45'),
(53, 'Gbenga1', 'other name', '654321', 'JS1', '2017-07-11 21:26:20'),
(54, 'Adetiloye', 'Kikiope Olaoluwa', '345678', 'SS3', '2017-07-11 21:34:42'),
(55, 'Daniel', 'Blessing', '09876', 'SS2', '2017-07-11 22:02:29'),
(56, 'iytirycgkuvhljl', 'jliyutyuyiu', 'yiturttucuvi', 'none', '2017-07-12 07:15:30'),
(57, 'Owolabi', 'Blessing', '061990', 'SS3', '2017-07-12 07:16:00'),
(58, 'michael', 'esquivell', 'esquivell', 'SS3', '2017-07-12 07:29:34'),
(59, 'New Student', 'Old student', 'examnumber', 'SS3', '2017-07-12 13:28:30'),
(60, 'Oni', 'Gbenga', '122017', 'SS3', '2017-07-13 09:05:36'),
(61, 'Bukola', 'kjckjhbkhvcfjxyj', 'liuykukulkj', 'SS2', '2017-07-14 13:02:35'),
(62, 'hutyrucilvblkuty', 'yrxjckivlbkl', 'uyckuvilblk', 'JS2', '2017-07-14 13:06:49'),
(63, 'Olawale', 'Samuel', '062017', 'JS3', '2017-07-23 13:27:33'),
(64, 'Adewole', 'Samuel', '1111111', 'SS3', '2017-08-16 22:02:58'),
(65, 'Adekanle', 'Seun', 'SEUNKKK', 'SS3', '2017-08-26 08:42:15');

-- --------------------------------------------------------

--
-- Table structure for table `student_answers`
--

CREATE TABLE `student_answers` (
  `id` bigint(20) NOT NULL,
  `session_id` varchar(80) NOT NULL,
  `course_id` int(4) DEFAULT NULL,
  `question_id` bigint(100) DEFAULT NULL,
  `student_id` bigint(20) NOT NULL,
  `question` text NOT NULL,
  `option1` text NOT NULL,
  `option2` text NOT NULL,
  `option3` text NOT NULL,
  `option4` text NOT NULL,
  `answer_selected` text NOT NULL,
  `answer_true` text NOT NULL,
  `image_name` varchar(60) DEFAULT NULL,
  `instruction_id` int(4) DEFAULT NULL,
  `passage_id` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student_answers`
--

INSERT INTO `student_answers` (`id`, `session_id`, `course_id`, `question_id`, `student_id`, `question`, `option1`, `option2`, `option3`, `option4`, `answer_selected`, `answer_true`, `image_name`, `instruction_id`, `passage_id`) VALUES
(6, 'g2nr75mq3oglv780h41664quu2', 116, 11440, 65, '69dDrV9r4ymtGBPBIEbZnze5hsYtbxDq26kz5lRREgn2AgkauR0sn25fjwdAoDDLD4v1aB97pkKoZACQoTCFcIt/cViqL0vaLqdnyJSOqqo=', 'hVOchJ5l8c0zr3dUi5w1QHcxbDWZXhiIdY8YcrRl6PA=', '06z+J87o5golvd6KIJPt0DIRIsXx8UT1O3p8Zn/IAss=', 'bxKxOid59Gl5uoh2rz1ziGYiNDr5Y8X+jIMqv11O7bGmOARV9pmlMjLHQ/C9ZHHC', 'keg+SGcm8Nz33BLvjHWqp3xq0/Fdk7zFXc9mlysDrmQb1N8QxPgfFdGP57ANXIgF', 'hVOchJ5l8c0zr3dUi5w1QHcxbDWZXhiIdY8YcrRl6PA=', '06z+J87o5golvd6KIJPt0DIRIsXx8UT1O3p8Zn/IAss=', '', 76, NULL),
(7, 'g2nr75mq3oglv780h41664quu2', 116, 11445, 65, 'BQXS98eU/baks0aZA2vUZ82fExTI1hlUE1LoFHAXLYCDMLyzVV6MWm2t0tKfaK+bE//iC+Ky/ppwwxYGGSc6faiZBQyFhmbsHhYE8JG5Ai0=', 'v/HfQFYmvgPHqXuoeoQ9+geBh23wwEjM4adaE8Zdsbk=', 'Vj+sQMPh8UGq8rRFcnwdFSEJp1iMMwA3qaeLLC5YhMM=', 'QB1p94JjY/z82JnEGYU2GQAPOOOYRXkwxV/E214ERe4=', '2b9MZ0WY3i5KfxCYUX4GboBNRBVtzXUrREs5RVoegY8=', 'QB1p94JjY/z82JnEGYU2GQAPOOOYRXkwxV/E214ERe4=', '2b9MZ0WY3i5KfxCYUX4GboBNRBVtzXUrREs5RVoegY8=', '', 81, NULL),
(8, 'g2nr75mq3oglv780h41664quu2', 116, 11443, 65, '2VyXB95qUQpopLVtIFErNx3Un5c47t++p6mBwM70b2RLGJHeROg4Muhc4w1XorwO/CGUOgnulICVD4G//4uIeQ==', '7hIfHOEGlxV5xdkOX5lNDkUtgX61yfCdbCbc61Sobqk=', '+xR8E+ep3l7Z62uIeiGImnAB48oa08ABcRvQO7cs9pI=', 'ukjZnTMa58Px12ALncipeDG/00QHB88tERqoOH4qSoY=', 'XrWsltzl0GtBIv5/M7Ge28J+pujpSN5mIE4TdWPBN4g=', '+xR8E+ep3l7Z62uIeiGImnAB48oa08ABcRvQO7cs9pI=', '+xR8E+ep3l7Z62uIeiGImnAB48oa08ABcRvQO7cs9pI=', '', 79, NULL),
(9, 'g2nr75mq3oglv780h41664quu2', 116, 11441, 65, 'KYnYPhaM9bxGsMohgt7fE2GdjwpleUIfnFUy+GPyEhKi/c3X3NY2Jz461Cm3fJJ1AWGY+xDeYaD7D54b1lSzVg==', 'uKb7v63R4SZlnv7yqfPazEJB3ZSjA0Wbl168XMAEgv8=', 'gWj6znH+fMFmd3VaJrltP7SyhKl9+JuGHf/6SXF64os=', '+C1tmqe5/BN6yCTROEBqfV+R8DMjn+g3Sh/LIkBSoLE=', 'wDx/23NccscKvr26S0voWjwx9an+XG1narGTt13XXlg=', 'uKb7v63R4SZlnv7yqfPazEJB3ZSjA0Wbl168XMAEgv8=', 'uKb7v63R4SZlnv7yqfPazEJB3ZSjA0Wbl168XMAEgv8=', '', 77, NULL),
(10, 'g2nr75mq3oglv780h41664quu2', 69, 19227, 65, 'l6IDgpwdeLlkOSZVuN6S/l9/IyMBsjv88g/td5/pHOU=', 'L8BlUzjPPv3EQA/OnPlgbIwOEn+BzeLn15AAz1JU7YY=', 'D7SJgNlN1SUIp/dPYqt6pigaIO/2dewJvLKU2nycvVM=', 'pz+mhLPi46IEptinYHQOOYuwAcCgEOFPX+8rKKrQXJk=', 'CGU4/s5qIDA4cB8mDmC8ibn0rmqiwitHKS6ZhyZBlS8=', 'pz+mhLPi46IEptinYHQOOYuwAcCgEOFPX+8rKKrQXJk=', 'pz+mhLPi46IEptinYHQOOYuwAcCgEOFPX+8rKKrQXJk=', '', 188, NULL),
(11, 'g2nr75mq3oglv780h41664quu2', 69, 19222, 65, '6PphkETvH7p3aQmOChFmc+tlNObJrDuyEGd8YZGfR0haPpGuhRdqhHnpy2aMJebcIJiScTia5tnoqAJ6jvD1VXGUw2t+oY9WYL+sxxyjhoBBykMxeWbWqS26wb+IS5aP', 'mlvMU1rET9Gwcry5KA5echjJhjIONTxUAVXvq7FVAGk=', 'xb/65RMu2nkYgsYYXGMGJ00YfbMdv6srykO7WbdFAPs=', 'Z8/W1xmye8BCO+pyahFuVhttguQyjpqHDNWIeso8P1k=', 'LBwZdVD4X0jK2lBEJWs20WwrTxIkJzSQT4qOWP1+U/w=', 'LBwZdVD4X0jK2lBEJWs20WwrTxIkJzSQT4qOWP1+U/w=', 'LBwZdVD4X0jK2lBEJWs20WwrTxIkJzSQT4qOWP1+U/w=', '', 183, NULL),
(12, 'g2nr75mq3oglv780h41664quu2', 69, 11436, 65, '7oSVXx/2fvRimW4AgFftKJw29wI5ztOy8yVU010z6m2rdSZSaaPQbo4OyNvQZpp/A+cGXGJOhg3YCqmqliBB6AQtwkAEt3lSGptg2sdgwtc6KFn/JG1CzVDfzJuX83lb', '0gwf/oTHOU8qFTt0itusF4QbzwhRitu3jrIwlf/1xhjDbt1RpKmko5DACpDA8al1', 'wuIZx/iyFwzh07zkRi+S+4RenUIDOj1c4qLq31ahXrsVMH5T2jIluQ+b9zO8liM6', 'zjKJ8AbLOm7RF3Lg9/u58VetjGphTlrzDTCeFo6yHf0=', 'biufdyKxbAGpKQDAzHnjXc1Yca5nOMhN6GEJ+hj1wMY=', 'biufdyKxbAGpKQDAzHnjXc1Yca5nOMhN6GEJ+hj1wMY=', 'zjKJ8AbLOm7RF3Lg9/u58VetjGphTlrzDTCeFo6yHf0=', '', 72, 6),
(13, 'g2nr75mq3oglv780h41664quu2', 69, 19213, 65, 'VN1F7fgzKammx5q5xaPB4+X58h7kqF/46BPX1omaDZQJxHj8QmwE7Ve5zvqMtGRTGNz20FKdc5FNlSFGJdJqcVDF8uthJ5OsaiFh4ECTHcej8flRooQ+qQKBMz1vzhzEHEjhs7xCd671iUWyCamVNg==', 'x2RKDr/cYk6BVcehddWiz4UctgEiuFf4zW7Z6favyNA=', 'geSbIhCM2WAIUgXQ0UBGPhEu8Pp7cfSR2HMUFXLBXQA=', 'JVtQsQcmwnMT0OEpsGLWmTwEHQbCCsTCXIQz+gT0zlg=', 'mcmuDuZm+tG8w1Rog+bjm21xyEySTsk6JCSdPqXHvHY=', 'mcmuDuZm+tG8w1Rog+bjm21xyEySTsk6JCSdPqXHvHY=', 'mcmuDuZm+tG8w1Rog+bjm21xyEySTsk6JCSdPqXHvHY=', '', 174, 20),
(14, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11460, 65, 'r2dubDyKLAsMzqGP5x1VoB3nXiWzcdOH6prTktXt4Cc7OQFKnu7+q1XuUY5R20gy2+Ru9kx0hq75Jt4hO3bb/BI9AI3kB9yw40YmDy8rRqC2SQ2XliYMYO5WrtpI1s2L8HGseD6CX9Tdop8JrBRG49GmmmOT9H8qrgBd8gLditXxOMv4q+sWxxDbaOutlC7x', 'B0aQ/Jf8sRAslUvHi/fjzcIQ3jeLo3pxhr209EtyUN8=', 'P4WS7dPPGHQsvNRgEDJRWhELOQliwahr2Bf36rK5q04=', '/oqDSE44suG/Znq/Hv1gi/VRI3TE9dYLY4YMfA931Kw=', 'xpmViRraKZZQXRSoMgneaG3WSpfUQWQN0g31EVCdjIM=', 'P4WS7dPPGHQsvNRgEDJRWhELOQliwahr2Bf36rK5q04=', 'P4WS7dPPGHQsvNRgEDJRWhELOQliwahr2Bf36rK5q04=', '', 96, NULL),
(15, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11459, 65, 'TobqT1LCEYKsBeLd5/Snyysl8nX4hzVvXSjh1iIwSCVEIfyz3VuWy8j5YIc5dEcHYqsqsEP0YBRQPDPs7hfvzwU/uJGG1HXgop/MnJVEDFE=', 'v6cW0idYAVimzVbIxLFfilEK2H40kNoifnsLbrKfumBjICRc/nqW0u0zY5idL3tGY2DnZVlkoerKNPEsD0t4ag==', 'iyvkhYDhLSGt/QFHmienXvKbpNWQHHmXbDnQmC+jjpFmNsM3shcgax2Ov9JErWP4kNMdUHdVwTLSy60d/rBe7w==', 'EigitN1M0I+A9qoTgs73qFueUJ9MSr+FakRilFaZtHsyepJNdwULV8xn+7nowrsEwlkaYRCFHsOii5Bdm34WWw==', '7PuAOEYmjCiXduNiaJTPTSsZSjPKZtIkXW2LI9oEATlO6n9a8y1ywZ3biewPTxk7T7teQSeSD0pyjG5UWnSSkA==', 'v6cW0idYAVimzVbIxLFfilEK2H40kNoifnsLbrKfumBjICRc/nqW0u0zY5idL3tGY2DnZVlkoerKNPEsD0t4ag==', 'EigitN1M0I+A9qoTgs73qFueUJ9MSr+FakRilFaZtHsyepJNdwULV8xn+7nowrsEwlkaYRCFHsOii5Bdm34WWw==', '', 95, NULL),
(16, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11451, 65, 'AuCYuKSx+9Qrw7b2XABRxt10DGOm7G7pIiF2JZkDPipvDvNhqpZUAR5qTNStfIrhzL9a10+W6ZHSAGWexGD9sx1xJefMv6Avb0JNAmrMJSV2syzFkk9tNjA7FAAtGpv8G2MhMX300rjRqXIJGL7dBGrxT+v4CT91JO3ds6ECJ5M=', 'Kc8K2NA00WobmrC/0Oovg8J1FLprXtnf8idJ6/YFiHI=', 'MR5bWtsXh17q0YroJDXsoNa9ao6oo7jD++e4NQ/5tUo=', 'OoxV3B5nqnPG4zhv+uiEeaRDmyWDmsfacQYG1fFVJcw=', '0aq2rboacLgm6SHo3gRS5c0vc4zhb5YZzqHap+KC+eo=', 'MR5bWtsXh17q0YroJDXsoNa9ao6oo7jD++e4NQ/5tUo=', 'MR5bWtsXh17q0YroJDXsoNa9ao6oo7jD++e4NQ/5tUo=', '', 87, NULL),
(17, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11456, 65, 'MSGmHrS+pM5ZE4mKB6f6mSgXJnUhZHaUgjz4AdJlTmkDAsjm6NsYY/wTOR6NjoWsaAQ3ubDmXduHA5uOwWrlbbqZr2oF9HCbKz2pCebXm2PKbKZ6+eVr1kt9w2wBaGoLzOiQEIrjTdo/W0lqxp4nIkvuzk8OGRzoDRBZFdCxVz3h1tdC9Id9romj8vnwsZVqyuWWeo2LETYJWtwmVf3sVdiNeJIrIkmdgXaYmFrVbMwuQ4MzqdLn1y1X5HjiB6Opry3V7jEoQ/6Rh+n653WmYA4GpeVOKeGaIQf0qYA7Y5TOUFZ2jkAuLsXMIwJpG/j5', '48dDe4Q7sJFnBiJTc7BCCZka7leMPO/gRTsrLNx4Kn0=', '1LUDr+HE+gJwbDlAaDJlscXMX3fmTQeOTTPqYCtksIY=', 'T0QotfmpD+1GR1qxHKO0SVHRPMUiO4kxW6iLPU5p4wk=', 'EEI3eSdEqe0gvMEu4TUngWXK+PYPb6qzQS6vsm+rAqU=', 'EEI3eSdEqe0gvMEu4TUngWXK+PYPb6qzQS6vsm+rAqU=', 'T0QotfmpD+1GR1qxHKO0SVHRPMUiO4kxW6iLPU5p4wk=', '', 92, NULL),
(18, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11458, 65, 'rG9TTU0w05U3cSFw0jlkp6BraJcIazF/kQMIwVL1KoxIJNi9sz0FdIm0ZII+R/Oi9UzlKs+WLKXweYRfMmVbb5wUs6M/2JNn9KDghRUd9Hj3qfXk3gnlbqRsaeQbou4KWZdA1hOlHSfXPdiSIJO5cA==', 'P5V4DTR6LNgynm33oQtlM9Xq2usLhHZDTck4E8dd6Qs=', 'Mpr8rHqj5PyMrBtgz7zFnkHw8nkQoViwu7UOoYC+1L8=', 'LVyOAQuTnE9T6ZjPbGepTcsEDGspx+Uflf2tLWQcGXY=', 'aka50fRZk5soy5vYbaX4UZ1SRypGBH3S6Y+d3QcRBpo=', 'P5V4DTR6LNgynm33oQtlM9Xq2usLhHZDTck4E8dd6Qs=', 'Mpr8rHqj5PyMrBtgz7zFnkHw8nkQoViwu7UOoYC+1L8=', '', 94, NULL),
(19, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11450, 65, 'UwpmWfGUeTS7yOs7+A7FmCnlBwIsc+cWDNtqF/di5VunIVA3PMcgEOmAb6BFuilgy4StheyrtIpExXkHWwzX5mUCktiytzReTZF+rDG1v9ktgzxsEVAiBmBQ7l8NhW3dLPsfnJ5RFhgddtyNI0dH6Uzsh6qg9f5X6muvFzwQjfzgYSkI0LirksBCNPfB92VWstBq7HvVL/LsX56pwqhbUGzJeisxUDCBYbjx7rcyjEJUQUDZa5ElXutCgsYwKwhTHfAfclSkZyPDdlR8K+I7bIET//2i3eyEWEozrMGjKOTUGhPO/waMLWeu9TIIQJS75iEEZl6F6WynJoUITBVuv5sv4nuBsT/F5kCovYKO8do=', 'C+9xYzEizKUDfQeUx2spWj7y4dMHrXZ+6sKPQTzBAr61rtG2dnLKhWTxIapdSvRg', 'SdG6nMwbw4QdLMy6gHDcZZJmiDRWrHYnggPbuc+VzKyjBfUl6xlfxLGbBrlwEzlu', 'vsx8LiGrsjxv8go47w2HSapfZJUBxt/Xlbx2VwE1XcOvluvoN5CTlBlazEXzVOVD', 'bd+1GC3Tmsv40b4OGEErBednfd2gQu/0BBto6lV8Qes9A94tFkb1BfaFd8lBJb5F', 'C+9xYzEizKUDfQeUx2spWj7y4dMHrXZ+6sKPQTzBAr61rtG2dnLKhWTxIapdSvRg', 'C+9xYzEizKUDfQeUx2spWj7y4dMHrXZ+6sKPQTzBAr61rtG2dnLKhWTxIapdSvRg', '', 86, NULL),
(20, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11455, 65, 'IcJ78hxrHgmxIl/DSPFl6YmY/I2Jp/muqe0C65fDgox3dpiSGr5UWXJtRtyWaYWTV80UwS1gVeOwc7tVS2SYij7WMIMyKho2ZMHtA6tgb8SjN2NEvWlVT5xIPzfzBuKtW2Zv81Kjp5i50EUnx8n5g8CcMk6zkcxwgbBcAIo+qQlXPUBOk0SY2nMTlJze7sk5s6qWpZdMWeEVwj0Bu61wPMh0ujn6rQnVzIT/ckkOMeNM7lAxURrFabqkqQqDBbF6pLQvoECbFwqFA65zio8ruLtXvmTlPYxzxn8H+FTN46frzw0YVFmRTUSwdDdQQOYguvOFPO6SNElKH8E4IB9EMVtXsxpbsVg4EG/lqfrYa/oNA13ewN65KImH4Q9udHDFwc1/Chp7BHLiNCHVk88GLWi9GmgKopzaxR7wbexwdWThWiPwoANGIMP7z3nTdEcOES5V9mWAkkIhqOpRlKhmmEiX6qLf67svyQsROUeHrHA=', 'HPDHeuo9H5UUWNMT/ksOvfqsNvM5mhsy22n8BH1sk5Y=', 'kp112jhYMjPWAuwQ1qLNN3McyquxC/o39AV2sy9rHvM=', 'dv504RrufwHWbqhDFYUXcfigV0sqzWX24fL9DewCX6U=', 'vLty0TYa4y9pJxLPvesmeyoZ3+3W5bdEpuxe0kxWaes=', 'vLty0TYa4y9pJxLPvesmeyoZ3+3W5bdEpuxe0kxWaes=', 'dv504RrufwHWbqhDFYUXcfigV0sqzWX24fL9DewCX6U=', '', 91, NULL),
(21, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11452, 65, 'Dgc1hFbokzvktlsSYLj0EKxM3ZJ6GmpRvnfbVK3IKDWfRLYPOHN3bfHPoSB1kf+uAQAsDu8WwdvywtDMhY7Rijr9QNNE4DOLIEMuCAcVnkIQqFt9qQc2GeoPQvdEHXbkpSc3IY/JOlQykrxOcNKwTg==', 'ApA6wsSVA0wtZJTU4khYZLX4ivirb1MGMZjNedyNbwM=', '7n7aTyDo4E4WvtDseUcSMz7J95/2jdCsEbbdd6tK7CEIvOu6BjGpFpTFQ3HlRYrI', 'ckyMqKkVqVVFaE/C7o/m9adzBW2vQQnCyNSBXUKEwpYcKpuzDjDc9Ce4Pm0t6UOQ', 'zlJXeYv4ClVNSuUPvI9TsaNZVc3t0LFYM4RpH/nc40Zp/MwIDDP3yIChE3k2s8HS', 'zlJXeYv4ClVNSuUPvI9TsaNZVc3t0LFYM4RpH/nc40Zp/MwIDDP3yIChE3k2s8HS', '7n7aTyDo4E4WvtDseUcSMz7J95/2jdCsEbbdd6tK7CEIvOu6BjGpFpTFQ3HlRYrI', '', 88, NULL),
(22, 'p71kmlccp0nfol486b1lqn2lm2', 122, 11457, 65, 'gu/rub/nsuQxsaAmnTQ+JQ+zCyiQXaWGen8X1UO4yEr0ndfssB+yITt9D5sebFRfGfQ669XSTAlPyJNkhy9gWSUXfgjlhaWcSUIxpwXwI8s=', 'gT4A6sddjv7AzsOnNXoqjs9MDbEfGxGC7+WvX5+OtKk=', 'bcbG2jGcIzTIY0fD+wW6MEnFqURMjzZGjDMcAin6Bxk=', 'bp89Qq1htacBVTWCMGJFe/QIh7tyTuFEfNSwed1x3Zs=', 'EuaFotPyMMGIkMK2+afDKiNgMMCpjfKEYiEQF1HidM8=', 'bp89Qq1htacBVTWCMGJFe/QIh7tyTuFEfNSwed1x3Zs=', 'gT4A6sddjv7AzsOnNXoqjs9MDbEfGxGC7+WvX5+OtKk=', '', 93, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_results`
--

CREATE TABLE `student_results` (
  `id` bigint(100) NOT NULL,
  `course_id` int(4) DEFAULT NULL,
  `student_id` bigint(20) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `score` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_results`
--

INSERT INTO `student_results` (`id`, `course_id`, `student_id`, `date_created`, `score`) VALUES
(846, 116, 65, '2017-08-26 11:48:52', 2),
(847, 69, 65, '2017-08-26 11:51:08', 3),
(848, 122, 65, '2017-08-26 12:30:04', 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `surname` varchar(35) CHARACTER SET utf8 NOT NULL,
  `matricno` varchar(15) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `surname`, `matricno`) VALUES
(1061, 'Oni', 'FDV/12/1234'),
(1062, 'manager', 'revelation1'),
(1063, 'schoolmanager', 'genesis'),
(1064, 'schoolmanager', 'genesist'),
(1065, 'hsvoenej', '1'),
(1066, 'knogaydh', '1'),
(1067, 'vnrghhre', '1'),
(1068, 'mavitech', 'revelation7'),
(1069, 'mavitech', 'revelation0'),
(1070, 'mavitech', 'revelation0'),
(1071, 'mavitech', 'revelation5'),
(1072, 'schoolmanager', 'genesis'),
(1073, 'schooladmin', 'revelation1'),
(1074, 'schooladmin', 'revelation4'),
(1075, 'schooladmin', 'revelation5'),
(1076, 'schooladmin', 'revelation3'),
(1077, 'schooladmin', 'revelation2'),
(1078, 'schooladmin', 'revelatioo9'),
(1079, 'schooladmin', 'revelatiok5'),
(1080, 'schooladmin', 'revelations2'),
(1081, 'schooladmin', 'revelationl4'),
(1082, 'schooladmin', 'revelationu7'),
(1083, 'schooladmin', 'revelatioo4'),
(1084, 'schooladmin', 'revelation1khbv'),
(1085, 'schooladmin', 'revelation1ds'),
(1086, 'schooladmin', 'revelation1ry'),
(1087, 'schooladmin', 'revelation1ethw'),
(1088, 'schooladmin', 'revelation1e'),
(1089, 'schooladmin', 'revelation1w'),
(1090, 'schoolmanager', 'genesis'),
(1091, 'Oni', 'CSC/11/1111'),
(1092, 'schoolmanager', 'genesis4'),
(1093, 'mavitech', 'revelation13'),
(1094, 'mavitech', 'khgcudoyi34'),
(1095, 'alese2017', 'revelation1hy'),
(1096, 'mavitech', 'revelation1hlhk'),
(1097, 'alese2017', 'revelation1vmn'),
(1098, 'Oni', 'cukylkfgcyulivU'),
(1099, 'Oni', 'hgfjgkhlhy6787'),
(1100, ';iuvil', 'hliuyfjgkhlk'),
(1101, 'schoolmanager', 'revelatig54'),
(1102, 'schoolmanager', 'revela3562'),
(1103, 'schoolmanager', 'revelati754'),
(1104, 'alpha', 'adminmx,,x'),
(1105, 'khijlkh', 'khb ijb90-90'),
(1106, 'schoolmanager', 'managerjgbmb2'),
(1107, 'schoolmanager', 'managerhvkhblj'),
(1108, 'schoolmanager', 'managerf33'),
(1109, 'schoolmanager', 'managerjkhkj'),
(1110, 'schoolmanager', 'manager2w'),
(1111, 'schoolmanager', 'managern'),
(1112, 'schoolmanager', 'managerbm,'),
(1113, 'schoolmanager', 'managerfl'),
(1114, 'ifgoh', 'englk45'),
(1115, 'Oni', 'sdfc34rf'),
(1116, 'iefbol', 'whikj3hibjl'),
(1117, 'vkkjhlk', 'hbvii478'),
(1118, 'mavite', 'revelatio'),
(1119, 'mavit', 'revelat'),
(1120, 'fjfjfj', 'fjjfjf'),
(1121, 'schoolmanager', 'manager'),
(1122, 'schoolmanager', 'CSC121025'),
(1123, 'schoolmanager', 'CHE127468'),
(1124, 'Oni', 'CBG125643'),
(1125, 'schoolmanager', 'CBG125643'),
(1126, 'schoolmanager', 'CBG125643'),
(1127, 'schoolmanager', 'CBG1256436'),
(1128, 'schoolmanager', 'CBG1256435'),
(1129, 'schoolmanager', 'khgc8794'),
(1130, 'schoolmanager', 'CBG125643'),
(1131, 'schoolmanager', '1234567'),
(1132, 'oni', '1234567'),
(1133, 'schoolmanager', '1234567'),
(1134, 'jhjlk', 'CSC121025'),
(1135, 'Gbenga', 'CSC121025'),
(1136, 'Adeseko', '1234567'),
(1137, 'Adeseko', '12345'),
(1138, 'Oni', '12345'),
(1139, 'gghik', 'csc120999'),
(1140, 'Komolafe', '12345'),
(1141, 'Komolafe', '1234567'),
(1142, 'Komolafe', '12345'),
(1143, 'Oni', 'CSC121025'),
(1144, 'Oni', '12345'),
(1145, 'Daramola', '654321'),
(1146, 'jiyuty', '654321'),
(1147, 'ouig', '12345'),
(1148, 'kiutyf', '12345'),
(1149, 'Head', '12345'),
(1150, 'gbenga', '1234567'),
(1151, 'Oni', '061995'),
(1152, 'Oni', '061995'),
(1153, 'Oni', '061995'),
(1154, 'Oni', '061995'),
(1155, 'Oni', '061995'),
(1156, 'Oni', '061995'),
(1157, 'Oni', '061995'),
(1158, 'Oni', '061995'),
(1159, 'Oni', '061995'),
(1160, 'Oni', '061995'),
(1161, 'Oni', '061995'),
(1162, 'iohu', '061995'),
(1163, 'Oni', '061995'),
(1164, 'Oni', '061995'),
(1165, 'Oni', '061995'),
(1166, 'ouvojl', '061995'),
(1167, 'Oni', '061995'),
(1168, 'Oni', '061995'),
(1169, 'Oofjdg', '061995'),
(1170, 'Oni', '061995'),
(1171, 'Oni', '061995'),
(1172, 'Oni', '061995'),
(1173, 'Oni', '061995'),
(1174, 'Oni', '061995'),
(1175, 'Oni', '061995'),
(1176, 'yurjkf', '061995'),
(1177, 'Oni', '061995'),
(1178, 'xjykfjgfjh', '061995'),
(1179, 'Oni', '061995'),
(1180, 'luiyutl', '061995'),
(1181, 'Oni', '061995'),
(1182, 'Oni', '061995'),
(1183, 'Oni', '061995'),
(1184, 'Oni', '061995'),
(1185, 'Oni', '061995'),
(1186, 'Gbenga', '061995'),
(1187, 'Oni', '061995'),
(1188, 'Oni', '061995'),
(1189, 'Oni', '061995'),
(1190, 'Gbenga', '061995'),
(1191, 'Oni', '061995'),
(1192, 'oni', '061995'),
(1193, 'Gbenga', '061995'),
(1194, 'Oni', '061995'),
(1195, 'Daniel', '061990'),
(1196, 'ouiytryukj', '345678'),
(1197, 'Daniel', '345678'),
(1198, 'Owolabi', 'esquivell'),
(1199, 'Gbenga', 'esquivell'),
(1200, 'iruityiu', 'esquivell'),
(1201, 'iyid6uitufyiu', 'esquivell'),
(1202, 'Oni', 'esquivell'),
(1203, 'hufjkguil', 'esquivell'),
(1204, 'uid6utfiuil', 'esquivell'),
(1205, 'urueysuryuli', 'esquivell'),
(1206, 'Gbenga', 'esquivell'),
(1207, 'lcgjvkjlbk', 'esquivell'),
(1208, 'jykutyjx,', 'esquivell'),
(1209, 'Oni', '122017'),
(1210, 'Gbenga', '122017'),
(1211, 'Oni', '122017'),
(1212, 'tdj,m', '062017'),
(1213, 'michael', '062017'),
(1214, 'ASdf', '1111111'),
(1215, 'mavitech', 'revelation1'),
(1216, 'Adesona', 'CV23E4FG6'),
(1217, 'Wale-Doyin', 'VFBGR44W2'),
(1218, 'Adekanle', 'SEUNKKK'),
(1219, 'Seun', 'seunkkk'),
(1220, 'Gbenga', 'seunkkk');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `instructions`
--
ALTER TABLE `instructions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `passage`
--
ALTER TABLE `passage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_idd` (`course_id`);

--
-- Indexes for table `school`
--
ALTER TABLE `school`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_answers`
--
ALTER TABLE `student_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `course_id_2` (`course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `student_results`
--
ALTER TABLE `student_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;
--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10063;
--
-- AUTO_INCREMENT for table `instructions`
--
ALTER TABLE `instructions`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;
--
-- AUTO_INCREMENT for table `passage`
--
ALTER TABLE `passage`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19236;
--
-- AUTO_INCREMENT for table `school`
--
ALTER TABLE `school`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
--
-- AUTO_INCREMENT for table `student_answers`
--
ALTER TABLE `student_answers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `student_results`
--
ALTER TABLE `student_results`
  MODIFY `id` bigint(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=849;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1221;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `course_idd` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_answers`
--
ALTER TABLE `student_answers`
  ADD CONSTRAINT `question_id` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `student_answers_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
