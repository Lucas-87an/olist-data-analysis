-- customers
ALTER TABLE customers
ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

-- orders
ALTER TABLE orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

-- products
ALTER TABLE products
ADD CONSTRAINT pk_products PRIMARY KEY (product_id);

-- sellers
ALTER TABLE sellers
ADD CONSTRAINT pk_sellers PRIMARY KEY (seller_id);

-- reviews
ALTER TABLE reviews
ADD CONSTRAINT pk_reviews
PRIMARY KEY (order_id, review_id);

-- category_translation
ALTER TABLE category_translation
ADD CONSTRAINT pk_category_translation PRIMARY KEY (product_category_name);

--- Unique ---
-- Um item por pedido deve ter um número único
ALTER TABLE order_items
ADD CONSTRAINT uq_order_items
UNIQUE (order_id, order_item_id);

--- Foreign keys ---
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_sellers
FOREIGN KEY (seller_id)
REFERENCES sellers (seller_id);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

--- Índices ---
CREATE INDEX idx_orders_customer_id
ON orders (customer_id);

CREATE INDEX idx_order_items_order_id
ON order_items (order_id);

CREATE INDEX idx_order_items_product_id
ON order_items (product_id);

CREATE INDEX idx_order_items_seller_id
ON order_items (seller_id);

CREATE INDEX idx_payments_order_id
ON payments (order_id);

CREATE INDEX idx_reviews_order_id
ON reviews (order_id);
