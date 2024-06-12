/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : bookstore

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 07/06/2024 23:56:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book_info
-- ----------------------------
DROP TABLE IF EXISTS `book_info`;
CREATE TABLE `book_info`  (
  `bid` int NOT NULL AUTO_INCREMENT,
  `b_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `b_price` double NULL DEFAULT NULL,
  `b_num` int NOT NULL,
  `b_imgpath` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type_id` int NULL DEFAULT NULL,
  `publisher` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `b_time` date NULL DEFAULT NULL,
  `rate_number` int NULL DEFAULT 10 COMMENT '评分，根据用户们的评分做平均值',
  `author` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `storage_time` date NULL DEFAULT NULL,
  `b_info` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '简介',
  `discount` double NULL DEFAULT NULL COMMENT '折扣',
  PRIMARY KEY (`bid`) USING BTREE,
  INDEX `idx_type_id`(`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book_info
-- ----------------------------
INSERT INTO `book_info` VALUES (1, 'The Divine Comedy', 28, 60, '/images/divinecomedy.jpg', 10, 'Italy', '1320-01-01', 9, 'Dante Alighieri', '2023-10-01', 'An epic poem about Dante\'s journey through Hell, Purgatory, and Heaven.', 0.75);
INSERT INTO `book_info` VALUES (2, 'The Lord of the Rings', 35, 120, '/images/lotr.jpg', 6, 'George Allen & Unwin', '1954-07-29', 9, 'J.R.R. Tolkien', '2023-11-01', 'A high fantasy novel about the quest to destroy the One Ring.', 0.9);
INSERT INTO `book_info` VALUES (3, 'Crime and Punishment', 20, 90, '/images/crimepunishment.jpg', 8, 'The Russian Messenger', '1866-01-01', 9, 'Fyodor Dostoevsky', '2023-12-01', 'A psychological novel about guilt, conscience, and redemption.', 0.8);
INSERT INTO `book_info` VALUES (4, 'The Picture of Dorian Gray', 16, 100, '/images/doriangray.jpg', 1, 'Lippincott’s Monthly Magazine', '1890-07-20', 8, 'Oscar Wilde', '2024-01-01', 'A philosophical novel about the consequences of vanity and immorality.', 0.85);
INSERT INTO `book_info` VALUES (5, 'Don Quixote', 25, 80, '/images/donquixote.jpg', 11, 'Spain', '1605-01-16', 9, 'Miguel de Cervantes', '2024-02-01', 'A satirical novel about the adventures of a delusional knight and his loyal squire.', 0.75);
INSERT INTO `book_info` VALUES (6, 'Les Misérables', 22, 110, '/images/lesmiserables.jpg', 8, 'France', '1862-01-01', 10, 'Victor Hugo', '2024-03-01', 'A historical novel about love, redemption, and revolution in 19th-century France.', 0.7);
INSERT INTO `book_info` VALUES (7, 'The Brothers Karamazov', 28, 70, '/images/brotherskaramazov.jpg', 8, 'The Russian Messenger', '1880-01-01', 9, 'Fyodor Dostoevsky', '2024-04-01', 'A philosophical novel exploring the nature of faith, morality, and free will.', 0.85);
INSERT INTO `book_info` VALUES (8, 'Frankenstein', 18, 130, '/images/frankenstein.jpg', 12, 'United Kingdom', '1818-01-01', 8, 'Mary Shelley', '2024-05-01', 'A Gothic novel about the dangers of scientific experimentation and human ambition.', 0.9);
INSERT INTO `book_info` VALUES (9, 'Jane Eyre', 21, 95, '/images/janeeyre.jpg', 4, 'Smith, Elder & Co.', '1847-10-16', 9, 'Charlotte Brontë', '2024-06-01', 'A Bildungsroman about the struggles and triumphs of a young orphaned girl.', 0.95);
INSERT INTO `book_info` VALUES (10, 'The Count of Monte Cristo', 26, 85, '/images/montecristo.jpg', 13, 'France', '1844-08-28', 10, 'Alexandre Dumas', '2024-07-01', 'An adventure novel about revenge, forgiveness, and redemption.', 0.7);
INSERT INTO `book_info` VALUES (11, 'The Great Gatsby', 20, 100, '/images/gatsby.jpg', 1, 'Scribner', '1925-04-10', 9, 'F. Scott Fitzgerald', '2023-01-01', 'A classic novel of the Roaring Twenties.', 0.9);
INSERT INTO `book_info` VALUES (12, '1984', 15, 150, '/images/1984.jpg', 2, 'Secker & Warburg', '1949-06-08', 10, 'George Orwell', '2023-02-01', 'A dystopian social science fiction novel.', 0.8);
INSERT INTO `book_info` VALUES (13, 'To Kill a Mockingbird', 18, 120, '/images/mockingbird.jpg', 3, 'J.B. Lippincott & Co.', '1960-07-11', 10, 'Harper Lee', '2023-03-01', 'A novel about racial injustice in the Deep South.', 0.85);
INSERT INTO `book_info` VALUES (14, 'Pride and Prejudice', 12, 80, '/images/pride.jpg', 4, 'T. Egerton', '1813-01-28', 9, 'Jane Austen', '2023-04-01', 'A romantic novel about manners and marriage.', 0.75);
INSERT INTO `book_info` VALUES (15, 'The Catcher in the Rye', 17, 90, '/images/catcher.jpg', 5, 'Little, Brown and Company', '1951-07-16', 8, 'J.D. Salinger', '2023-05-01', 'A story about teenage alienation and rebellion.', 0.9);
INSERT INTO `book_info` VALUES (16, 'The Hobbit', 25, 110, '/images/hobbit.jpg', 6, 'George Allen & Unwin', '1937-09-21', 9, 'J.R.R. Tolkien', '2023-06-01', 'A fantasy novel about the journey of Bilbo Baggins.', 0.95);
INSERT INTO `book_info` VALUES (17, 'Moby-Dick', 22, 70, '/images/mobydick.jpg', 7, 'Harper & Brothers', '1851-10-18', 7, 'Herman Melville', '2023-07-01', 'A novel about the quest for a giant white whale.', 0.7);
INSERT INTO `book_info` VALUES (18, 'War and Peace', 30, 50, '/images/warandpeace.jpg', 8, 'The Russian Messenger', '1869-01-01', 10, 'Leo Tolstoy', '2023-08-01', 'A historical novel set during the Napoleonic Wars.', 0.6);
INSERT INTO `book_info` VALUES (19, 'The Odyssey', 10, 200, '/images/odyssey.jpg', 9, 'Ancient Greece', '0800-01-01', 8, 'Homer', '2023-09-01', 'An epic poem about the adventures of Odysseus.', 0.85);
INSERT INTO `book_info` VALUES (20, 'Anna Karenina', 24, 75, '/images/annakarenina.jpg', 8, 'The Russian Messenger', '1878-01-01', 9, 'Leo Tolstoy', '2024-08-01', 'A tragic love story set in the high society of Imperial Russia.', 0.75);

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
  `bid` int NOT NULL,
  `book_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `book_time` date NULL DEFAULT NULL,
  `book_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '书的类型',
  `uid` int NOT NULL,
  PRIMARY KEY (`bid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `collection_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `book_info` (`bid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `collection_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collection
-- ----------------------------
INSERT INTO `collection` VALUES (1, 'The Divine Comedy', '2024-05-01', 'Fiction', 1);
INSERT INTO `collection` VALUES (2, 'The Lord of the Rings', '2024-05-02', 'Non-fiction', 1);
INSERT INTO `collection` VALUES (3, 'Crime and Punishment', '2024-05-03', 'Science Fiction', 2);
INSERT INTO `collection` VALUES (4, 'The Picture of Dorian Gray', '2024-05-04', 'Mystery', 2);
INSERT INTO `collection` VALUES (5, 'Don Quixote', '2024-05-05', 'Fantasy', 3);
INSERT INTO `collection` VALUES (6, 'Les Misérables', '2024-05-06', 'Thriller', 3);
INSERT INTO `collection` VALUES (7, 'The Brothers Karamazov', '2024-05-07', 'Romance', 4);
INSERT INTO `collection` VALUES (8, 'Frankenstein', '2024-05-08', 'Biography', 4);
INSERT INTO `collection` VALUES (9, 'Jane Eyre', '2024-05-09', 'History', 5);
INSERT INTO `collection` VALUES (10, 'The Count of Monte Cristo', '2024-05-10', 'Self-help', 5);

-- ----------------------------
-- Table structure for interest
-- ----------------------------
DROP TABLE IF EXISTS `interest`;
CREATE TABLE `interest`  (
  `uid` int NOT NULL,
  `type_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户感兴趣的类型的汉语名字',
  `type_id` int NOT NULL,
  PRIMARY KEY (`uid`, `type_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `interest_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `interest_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `book_info` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of interest
-- ----------------------------
INSERT INTO `interest` VALUES (1, '文学', 1);
INSERT INTO `interest` VALUES (1, '科幻', 2);
INSERT INTO `interest` VALUES (1, '戏剧', 11);
INSERT INTO `interest` VALUES (2, '冒险', 6);
INSERT INTO `interest` VALUES (2, '历史', 8);
INSERT INTO `interest` VALUES (2, '幻想', 12);
INSERT INTO `interest` VALUES (3, '经典', 3);
INSERT INTO `interest` VALUES (3, '爱情', 4);
INSERT INTO `interest` VALUES (3, '传记', 13);
INSERT INTO `interest` VALUES (4, '社会', 5);
INSERT INTO `interest` VALUES (4, '冒险', 6);
INSERT INTO `interest` VALUES (5, '诗歌', 9);
INSERT INTO `interest` VALUES (5, '宗教', 10);
INSERT INTO `interest` VALUES (6, '小说', 7);
INSERT INTO `interest` VALUES (7, '历史', 8);
INSERT INTO `interest` VALUES (8, '诗歌', 9);
INSERT INTO `interest` VALUES (9, '社会', 5);
INSERT INTO `interest` VALUES (10, '宗教', 3);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `oid` int NOT NULL AUTO_INCREMENT,
  `receiver_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `buyer_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `buyer_tel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `postal_code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_date` date NULL DEFAULT NULL,
  `uid` int NOT NULL,
  `order_type` int NULL DEFAULT NULL,
  `bid` int NULL DEFAULT NULL COMMENT '商品id',
  `b_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `book_num` int NOT NULL COMMENT '买的书的数目',
  `sum_price` double NULL DEFAULT NULL COMMENT '总价',
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '张三-1', '北京市朝阳区XX街道1号', '13800000001', '100000', '2024-01-01', 1, 0, 1, 'The Great Gatsby', 1, 18);
INSERT INTO `orders` VALUES (2, '张三-2', '北京市朝阳区XX街道2号', '13800000002', '100000', '2024-01-02', 1, 1, 2, '1984', 2, 24);
INSERT INTO `orders` VALUES (3, '张三-3', '北京市朝阳区XX街道3号', '13800000003', '100000', '2024-01-03', 1, -1, 3, 'To Kill a Mockingbird', 1, 15.3);
INSERT INTO `orders` VALUES (4, '张三-4', '北京市朝阳区XX街道4号', '13800000004', '100000', '2024-01-04', 1, 0, 10, 'The Divine Comedy', 2, 42);
INSERT INTO `orders` VALUES (5, '李四-1', '上海市浦东新区YY路1号', '13900000011', '200000', '2024-02-01', 2, 0, 4, 'Pride and Prejudice', 1, 9);
INSERT INTO `orders` VALUES (6, '李四-2', '上海市浦东新区YY路2号', '13900000012', '200000', '2024-02-02', 2, -1, 5, 'The Catcher in the Rye', 2, 30.6);
INSERT INTO `orders` VALUES (7, '李四-3', '上海市浦东新区YY路3号', '13900000013', '200000', '2024-02-03', 2, 1, 6, 'The Hobbit', 1, 23.75);
INSERT INTO `orders` VALUES (8, '王五-1', '广州市天河区ZZ街1号', '13700000021', '510000', '2024-03-01', 3, 0, 7, 'Moby-Dick', 1, 15.4);
INSERT INTO `orders` VALUES (9, '王五-2', '广州市天河区ZZ街2号', '13700000022', '510000', '2024-03-02', 3, 1, 8, 'War and Peace', 1, 18);
INSERT INTO `orders` VALUES (10, '王五-3', '广州市天河区ZZ街3号', '13700000023', '510000', '2024-03-03', 3, -1, 9, 'The Odyssey', 3, 25.5);

-- ----------------------------
-- Table structure for rate
-- ----------------------------
DROP TABLE IF EXISTS `rate`;
CREATE TABLE `rate`  (
  `uid` int NOT NULL,
  `bid` int NOT NULL,
  `star` double NOT NULL,
  `info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uidRateId` int NULL DEFAULT NULL,
  INDEX `fk_rate_uid`(`uid`) USING BTREE,
  INDEX `fk_rate_bid`(`bid`) USING BTREE,
  CONSTRAINT `fk_rate_bid` FOREIGN KEY (`bid`) REFERENCES `book_info` (`bid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rate_uid` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rate
-- ----------------------------
INSERT INTO `rate` VALUES (1, 1, 4.5, 'A profound exploration of the American dream.', 1);
INSERT INTO `rate` VALUES (1, 2, 5, 'A chilling portrayal of a dystopian future.', 2);
INSERT INTO `rate` VALUES (1, 3, 4.8, 'A deeply moving and insightful novel.', 3);
INSERT INTO `rate` VALUES (2, 4, 4.2, 'A timeless romance with sharp social commentary.', 1);
INSERT INTO `rate` VALUES (2, 5, 3.8, 'An intriguing look at teenage rebellion.', 2);
INSERT INTO `rate` VALUES (2, 6, 4.9, 'An enchanting journey through a fantasy world.', 3);
INSERT INTO `rate` VALUES (3, 7, 4, 'A gripping tale of obsession and revenge.', 1);
INSERT INTO `rate` VALUES (3, 8, 4.7, 'An epic novel of war and peace.', 2);
INSERT INTO `rate` VALUES (3, 9, 4.5, 'A classic adventure story.', 3);
INSERT INTO `rate` VALUES (1, 10, 4.6, 'A profound and poetic journey through the afterlife.', 4);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `uid` int NOT NULL COMMENT '外键，指向users表的uid',
  `bid` int NOT NULL COMMENT '书编号，外键，指向book_info表的bid',
  `book_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `price` double NOT NULL COMMENT '单价',
  `book_type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '买的书的类型',
  `book_num` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '买的书的数目',
  `sum` double NOT NULL DEFAULT 0 COMMENT '总价',
  PRIMARY KEY (`uid`, `bid`) USING BTREE,
  INDEX `bid`(`bid`) USING BTREE,
  CONSTRAINT `shopping_cart_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `shopping_cart_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `book_info` (`bid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (1, 1, 'The Divine Comedy', 20, 'Classic', '2', 40);
INSERT INTO `shopping_cart` VALUES (1, 3, 'Crime and Punishment', 18, 'Classic', '1', 18);
INSERT INTO `shopping_cart` VALUES (1, 5, 'Don Quixote', 17, 'Classic', '3', 51);
INSERT INTO `shopping_cart` VALUES (2, 2, 'The Lord of the Rings', 15, 'Dystopian', '1', 15);
INSERT INTO `shopping_cart` VALUES (2, 4, 'The Picture of Dorian Gray', 12, 'Romance', '2', 24);
INSERT INTO `shopping_cart` VALUES (2, 6, 'Les Misérables', 25, 'Fantasy', '1', 25);
INSERT INTO `shopping_cart` VALUES (3, 7, 'The Brothers Karamazov', 22, 'Adventure', '1', 22);
INSERT INTO `shopping_cart` VALUES (3, 8, 'Frankenstein', 30, 'Historical', '2', 60);
INSERT INTO `shopping_cart` VALUES (3, 9, 'Jane Eyre', 10, 'Epic', '4', 40);
INSERT INTO `shopping_cart` VALUES (3, 10, 'The Count of Monte Cristo', 28, 'Epic', '1', 28);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `uid` int NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `upassword` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `uquestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `uanswer` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `true_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `gender` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Email` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `career` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `interest` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `money` decimal(10, 2) NOT NULL,
  `registration_time` date NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'dsy', '123', '123', '123', 'dsy', 'male', '1820304552', '1820304552@qq.com', 'student', 'Reading', 'dsy的address', 800.00, '2024-06-05');
INSERT INTO `users` VALUES (2, 'lyy', '456', '456', '456', 'lyy', 'male', '3353059659', '3353059659@qq.com', 'student', 'Reading', 'lyy的address', 800.00, '2024-06-04');
INSERT INTO `users` VALUES (3, 'alice', '123', 'What is your favorite color?', 'blue', 'Alice Smith', 'Female', '1234567890', 'alice@example.com', 'Software Engineer', 'Reading', '123 Main Street, City, Country', 1000.00, '2024-06-01');
INSERT INTO `users` VALUES (4, 'bob', '123', 'What is your pet\'s name?', 'fluffy', 'Bob Johnson', 'Male', '0987654321', 'bob@example.com', 'Data Analyst', 'Hiking', '456 Elm Street, City, Country', 1500.00, '2024-06-02');
INSERT INTO `users` VALUES (5, 'charlie', 'charlie123', 'What city were you born in?', 'New York', 'Charlie Brown', 'Male', '9876543210', 'charlie@example.com', 'Graphic Designer', 'Photography', '789 Oak Street, City, Country', 800.00, '2024-06-03');
INSERT INTO `users` VALUES (6, 'david', '123', 'What is your mother\'s maiden name?', 'Johnson', 'David Davis', 'Male', '8765432109', 'david@example.com', 'Teacher', 'Traveling', '101 Maple Street, City, Country', 1200.00, '2024-06-04');
INSERT INTO `users` VALUES (7, 'emma', '123', 'What is your favorite food?', 'Pizza', 'Emma Wilson', 'Female', '7654321098', 'emma@example.com', 'Artist', 'Painting', '202 Pine Street, City, Country', 900.00, '2024-06-05');
INSERT INTO `users` VALUES (8, 'frank', 'fran123', 'What is your favorite hobby?', 'Fishing', 'Frank Miller', 'Male', '6543210987', 'frank@example.com', 'Writer', 'Writing', '303 Cedar Street, City, Country', 1100.00, '2024-06-06');
INSERT INTO `users` VALUES (9, 'grace', 'grace123', 'What is your favorite movie?', 'Titanic', 'Grace Taylor', 'Female', '5432109876', 'grace@example.com', 'Doctor', 'Cooking', '404 Walnut Street, City, Country', 1300.00, '2024-06-07');
INSERT INTO `users` VALUES (10, 'henry', 'henry123', 'What is your favorite sport?', 'Soccer', 'Henry Lee', 'Male', '4321098765', 'henry@example.com', 'Engineer', 'Gardening', '505 Oak Street, City, Country', 950.00, '2024-06-08');
INSERT INTO `users` VALUES (11, 'irene', 'irene123', 'What is your favorite animal?', 'Dog', 'Irene White', 'Female', '3210987654', 'irene@example.com', 'Lawyer', 'Singing', '606 Pine Street, City, Country', 1450.00, '2024-06-09');
INSERT INTO `users` VALUES (12, 'james', 'james123', 'What is your favorite book?', 'Harry Potter', 'James Harris', 'Male', '2109876543', 'james@example.com', 'Architect', 'Playing Guitar', '707 Maple Street, City, Country', 850.00, '2024-06-10');

SET FOREIGN_KEY_CHECKS = 1;
