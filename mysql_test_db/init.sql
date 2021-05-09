CREATE DATABASE IF NOT EXISTS competitive_users;
CREATE TABLE IF NOT EXISTS competitive_users.users( 
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  account_age INT,
  created_at TIMESTAMP NOT NULL default current_timestamp,
  updated_at TIMESTAMP NOT NULL default current_timestamp on update current_timestamp
);

