-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 15, 2025 at 07:09 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drug_notify`
--

-- --------------------------------------------------------

--
-- Table structure for table `d_categories`
--

CREATE TABLE `d_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_th` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `description_th` text DEFAULT NULL,
  `description_en` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `d_categories`
--

INSERT INTO `d_categories` (`id`, `name_th`, `name_en`, `description_th`, `description_en`) VALUES
(1, 'ยาแก้ปวด', 'Pain reliever', 'ยาที่ใช้บรรเทาอาการปวด', 'Medicines used to relieve pain'),
(2, 'ยาลดไข้', 'Antipyretic medicine', 'ยาที่ช่วยลดอุณหภูมิร่างกาย', 'Medicines that reduce body temperature'),
(3, 'ยาแก้แพ้', 'Antihistamines', 'ยาสำหรับอาการภูมิแพ้', 'Medicine for allergy symptoms'),
(4, 'ยาฆ่าเชื้อ', 'Disinfectant', 'ยาที่ใช้รักษาการติดเชื้อแบคทีเรีย', 'Medicines used to treat bacterial infections'),
(5, 'วิตามินและเกลือแร่', 'Vitamins and minerals', 'ยาที่ใช้เสริมสุขภาพ', 'Medicines used to enhance health'),
(6, 'ยาโรคกระเพาะ', 'Gastritis medicine', 'ยาสำหรับโรคกระเพาะ กรดไหลย้อน', 'Medicine for gastritis, acid reflux'),
(7, 'ยาเฉพาะทาง', 'Specialized medicine', 'ยาสำหรับรักษาอาการเฉพาะเจาะจง', 'Drugs for specific symptom treatment');

-- --------------------------------------------------------

--
-- Table structure for table `d_medications`
--

CREATE TABLE `d_medications` (
  `id` int(11) NOT NULL,
  `name_th` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `description_th` text NOT NULL,
  `description_en` text NOT NULL,
  `common_usage_th` text NOT NULL,
  `common_usage_en` text NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `d_medications`
--

INSERT INTO `d_medications` (`id`, `name_th`, `name_en`, `description_th`, `description_en`, `common_usage_th`, `common_usage_en`, `category_id`) VALUES
(1, 'อัลปราโซแลม', 'Alprazolam', 'บรรเทาอาการนอนไม่หลับ', 'Alleviates insomnia', 'ทานก่อนนอน', 'Take before bedtime', 1),
(2, 'แคลเซียมคาร์บอเนต', 'Calcium Carbonate', 'เสริมแคลเซียม', 'Calcium supplement', 'ทานพร้อมอาหาร', 'Take with food', 5),
(3, 'ซัลบูทามอล', 'Salbutamol', 'บรรเทาอาการหอบ', 'Relieves asthma symptoms', 'ทานหรือสูดตามคำแนะนำ', 'Take or inhale as directed', 3),
(4, 'โซเดียมคลอไรด์', 'Sodium Chloride', 'ล้างแผล/ทำความสะอาด', 'Wound cleaning', 'ใช้ภายนอก', 'For external use', 4),
(5, 'คีโตโคนาโซล', 'Ketoconazole', 'รักษาเชื้อราผิวหนัง', 'Treats skin fungal infections', 'ใช้ทาภายนอก', 'For external application', 4),
(6, 'ทรามาดอล', 'Tramadol', 'บรรเทาอาการปวดรุนแรง', 'Relieves severe pain', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 1),
(7, 'บัสโคแปน', 'Buscopan', 'แก้ปวดเกร็งท้อง', 'Relieves stomach cramps', 'ทานเมื่อมีอาการ', 'Take when symptoms occur', 1),
(8, 'ฟลูโคนาโซล', 'Fluconazole', 'รักษาเชื้อราภายใน', 'Treats internal fungal infections', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(9, 'ด็อกซี่ไซคลิน', 'Doxycycline', 'ยาฆ่าเชื้อแบคทีเรีย', 'Antibiotic', 'ทานวันละ 1 ครั้ง', 'Take once daily', 4),
(10, 'ไซโปรฟลอกซาซิน', 'Ciprofloxacin', 'รักษาอาการติดเชื้อแบคทีเรีย', 'Treats bacterial infections', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(11, 'แคลไดทรอล', 'Calcitriol', 'เสริมวิตามินดี', 'Vitamin D supplement', 'ทานพร้อมอาหาร', 'Take with food', 5),
(12, 'รานิทิดีน', 'Ranitidine', 'บรรเทาอาการกรดไหลย้อน', 'Relieves acid reflux', 'ทานก่อนอาหาร', 'Take before meals', 6),
(13, 'เฟอร์รัสซัลเฟต', 'Ferrous Sulfate', 'เสริมธาตุเหล็ก', 'Iron supplement', 'ทานพร้อมน้ำผลไม้', 'Take with fruit juice', 5),
(14, 'แอมพิซิลลิน', 'Ampicillin', 'ยาฆ่าเชื้อแบคทีเรีย', 'Antibiotic', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(15, 'โคลชิซีน', 'Colchicine', 'รักษาโรคเก๊าท์', 'Treats gout', 'ทานหลังอาหาร', 'Take after meals', 7),
(16, 'คลาร์ริโทรมัยซิน', 'Clarithromycin', 'ยาฆ่าเชื้อแบคทีเรีย', 'Antibiotic', 'ทานวันละ 2 ครั้ง', 'Take twice daily', 4),
(17, 'เมโทโคลพราไมด์', 'Metoclopramide', 'แก้อาการคลื่นไส้อาเจียน', 'Relieves nausea and vomiting', 'ทานก่อนอาหาร', 'Take before meals', 1),
(18, 'แอคซีโคลเวียร์', 'Acyclovir', 'รักษาเริม/งูสวัด', 'Treats herpes/shingles', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(19, 'นอร์ฟลอกซาซิน', 'Norfloxacin', 'รักษาอาการติดเชื้อในระบบทางเดินปัสสาวะ', 'Treats urinary tract infections', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(20, 'เม็ดฟู่เกลือแร่', 'Oral Rehydration Salts (ORS)', 'ชดเชยเกลือแร่', 'Replenishes electrolytes', 'ละลายน้ำและดื่ม', 'Dissolve in water and drink', 5),
(21, 'อิริโทรมัยซิน', 'Erythromycin', 'รักษาอาการติดเชื้อแบคทีเรีย', 'Treats bacterial infections', 'ทานวันละ 2-4 ครั้ง', 'Take 2-4 times daily', 4),
(22, 'ไทลีนอล', 'Tylenol', 'ลดไข้ บรรเทาอาการปวด', 'Reduces fever and relieves pain', 'ทานตามคำแนะนำ', 'Take as directed', 1),
(23, 'โพรพานอลอล', 'Propranolol', 'รักษาอาการหัวใจเต้นผิดจังหวะ', 'Treats irregular heartbeat', 'ทานวันละครั้ง', 'Take once daily', 7),
(24, 'อะโทรเวนต์', 'Atrovent', 'รักษาโรคหอบหืด', 'Treats asthma', 'สูดตามคำแนะนำแพทย์', 'Inhale as directed by a doctor', 7),
(25, 'บี1 บี6 บี12', 'Vitamin B1 B6 B12', 'บำรุงประสาท', 'Nerve health support', 'ทานวันละ 1 ครั้ง', 'Take once daily', 7),
(26, 'โฟลิก แอซิด', 'Folic Acid', 'เสริมวิตามินบี 9', 'Folic acid supplement', 'ทานก่อนอาหาร', 'Take before meals', 26),
(27, 'พาราเซตามอล', 'Paracetamol', 'บรรเทาอาการปวด ลดไข้', 'Relieves pain and reduces fever', 'ทานหลังอาหาร', 'Take after meals', 1),
(28, 'ไอบูโพรเฟน', 'Ibuprofen', 'ลดการอักเสบ บรรเทาอาการปวด', 'Reduces inflammation and relieves pain', 'ทานพร้อมน้ำ', 'Take with water', 2),
(29, 'อม็อกซีซิลลิน', 'Amoxicillin', 'รักษาอาการติดเชื้อแบคทีเรีย', 'Treats bacterial infections', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(30, 'โลเพอราไมด์', 'Loperamide', 'บรรเทาอาการท้องเสีย', 'Relieves diarrhea', 'ทานเมื่อมีอาการ', 'Take when symptoms occur', 7),
(31, 'เม็ดฟู่วิตามินซี', 'Vitamin C Effervescent', 'เสริมวิตามินซี', 'Vitamin C supplement', 'ละลายในน้ำ 1 แก้ว', 'Dissolve in 1 glass of water', 5),
(32, 'คลอร์เฟนิรามีน', 'Chlorpheniramine', 'บรรเทาอาการแพ้', 'Relieves allergy symptoms', 'ทานก่อนนอน', 'Take before bedtime', 3),
(33, 'ซิตริซีน', 'Cetirizine', 'รักษาอาการภูมิแพ้', 'Treats allergies', 'ทานก่อนนอน', 'Take before bedtime', 3),
(34, 'ลอราทาดีน', 'Loratadine', 'บรรเทาอาการคัดจมูก', 'Relieves nasal congestion', 'ทานวันละครั้ง', 'Take once daily', 3),
(35, 'โอเมพราโซล', 'Omeprazole', 'รักษาอาการกรดไหลย้อน', 'Treats acid reflux', 'ทานก่อนอาหารเช้า', 'Take before breakfast', 6),
(36, 'แอลบูมิน', 'Albumin', 'เสริมโปรตีน', 'Protein supplement', 'ดื่มระหว่างมื้ออาหาร', 'Drink between meals', 7),
(37, 'ไซเมทิโคน', 'Simethicone', 'แก้ปัญหาท้องอืด', 'Relieves bloating', 'ทานเมื่อมีอาการ', 'Take when symptoms occur', 7),
(38, 'โคเดอีน', 'Codeine', 'บรรเทาอาการไอ', 'Relieves cough', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 7),
(39, 'ยาคูลล์', 'Yakult', 'โปรไบโอติกส์ บำรุงลำไส้', 'Probiotics for gut health', 'ดื่มวันละครั้ง', 'Drink once daily', 7),
(40, 'ไดโคลฟีแนค', 'Diclofenac', 'บรรเทาอาการปวดข้อ', 'Relieves joint pain', 'ทานพร้อมอาหาร', 'Take with food', 2),
(41, 'กาบาเพนติน', 'Gabapentin', 'รักษาอาการปวดเส้นประสาท', 'Treats nerve pain', 'ทานก่อนนอน', 'Take before bedtime', 7),
(42, 'แอสไพริน', 'Aspirin', 'ป้องกันลิ่มเลือดอุดตัน', 'Prevents blood clots', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 7),
(43, 'เซฟาเล็กซิน', 'Cephalexin', 'ยาฆ่าเชื้อแบคทีเรีย', 'Antibiotic', 'ทานวันละ 2 ครั้ง', 'Take twice daily', 4),
(44, 'โพแทสเซียมคลอไรด์', 'Potassium Chloride', 'เสริมเกลือแร่', 'Potassium supplement', 'ทาน วันละครั้ง', 'Take once daily', 5),
(45, 'ฟลูออรีควิโนโลน', 'Fluoroquinolone', 'ยาปฏิชีวนะ', 'Antibiotic', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(46, 'เมโทรนิดาโซล', 'Metronidazole', 'รักษาอาการติดเชื้อ', 'Treats infections', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(47, 'ซัลฟาเมโทซีน', 'Sulfamethoxazole', 'ยาปฏิชีวนะ', 'Antibiotic', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(48, 'อัลลูมิเนียมไฮดรอกไซด์', 'Aluminum Hydroxide', 'บรรเทาอาการกรดในกระเพาะ', 'Relieves stomach acid', 'ทานตามคำแนะนำ', 'Take as directed', 6),
(49, 'ซิโทรไพริดีน', 'Ciprofloxacin', 'ยาปฏิชีวนะ', 'Antibiotic', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 4),
(50, 'อีโซเมพราโซล', 'Esomeprazole', 'รักษาอาการกรดไหลย้อน', 'Treats acid reflux', 'ทานก่อนอาหาร', 'Take before meals', 6),
(51, 'ฟีนิทอยน', 'Phenytoin', 'รักษาอาการชัก', 'Treats seizures', 'ทานตามคำแนะนำของแพทย์', 'Take as prescribed by a doctor', 7);

-- --------------------------------------------------------

--
-- Table structure for table `d_unit`
--

CREATE TABLE `d_unit` (
  `id` int(11) NOT NULL,
  `unit_th` varchar(255) NOT NULL,
  `unit_en` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `d_unit`
--

INSERT INTO `d_unit` (`id`, `unit_th`, `unit_en`) VALUES
(1, 'เม็ด', 'grain'),
(2, 'ขวด', 'bottle'),
(3, 'กระปุก', 'bowl');

-- --------------------------------------------------------

--
-- Table structure for table `d_user`
--

CREATE TABLE `d_user` (
  `id` int(11) NOT NULL,
  `name_th` text NOT NULL,
  `name_en` text NOT NULL,
  `sex_th` text NOT NULL,
  `sex_en` text NOT NULL,
  `weight` decimal(5,2) NOT NULL,
  `height` decimal(5,2) NOT NULL,
  `img` text NOT NULL,
  `birthday` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `other` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `tel` int(11) NOT NULL,
  `addr` varchar(355) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `d_user`
--

INSERT INTO `d_user` (`id`, `name_th`, `name_en`, `sex_th`, `sex_en`, `weight`, `height`, `img`, `birthday`, `phone`, `other`, `email`, `tel`, `addr`) VALUES
(1, 'สมชาย สุขสันต์', 'Somchai Suksant', 'ชาย', 'Male', '70.00', '170.00', 'img1.jpg', '1990-01-01', '0812345678', 'ข้อมูลอื่นๆ', 'test01@gmail.com', 613544099, 'ถนน รัตนโกสินทร์ ตำบลศรีภูมิ อำเภอเมืองเชียงใหม่ เชียงใหม่ 50200');

-- --------------------------------------------------------

--
-- Table structure for table `medication_schedule`
--

CREATE TABLE `medication_schedule` (
  `id` int(11) NOT NULL,
  `medication_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `qty` double NOT NULL,
  `stamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `st` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `status_stamp` timestamp NULL DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medication_schedule`
