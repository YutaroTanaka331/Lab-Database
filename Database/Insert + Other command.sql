/* Perubahan Pada database Master */

insert into DetailSalonServices values("TR009", "TM005"),("TR019", "TM006");
insert into HeaderSalonServices values("TR019", "CU005", "SF004", '2020-09-22', "Credit");

/* End */

UPDATE MsCustomer SET CustomerPhone = concat('628', substring(CustomerPhone, 3));

UPDATE MsCustomer INNER JOIN HeaderSalonServices ON(MsCustomer.CustomerId = HeaderSalonServices.CustomerId)
SET MsCustomer.CustomerName = LEFT(CustomerName, instr (CustomerName,' '))
WHERE  DAY(TransactionDate)=24;

UPDATE MsCustomer SET CustomerName = concat('Ms. ', CustomerName) 
WHERE (CustomerId = 'CU002' OR CustomerId = 'CU003');

UPDATE MsCustomer 
JOIN HeaderSalonServices ON(MsCustomer.CustomerId = HeaderSalonServices.CustomerId)
JOIN MsStaff ON(HeaderSalonServices.StaffId = MsStaff.StaffId)
SET MsCustomer.CustomerAddress = ('Daan Mogot Baru Street No. 23')
WHERE  (dayname(transactiondate)= 'thursday' AND StaffName = 'Indra Saswita');

select * from MsCustomer;

insert into MsCustomer values("CU001","Franky","Male","08565543338","Daan mogot baru street no 6"),
("CU002","Emalia Dewi","Female","085264782135","Tanjung Duren Street no 185"),
("CU003","Elysia Chen","Female","085754206611","Kebon Jeruk Street no 88"),
("CU004","Brando Kartawijaya","Male","081170224461","Greenvil Street no 88"),
("CU005","Andy Putra","Male","087751321421","Sunter Street no 42");

drop table MsCustomer;

desc MsCustomer;

insert into MsStaff values('SF001','Dian Felita Tanoto','Female','085265442222','Palmerah Street no 56','15000000','Top Stylist'),
('SF002','Melissa Pratiwi','Female','085755552011','Kebon jeruk Street no 151','10000000','Top Stylist'),  
('SF003','Livia Ashianti','Female','085755552011','Kebon jeruk Street no 19','7000000','Stylist'), 
('SF004','Indra Saswita','Male','085755552011','Sunter Street no 91','7000000','Stylist'),
('SF005','Ryan Nixon Salim','Male','085755552011','Kebon jeruk Street no 123','3000000','Stylist'),
("SF006", "Jeklin Harefa", "Female", "085265433322", "Kebon Jeruk Street no 140", "3000000", "Stylist"),
("SF007", "Lavinia", "Female", "085755500011", "Kebon Jeruk Street no 153", "3000000", "Stylist"),  
("SF008", "Stephen Adrianto", "Male", "085564223311", "Mandala Street no 14", "3000000", "Stylist"), 
("SF009", "Rico Wijaya", "Male", "085710252525", "Keluarga Street no 78", "3000000", "Stylist");

insert into MsStaff values ("SF010", "Effendy Lesmana", "Male", "085218587878", 
"Tanggerang City Street no 88", FLOOR(RAND()*(5000000-3000000+1)+3000000), "Stylist");

UPDATE MsStaff SET StaffPosition = 'Top Stylist', StaffSalary=StaffSalary+7000000
where StaffName LIKE 'Effendy Lesmana';

select StaffName, CONCAT('Rp.', StaffSalary)as StaffSalary from MsStaff 
where StaffSalary >= 10000000 AND StaffName like '%m%';

select * from MsStaff;

drop table MsStaff;

insert into mstreatmenttype values ('TT001', 'Hair treatment'),
('TT002', 'Hair Spa Treatment'),
('TT003', 'Make Up and Facial'),
('TT004', 'Menicure Pedicure'),
('TT005', 'Premium Treatment');
select * from MsTreatmentType;
UPDATE MsTreatmentType SET TreatmentTypeName = 'Nail Treatment'
where TreatmentTypeName LIKE 'Menicure Pedicure';
drop table MsTreatmentType;

