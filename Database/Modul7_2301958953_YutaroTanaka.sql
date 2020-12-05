/* No 1 Modul 7 */

select TreatmentId, TreatmentName
from MsTreatment
where TreatmentId in('TM001','TM002');

/* No 2 Modul 7 */

select TreatmentName, Price, TreatmentTypeName
from MsTreatment, MsTreatmentType
where MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId and 
TreatmentTypeName  not in ('Hair Treatment', 'Hair Spa Treatment');

/* No 3 Modul 7 */

select CustomerName, CustomerPhone, CustomerAddress
from MsCustomer, HeaderSalonServices
where HeaderSalonServices.CustomerId = MsCustomer.CustomerId and
Length(Customername) > 8 and dayname(TransactionDate) in ("Friday");

/* No 4 Modul 7 (Ada modifikasi pada DetailSalonServices untuk TR009 dan TR019)*/

select TreatmentTypeName, TreatmentName, Price
from MsTreatment, MsTreatmentType, DetailSalonServices, HeaderSalonServices, MsCustomer
where MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId and 
DetailSalonServices.TreatmentId = MsTreatment.TreatmentId and
HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId and
MsCustomer.CustomerId = HeaderSalonServices.CustomerId and
CustomerName like '%Putra%' and day(TransactionDate) like '22';

/* No 5 Modul 7 (pakai Modulus, tidak bisa pakai int)*/

select StaffName, CustomerName, date_format(TransactionDate, '%b %e, %Y') as TransactionDate, 
TreatmentId
from HeaderSalonServices, MsCustomer, MsStaff, DetailSalonServices
where exists(
select MsTreatment.TreatmentId
from MsTreatment
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId and
MsStaff.Staffid = HeaderSalonServices.StaffId and
DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId and
MsTreatment.TreatmentId = DetailSalonServices.TreatmentId and
(convert ((Right((MsTreatment.TreatmentId), 1)), unsigned)% 2) = 0 );
                
/* No 6 Modul 7 */

select CustomerName, CustomerPhone, CustomerAddress
from MsCustomer
where exists(
select StaffName
from MsStaff, headerSalonServices
where HeaderSalonServices.CustomerId = MsCustomer.CustomerId and
MsStaff.StaffId = HeaderSalonServices.StaffId and 
(length(StaffName) % 2) > 0);

/* No 7 Modul 7 */

select right(StaffId, 3) as ID, 
Substring(Staffname, 
instr(StaffName, ' ')+1, instr(StaffName, ' ')+1) as Name
from MsStaff
where exists(
select StaffName
from HeaderSalonServices, MsCustomer
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId and
MsStaff.StaffId = HeaderSalonServices.StaffId and
length(StaffName) - Length(replace(Staffname, ' ', '')) > 1 and 
CustomerGender not like 'Male'
);

/* No 8 Modul 7 */

select TreatmentTypeName, TreatmentName, Price
from MsTreatment, MsTreatmentType, (select avg(price) as average from MsTreatment) as alias
where MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId and 
price > alias.average;

/* No 9 Modul 7 */

select StaffName, StaffPosition, StaffSalary 
from MsStaff, (select min(StaffSalary) as minimum from MsStaff) as alias1, 
(select max(StaffSalary) as maximum from MsStaff) as alias2
where StaffSalary = alias2.maximum or StaffSalary = alias1.minimum;

/* No 10 Modul 7 */

select CustomerName, CustomerPhone, CustomerAddress, count(MsTreatment.TreatmentId) as 'Count Treatment'
from MsCustomer, HeaderSalonServices, MsTreatment, DetailSalonServices, 
(select max(alias1.hitung) as maximum from 
	(
	select count(MsTreatment.TreatmentId) as hitung 
	from MsCustomer, HeaderSalonServices, MsTreatment, DetailSalonServices
    where MsCustomer.CustomerId = HeaderSalonServices.CustomerId and 
	DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId and
	DetailSalonServices.TreatmentId = MsTreatment.TreatmentId 
    group by CustomerName, CustomerPhone, CustomerAddress, 'Count Treatment'
	) as alias1
) as alias2
where MsCustomer.CustomerId = HeaderSalonServices.CustomerId and 
DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId and
DetailSalonServices.TreatmentId = MsTreatment.TreatmentId 
group by CustomerName, CustomerPhone, CustomerAddress, 'Count Treatment', alias2.maximum
having count(MsTreatment.TreatmentId) = alias2.maximum;
