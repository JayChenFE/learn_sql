/*
Microsoft TSQL Crash Course
http://www.forta.com/books/0672337924/
Example table creation scripts
*/


/*
Create customers table
*/
CREATE TABLE customers
    (
      cust_id INT NOT NULL
                  IDENTITY(1, 1) ,
      cust_name NCHAR(50) NOT NULL ,
      cust_address NCHAR(50) NULL ,
      cust_city NCHAR(50) NULL ,
      cust_state NCHAR(5) NULL ,
      cust_zip NCHAR(10) NULL ,
      cust_country NCHAR(50) NULL ,
      cust_contact NCHAR(50) NULL ,
      cust_email NCHAR(255) NULL
    );
ALTER TABLE customers
ADD CONSTRAINT pk_customers PRIMARY KEY (cust_id);


/*
Create orderitems table
*/
CREATE TABLE orderitems
    (
      order_num INT NOT NULL ,
      order_item INT NOT NULL ,
      prod_id NCHAR(10) NOT NULL ,
      quantity INT NOT NULL ,
      item_price MONEY NOT NULL
    );
ALTER TABLE orderitems
ADD CONSTRAINT pk_orderitems PRIMARY KEY (order_num, order_item);


/*
Create orders table
*/
CREATE TABLE orders
    (
      order_num INT NOT NULL
                    IDENTITY(1, 1) ,
      order_date DATETIME NOT NULL ,
      cust_id INT NOT NULL
    );
ALTER TABLE orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_num);


/*
Create products table
*/
CREATE TABLE products
    (
      prod_id NCHAR(10) NOT NULL ,
      vend_id INT NOT NULL ,
      prod_name NCHAR(255) NOT NULL ,
      prod_price MONEY NOT NULL ,
      prod_desc NTEXT NULL
    );
ALTER TABLE products
ADD CONSTRAINT pk_products PRIMARY KEY (prod_id);


/*
Create vendors table
*/
CREATE TABLE vendors
    (
      vend_id INT NOT NULL
                  IDENTITY(1, 1) ,
      vend_name NCHAR(50) NOT NULL ,
      vend_address NCHAR(50) NULL ,
      vend_city NCHAR(50) NULL ,
      vend_state NCHAR(5) NULL ,
      vend_zip NCHAR(10) NULL ,
      vend_country NCHAR(50) NULL
    );
ALTER TABLE vendors
ADD CONSTRAINT pk_vendors PRIMARY KEY (vend_id);


/*
Create productnotes table
*/
CREATE TABLE productnotes
    (
      note_id INT NOT NULL
                  IDENTITY(1, 1) ,
      prod_id NCHAR(10) NOT NULL ,
      note_date DATETIME NOT NULL ,
      note_text NTEXT NULL
    );
ALTER TABLE productnotes
ADD CONSTRAINT pk_productnotes PRIMARY KEY (note_id);


/*
Define foreign keys
*/
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_num) REFERENCES orders (order_num);
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_products FOREIGN KEY (prod_id) REFERENCES products (prod_id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (cust_id) REFERENCES customers (cust_id);
ALTER TABLE products ADD CONSTRAINT fk_products_vendors FOREIGN KEY (vend_id) REFERENCES vendors (vend_id);
ALTER TABLE productnotes ADD CONSTRAINT fk_productnotes_products FOREIGN KEY (prod_id) REFERENCES products (prod_id);
