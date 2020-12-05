/*No 1 modul 5*/

select	Max(Price) as 'Maximum Price', Min(Price) as 'Minimum Price', 
Cast(Round(avg(Price)) as decimal(20, 2)) as 'Average Price' 
from MsTreatment;

/*No 2 modul 5*/

select	StaffPosition, left(StaffGender, 1) as Gender, CONCAT('Rp. ', cast(Avg(StaffSalary) 
as decimal(20,2))) as 'Average Salary'
from MsStaff group by StaffGender, StaffPosition;

/*No 3 modul 5 (%b untuk singkatan bulan) */

select date_format(TransactionDate, '%b %e, %Y') as TransactionDate, 
Count(TransactionDate) as 'Total Transaction per Day'
from HeaderSalonServices group by TransactionDate;

/*No 4 modul 5*/

select  upper(CustomerGender), Count(CustomerGender) as 'Total Transaction'
from MsCustomer, HeaderSalonServices where MsCustomer.CustomerId = HeaderSalonServices.CustomerId
group by CustomerGender;

/*No 5 modul 5*/

select TreatmentTypeName, Count(TransactionId) as 'Total Transaction'
from MsTreatmentType, MsTreatment, DetailSalonServices 
where MsTreatment.TreatmentId = DetailSalonServices.TreatmentId and 
MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId
group by TreatmentTypeName
order by Count(TransactionId) desc;

/*No 6 modul 5 (DI MySQL tidak bisa menggunakan convert untuk format date tertentu)*/
 
select date_format(TransactionDate, '%e %b %Y') as Date, 
CONCAT('Rp. ', cast(sum(Price) as char)) as 'Revenue per Day'
from HeaderSalonServices, DetailSalonServices, MsTreatment 
where DetailSalonServices.TreatmentId = MsTreatment.TreatmentId and 
HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
group by TransactionDate
having  sum(Price) between 1000000 and 5000000;

/*No 7 modul 5*/

select replace(MsTreatment.TreatmentTypeId,'TT0','Treatment Type ') as ID, TreatmentTypeName,
CONCAT(Cast(Count(MsTreatment.TreatmentTypeId)as char), ' Treatment') as 'Total Treatment per Type'
from MsTreatmentType, MsTreatment where MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId
group by MsTreatment.TreatmentTypeId, TreatmentTypeName
having Count(MsTreatment.TreatmentTypeId) > 5
order by Count(MsTreatment.TreatmentTypeId) desc;

/*No 8 modul 5*/

select SUBSTRING_INDEX(MsStaff.StaffName, ' ', 1)as StaffName, HeaderSalonServices.TransactionId as TransactionID, 
Count(HeaderSalonServices.TransactionId) as 'Total Treatment per Transaction'
from MsStaff, HeaderSalonServices, DetailSalonServices 
where MsStaff.StaffId = HeaderSalonServices.StaffId 
and HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
group by HeaderSalonServices.TransactionId, MsStaff.StaffName;

/*No 9 modul 5(MySQL gada Datename, Ryan gk handle hari thursday)*/ 

select TransactionDate, CustomerName, TreatmentName, Price
from MsCustomer, HeaderSalonServices, MsStaff, DetailSalonServices, MsTreatment 
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId 
and HeaderSalonServices.StaffId = MsStaff.StaffId
and HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
and DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
and dayname(TransactionDate) like "Tuesday" 
and StaffName like '%Ryan%'
order by TransactionDate, CustomerName asc;

/*No 10 modul 5*/

select TransactionDate, CustomerName, sum(Price) as TotalPrice
from HeaderSalonServices, MsCustomer, DetailSalonServices, MsTreatment
where HeaderSalonServices.CustomerId = MsCustomer.CustomerId
and HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
and DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
and Day(Transactiondate) > 20
group by TransactionDate, CustomerName
order by TransactionDate asc; 
