/*
   Schema for a postgres setup
*/

-- Make the database
-- NOTE: you will need to change the owner to one that exists in your DB
CREATE DATABASE dallas_por_zipcode
  WITH ENCODING='UTF8'
       OWNER=barrettclark
       CONNECTION LIMIT=-1;

-- Make the zipcode table
CREATE TABLE zipcode
(
   zip character(5) NOT NULL, 
   city character varying, 
   state character(2), 
   latitude real, 
   longitude real, 
   timezone integer, 
   dst integer, 
   CONSTRAINT zipcode_pk PRIMARY KEY (zip)
) 
WITH (
  OIDS = FALSE
)
;

CREATE DATABASE dallas_por_zipcode_test
  WITH ENCODING='UTF8'
       OWNER=barrettclark
       CONNECTION LIMIT=-1;

-- Make the zipcode table
CREATE TABLE zipcode
(
   zip character(5) NOT NULL, 
   city character varying, 
   state character(2), 
   latitude real, 
   longitude real, 
   timezone integer, 
   dst integer, 
   CONSTRAINT zipcode_pk PRIMARY KEY (zip)
) 
WITH (
  OIDS = FALSE
)
;
