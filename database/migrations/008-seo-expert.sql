CREATE TABLE IF NOT EXISTS seo_expert_enquiries (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 reference CHAR(12) NOT NULL UNIQUE,
 request_key CHAR(64) NOT NULL UNIQUE,
 request_type ENUM('audit','hire','plan') NOT NULL DEFAULT 'hire',
 full_name VARCHAR(120) NOT NULL,
 business_name VARCHAR(190) NOT NULL,
 website VARCHAR(500) NOT NULL,
 phone VARCHAR(40) NOT NULL,
 email VARCHAR(190) NOT NULL,
 target_location VARCHAR(190) NOT NULL,
 target_keywords TEXT NOT NULL,
 plan ENUM('undecided','starter','growth','pro') NOT NULL DEFAULT 'undecided',
 duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
 listed_amount INT UNSIGNED NOT NULL DEFAULT 0,
 current_problem TEXT NOT NULL,
 message TEXT NOT NULL,
 status ENUM('New','Contacted','Audit','Proposal','Payment Pending','Active','Completed','Lost') NOT NULL DEFAULT 'New',
 assigned_expert INT UNSIGNED NULL,
 follow_up_at DATETIME NULL,
 proposal_amount INT UNSIGNED NULL,
 payment_status VARCHAR(20) NOT NULL DEFAULT 'Unpaid',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 INDEX(status,created_at), INDEX(plan,duration), INDEX(follow_up_at),
 FOREIGN KEY(assigned_expert) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS seo_expert_notes (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 enquiry_id BIGINT UNSIGNED NOT NULL,
 author_id INT UNSIGNED NULL,
 body TEXT NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(enquiry_id,id), FOREIGN KEY(enquiry_id) REFERENCES seo_expert_enquiries(id) ON DELETE CASCADE,
 FOREIGN KEY(author_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS seo_expert_clients (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 enquiry_id BIGINT UNSIGNED NOT NULL UNIQUE,
 website VARCHAR(500) NOT NULL,
 plan ENUM('starter','growth','pro') NOT NULL,
 duration TINYINT UNSIGNED NOT NULL,
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 assigned_expert INT UNSIGNED NULL,
 target_keywords TEXT NOT NULL,
 target_location VARCHAR(190) NOT NULL,
 notes TEXT NOT NULL,
 status ENUM('Active','Completed','On Hold') NOT NULL DEFAULT 'Active',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(status,end_date), FOREIGN KEY(enquiry_id) REFERENCES seo_expert_enquiries(id) ON DELETE CASCADE,
 FOREIGN KEY(assigned_expert) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS seo_expert_tasks (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 client_id BIGINT UNSIGNED NOT NULL,
 month_number TINYINT UNSIGNED NOT NULL,
 title VARCHAR(300) NOT NULL,
 status ENUM('Todo','In Progress','Done') NOT NULL DEFAULT 'Todo',
 due_date DATE NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(client_id,month_number), FOREIGN KEY(client_id) REFERENCES seo_expert_clients(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS seo_expert_rankings (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 client_id BIGINT UNSIGNED NOT NULL,
 keyword VARCHAR(190) NOT NULL,
 checked_on DATE NOT NULL,
 position SMALLINT UNSIGNED NULL,
 target_url VARCHAR(500) NOT NULL DEFAULT '',
 source VARCHAR(50) NOT NULL DEFAULT 'Manual entry',
 UNIQUE(client_id,keyword,checked_on), FOREIGN KEY(client_id) REFERENCES seo_expert_clients(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS seo_expert_reports (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 client_id BIGINT UNSIGNED NOT NULL,
 title VARCHAR(190) NOT NULL,
 report_month DATE NOT NULL,
 url VARCHAR(1000) NOT NULL DEFAULT '',
 summary TEXT NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(client_id,report_month), FOREIGN KEY(client_id) REFERENCES seo_expert_clients(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS seo_expert_payments (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 enquiry_id BIGINT UNSIGNED NOT NULL,
 request_key CHAR(64) NOT NULL UNIQUE,
 kind ENUM('payment','refund') NOT NULL DEFAULT 'payment',
 amount INT UNSIGNED NOT NULL,
 status ENUM('pending','paid','failed','cancelled') NOT NULL,
 method VARCHAR(80) NOT NULL,
 reference VARCHAR(190) NOT NULL DEFAULT '',
 paid_on DATE NOT NULL,
 recorded_by INT UNSIGNED NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(enquiry_id,paid_on), INDEX(status,paid_on),
 FOREIGN KEY(enquiry_id) REFERENCES seo_expert_enquiries(id) ON DELETE CASCADE,
 FOREIGN KEY(recorded_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
