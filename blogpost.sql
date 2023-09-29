-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 29, 2023 at 04:41 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blogpost`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `mes` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone`, `mes`, `date`) VALUES
(1, 'first post', 'firstpost@gmail.com', '123456789', 'first post', '2023-09-21 20:56:34'),
(2, 'abc', 'email@gmail.com', '8456789654', 'hi', '2023-09-21 22:15:27'),
(3, 'abc', 'email@gmail.com', '8456789654', 'second post', '2023-09-21 22:21:51');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(50) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'This is my first post title', 'This is first pos', 'first-post', 'A blog (a truncation of \"weblog\") is an informational webpage published on the World Wide Web consisting of discrete, often informal diary-style text entries (posts). Posts are typically displayed in reverse chronological order so that the most recent post appears first, at the top of the web page. Until 2009, blogs were usually the work of a single individual,[citation needed] occasionally of a small group, and often covered a single subject or topic. In the 2010s, \"multi-author blogs\" (MABs) emerged, featuring the writing of multiple authors and sometimes professionally edited. MABs from newspapers, other media outlets, universities, think tanks, advocacy groups, and similar institutions account for an increasing quantity of blog traffic. The rise of Twitter and other \"microblogging\" systems helps integrate MABs and single-author blogs into the news media. Blog can also be used as a verb, meaning to maintain or add content to a blog.\r\n\r\nThe emergence and growth of blogs in the late 1990s coincided with the advent of web publishing tools that facilitated the posting of content by non-technical users who did not have much experience with HTML or computer programming. Previously, knowledge of such technologies as HTML and File Transfer Protocol had been required to publish content on the Web, and early Web users therefore tended to be hackers and computer enthusiasts. As of the 2010s, the majority are interactive Web 2.0 websites, allowing visitors to leave online comments, and it is this interactivity that distinguishes them from other static websites.[2] In that sense, blogging can be seen as a form of social networking service. Indeed, bloggers not only produce content to post on their blogs but also often build social relations with their readers and other bloggers.[3] Blog owners or authors often moderate and filter online comments to remove hate speech or other offensive content. There are also high-readership blogs which do not allow comments.', 'post-bg.jpg', '2023-09-27 22:31:49'),
(2, 'This is second post', '2nd post', 'second-post', 'Before blogging became popular, digital communities took many forms, including Usenet, commercial online services such as GEnie, Byte Information Exchange (BIX) and the early CompuServe, e-mail lists,[10] and Bulletin Board Systems (BBS). In the 1990s, Internet forum software created running conversations with \"threads\". Threads are topical connections between messages on a virtual \"corkboard\".[further explanation needed]\r\n\r\nBerners-Lee also created what is considered by Encyclopedia Britannica to be \"the first \'blog\'\" in 1992 to discuss the progress made on creating the World Wide Web and software used for it.[11]\r\n\r\nFrom June 14, 1993, Mosaic Communications Corporation maintained their \"What\'s New\"[12] list of new websites, updated daily and archived monthly. The page was accessible by a special \"What\'s New\" button in the Mosaic web browser.\r\n\r\nThe earliest instance of a commercial blog was on the first business to consumer Web site created in 1995 by Ty, Inc., which featured a blog in a section called \"Online Diary\". The entries were maintained by featured Beanie Babies that were voted for monthly by Web site visitors.[13]\r\n\r\nThe modern blog evolved from the online diary where people would keep a running account of the events in their personal lives. Most such writers called themselves diarists, journalists, or journalers. Justin Hall, who began personal blogging in 1994 while a student at Swarthmore College, is generally recognized as one of the earlier bloggers,[14] as is Jerry Pournelle.[15] Dave Winer\'s Scripting News is also credited with being one of the older and longer running weblogs.[16][17] The Australian Netguide magazine maintained the Daily Net News[18] on their web site from 1996. Daily Net News ran links and daily reviews of new websites, mostly in Australia.', 'post-bg.jpg', '2023-09-24 16:50:10'),
(3, 'This is the new post', 'niceu', 'first-post', 'wawqagwaegfqwegtqwgfqgqwg q qw2 gtq2wt4egttq2w4egt 2qw4e 2qw 2qw g2wq4 gaw3hy43wah 34wh34wh3w4 ah3w4a h4w3a h4w3a h4y2w 22w rwa wrra grw jertr yrtk t7yk jty7 jr yjr jkr yj ry jry jr ysjs4rj3e4a5uj haeu4 jhea4 hjea4 jhe4a ujhe4utj esjuuutjhgfgdhg nbgfn bdgfbngds edsh tedshb', 'img.jpg', '2023-09-27 22:21:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
