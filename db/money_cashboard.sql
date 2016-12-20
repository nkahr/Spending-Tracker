DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS standing_orders;
DROP TABLE IF EXISTS visits;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS tags;

CREATE TABLE merchants (
  id SERIAL8 primary key,
  name VARCHAR(255)
);

CREATE TABLE users (
  id SERIAL8 primary key,
  username VARCHAR(255),
  monthly_limit DECIMAL(16,2),
  monthly_income DECIMAL(16,2),
  pay_day INT8,
  funds DECIMAL(16,2)
);

CREATE TABLE tags (
  id SERIAL8 primary key,
  label VARCHAR(255)
  );

CREATE TABLE transactions (
  id SERIAL8 primary key,
  amount DECIMAL(16,2),
  time VARCHAR(255),
  note VARCHAR(255),
  merchant_id INT8 references merchants(id) ON DELETE CASCADE,
  user_id INT8 references users(id) ON DELETE CASCADE, 
  tag_id INT8 references tags(id) ON DELETE CASCADE
);

CREATE TABLE standing_orders (
  id SERIAL8 primary key,
  first_payment VARCHAR(255), 
  times_paid INT8, 
  amount DECIMAL(16,2),
  note VARCHAR(255),
  merchant_id INT8 references merchants(id) ON DELETE CASCADE,
  user_id INT8 references users(id) ON DELETE CASCADE, 
  tag_id INT8 references tags(id) ON DELETE CASCADE
  );

CREATE TABLE visits (
  id SERIAL8 primary key,
  date VARCHAR(255), 
  user_id INT8 references users(id) ON DELETE CASCADE
);
