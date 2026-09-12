ALTER TABLE human_service_requests ADD COLUMN quoted_amount INT UNSIGNED NULL;
ALTER TABLE payments ADD COLUMN purpose ENUM('subscription','service','ai_credits') NOT NULL DEFAULT 'subscription', ADD COLUMN service_request_id INT UNSIGNED NULL, ADD COLUMN ai_credits INT UNSIGNED NOT NULL DEFAULT 0, ADD FOREIGN KEY(service_request_id) REFERENCES human_service_requests(id);
CREATE TABLE ai_credit_balances (user_id INT UNSIGNED PRIMARY KEY, credits INT UNSIGNED NOT NULL DEFAULT 0, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY(user_id) REFERENCES users(id)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO settings(name,value) VALUES ('ai_pack_price','49900'),('ai_pack_credits','100');
