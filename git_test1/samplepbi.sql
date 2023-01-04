#Hãy cho biết doanh thu của mỗi Khách hàng: (gồm cột mã KH, tên KH, quốc gia của KH đó) và total doanh thu của mỗi khách hàng trong năm 2004.
#Và lưu ý, để ghi nhận doanh thu thì status (trạng thái) của đơn hàng phải là đã ship ‘Shipped’.

create table t1(
with shiporder as(
select c.customerNumber, c.customerName, c.country, o.orderNumber, o.status  
from customers c 
left join orders o on c.customerNumber = o.customerNumber 
where year(o.orderDate) = '2004' and o.status = 'Shipped'
group by c.customerNumber )
select oc.customerNumber, oc.customerName, oc.country, oc.status ,sum(o2.quantityOrdered * o2.priceEach) as total_revenue
from shiporder as oc
left join orderdetails o2 on oc.orderNumber = o2.orderNumber 
group by oc.customerNumber, oc.customerName, oc.country)
