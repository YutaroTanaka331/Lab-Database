/*No 1 modul 4*/
select * from MsStaff where StaffGender = 'Female';

/*No 2 modul 4*/
select StaffName, CONCAT('Rp.', StaffSalary)as StaffSalary from MsStaff 
where StaffSalary >= 10000000 AND StaffName like '%m%';

/*No 3 modul 4*/
select TreatmentName, Price from MsTreatment, MsTreatmentType 
where MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId 
and TreatmentTypeName in ('Hair Spa Treatment','Premium Treatment');

/*No 4 modul 4*/
select StaffName, StaffPosition, date_format(TransactionDate, '%b %e, %Y') as TransactionDate
from MsStaff, HeaderSalonServices 
where MsStaff.StaffId = HeaderSalonServices.StaffId AND StaffSalary between 7000000 and 10000000;

/*No 5 modul 4*/
select SUBSTRING_INDEX(CustomerName, ' ', 1) as CustomerName, LEFT(CustomerGender , 1) 
as CustomerGender, PaymentType, TransactionDate from MsCustomer, HeaderSalonServices 
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId AND PaymentType = 'Debit';

/*No 6 modul 4*/

select CONCAT(LEFT(CustomerName, 1), SUBSTRING(CustomerName,LOCATE(' ',CustomerName) + 1,1)) 
as Initial, dayname(T ransactionDate) as Day, TransactionDate from MsCustomer, HeaderSalonServices
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId AND
DATEDIFF('2012/12/24', TransactionDate) <= 3 AND TransactionDate <= ("2012-12-24"); 
 
 /*No 7 modul 4*/
 
select  TransactionDate, right(CustomerName,LOCATE(' ',reverse(CustomerName)) - 1) as CustomerName 
from MsCustomer, HeaderSalonServices 
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId AND dayname(TransactionDate) 
like "Saturday" AND CustomerName LIKE '% %';

 /*No 8 modul 4*/
 
select StaffName, CustomerName, (REPLACE(CustomerPhone, '08', '+628')) as CustomerPhone, CustomerAddress 
from MsStaff, MsCustomer, HeaderSalonServices where MsStaff.StaffId = HeaderSalonServices.StaffId 
AND MsCustomer.CustomerId = HeaderSalonServices.CustomerId AND StaffName like '% % %' 
AND (StaffName like "%a%" or 
StaffName like "%i%" or 
StaffName like "%u%" or 
StaffName like "%e%" or 
StaffName like "%o%"); 

 /*No 9 modul 4*/
 
select StaffName, TreatmentName, DATEDIFF(TransactionDate,"2012-12-24") as 'Term of Transaction' 
from MsStaff, HeaderSalonServices, DetailSalonServices, MsTreatment 
where MsStaff.StaffId = HeaderSalonServices.StaffId AND 
DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId AND 
MsTreatment.TreatmentId = DetailSalonServices.TreatmentId AND 
( LENGTH(TreatmentName) > 20 or instr (TreatmentName,' ') != 0); 

 /*No 10 modul 4*/
 
select TransactionDate, CustomerName, TreatmentName, CAST((price * 20/ 100)  as unsigned) 
as Discount, PaymentType 
from HeaderSalonServices, MsCustomer, DetailSalonServices, MsTreatment 
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId AND 
DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId AND 
DetailSalonServices.TreatmentId = MsTreatment.TreatmentId AND 
Day(Transactiondate)='24'; 
