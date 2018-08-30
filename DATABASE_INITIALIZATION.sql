
/* SQL script to create all tables in the COMPANY schema. */

CREATE TABLE ACCIDENT_REPORT (
    report_id        INT             NOT NULL UNIQUE,
        CHECK(report_id > 0),
    date_            DATE            NOT NULL,
    description      VARCHAR(20)     NOT NULL,
        CHECK(LEN(description) > 0),
    customer_id      INT             NOT NULL,
        CHECK(customer_id > 0),
    vin              INT             NOT NULL,
        CHECK(vin > 0) );
		

CREATE TABLE ADDITIONAL_PACKAGES (
	package_id		 INT		     NOT NULL UNIQUE,
		CHECK(package_id > 0),
	additional_price INT,
	description	     VARCHAR(100)    NOT NULL,
		CHECK(LEN(description) > 0) );

CREATE TABLE CAR (
    vin				 INT		     NOT NULL UNIQUE,
        CHECK(vin > 0),
    model_no		 INT             NOT NULL,
        CHECK(model_no > 0),
    color			 VARCHAR(20)     NOT NULL,
        CHECK(LEN(color) > 0) );

CREATE TABLE CAR_MODEL (
    model_no   		 INT             NOT NULL UNIQUE,
        CHECK(model_no > 0),
    year_			 SMALLINT        NOT NULL,
        CHECK(year_ > 1990),
    name			 VARCHAR(40)     NOT NULL,
        CHECK(LEN(name) > 0) );

CREATE TABLE CUSTOMER (
	customer_id		 INT				NOT NULL UNIQUE,
	first_name		 VARCHAR(20),
		CHECK(LEN(first_name) > 1),
	last_name		 VARCHAR(20)		NOT NULL,
		CHECK(LEN(last_name) > 1) );

CREATE TABLE DEALERSHIP (
	dealership_id	INT				NOT NULL UNIQUE,
		CHECK (dealership_id > 0),
	dealership_name VARCHAR(20)		NOT NULL,
		CHECK (LEN(dealership_name) > 0),
	staff_id		INT				NOT NULL,
		CHECK (staff_id > 0),
	location_id		INT				NOT NULL,
		CHECK (location_id > 0) );

CREATE TABLE LOAN (
	loan_id			INT				NOT NULL UNIQUE,
		CHECK(loan_id > 0),
	date_issued		DATE			NOT NULL,
	balance			DECIMAL(10, 2)	NOT NULL,
		CHECK(balance > 0),
	amount			DECIMAL(10, 2)	NOT NULL,
		CHECK(amount > 0),
	customer_id		INT				NOT NULL,
		CHECK(customer_id > 0),
	vin				INT				NOT NULL,
		CHECK(vin > 0) );

CREATE TABLE LOC (
    location_id		INT				NOT NULL UNIQUE,
	   CHECK(location_id > 0),
    street			VARCHAR(20)		NOT NULL,
	   CHECK(LEN(street) > 2),
    city			VARCHAR(20)		NOT NULL,
	   CHECK(LEN(city) > 2),
    us_state	    CHAR(2)			NOT NULL,
    zip				VARCHAR(5)		NOT NULL );

CREATE TABLE MANUFACTURER (
	manufacturer_id INT				NOT NULL UNIQUE,
		CHECK (manufacturer_id > 0),
	location_id		INT				NOT NULL,
		CHECK (location_id > 0) );

CREATE TABLE MANUFACTURING_ORDER (
	order_id		INT				NOT NULL UNIQUE,
		CHECK(order_id > 0),
	quantity		INT				NOT NULL,
		CHECK(quantity > 0),
	total_price		DECIMAL(10, 2)	NOT NULL,
		CHECK(total_price >= 0),
	staff_id		INT				NOT NULL,
		CHECK(staff_id > 0),
	model_no		INT				NOT NULL,
		CHECK(model_no > 0) );

CREATE TABLE MONTHLY_PAYMENT (
	loan_id			INT				NOT NULL UNIQUE,
		CHECK(loan_id > 0),
	payment_id		INT				NOT NULL,
		CHECK(payment_id > 0),
	amount			DECIMAL(10, 2)	NOT NULL,
		CHECK(amount > 0),
	payment_date	DATE			NOT NULL );

CREATE TABLE ORDERS_FROM (
	dealership_id	INT				NOT NULL,
	manufacturer_id INT				NOT NULL );

