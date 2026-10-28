CREATE DATABASE IF NOT EXISTS aastha_grocery CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE aastha_grocery;

CREATE TABLE IF NOT EXISTS admins (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(80) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS categories (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 slug VARCHAR(140) NOT NULL UNIQUE,
 image VARCHAR(255) DEFAULT NULL,
 sort_order INT NOT NULL DEFAULT 0,
 active TINYINT(1) NOT NULL DEFAULT 1,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS products (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 category_id INT UNSIGNED NULL,
 name VARCHAR(180) NOT NULL,
 description TEXT NULL,
 image VARCHAR(255) DEFAULT NULL,
 unit VARCHAR(60) NOT NULL DEFAULT '1 item',
 price DECIMAL(10,2) NOT NULL DEFAULT 0,
 old_price DECIMAL(10,2) DEFAULT NULL,
 stock INT NOT NULL DEFAULT 0,
 featured TINYINT(1) NOT NULL DEFAULT 0,
 active TINYINT(1) NOT NULL DEFAULT 1,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
 INDEX(active), INDEX(category_id), INDEX(name)
);
CREATE TABLE IF NOT EXISTS customers (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(140) NOT NULL,
 phone VARCHAR(30) NOT NULL,
 email VARCHAR(190) DEFAULT NULL,
 address TEXT NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(phone)
);
CREATE TABLE IF NOT EXISTS orders (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 order_code VARCHAR(32) NOT NULL UNIQUE,
 customer_id INT UNSIGNED NULL,
 customer_name VARCHAR(140) NOT NULL,
 phone VARCHAR(30) NOT NULL,
 address TEXT NOT NULL,
 subtotal DECIMAL(10,2) NOT NULL,
 delivery_fee DECIMAL(10,2) NOT NULL DEFAULT 0,
 total DECIMAL(10,2) NOT NULL,
 payment_method VARCHAR(30) NOT NULL DEFAULT 'COD',
 status ENUM('Pending','Confirmed','Processing','Out for Delivery','Delivered','Cancelled') NOT NULL DEFAULT 'Pending',
 notes TEXT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
 INDEX(status), INDEX(created_at)
);
CREATE TABLE IF NOT EXISTS order_items (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 order_id BIGINT UNSIGNED NOT NULL,
 product_id INT UNSIGNED NULL,
 product_name VARCHAR(180) NOT NULL,
 unit VARCHAR(60) NOT NULL,
 price DECIMAL(10,2) NOT NULL,
 quantity INT NOT NULL,
 FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
 FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS settings (
 setting_key VARCHAR(100) PRIMARY KEY,
 setting_value TEXT NULL
);

INSERT IGNORE INTO categories (id,name,slug,sort_order) VALUES
(1,'Oil','oil',1),(2,'Flour','flour',2),(3,'Dal or Lentil','dal-or-lentil',3),
(4,'Spices','spices',4),(5,'Our Packages','our-packages',5),(6,'Offers','offers',6);
INSERT IGNORE INTO products (id,category_id,name,description,unit,price,old_price,stock,featured) VALUES
(1,1,'Pure Mustard Oil','Traditional mustard oil for everyday cooking.','1 Ltr',330,350,40,1),
(2,1,'Pure Mustard Oil','Pure mustard oil, family pack.','500 ml',170,180,55,1),
(3,3,'Alu Bokhara','Premium dried alu bokhara.','100 gm',65,70,80,1),
(4,3,'Raisins (Kishmish)','Sweet premium raisins.','100 gm',65,70,70,1),
(5,4,'Mace (Jaytree)','Aromatic whole spice.','25 gm',85,100,25,1),
(6,4,'White Pepper','Fine white pepper.','50 gm',65,75,30,1);
