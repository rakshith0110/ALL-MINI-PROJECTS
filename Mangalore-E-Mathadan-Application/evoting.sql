-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2015 at 11:05 AM
-- Server version: 5.5.39
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- Database: `evoting`

-- Table structure for table `tbl_admin`
CREATE TABLE IF NOT EXISTS `tbl_admin` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `admin_username` varchar(30) NOT NULL,
  `admin_password` varchar(30) NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- Dumping data for table `tbl_admin`
INSERT INTO `tbl_admin` (`aid`, `admin_username`, `admin_password`, `time_stamp`) VALUES
(1, 'admin', '_admin', '2015-05-04 14:33:17');

-- Table structure for table `tbl_users`
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `full_name` varchar(32) NOT NULL,
  `email` varchar(32) NOT NULL,
  `voter_id` int(10) NOT NULL,
  `voted_for` varchar(32),
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`voter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Inserting values into tbl_users with default passwords
INSERT INTO `tbl_users` (`full_name`, `email`, `voter_id`, `voted_for`, `password`) VALUES
('Abhishek Kumar Ravi', 'don.coolbuddy.xxx@gmail.com', 546754, 'BJP', 'password1'),
('Chadan', 'chabdan@gmail.com', 65786, 'BJP', 'password2'),
('Aman', 'aman@live.in', 896740, 'BJP', 'password3'),
('Vicky', 'lastworker@gmail.com', 45432, 'BJP', 'password4'),
('Abhishek Singh', 'abhi6751@gmail.com', 87430, 'BJP', 'password5'),
('Avneet', 'avneet@gmail.com', 74629, 'INC', 'password6'),
('Santanu', 'santa@gmail.com', 89378, 'BSP', 'password7'),
('Arvind Kejriwal', 'arvind@gmail.com', 94940, 'UPP', 'password8'),
('Manish Sisodia', 'manish@live.in', 6483, 'UPP', 'password9'),
('Rahul Raju', 'rahulraj@hmail.com', 9749403, 'INC', 'password10'),
('Subham Kumar', 'subham@gmail.com', 95678, 'UPP', 'password11'),
('Chadan', 'chabdan@gmail.com', 5, 'BJP', 'password12'),
('Abhishek Singh', 'abhi6751@gmail.com', 12345, 'BSP', 'password13'),
('Abhishek Kumar', 'ak@gmail.com', 1234, 'BSP', 'password14');

-- Table structure for table `tbl_candidates`
CREATE TABLE IF NOT EXISTS tbl_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    party_affiliation VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    more_details_url VARCHAR(255) NOT NULL
);
INSERT INTO tbl_candidates (name, party_affiliation, image_url, more_details_url) 
VALUES 
('Brijesh Chowta', 'BJP', 'images/brijesh.jpg', 'https://www.myneta.info/LokSabha2024/candidate.php?candidate_id=1889'),
('Padmaraj R Poojary', 'INC', 'images/pamaraj.jpg', 'https://www.myneta.info/LokSabha2024/candidate.php?candidate_id=2345'),
('Prajaakeeya Manohara', 'UPP', 'images/manohar.jpg', 'https://www.myneta.info/LokSabha2024/candidate.php?candidate_id=2052'),
('Kanthappa Alangar', 'BSP', 'images/Kanthappa.jpg', 'https://www.myneta.info/LokSabha2024/candidate.php?candidate_id=2636');


-- Create tbl_party_logos table
CREATE TABLE IF NOT EXISTS tbl_party_logos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    party_name VARCHAR(255) NOT NULL,
    logo_url VARCHAR(255) NOT NULL
);

-- Insert sample values for party logos
INSERT INTO tbl_party_logos (party_name, logo_url) VALUES
('Bharatiya Janata Party', 'images/BJPLOGO.jpeg'),
('Indian National Congress', 'images/INCLOGO.jpg'),
('Uttama Prajaakeeya Party', 'images/UPPLOGO.png'),
('Bahujan Samaj Party', 'images/BSPLOGO.jpeg');
