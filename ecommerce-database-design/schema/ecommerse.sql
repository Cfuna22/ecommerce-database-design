-- E-Commerce Database Schema

-- Table 1: Brand
USE E_Commerce;

CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Table 2: Product Category
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Table 3: Product
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10, 2),
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- Table 4: Product Image
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(150),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Table 5: Color
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_code CHAR(7) -- Optional: "#FFFFFF"
);

-- Table 6: Size Category
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Table 7: Size Option
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(20) NOT NULL,  -- e.g., S, M, L, 42
    size_category_id INT,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Table 8: Product Variation
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- Table 9: Product Item
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    sku VARCHAR(50) UNIQUE, -- Stock Keeping Unit
    quantity_in_stock INT DEFAULT 0,
    price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- Table 10: Attribute Category
CREATE TABLE attribute_category (
    attr_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Table 11: Attribute Type
CREATE TABLE attribute_type (
    attr_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL  -- e.g., 'Text', 'Number', 'Boolean'
);

-- Table 12: Product Attribute
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attr_category_id INT,
    attr_type_id INT,
    attr_key VARCHAR(100) NOT NULL,  -- e.g., "Material", "Weight"
    value TEXT NOT NULL,        -- e.g., "Cotton", "2kg"
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attr_category_id) REFERENCES attribute_category(attr_category_id),
    FOREIGN KEY (attr_type_id) REFERENCES attribute_type(attr_type_id)
);

-- brand
INSERT INTO brand (name, description) VALUES
('Nike', 'Athletic apparel and footwear'),
('Samsung', 'Electronics and mobile devices'),
('Apple', 'Innovative tech products');

-- product_category
INSERT INTO product_category (name, description) VALUES
('Clothing', 'Apparel and fashion wear'),
('Electronics', 'Phones, laptops, and gadgets');


-- product
INSERT INTO product (name, brand_id, category_id, base_price, description) VALUES
('Nike Air Max', 1, 1, 120.00, 'Running shoes with Air Max cushioning'),
('Samsung Galaxy S23', 2, 2, 799.99, 'Latest flagship smartphone'),
('Apple MacBook Pro', 3, 2, 1999.00, '16-inch professional laptop');

-- product_image
INSERT INTO product_image (product_id, image_url, alt_text) VALUES
(1, 'https://example.com/images/airmax.jpg', 'Nike Air Max Shoe'),
(2, 'https://example.com/images/s23.jpg', 'Samsung Galaxy S23'),
(3, 'https://example.com/images/macbook.jpg', 'MacBook Pro');

-- color
INSERT INTO color (name, hex_code) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000');

-- size_category
INSERT INTO size_category (name) VALUES
('Clothing Sizes'),
('Shoe Sizes');

-- size_option
INSERT INTO size_option (label, size_category_id) VALUES
('S', 1), ('M', 1), ('L', 1),
('42', 2), ('43', 2);

-- product_variation
INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES
(1, 1, 4), -- Nike Air Max, Black, Size 42
(1, 3, 5), -- Nike Air Max, Red, Size 43
(2, 2, NULL); -- Samsung S23, White (no size)

-- product_item
INSERT INTO product_item (product_id, color_id, size_option_id, sku, quantity_in_stock, price) VALUES
(1, 1, 4, 'AIRMAX-BLK-42', 15, 125.00),
(1, 3, 5, 'AIRMAX-RED-43', 10, 125.00),
(2, 2, NULL, 'S23-WHT', 20, 799.99);

-- attribute_category
INSERT INTO attribute_category (name) VALUES
('Physical'), ('Technical');

-- attribute_type
INSERT INTO attribute_type (name) VALUES
('Text'), ('Number'), ('Boolean');

-- product_attribute
INSERT INTO product_attribute (product_id, attr_category_id, attr_type_id, key, value) VALUES
(1, 1, 1, 'Material', 'Mesh'),
(1, 1, 2, 'Weight', '0.8'),
(2, 2, 2, 'Battery Life', '24'),
(3, 2, 1, 'Processor', 'Apple M2 Pro');
(3, 1, 2, 'Weight', '2.0');

