
-- create users table
CREATE TABLE users 
( 
    ID NUMBER(15) CONSTRAINT USERS_PK PRIMARY KEY,
    NAME VARCHAR2(50) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(50) UNIQUE NOT NULL,
    PHONE_NUMBER NUMBER(15) UNIQUE NOT NULL,
    USER_TYPE VARCHAR2(2) NOT NULL CHECK(USER_TYPE IN ('AD','CU','CO'))
);

-- create table company
CREATE TABLE company 
(
    ID NUMBER(15) CONSTRAINT COMPANY_PK PRIMARY KEY,
    COMPANY_URL VARCHAR2(1000) UNIQUE NOT NULL,
    RATING NUMBER(5),
    FOREIGN KEY(ID) REFERENCES users(ID) ON DELETE CASCADE
);

--create table customer
CREATE TABLE customer 
(
    ID NUMBER(15) CONSTRAINT CUSTOMER_PK PRIMARY KEY,
    ACCOUNT_CREATED_ON DATE DEFAULT SYSDATE NOT NULL, 
    FOREIGN KEY(ID) REFERENCES users(ID) ON DELETE CASCADE
);

--create table admin
CREATE TABLE admin 
(
    ID NUMBER(15) CONSTRAINT ADMIN_PK PRIMARY KEY,
    FOREIGN KEY(ID) REFERENCES users(ID) ON DELETE CASCADE
);

--create table locations
CREATE TABLE locations
(
    LOCATION_ID NUMBER(15) CONSTRAINT LOCATIONS_PK PRIMARY KEY,
    COUNTRY VARCHAR2(15) NOT NULL,
    DIVISION VARCHAR2(15),
    CITY VARCHAR2(25) UNIQUE
);

--create table cars
CREATE TABLE cars
(
MODEL_COLOR_ID NUMBER(15) CONSTRAINT CARS_PK PRIMARY KEY,
MODEL_NAME VARCHAR2(25) NOT NULL,
SEAT_CAP NUMBER(5) NOT NULL,
ENGINE_CAP NUMBER(10) NOT NULL,
COLOR VARCHAR2(15) NOT NULL,
PRICE NUMBER(25) NOT NULL, 
LAUNCH_DATE DATE NOT NULL,
STOCK NUMBER(5) NOT NULL,
WARRANTY NUMBER(10) NOT NULL,
COMPANY_ID NUMBER(15),
CAR_IMAGE_URL VARCHAR2(1000),
FOREIGN KEY(COMPANY_ID) REFERENCES company(ID) ON DELETE CASCADE
);

--create table cartype
CREATE TABLE cartype
(
    TYPE_ID VARCHAR2(15) CONSTRAINT CARTYPE_PK PRIMARY KEY,
    TYPE_NAME VARCHAR2(50) UNIQUE NOT NULL,
    CAR_TYPE_URL VARCHAR2(1000)
);

--create table showroom
CREATE TABLE showroom
(
    SHOWROOM_ID NUMBER(15) CONSTRAINT SHOWROOM_PK PRIMARY KEY,
    LOCATION_ID NUMBER(10) NOT NULL,
    FOREIGN KEY(LOCATION_ID) REFERENCES locations(LOCATION_ID) ON DELETE CASCADE
);

--create table cart
CREATE TABLE cart
(
    CART_ID NUMBER(15) CONSTRAINT CART_PK PRIMARY KEY,
    MODEL_COLOR_ID NUMBER,
    CUSTOMER_ID NUMBER,
    CONFIRM_STATUS VARCHAR2(20) CHECK(CONFIRM_STATUS IN ('CONFIRMED','NOT_CONFIRMED')),
    FOREIGN KEY(MODEL_COLOR_ID) REFERENCES cars(MODEL_COLOR_ID),
    FOREIGN KEY(CUSTOMER_ID) REFERENCES customer(ID)
);

--create table orderlist
CREATE TABLE orderlist
(
    ORDER_ID NUMBER(25) CONSTRAINT ORDERLIST_PK PRIMARY KEY,
    ORDER_DATE DATE DEFAULT SYSDATE NOT NULL,
    ORDER_STATE VARCHAR2(25)  NOT NULL CHECK(ORDER_STATE IN ('PROCESSING','SHIPPING','DELIVERED')),
    PAYMENT_METHOD VARCHAR2(25) NOT NULL,
    PAYMENT_STATUS VARCHAR2(25) NOT NULL CHECK(PAYMENT_STATUS IN ('PAID','NOT_PAID')) ,
    CART_ID NUMBER(25) UNIQUE NOT NULL,
    FOREIGN KEY(CART_ID) REFERENCES cart(CART_ID) 
);

