
-- Table: customer
CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    gender BIT,
    email VARCHAR(150),
    phone VARCHAR(150),
    address VARCHAR(250),
    create_at DATETIME,
    update_by INT,
    update_at DATETIME
);

-- Table: category
CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    seo_title VARCHAR(250),
    des VARCHAR(250),
    statu BIT,
    parent_id INT,
    meta_keyword VARCHAR(100),
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME
);

-- Table: brand
CREATE TABLE brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

-- Table: supplier
CREATE TABLE supplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(150),
    address VARCHAR(250),
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME
);

-- Table: product
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    seo_title VARCHAR(250),
    des VARCHAR(250),
    statu BIT,
    image VARCHAR(250),
    list_image text,
    price DECIMAL(12, 3) DEFAULT 0,
    promotion_price DECIMAL(12, 3) DEFAULT 0,
    vat_product DECIMAL(4, 3) DEFAULT 0,
    quantity INT,
    warranty VARCHAR(50) /* bảo hành */,
    hot DATETIME /* sản phẩm hot theo thời gian */,
    view_count INT,
    cate_id INT,
    brand_id INT,
    sup_id INT,
    meta_keyword VARCHAR(100),
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME,
    expiry_date VARCHAR(50) /* hạn sử dụng */,
    FOREIGN KEY (cate_id) REFERENCES category(id), -- 1-nhiều
    FOREIGN KEY (brand_id) REFERENCES brand(id), -- 1-nhiều
    FOREIGN KEY (sup_id) REFERENCES supplier(id) -- 1-nhiều
);


-- Table: payment_method
CREATE TABLE payment_method (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150),
    des VARCHAR(150),
    vat DECIMAL(3, 3) DEFAULT 0
);

-- Table: payment
CREATE TABLE payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150),
    code VARCHAR(150),
    statu BIT,
    method_id INT,
    time DATETIME,
    FOREIGN KEY (method_id) REFERENCES payment_method(id) -- 1-nhiều
);


-- Table: voucher
CREATE TABLE voucher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    seo_title VARCHAR(250),
    des VARCHAR(250),
    statu BIT,
    start_voucher DATETIME,
    end_voucher DATETIME,
    discount DECIMAL(3, 3) DEFAULT 0,
    discount_per VARCHAR(10)
);

-- Table: post_new
CREATE TABLE post_new (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(250),
    des VARCHAR(500),
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME
);


-- Table: feedback
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(12),
    des VARCHAR(500),
    create_at DATETIME,
    update_at DATETIME,
    create_by INT,
    update_by INT
);

-- Table: contact
CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150),
    statu BIT,
    address VARCHAR(250)
);


-- Table: store_revenue
CREATE TABLE store_revenue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATETIME,
    revenue DECIMAL(18, 3) DEFAULT 0
);


-- Table: department
CREATE TABLE department (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    des VARCHAR(250)
);



-- Table: user
CREATE TABLE user_department (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    username VARCHAR(100),
    password VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(12),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id) -- 1-nhiều
);

-- Table: role
CREATE TABLE user_role (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    use_id INT,
    des VARCHAR(250),
    FOREIGN KEY (user_id) REFERENCES user_department(id) -- 1-1
);

-- Table: inventory
CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contact_id INT UNIQUE, -- 1-1
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME,
    statu BIT,
    FOREIGN KEY (contact_id) REFERENCES contact(id), -- 1-1
    FOREIGN KEY (id) REFERENCES user_department(department_id) -- 1-nhiều
);

-- Table: store
CREATE TABLE store (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    contact_id INT UNIQUE, -- 1-1
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME,
    status BIT,
    FOREIGN KEY (contact_id) REFERENCES contact(id), -- 1-1
    FOREIGN KEY (id) REFERENCES user_department(department_id), -- 1-1
    FOREIGN KEY (id) REFERENCES store_revenue(id) -- 1- nhiều
);

