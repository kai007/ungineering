CREATE DATABASE IF NOT EXISTS phpwebco_shop;
USE phpwebco_shop;

CREATE TABLE tbl_category (
    cat_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_parent_id INTEGER NOT NULL DEFAULT 0,

    cat_name VARCHAR(50) NOT NULL DEFAULT '',
    cat_description VARCHAR(200) NOT NULL DEFAULT '',
    cat_image VARCHAR(255) NOT NULL DEFAULT '',

    PRIMARY KEY (cat_id),
    INDEX (cat_parent_id),
    INDEX (cat_name)
);


CREATE TABLE tbl_product (
    pd_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_id INTEGER UNSIGNED NOT NULL,

    pd_name VARCHAR(100) NOT NULL DEFAULT '',
    pd_description TEXT NOT NULL DEFAULT '',
    pd_price DECIMAL(7,2) NOT NULL DEFAULT 0.00,
    pd_qty SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    pd_image VARCHAR(200),
    pd_thumbnail VARCHAR(200),
    pd_date DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    pd_last_update DATE TIME NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (pd_id),
    INDEX (cat_id),
    INDEX (pd_name)
);

CREATE TABLE tbl_cart (
    ct_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    pd_id  INTEGER UNSIGNED NOT NULL,
    ct_qty INTEGER UNSIGNED NOT NULL DEFAULT 1,
    ct_session_id CHAR(32) NOT NULL DEFAULT '',
    ct_date DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (ct_id),
    INDEX (pd_id),
    INDEX (ct_session_id)
);

CREATE TABLE tbl_order (
    od_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    od_date DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    od_last_update DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    od_status ENUM('New', 'Shipped', 'Completed', 'Cancelled') NOT NULL DEFAULT 'New',

    od_shipping_first_name VARCHAR(50) NOT NULL,
    od_shipping_last_name VARCHAR(50) NOT NULL DEFAULT '',
    od_shipping_address1 VARCHAR(100) NOT NULL DEFAULT '',
    od_shipping_address2 VARCHAR(100) NOT NULL DEFAULT '',
    od_shipping_city VARCHAR(100) NOT NULL DEFAULT '',
    od_shipping_postal_code VARCHAR(10) NOT NULL DEFAULT '',
    od_shipping_cost DECIMAL(5,2) DEFAULT 0.00,

    od_payment_first_name VARCHAR(50) NOT NULL,
    od_payment_last_name VARCHAR(50) NOT NULL DEFAULT '',
    od_payment_address1 VARCHAR(100) NOT NULL DEFAULT '',
    od_payment_address2 VARCHAR(100) NOT NULL DEFAULT '',
    od_payment_city VARCHAR(100) NOT NULL DEFAULT '',
    od_payment_postal_code VARCHAR(10) NOT NULL DEFAULT '',

    PRIMARY KEY (od_id)
) AUTO_INCREMENT = 1001;


CREATE TABLE tbl_order_item (
    od_id INTEGER UNSIGNED NOT NULL,
    pd_id  INTEGER UNSIGNED NOT NULL,
    od_qty INTEGER UNSIGNED NOT NULL,

    PRIMARY KEY (od_id, pd_id)
);


CREATE TABLE tbl_user (
  user_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(20) NOT NULL DEFAULT '',
  user_password VARCHAR(32) NOT NULL DEFAULT '',
  user_regdate DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  user_last_login DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY  (user_id),
  UNIQUE KEY user_name (user_name)
);

INSERT INTO tbl_user VALUES(1, 'admin', PASSWORD('admin'), NOW(), NOW());

CREATE TABLE tbl_shop_config (
    sc_name VARCHAR(50) NOT NULL DEFAULT '',
    sc_address VARCHAR(100) NOT NULL DEFAULT '',
    sc_phone VARCHAR(30) NOT NULL DEFAULT '',
    sc_email VARCHAR(30) NOT NULL DEFAULT '',
    sc_shipping_cost DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    sc_currency INTEGER unsigned NOT NULL DEFAULT 1
);

INSERT INTO tbl_shop_config VALUES ('', '', '', '', 0.00, 1);

CREATE TABLE tbl_currency (
    cy_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    cy_code CHAR(3) NOT NULL,
    cy_symbol VARCHAR(8) NOT NULL,
    PRIMARY KEY (cy_id)
);

INSERT INTO tbl_currency (cy_id, cy_code, cy_symbol) VALUES (1, 'EUR', '&#8364;');
INSERT INTO tbl_currency (cy_id, cy_code, cy_symbol) VALUES (2, 'GBP', '&pound;');
INSERT INTO tbl_currency (cy_id, cy_code, cy_symbol) VALUES (3, 'JPY', '&yen;');
INSERT INTO tbl_currency (cy_id, cy_code, cy_symbol) VALUES (4, 'USD', '$'); 