CREATE TABLE RECEIVES (
    review_id		INT				NOT NULL UNIQUE,
        CHECK(review_id > 0),
    d_flag			BIT				NOT NULL,
		CHECK(d_flag = 0 OR d_flag = 1),
	s_flag			BIT				NOT NULL,
		CHECK(s_flag = 0 OR s_flag = 1),
	v_flag			BIT				NOT NULL,
		CHECK(v_flag = 0 OR v_flag = 1),
	staff_id		INT				NOT NULL );

CREATE TABLE REVIEW (
	review_id		INT				NOT NULL UNIQUE,
		CHECK(review_id > 0),
	comments		VARCHAR(100),
	rating			INT				NOT NULL,
		CHECK(rating <= 5 and rating >= 1),
	d_flag			BIT				NOT NULL,
		CHECK(d_flag = 0 OR d_flag = 1),
	dealership_id	INT,
		CHECK(d_flag = 0 AND dealership_id IS NULL OR d_flag = 1 AND dealership_id > 0),
	s_flag			BIT				NOT NULL,
		CHECK(s_flag = 0 OR s_flag = 1),
	salesman_id		INT,
		CHECK(s_flag = 0 AND salesman_id IS NULL OR s_flag = 1 AND salesman_id > 0),
	v_flag			BIT				NOT NULL,
		CHECK(v_flag = 0 OR v_flag = 1),
	vin				INT,
		CHECK(v_flag = 0 AND vin IS NULL OR v_flag = 1 AND vin > 0),
	customer_id		INT				NOT NULL,
		CHECK(customer_id > 0) );

CREATE TABLE SALE (
    sale_id         INT             NOT NULL UNIQUE,
        CHECK(sale_id >= 0),
    price			DECIMAL(10, 2)  NOT NULL,
        CHECK(price >= 0),
    customer_id     INT             NOT NULL,
        CHECK(customer_id > 0),
    vin             INT             NOT NULL,
        CHECK(vin > 0),
    date_           DATE            NOT NULL,
    staff_id		INT				NOT NULL,
        CHECK(staff_id > 0) );

CREATE TABLE SERV(
    service_id		INT             NOT NULL UNIQUE,
        CHECK(service_id > 0),
    mileage			INT             NOT NULL,
        CHECK(mileage >= 0),
    date_			DATE            NOT NULL,
    cost			DECIMAL(10, 2)  NOT NULL,
        CHECK(cost >= 0),
    type_id			INT             NOT NULL,
        CHECK(type_id > 0),
	vin				INT				NOT NULL,
		CHECK(vin > 0) );

CREATE TABLE SERVICE_TYPE (
	service_type_id INT				NOT NULL UNIQUE,
		CHECK(service_type_id > 0),
	description		VARCHAR(100)	NOT NULL,
	hrs_required	INT				NOT NULL,
		CHECK(hrs_required > 0 and hrs_required < 1000) );

CREATE TABLE STAFF (
	staff_id		INT				NOT NULL UNIQUE,
		CHECK (staff_id > 0),
  	first_name		VARCHAR(20)		NOT NULL,
		CHECK (LEN(first_name) > 0),
  	last_name		VARCHAR(20)		NOT NULL,
		CHECK (LEN(first_name) > 0),
  	m_flag			BIT				NOT NULL,
		CHECK (m_flag = 0 OR m_flag = 1),
  	salary			DECIMAL(10, 2),
		CHECK (m_flag = 0 AND salary IS NULL OR m_flag = 1 AND salary > 0),
 	s_flag			BIT				NOT NULL,
		CHECK (s_flag = 0 OR s_flag = 1),
  	total_commission DECIMAL(10, 2),
		CHECK (s_flag = 0 AND total_commission IS NULL OR s_flag = 1 AND total_commission > 0),
  	no_of_sales		INT,
		CHECK (s_flag = 0 AND no_of_sales IS NULL OR s_flag = 1 AND no_of_sales > -1),
  	location_id		INT				NOT NULL,
		CHECK (location_id > 0),
  	manager_id		INT,
		CHECK (manager_id > 0 OR manager_id IS NULL) );

CREATE TABLE WARRANTY (
    warranty_id     INT             NOT NULL UNIQUE,
        CHECK(warranty_id > 0),
    miles_covered   INT,
        CHECK(miles_covered > 0 OR miles_covered IS NULL),
    years_covered   INT
        CHECK(years_covered > 0 OR years_covered IS NULL),
    expiration_date DATE            NOT NULL,
    vin             INT             NOT NULL,
        CHECK(vin > 0) );
		
/* SQL script to add primary key(s) to all tables in the COMPANY schema. */

