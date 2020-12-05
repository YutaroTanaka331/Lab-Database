/* No 1 Modul 6 */

select TreatmentTypeName, TreatmentName, Price from MsTreatment
join MsTreatmentType on (MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId) 
where price < 100000 and (TreatmentTypeName like '%hair%' or TreatmentTypeName like 'nail%');

/* No 2 Modul 6 */

select distinct TransactionDate, StaffName, Concat(left(lower(StaffName), 1), 
right(lower(StaffName),LOCATE(' ',reverse(lower(StaffName))) - 1), 
'@oosalon.com') as StaffEmail from MsStaff 
join HeaderSalonServices on (HeaderSalonServices.StaffId = MsStaff.StaffId)
where dayname(TransactionDate) like "Thursday";

/* No 3 Modul 6 */

select replace(TransactionId,'TR','Trans') as 'New Transaction ID ', 
TransactionId, TransactionDate, StaffName, CustomerName from HeaderSalonServices 
join MsStaff on (MsStaff.StaffId = HeaderSalonServices.StaffId)
join MsCustomer on (MsCustomer.CustomerId = HeaderSalonServices.CustomerId)
where DATEDIFF('2012/12/24', TransactionDate) = 2; 

/* No 4 Modul 6 */

select DATE_ADD(TransactionDate, INTERVAL 5 DAY) as 'New Transaction Date ', TransactionDate, CustomerName 
from MsCustomer join HeaderSalonServices on (HeaderSalonServices.CustomerId = MsCustomer.CustomerId) 
where day(TransactionDate) not like '20';

/* No 5 Modul 6 */

select dayname(TransactionDate) as Day, StaffName, CustomerName, TreatmentName from HeaderSalonServices
join MsCustomer on (MsCustomer.CustomerId = HeaderSalonServices.CustomerId) 
join MsStaff on (MsStaff.StaffId = HeaderSalonServices.StaffId) 
join DetailSalonServices on (DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId)
join MsTreatment on (DetailSalonServices.TreatmentId = MsTreatment.TreatmentId)
where StaffGender in ('Female') and StaffPosition like 'TOP%'
order by CustomerName asc;

/* No 6 Modul 6 (di MySql tidak ada fungsi TOP) */ 

select MsCustomer.CustomerId, MsCustomer.CustomerName, HeaderSalonServices.TransactionId, 
count(DetailSalonServices.TransactionId) as 'Total Treatment'
from HeaderSalonServices
join MsCustomer on (MsCustomer.CustomerId = HeaderSalonServices.CustomerId) 
join DetailSalonServices on (DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId)
group by MsCustomer.CustomerId, MsCustomer.CustomerName, HeaderSalonServices.TransactionId, 'Total Treatment'
order by count(DetailSalonServices.TransactionId) desc
limit 1;

/* No 7 Modul 6 */

select MsCustomer.CustomerId, HeaderSalonServices.TransactionId, MsCustomer.CustomerName, 
sum(MsTreatment.price) as 'Total Price' 
from HeaderSalonServices
join MsCustomer on (MsCustomer.CustomerId = HeaderSalonServices.CustomerId) 
join DetailSalonServices on (DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId)
join MsTreatment on (DetailSalonServices.TreatmentId = MsTreatment.TreatmentId)
group by MsCustomer.CustomerId, HeaderSalonServices.TransactionId, MsCustomer.CustomerName, 'Total Price'
having sum(MsTreatment.price) >  
(select sum(alias.average) from (select avg(price) as average from MsTreatment) as alias)
order by sum(MsTreatment.price) desc;          

/* No 8 Modul 6 */

select concat('Mr. ', StaffName)as Name , StaffPosition, StaffSalary 
from MsStaff
where StaffGender = 'Male'
union
select concat('Ms. ', StaffName) as Name, StaffPosition, StaffSalary
from MsStaff
where Staffgender = 'Female'
order by Name , StaffPosition asc;

/* No 9 Modul 6 */

select TreatmentName, concat( 'Rp. ', Price) as Price, cast('Maximum Price' as char) as Status
from MsTreatment, (select max(MsTreatment.Price) as maximum from MsTreatment) as alias1
where price = alias1.maximum
union 
select TreatmentName, concat( 'Rp. ', Price), cast('Minimum Price' as char) as Status
from MsTreatment, (select min(MsTreatment.Price) as minimum from MsTreatment) as alias2
where MsTreatment.Price = alias2.minimum;

/* No 10 Modul 6 */

select CustomerName as 'Longest Name of Staff and Customer', Length(Customername) as  'Length of Name', 
cast('Customer' as char) as Status
from MsCustomer,  (select max(Length(CustomerName)) as maximum1 from MsCustomer) as alias1
where Length(CustomerName) = alias1.maximum1
union
select StaffName as 'Longest Name of Staff and Customer', Length(StaffName) as  'Length of Name', 
cast('Staff' as char) as Status
from MsStaff, (select max(Length(StaffName)) as maximum2 from MsStaff) as alias2
where Length(StaffName) = alias2.maximum2;
