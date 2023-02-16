-- Number of products stocked on a given store
select *
from PortfolioProject.dbo.inventory


-- Characteristics of a prodcut, its production cost and its price
select *
from PortfolioProject.dbo.products


-- The sales of a product at a given date and the number of untis sold
select *
from PortfolioProject.dbo.sales


-- Characteristics of stores (ID, City, Location and Open Date)
select *
from PortfolioProject.dbo.stores


-- Changing column type of "Sale_Id" from string to int

alter table PortfolioProject.dbo.sales
alter column Sale_ID int


select PortfolioProject.dbo.Product_Category
from products
group by Product_Category

-- Checking the total item sales for each Store

select a.Store_ID, a.Store_Name, a.Store_City, a.Store_Location,
b.Sale_Id, b.Date, b.Product_ID,
c.Product_Name, c.Product_Category, c.Product_Cost, c.Product_Price
from PortfolioProject.dbo.Stores as a
join PortfolioProject.dbo.Sales as b
on a.Store_ID = b.Store_ID
join PortfolioProject.dbo.Products as c
on b.Product_ID = c.Product_ID
order by a.Store_ID asc
-- where a.Store_ID = 1


-- Checking the total item sales for Store 1




select a.Store_ID, a.Store_Name, a.Store_City, a.Store_Location,
b.Sale_Id, b.Date, b.Product_ID, b.Units,
c.Product_Name, c.Product_Category, c.Product_Cost, c.Product_Price--,
from PortfolioProject.dbo.Stores as a
join PortfolioProject.dbo.Sales as b
on a.Store_ID = b.Store_ID
join PortfolioProject.dbo.Products as c
on b.Product_ID = c.Product_ID
where a.Store_ID = 1
order by b.Product_ID asc




-- Checking how many units of each toy sold by Store 1

select a.Sale_ID, a.Date, a.Store_ID, a.Product_ID, a.Units,
b.Store_Name, b.Store_City, b.Store_Location
from PortfolioProject.dbo.Sales as a
join PortfolioProject.dbo.Stores as b
on a.Store_ID = b.Store_ID
where a.Store_ID = 1
order by a.Product_ID asc


-- Checking Profits for Product_ID =1 and Store_ID = 1 

select a.Sale_ID, a.Date, a.Store_ID, a.Product_ID, a.Units,
b.Product_Name, b.Product_Category, b.Product_Cost, b.Product_Price,
((a.Units * b.Product_Price) - b.Product_Cost) as [Real Gain],
(((a.Units * b.Product_Price) - b.Product_Cost) / b.Product_Cost) * 100 as [% of Gain]
--c.Stock_On_Hand
from PortfolioProject.dbo.Sales as a
join PortfolioProject.dbo.Products as b
on a.Product_ID= b.Product_ID
join PortfolioProject.dbo.Inventory as c
on a.Product_ID = c.Product_ID
where c.Product_ID = 1 and c.Store_ID = 1
order by a.Store_ID, a.Date, a.Product_ID asc


-- Checking for total profits for the year 2017 for each Product and each Store

select a.Store_ID, 
c.Store_Name, c.Store_City, c.Store_Location,
a.Product_ID,
b.Product_Name, b.Product_Category, b.Product_Cost, b. Product_Price, sum(b.Product_Price * a.Units) as [Total Profits],
sum(b.Product_Cost * a.Units) as [Total Expenses],
((sum(b.Product_Price * a.Units) - sum(b.Product_Cost * a.Units)) / sum(b.Product_Cost * a.Units)) * 100 as [% of Profits]
from PortfolioProject.dbo.Sales as a
join PortfolioProject.dbo.Products as b
on a.Product_ID= b.Product_ID
join PortfolioProject.dbo.Stores as c
on a.Store_ID = c.Store_ID
where a.Date like '2017%'
group by a.Product_ID, a.Store_ID,b.Product_Name, b.Product_Category, b.Product_Cost, b. Product_Price,
c.Store_Name, c.Store_City, c.Store_Location
order by [% of Profits] desc


-- Checking for total profits for the year 2018 for each prodcut and each store

select a.Store_ID, 
c.Store_Name, c.Store_City, c.Store_Location,
a.Product_ID,
b.Product_Name, b.Product_Category, b.Product_Cost, b. Product_Price, sum(b.Product_Price * a.Units) as [Total Profits],
sum(b.Product_Cost * a.Units) as [Total Expenses],
((sum(b.Product_Price * a.Units) - sum(b.Product_Cost * a.Units)) / sum(b.Product_Cost * a.Units)) * 100 as [% of Profits]
from PortfolioProject.dbo.Sales as a
join PortfolioProject.dbo.Products as b
on a.Product_ID= b.Product_ID
join PortfolioProject.dbo.Stores as c
on a.Store_ID = c.Store_ID
where a.Date like '2018%'
group by a.Product_ID, a.Store_ID,b.Product_Name, b.Product_Category, b.Product_Cost, b. Product_Price,
c.Store_Name, c.Store_City, c.Store_Location
order by [% of Profits] desc



