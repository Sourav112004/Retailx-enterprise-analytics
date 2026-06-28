CREATE TABLE sellers(
    seller_id CHAR(32) NOT NULL PRIMARY KEY,
    seller_zip_code_prefix INT NOT NULL,
    seller_city VARCHAR(30) NOT NULL,
    seller_state CHAR(2) NOT NULL
);
