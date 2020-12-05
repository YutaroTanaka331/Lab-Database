USE Lab1;

/* No 1 */

create procedure sp1 @Customerid char(5)as
select CustomerId, CustomerName, CustomerGender, CustomerAddress
from MsCustomer
where CustomerId = @Customerid;

exec sp1 'CU001';

/* No 2 */

create procedure sp2 @CustomerName varchar(50) as
if len(@CustomerName)% 2 = 1
	print 'Character Length of Mentor Name is an Odd Number'
else
	select MsCustomer.CustomerId, MsCustomer.CustomerName, MsCustomer.CustomerGender,
	HeaderSalonServices.TransactionId, HeaderSalonServices.Transactiondate
	from MsCustomer
	join HeaderSalonServices on HeaderSalonServices.CustomerId = MsCustomer.CustomerId
	where MsCustomer.CustomerName like '%' + @CustomerName + '%';       

exec sp2 'Elysia Chen';
exec sp2 'Fran';

/* No 3 */

create procedure sp3 @Id char(5), @Nama varchar(50), 
@Gender varchar(10), @Phone varchar(13) as
begin
if exists(
	select StaffId
	from MsStaff 
	where StaffId = @Id
	)
	update MsStaff
	set StaffId = @Id, StaffName = @Nama, StaffGender = @Gender, StaffPhone = @Phone
	where StaffId = @Id
	select *from MsStaff where StaffId = @Id
else
    print 'Staff does not exists'
end

exec sp3 'SF005', 'Ryan Nixon', 'M', '08567756123';
exec sp3 'SF010', 'Ryan Nixon', 'M', '08567756123';
select *from MsStaff
/* No 4 */

create trigger trig1 on MsCustomer
for update 
as
begin
	select *from INSERTED
	union
	select *from DELETED
end

begin tran
update  MsCustomer set CustomerName = 'Franky Quo' where CustomerId = 'CU001';

rollback
select *from MsCustomer;

/* No 5 */

create trigger trig2 on MsCustomer
after insert
as
begin
	delete top(1) 
	from MsCustomer
end

begin tran
insert into MsCustomer values ('CU006', 'Yogie Soesanto', 'Male', '085562133000', 'Pelsakih Street no 52');

select *from mscustomer;
rollback

/* No 6 */

create trigger trig3 on MsCustomer
after delete
as
begin
	if OBJECT_ID('Removed') is not null
		begin
		insert into Removed
		select *from Deleted
		end
	else
		begin
		select *into Removed from Deleted
        end
end

begin tran
delete from MsCustomer where CustomerId = 'CU002';
select * from MsCustomer
select * from Removed
rollback

/* No 7 */

declare @StaffName varchar(50)
declare cur1 cursor
for 
select StaffName from MsStaff
open cur1
fetch next from cur1 into @StaffName
while @@FETCH_STATUS = 0
begin
	if len(@StaffName) % 2 = 1
		begin
			print 'The length from StaffName ' + @StaffName + ' is an odd number'
        end
	else
        begin
            print 'The length from StaffName ' + @StaffName + ' is an even number'
        end
fetch next from cur1 into @StaffName
end

close cur1
deallocate cur1;

/* No 8 */

create procedure sp4 @StaffInput varchar(50) as
declare @Nama varchar(50),@Position varchar(20)
declare cur2 cursor
for
select StaffName, StaffPosition
from  MsStaff
where StaffName like '%' + @StaffInput + '%'
open cur2
fetch next from cur2 into @Nama, @Position
while @@FETCH_STATUS = 0
begin
	print 'StaffName : ' + @Nama + ' Position : ' + @Position
	fetch next from cur2 into @Nama, @Position
end           
close cur2
deallocate cur2
exec sp4 'a'

go

/* No 9 */

create procedure sp5 @InputId char(5) as
declare @Nama varchar(50), @Date date
declare cur3 cursor
for
select  MsCustomer.CustomerName, HeaderSalonServices.Transactiondate
from MsCustomer
JOIN HeaderSalonServices ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId
where MsCustomer.CustomerId IN (@InputId)
open cur3
fetch next from cur3 into @Nama, @Date
while @@FETCH_STATUS = 0
begin
	print 'Customer Name : ' + @Nama + ' Transaction date is ' + CasT(@Date as varchar)
	fetch next from cur3 into @Nama, @Date
end

close cur3
deallocate cur3
exec sp5 'CU001'

go

/* No 10 */

drop proc sp1, sp2, sp3, sp4, sp5;
drop trigger trig1, trig2, trig3;