-- Checking for Product Catgeory with maximum Profits for 2017 and 2018

select a.Product_Category,
count(a.Product_Category) as [Number of Entries],
sum(a.Product_Price * b.Units) as [Total Profits],
sum(a.Product_Cost * b.Units) as [Total Expenses],
((sum(a.Product_Price * b.Units) - sum(a.Product_Cost * b.Units)) / sum(a.Product_Cost * b.Units)) * 100 as [% of Profits]
from PortfolioProject.dbo.Products as a
join PortfolioProject.dbo.Sales as b
on a.Product_ID= b.Product_ID
group by a.Product_Category
order by [% of Profits] desc

-- Checking for Product Catgeory with maximum Profits for 2017

select a.Product_Category,
count(a.Product_Category) as [Number of Entries],
sum(a.Product_Price * b.Units) as [Total Profits],
sum(a.Product_Cost * b.Units) as [Total Expenses],
((sum(a.Product_Price * b.Units) - sum(a.Product_Cost * b.Units)) / sum(a.Product_Cost * b.Units)) * 100 as [% of Profits]
from PortfolioProject.dbo.Products as a
join PortfolioProject.dbo.Sales as b
on a.Product_ID= b.Product_ID
where b.Date like '2017%'
group by a.Product_Category
order by [% of Profits] desc

-- Checking for Product Catgeory with maximum Profits for 2018

select a.Product_Category,
count(a.Product_Category) as [Number of Sold Products],
sum(a.Product_Price * b.Units) as [Total Profits],
sum(a.Product_Cost * b.Units) as [Total Expenses],
((sum(a.Product_Price * b.Units) - sum(a.Product_Cost * b.Units)) / sum(a.Product_Cost * b.Units)) * 100 as [% of Profits]
from PortfolioProject.dbo.Products as a
join PortfolioProject.dbo.Sales as b
on a.Product_ID= b.Product_ID
where b.Date like '2018%'
group by a.Product_Category
order by [% of Profits] desc



-- Checking for Product Catgeory with maximum Profits depending on Store Type and Location

select a.Product_Category,
c.Store_Name, c.Store_City, c.Store_Location,
sum(a.Product_Price * b.Units) as [Total Profits],
sum(a.Product_Cost * b.Units) as [Total Expenses],
((sum(a.Product_Price * b.Units) - sum(a.Product_Cost * b.Units)) / sum(a.Product_Cost * b.Units)) * 100 as [% of Profits]
from PortfolioProject.dbo.Products as a
join PortfolioProject.dbo.Sales as b
on a.Product_ID= b.Product_ID
join PortfolioProject.dbo.Stores as c
on b.Store_ID = c.Store_ID
group by a.Product_Category, c.Store_City, c.Store_Location, c.Store_Name
order by [% of Profits] desc


-- Checking for seasonal trends in sales data

-- Looking for Sales in 2017

select DATEPART(MONTH, b.Date) as [Sales Month],
a.Product_ID, a.Product_Name, a.Product_Category, sum(b.Units) as [Total Sold Units per Toy Category]
from PortfolioProject.dbo.Products as a
join PortfolioProject.dbo.Sales as b
on a.Product_ID = b.Product_ID
where b.Date like '2017%'
group by DATEPART(MONTH, b.Date), a.Product_Name, a.Product_Category, a.Product_ID
order by sum(b.Units) desc


-- Looking for Sales in 2018

select DATEPART(MONTH, b.Date) as [Sales Month],
a.Product_ID, a.Product_Name, a.Product_Category, sum(b.Units) as [Total Sold Units per Toy Category]
from PortfolioProject.dbo.Products as a
join PortfolioProject.dbo.Sales as b
on a.Product_ID = b.Product_ID
where b.Date like '2018%'
group by DATEPART(MONTH, b.Date), a.Product_Name, a.Product_Category, a.Product_ID
order by sum(b.Units) desc


-- Looking for Sales in 2017 and 2018

select DATEPART(MONTH, b.Date) as [Sales Month],
a.Product_ID, a.Product_Name, a.Product_Category, sum(b.Units) as [Total Sold Units per Toy Category]
from PortfolioProject.dbo.Products as a
join PortfolioProject.dbo.Sales as b
on a.Product_ID = b.Product_ID
-- where b.Date like '2018%'
group by DATEPART(MONTH, b.Date), a.Product_Name, a.Product_Category, a.Product_ID
order by sum(b.Units) desc