/*No 1 modul 8 (Mysql tidak ada Stuff) */

create view ViewBonus as
select insert (CustomerId, 1, 2, 'BN') as BinusId, CustomerName
from MsCustomer
where length(CustomerName) > 10;

select *from ViewBonus;

/*No 2 modul 8*/

create view ViewCustomerData as
select  SUBSTRING_INDEX(CustomerName, ' ', 1) as Name, CustomerAddress as Address,
CustomerPhone as Phone
from MsCustomer
where instr (CustomerName,' ') != 0;

select *from ViewCustomerData;

/*No 3 modul 8*/

create view ViewTreatment as
select  TreatmentName, TreatmentTypeName, concat ('Rp. ', Price) as Price 
from MsTreatment, MsTreatmentType
where MsTreatmentType.TreatmentTypeId = Mstreatment.TreatmentTypeId 
and Price between 450000 and 800000
and TreatmentTypeName = 'Hair Treatment';

select *from ViewTreatment;

/*No 4 modul 8*/

create view ViewTransaction as
select StaffName, CustomerName, date_format(TransactionDate, '%e %b %Y') as TransactionDate,
PaymentType
from MsStaff, MsCustomer, HeaderSalonServices
where MsStaff.StaffId = HeaderSalonservices.StaffId
and MsCustomer.CustomerId = HeaderSalonservices.CustomerId
and Day(Transactiondate) between 21 and 25
and PaymentType = 'Credit';

select *from ViewTransaction;

/*No 5 modul 8*/

create view ViewBonusCustomer as 
select replace(MsCustomer.CustomerId,'CU','BN')as BonusId, 
lower(Substring(CustomerName, instr(CustomerName, ' ')+1)) as Name, 
dayname(TransactionDate) as Day, 
date_format(TransactionDate, '%m/%d/%Y') as TransactionDate, Staffname
from MsCustomer, HeaderSalonServices, MsStaff
where MsCustomer.CustomerId = HeaderSalonservices.CustomerId
and MsStaff.StaffId = HeaderSalonservices.StaffId
and instr (CustomerName,' ') != 0
and SUBSTRING_INDEX(StaffName,' ',-1) like '%a%';

select *from ViewBonusCustomer;

/*No 6 modul 8(TR01 - TR09 tidak ada di DetailSalonServices)*/

create view ViewTransactionByLivia as 
select StaffName, HeaderSalonServices.TransactionId as TransactionId, 
date_format(TransactionDate, '%b %e, %Y') as Date, TreatmentName
from Mstreatment, HeaderSalonServices, DetailSalonServices, MsStaff
where mstreatment.TreatmentId = detailsalonservices.TreatmentId 
and headersalonservices.TransactionId = detailsalonservices.TransactionId
and Day(Transactiondate) like 23
and StaffName like 'Livia Ashianti';

select *from ViewTransactionByLivia;

/*No 7 modul 8*/

alter algorithm=merge
view ViewCustomerData as
select right(CustomerId, 3) as Id, CustomerName as Name, CustomerAddress as Address,
CustomerPhone as Phone
from MsCustomer
where instr (CustomerName,' ') != 0; 

select *from ViewCustomerData;

/*No 8 modul 8*/

create view ViewCustomer as 
select CustomerId, CustomerName, CustomerGender, 
CustomerPhone, CustomerAddress
from MsCustomer;
insert into ViewCustomer values ("CU006", "Cristian", "Male", NULL, NULL);

select *from ViewCustomer;

/*No 9 modul 8*/

select *from ViewCustomerData;

delete from ViewCustomerData where (Id = '005');

/*No 10 modul 8*/

drop view ViewCustomerData;
select *from ViewCustomerData;