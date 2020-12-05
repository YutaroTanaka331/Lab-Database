CREATE DATABASE Lab1;
USE Lab1;
/*No 1*/
CREATE TABLE MsCustomer (
CustomerId CHAR(5) PRIMARY KEY NOT NULL,
CustomerName VARCHAR(50),
CustomerGender VARCHAR(10),
CustomerPhone VARCHAR(13),
CustomerAddress VARCHAR(100),
CONSTRAINT chk1 CHECK(CustomerId REGEXP binary '^CU[0-9][0-9][0-9]'),
CONSTRAINT chk2  CHECK(CustomerGender='Male' OR CustomerGender='Female')
);
select *from mscustomer;

CREATE TABLE MsStaff (
StaffId CHAR(5) PRIMARY KEY NOT NULL,
StaffName VARCHAR(50),
StaffGender VARCHAR(10),
StaffPhone VARCHAR(13),
StaffAddress VARCHAR(100),
StaffSalary NUMERIC(11,2),
StaffPosition VARCHAR(20),
CONSTRAINT chk3 CHECK(StaffId REGEXP binary '^SF[0-9][0-9][0-9]'),
CONSTRAINT chk4  CHECK(StaffGender='Male' OR StaffGender='Female')
);
select * from MsStaff; 

CREATE TABLE MsTreatmentType (
TreatmentTypeId CHAR(5) PRIMARY KEY NOT NULL,
TreatmentTypeName VARCHAR(50),
CONSTRAINT chk5 CHECK(TreatmentTypeId REGEXP binary '^TT[0-9][0-9][0-9]')
);
select * from MsTreatmentType;


CREATE TABLE MsTreatment (
TreatmentId CHAR(5) PRIMARY KEY NOT NULL,
TreatmentTypeId CHAR(5) NOT NULL,
TreatmentName VARCHAR(50),
Price NUMERIC(11,2),
CONSTRAINT chk6 CHECK(TreatmentId REGEXP binary '^TM[0-9][0-9][0-9]'),
FOREIGN KEY (TreatmentTypeId) REFERENCES MsTreatmentType (TreatmentTypeId) on update cascade on delete cascade
);
select * from mstreatment;

CREATE TABLE HeaderSalonServices (
TransactionId CHAR(5) PRIMARY KEY NOT NULL,
CustomerId CHAR(5) NOT NULL,
StaffId CHAR(50) NOT NULL,
TransactionDate DATE,
PaymentType VARCHAR(20),
CONSTRAINT chk7 CHECK(TransactionId REGEXP binary '^TR[0-9][0-9][0-9]'),
FOREIGN KEY (CustomerId) REFERENCES MsCustomer (CustomerId) on update cascade on delete cascade,
FOREIGN KEY (StaffId) REFERENCES MsStaff (StaffId) on update cascade on delete cascade
);
select * from headersalonservices;

CREATE TABLE DetailSalonServices (
TransactionId CHAR(5) NOT NULL,
TreatmentId CHAR(5) NOT NULL,
FOREIGN KEY (TransactionId) REFERENCES HeaderSalonServices (TransactionId) on update cascade on delete cascade,
FOREIGN KEY (TreatmentId) REFERENCES MsTreatment (TreatmentId) on update cascade on delete cascade
);
select * from DetailSalonServices;

/*No 2*/
DROP TABLE DetailSalonServices;
/*No 3*/
CREATE TABLE DetailSalonServices (
TransactionId CHAR(5) NOT NULL,
TreatmentId CHAR(5) NOT NULL,
FOREIGN KEY (TransactionId) REFERENCES HeaderSalonServices (TransactionId) on update cascade on delete cascade,
FOREIGN KEY (TreatmentId) REFERENCES MsTreatment (TreatmentId) on update cascade on delete cascade
);
ALTER TABLE DetailSalonServices ADD PRIMARY KEY (TransactionId, TreatmentId);
/*No 4*/
set check_constraint_checks=0;
ALTER TABLE MsStaff ADD CONSTRAINT panjangnama CHECK (char_length(StaffName) >= 5 AND char_length(StaffName) <= 20); 
ALTER TABLE MsStaff DROP CONSTRAINT panjangnama;
set check_constraint_checks = 1;
/*No 5*/
ALTER TABLE MsTreatment ADD DESCRIPTION VARCHAR(100);
ALTER TABLE MsTreatment DROP COLUMN DESCRIPTION;