select * from HeaderSalonServices;
set foreign_key_checks=0;
insert into HeaderSalonServices values ('TR001', 'CU001', 'SF004', '2012-12-20', 'Credit'),
('TR002', 'CU002', 'SF005', '2012-12-20', 'Credit'),
('TR003', 'CU003', 'SF003', '2012-12-20', 'Cash'),
('TR004', 'CU004', 'SF005', '2012-12-20', 'Debit'),
('TR005', 'CU005', 'SF003', '2012-12-21', 'Debit'),
('TR006', 'CU001', 'SF005', '2012-12-21', 'Credit'),
('TR007', 'CU002', 'SF001', '2012-12-22', 'Cash'),
('TR008', 'CU003', 'SF002', '2012-12-22', 'Credit'),
('TR009', 'CU005', 'SF004', '2012-12-22', 'Debit'),
('TR010', 'CU001', 'SF004', '2012-12-23', 'Credit'),
('TR011', 'CU002', 'SF006', '2012-12-24', 'Credit'),
('TR012', 'CU003', 'SF007', '2012-12-24', 'Cash'),
('TR013', 'CU004', 'SF005', '2012-12-25', 'Debit'),
('TR014', 'CU005', 'SF007', '2012-12-25', 'Debit'),
('TR015', 'CU005', 'SF005', '2012-12-26', 'Credit'),
('TR016', 'CU002', 'SF001', '2012-12-26', 'Cash'),
('TR017', 'CU003', 'SF002', '2012-12-26', 'Credit'),
('TR018', 'CU005', 'SF001', '2012-12-27', 'Debit');
insert into HeaderSalonServices values("TR019", "CU005", "SF004", curdate()+3, "Credit");
DELETE HeaderSalonServices FROM HeaderSalonServices 
INNER JOIN MsCustomer ON (MsCustomer.CustomerId = HeaderSalonServices.CustomerId)
WHERE instr (CustomerName,' ') = 0;
UPDATE headersalonservices SET TransactionId = 'TR019', CustomerId = 'CU005', StaffId = 'SF004', 
TransactionDate = '2020-9-22', PaymentType = 'Credit'
where TransactionId LIKE 'TR019';

select * from HeaderSalonServices;
drop table headerSalonServices;

insert into DetailSalonServices values("TR010", "TM003"),
("TR010", "TM005"), ("TR010", "TM010"), ("TR011", "TM015"),
("TR011", "TM025"), ("TR012", "TM009"), ("TR013", "TM003"),
("TR013", "TM006"), ("TR013", "TM015"), ("TR014", "TM016"),
("TR015", "TM016"), ("TR015", "TM006"), ("TR016", "TM015"),
("TR016", "TM003"), ("TR016", "TM005"), ("TR017", "TM003"),
("TR018", "TM006"), ("TR018", "TM005"), ("TR018", "TM007");
select * from DetailSalonServices;
insert into DetailSalonServices values("TR009", "TM005"),("TR019", "TM006");
select * from DetailSalonServices;

INSERT INTO MsTreatment VALUES	('TM001', 'TT001', 'Cutting by Stylist','150000'),
('TM002', 'TT001', 'Cutting by Top Stylist','450000'),
('TM003', 'TT001', 'Cutting Pony','50000'),
('TM004', 'TT001', 'Blow','90000'),
('TM005', 'TT001', 'Coloring','480000'),
('TM006', 'TT001', 'Highlight','320000'),
('TM007', 'TT001', 'Japanese Perm','700000'),
('TM008', 'TT001', 'Digital Perm','1100000'),
('TM009', 'TT001', 'Special Perm','1100000'),
('TM010', 'TT001', 'Rebonding Treatment','1100000'),
('TM011', 'TT002', 'Creambath','150000'),
('TM012', 'TT002', 'Hair Spa','250000'),
('TM013', 'TT002', 'Hair Mask','250000'),
('TM014', 'TT002', 'Hand Spa Reflexy','200000'),
('TM015', 'TT002', 'Reflexy','250000'),
('TM016', 'TT002', 'Back Therapy Massage','300000'),
('TM017', 'TT003', 'Make Up','500000'),
('TM018', 'TT003', 'Make Up Wedding','5000000'),
('TM019', 'TT003', 'Facial','300000'),
('TM020', 'TT004', 'Manicure','80000'),
('TM021', 'TT004', 'Pedicure','100000'),
('TM022', 'TT004', 'Nail Extension','250000'),
('TM023', 'TT004', 'Nail Acrylic Infill','340000'),
('TM024', 'TT005', 'Japanese Treatment','350000'),
('TM025', 'TT005', 'Scalp Treatment','250000'),
('TM026', 'TT005', 'Crystal Treatment','400000');

DELETE MsTreatment FROM MsTreatment 
JOIN MsTreatmentType ON (MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId)
WHERE TreatmentTypeName NOT LIKE ('%treatment%');

select TreatmentName, Price from MsTreatment, MsTreatmentType 
where MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId 
and TreatmentTypeName in ('Hair Spa Treatment','Premium Treatment');

select * from MsTreatment;

select MsCustomer.CustomerId, HeaderSalonServices.TransactionId, MsCustomer.CustomerName, 
sum(MsTreatment.price) as 'Total Price' 
from HeaderSalonServices, (select sum(price) as harga from MsTreatment) as total
join MsCustomer on (MsCustomer.CustomerId = HeaderSalonServices.CustomerId) 
join DetailSalonServices on (DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId)
join MsTreatment on (DetailSalonServices.TreatmentId = MsTreatment.TreatmentId)
group by MsCustomer.CustomerId, HeaderSalonServices.TransactionId, MsCustomer.CustomerName, 'Total Price'
having sum(MsTreatment.price) >  avg(total.harga)
order by sum(MsTreatment.price) desc;  