ALTER TABLE ACCIDENT_REPORT ADD PRIMARY KEY(report_id);
ALTER TABLE ADDITIONAL_PACKAGES ADD PRIMARY KEY(package_id);
ALTER TABLE CAR ADD PRIMARY KEY(vin);
ALTER TABLE CAR_MODEL ADD PRIMARY KEY(model_no);
ALTER TABLE CUSTOMER ADD PRIMARY KEY(customer_id);
ALTER TABLE DEALERSHIP ADD PRIMARY KEY(dealership_id);
ALTER TABLE LOAN ADD PRIMARY KEY(loan_id);
ALTER TABLE LOC ADD PRIMARY KEY(location_id);
ALTER TABLE MANUFACTURER ADD PRIMARY KEY(manufacturer_id);
ALTER TABLE MANUFACTURING_ORDER ADD PRIMARY KEY(order_id);
ALTER TABLE MONTHLY_PAYMENT ADD PRIMARY KEY(loan_id);
ALTER TABLE REVIEW ADD PRIMARY KEY(review_id);
ALTER TABLE SALE ADD PRIMARY KEY(sale_id);
ALTER TABLE SERV ADD PRIMARY KEY(service_id);
ALTER TABLE SERVICE_TYPE ADD PRIMARY KEY(service_type_id);
ALTER TABLE STAFF ADD PRIMARY KEY(staff_id);
ALTER TABLE WARRANTY ADD PRIMARY KEY(warranty_id);


/* SQL script to add foreign key(s) to all necessary tables in the COMPANY schema. */

ALTER TABLE ACCIDENT_REPORT
ADD FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id);
ALTER TABLE ACCIDENT_REPORT
ADD FOREIGN KEY (vin) REFERENCES CAR(vin);

ALTER TABLE CAR
ADD FOREIGN KEY (model_no) REFERENCES CAR_MODEL(model_no);

ALTER TABLE DEALERSHIP
ADD FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id);
ALTER TABLE DEALERSHIP
ADD FOREIGN KEY (location_id) REFERENCES LOC(location_id);

ALTER TABLE LOAN
ADD FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id);
ALTER TABLE LOAN
ADD FOREIGN KEY (vin) REFERENCES CAR(vin);

ALTER TABLE MANUFACTURER
ADD FOREIGN KEY (location_id) REFERENCES LOC(location_id);

ALTER TABLE MANUFACTURING_ORDER
ADD FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id);
ALTER TABLE MANUFACTURING_ORDER
ADD FOREIGN KEY (model_no) REFERENCES CAR_MODEL(model_no);

ALTER TABLE ORDERS_FROM
ADD FOREIGN KEY (dealership_id) REFERENCES DEALERSHIP(dealership_id);
ALTER TABLE ORDERS_FROM
ADD FOREIGN KEY (manufacturer_id) REFERENCES MANUFACTURER(manufacturer_id);

ALTER TABLE RECEIVES
ADD FOREIGN KEY (review_id) REFERENCES REVIEW(review_id);
ALTER TABLE RECEIVES
ADD FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id);

ALTER TABLE REVIEW
ADD FOREIGN KEY (dealership_id) REFERENCES DEALERSHIP(dealership_id);
ALTER TABLE REVIEW
ADD FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id);
ALTER TABLE REVIEW
ADD FOREIGN KEY (vin) REFERENCES CAR(vin);

ALTER TABLE SALE
ADD FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id);
ALTER TABLE SALE
ADD FOREIGN KEY (vin) REFERENCES CAR(vin);
ALTER TABLE SALE
ADD FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id);

ALTER TABLE SERV
ADD FOREIGN KEY (type_id) REFERENCES SERVICE_TYPE(service_type_id);
ALTER TABLE SERV
ADD FOREIGN KEY (vin) REFERENCES CAR(vin);

ALTER TABLE STAFF
ADD FOREIGN KEY (manager_id) REFERENCES STAFF(staff_id);
ALTER TABLE STAFF
ADD FOREIGN KEY (location_id) REFERENCES LOC(location_id);

ALTER TABLE WARRANTY
ADD FOREIGN KEY (vin) REFERENCES CAR(vin);

/* SQL script to create all indexes in the COMPANY schema. */

CREATE INDEX cust_lname
ON CUSTOMER (last_name);

CREATE INDEX staff_lname
ON STAFF (last_name);

CREATE INDEX deal_name
ON DEALERSHIP (dealership_name);

CREATE INDEX cust_id
ON ACCIDENT_REPORT (customer_id);

CREATE INDEX cust_id
ON LOAN (customer_id);

CREATE INDEX v_id
ON LOAN (vin);


