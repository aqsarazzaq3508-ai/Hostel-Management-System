CREATE DATABASE IF NOT EXISTS hostelhub_student_portal CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hostelhub_student_portal;

CREATE TABLE IF NOT EXISTS rooms (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  room_number VARCHAR(20) NOT NULL UNIQUE,
  room_type ENUM('Single','Double','Triple','Shared') NOT NULL DEFAULT 'Double',
  capacity TINYINT UNSIGNED NOT NULL DEFAULT 2,
  occupied TINYINT UNSIGNED NOT NULL DEFAULT 0,
  monthly_fee DECIMAL(10,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CHECK (occupied <= capacity)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS students (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  phone VARCHAR(30) DEFAULT NULL,
  status ENUM('Active','Inactive') NOT NULL DEFAULT 'Active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED DEFAULT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('admin','student') NOT NULL DEFAULT 'student',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_user_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT IGNORE INTO users (student_id,name,email,password_hash,role) VALUES
(NULL,'Hostel Admin','aqsarazaq12@gmail.com','$2y$12$aWRE56Ivgj43JUDyCoigsewo8eS/rCePgbSOkI3/Q0491x5BZ1272','admin');

CREATE TABLE IF NOT EXISTS room_requests (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED NOT NULL,
  room_id INT UNSIGNED NOT NULL,
  request_date DATE NOT NULL DEFAULT (CURRENT_DATE),
  status ENUM('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_request_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  CONSTRAINT fk_request_room FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS room_allocations (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED NOT NULL,
  room_id INT UNSIGNED NOT NULL,
  status ENUM('Active','Ended') NOT NULL DEFAULT 'Active',
  allocated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_allocation_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  CONSTRAINT fk_allocation_room FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
  INDEX idx_active_allocation(student_id,status)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fees (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED NOT NULL,
  month_label VARCHAR(30) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  due_date DATE DEFAULT NULL,
  status ENUM('Paid','Pending','Overdue') NOT NULL DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_fee_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS complaints (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED DEFAULT NULL,
  student_name VARCHAR(100) NOT NULL,
  category ENUM('Maintenance','Cleanliness','Noise','Internet','Other') NOT NULL DEFAULT 'Other',
  details VARCHAR(1000) NOT NULL,
  status ENUM('Open','Under Review','Resolved','Closed') NOT NULL DEFAULT 'Open',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_complaint_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT IGNORE INTO rooms (room_number,room_type,capacity,occupied,monthly_fee) VALUES
('A-101','Double',2,1,8500),('A-102','Triple',3,2,7000),('A-103','Single',1,0,12000),('B-201','Double',2,0,9000),('B-202','Shared',4,3,6000),('B-203','Triple',3,1,7500);

INSERT IGNORE INTO students (id,name,email,phone,status) VALUES
(1,'Ayesha Khan','ayesha@example.com','0300-1234567','Active'),
(2,'Hira Ahmed','hira@example.com','0301-2345678','Active'),
(3,'Maham Ali','maham@example.com','0302-3456789','Active');

INSERT IGNORE INTO room_requests (id,student_id,room_id,request_date,status) VALUES
(1,1,3,CURRENT_DATE,'Pending'),(2,2,4,CURRENT_DATE,'Pending'),(3,3,6,CURRENT_DATE,'Approved');

INSERT IGNORE INTO room_allocations (student_id,room_id,status) VALUES (1,1,'Active'),(2,2,'Active');

INSERT IGNORE INTO fees (id,student_id,month_label,amount,due_date,status) VALUES
(1,1,'October 2026',8500,DATE_ADD(CURRENT_DATE,INTERVAL 5 DAY),'Paid'),
(2,2,'October 2026',7000,DATE_ADD(CURRENT_DATE,INTERVAL 2 DAY),'Pending'),
(3,3,'October 2026',7500,DATE_SUB(CURRENT_DATE,INTERVAL 3 DAY),'Overdue');

INSERT IGNORE INTO complaints (id,student_name,category,details,status) VALUES
(1,'Ayesha Khan','Maintenance','The study-room light needs repair.','Open'),
(2,'Hira Ahmed','Internet','Wi-Fi is not working properly on the second floor.','Under Review');
