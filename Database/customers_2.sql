-- To see which customer bought vouchers and their order date.
-- For marketing purposes so we can target those who bought recently

/*
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID; 
*/

-- To calculate the total amount of vouchers bought, and the voucher category of the total price.
-- In this case, we can see which one is more popular, food vs ride among customers.

SELECT SUM(voucher_amount) as total_vouchers
FROM voucher;

SELECT voucher_category,
 voucher_amount*voucher_qty  AS total_price
FROM voucher;

/*
SELECT voucher_category,
 voucher_amount*voucher_qty  AS total_price
FROM voucher;
*/

-- To group the orders by order date and the quantity 
-- We can compare if marketing efforts are needed if the voucher amount is getting lesser.

SELECT orders.*, voucher.voucher_amount 
FROM orders 
INNER JOIN voucher ON orders.orderID = voucher.VoucherID
ORDER BY orderDate DESC, voucher_amount DESC;


-- To see all the orders, by customer id, vouchers and orders. 

SELECT *
FROM orders
JOIN customers
USING (customerID)
JOIN voucher
using(orderID)
JOIN recipient
using(orderID)
ORDER BY voucher_amount DESC;


/*
A daily list of orders placed by customers providing details of the orders including order
date, customer email, order number and details of each voucher in terms of the email of the
voucher’s recipient, type of voucher and the voucher’s value. The list is to be sorted by
voucher type and voucher ID 
Change the order date to current date to get details. 
*/


SELECT customers.customerName, orders.orderdate,voucher.voucherID,voucher.voucher_category,voucher.voucher_amount,recipient.recipient_email
FROM orders
JOIN customers
USING (customerID)
JOIN voucher
using(orderID)
JOIN recipient
using(orderID)
WHERE orderdate = "2022-01-04"