-- Table: stock_store
CREATE TABLE stock_store (
    store_id INT PRIMARY KEY,
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME,
    statu BIT,
    product_id INT,
    min_quantity INT,
    FOREIGN KEY (store_id) REFERENCES store(id), -- 1-1
    FOREIGN KEY (product_id) REFERENCES product(id)-- 1-nhiều
);

-- Table: order_online
CREATE TABLE order_online (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATETIME,
    statu BIT,
    start_order DATETIME,
    end_order DATETIME,
    customer_id INT,
    discount DECIMAL(3, 3) DEFAULT 0,
    store_id INT,
    voucher_id INT,
    pay_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id), -- 1-nhiều
    FOREIGN KEY (store_id) REFERENCES store(id), -- 1-nhiều
    FOREIGN KEY (voucher_id) REFERENCES voucher(id), -- 1-nhiều
    FOREIGN KEY (pay_id) REFERENCES payment(id) -- 1-nhiều
);


-- Table: import_log
CREATE TABLE import_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    from_inventory INT,
    to_stock_store INT,
    start DATETIME,
    end DATETIME,
    statu BIT,
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME,
    FOREIGN KEY (from_inventory) REFERENCES inventory(id), -- 1-nhiều
    FOREIGN KEY (to_stock_store) REFERENCES stock_store(store_id) -- 1-nhiều
);

-- Table: import_product
CREATE TABLE import_product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    price DECIMAL(12, 3) DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(id), -- 1-nhiều
    FOREIGN KEY (id) REFERENCES import_log(id) -- 1-1
);


-- Table: order_offline
CREATE TABLE order_offline (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATETIME,
    status BIT,
    customer_id INT,
    discount DECIMAL(3, 3) DEFAULT 0,
    store_id INT,
    voucher_id INT,
    create_by INT,
    pay_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id), -- 1-nhiều
    FOREIGN KEY (store_id) REFERENCES store(id), -- 1-nhiều
    FOREIGN KEY (voucher_id) REFERENCES voucher(id), -- 1-nhiều
    FOREIGN KEY (pay_id) REFERENCES payment(id) -- 1-nhiều
);


-- Table: order_detail
CREATE TABLE order_detail (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(12, 3) DEFAULT 0,
    PRIMARY KEY (order_id, product_id), -- Khóa chính ghép
    FOREIGN KEY (order_id) REFERENCES order_offline(id), -- 1-1
    FOREIGN KEY (order_id) REFERENCES order_online(id), -- 1-1
    FOREIGN KEY (product_id) REFERENCES product(id) -- 1-nhiều
);


-- Table: product_comment
CREATE TABLE product_comment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    des VARCHAR(250),
    post_id INT,
    create_by INT,
    create_at DATETIME,
    update_by INT,
    update_at DATETIME,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES product(id) -- 1-nhiều
);



-- Table: menu true
CREATE TABLE menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT,
    inventory_id INT,
    feedback_id INT,
    post_id INT,
    FOREIGN KEY (store_id) REFERENCES store(id), -- 1-nhiều
    FOREIGN KEY (inventory_id) REFERENCES inventory(id), -- 1-nhiều
    FOREIGN KEY (feedback_id) REFERENCES feedback(id), -- 1-nhiều
    FOREIGN KEY (post_id) REFERENCES post_new(id) -- 1-nhiều
);

-- Tạo bảng analyst
CREATE TABLE analyst (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính tự tăng
    name VARCHAR(100),                 -- Tên phân tích
    description VARCHAR(250),          -- Mô tả (thay des thành description cho rõ ràng)
    image_analyst VARCHAR(250),        -- Đường dẫn hình ảnh phân tích
    detail VARCHAR(250),               -- Chi tiết phân tích
    store_id INT,                      -- Khóa ngoại trỏ đến store
    date_analyst DATETIME,             -- Ngày phân tích
    method_id INT,                     -- Khóa ngoại trỏ đến phương pháp phân tích
    FOREIGN KEY (store_id) REFERENCES store(id) -- Quan hệ 1-nhiều
);