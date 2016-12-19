DROP TABLE IF EXISTS transactions;
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
  monthly_limit INT8,
  funds INT8 
);

CREATE TABLE tags (
  id SERIAL8 primary key,
  label VARCHAR(255)
  );

CREATE TABLE transactions (
  id SERIAL8,
  amount INT8,
  time VARCHAR(255),
  merchant_id INT8 references merchants(id) ON DELETE CASCADE,
  user_id INT8 references users(id) ON DELETE CASCADE, 
  tag_id INT8 references tags(id) ON DELETE CASCADE
);