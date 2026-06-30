CREATE TABLE reviews(
review_id CHAR(32) NOT NULL,
order_id CHAR(32) NOT NULL,
review_score INT,
review_comment_title VARCHAR(50),
review_comment_message 	TEXT,
review_creation_date DATETIME,
review_answer_timestamp DATETIME,

CONSTRAINT fk_reviews
FOREIGN KEY(order_id)
REFERENCES orders(order_id),

PRIMARY KEY(review_id,order_id)

)