--create table voucher
CREATE TABLE voucher
(
    VOUCHER_NO NUMBER(15) CONSTRAINT VOUCHER_PK PRIMARY KEY,
    VOUCHER_NAME VARCHAR2(50) NOT NULL,
    DISCOUNT VARCHAR2(20) NOT NULL,
    VALIDITY_DATE DATE NOT NULL,
    ADD_TYPE VARCHAR2(5) NOT NULL CHECK(ADD_TYPE IN ('AD','CO') )
);

CREATE TABLE comments
(
    -- COMMENT_ID NUMBER(15) CONSTRAINT COMMENTS_PK PRIMARY KEY,
    COMMENT_TEXT VARCHAR2(1000),
    RATING NUMBER(5) ,
    MODEL_COLOR_ID NUMBER ,
    CUSTOMER_ID NUMBER,
    PRIMARY KEY (MODEL_COLOR_ID,CUSTOMER_ID),
    FOREIGN KEY(MODEL_COLOR_ID) REFERENCES cars(MODEL_COLOR_ID),
    FOREIGN KEY(CUSTOMER_ID) REFERENCES customer(ID)
);

CREATE TABLE company_type_table
(
    ID NUMBER(15) CONSTRAINT ctt_pk PRIMARY KEY,
    COMPANY_ID NUMBER(15),
    TYPE_ID VARCHAR2(15),
    FOREIGN KEY (COMPANY_ID) REFERENCES company(ID),
    FOREIGN KEY (TYPE_ID) REFERENCES cartype(TYPE_ID)
);

CREATE TABLE rating
(
    RATING NUMBER(5) ,
    MODEL_COLOR_ID NUMBER ,
    CUSTOMER_ID NUMBER,
    PRIMARY KEY (MODEL_COLOR_ID,CUSTOMER_ID),
    FOREIGN KEY(MODEL_COLOR_ID) REFERENCES cars(MODEL_COLOR_ID),
    FOREIGN KEY(CUSTOMER_ID) REFERENCES customer(ID)
);

ALTER TABLE company
ADD LOCATION_ID NUMBER;
ALTER TABLE company
ADD FOREIGN KEY(LOCATION_ID) REFERENCES locations(LOCATION_ID);

ALTER TABLE customer
ADD LOCATION_ID NUMBER
ADD FOREIGN KEY(LOCATION_ID) REFERENCES locations(LOCATION_ID);

ALTER TABLE cars
ADD TYPE_ID VARCHAR2(15)
ADD VOUCHER_NO NUMBER
ADD FOREIGN KEY (TYPE_ID) REFERENCES cartype(TYPE_ID)
ADD FOREIGN KEY (VOUCHER_NO) REFERENCES voucher(VOUCHER_NO);

ALTER TABLE orderlist
ADD VOUCHER_NO NUMBER
ADD FOREIGN KEY(VOUCHER_NO) REFERENCES voucher(VOUCHER_NO);

ALTER TABLE orderlist
ADD SHOWROOM_ID NUMBER
ADD FOREIGN KEY(SHOWROOM_ID) REFERENCES showroom(SHOWROOM_ID);

ALTER table cart
ADD CAR_COUNT NUMBER;
ALTER table showroom
ADD SHOWROOM_NAME VARCHAR2(25);

ALTER table orderList
ADD DUE NUMBER;

ALTER TABLE comments
ADD (COMMENT_ID NUMBER(15));

ALTER TABLE comments
DROP PRIMARY KEY;

ALTER TABLE comments
ADD CONSTRAINT COMMENTS_PK PRIMARY KEY (COMMENT_ID);

ALTER TABLE COMMENTS
DROP COLUMN RATING;



--- extra table ---

CREATE TABLE user_backup
( 
    ID NUMBER(15) CONSTRAINT USERS_BACKUP_PK PRIMARY KEY,
    NAME VARCHAR2(50) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(50) UNIQUE NOT NULL,
    PHONE_NUMBER NUMBER(15) UNIQUE NOT NULL,
    USER_TYPE VARCHAR2(2) NOT NULL CHECK(USER_TYPE IN ('AD','CU','CO')),
	ACCOUNT_CREATED_ON DATE
);
