 CREATE TABLE payments(
order_id CHAR(32) NOT NULL ,
payment_sequential INT NOT NULL,
payment_type VARCHAR(12) NOT NULL,
payment_installments INT NOT NULL,
payment_value DECIMAL(10,2) NOT NULL,

CONSTRAINT fk_payment_order
FOREIGN KEY(order_id)
REFERENCES orders(order_id),

PRIMARY KEY(order_id,payment_sequential)
);
