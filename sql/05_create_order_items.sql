create table order_items( order_id CHAR(32)  NOT NULL,
 order_item_id INT  NOT NULL,
 product_id CHAR(32) NOT NULL,
 seller_id CHAR(32) NOT NULL, shipping_limit_date DATETIME NOT NULL,
 price DECIMAL(12,2) NOT NULL,
 freight_value DECIMAL(12,2) NOT NULL,
 constraint fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
 constraint fk_product FOREIGN KEY(product_id) REFERENCES products(product_id),
 CONSTRAINT fk_seller FOREIGN KEY(seller_id) references sellers(seller_id),
 constraint primary key(order_id,order_item_id)
 );