--

INSERT INTO `medication_schedule` (`id`, `medication_id`, `date`, `time`, `qty`, `stamp`, `status`, `st`, `user_id`, `status_stamp`, `type`) VALUES
(1, 1, '2025-01-14', '08:00:00', 1.5, '2025-01-14 01:00:00', 'succeed', 0, 1, '2025-01-14 01:10:00', 1),
(2, 2, '2025-01-14', '12:00:00', 1.5, '2025-01-14 05:00:00', 'succeed', 0, 1, '2025-01-14 05:20:47', 1),
(3, 3, '2025-01-14', '18:00:00', 1, '2025-01-14 11:00:00', 'pending', 0, 1, NULL, 1),
(4, 1, '2025-01-15', '08:00:00', 1, '2025-01-15 01:00:00', 'pending', 0, 1, NULL, 1),
(5, 2, '2025-01-15', '12:00:00', 2, '2025-01-15 05:00:00', 'pending', 0, 1, NULL, 1),
(6, 3, '2025-01-15', '18:00:00', 3, '2025-01-15 01:00:00', 'pending', 0, 1, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `d_categories`
--
ALTER TABLE `d_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `d_medications`
--
ALTER TABLE `d_medications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `d_unit`
--
ALTER TABLE `d_unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `d_user`
--
ALTER TABLE `d_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medication_schedule`
--
ALTER TABLE `medication_schedule`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `d_categories`
--
ALTER TABLE `d_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `d_unit`
--
ALTER TABLE `d_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `d_user`
--
ALTER TABLE `d_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
